Production agent systems require session state that survives process restarts, scales across distributed instances, and supports long-lived workflows spanning hours or days. Microsoft Foundry Agent Service threads provide in-service message history, but threads alone don't meet these persistence requirements. You need external state management.

## Understand thread limitations and session requirements

In Microsoft Foundry Agent Service, a **thread** is the session—it holds all message history. As long as the thread exists in the service, message history persists. But threads are ephemeral within the service lifetime. If your application process crashes, the thread ID is all you have. Without external state, you lose the ability to resume.

**Session requirements** exceed what service threads provide:

| Requirement | Service Thread Alone | With External Persistence |
|-------------|---------------------|---------------------------|
| Survive app restart | No | Yes |
| Cross-instance sharing | No (thread ID required) | Yes (query by session metadata) |
| Historical audit trail | Limited (thread may be deleted) | Yes (permanent record) |
| Analytics on agent interactions | No | Yes (queryable state store) |

The solution: persist thread state externally at strategic checkpoints. The thread remains the active session container during execution. External storage provides durability, queryability, and analytics support.

## Design state persistence tiers

> [!NOTE]
> Microsoft Foundry Agent Service includes a managed **Memory** feature (preview) that provides long-term memory across sessions without custom code. It extracts meaningful information from conversations, consolidates it into durable knowledge, and makes it available in future sessions. Before building a custom persistence tier, evaluate whether managed Memory meets your requirements. Use custom tiers when you need structured schemas, cross-product analytics, or permanent audit records. See [Memory in Microsoft Foundry Agent Service](https://learn.microsoft.com/azure/foundry/agents/concepts/what-is-memory).

Three persistence tiers trade off complexity against durability and query capabilities:

**In-memory / service thread only** suits short-lived interactions within a single process lifetime. The thread ID lives in application memory or a simple key-value cache. This approach works for stateless request-response agents where each interaction is independent. Risk: no recovery if the process crashes mid-conversation. For simple market quote lookups in the Contoso Capital scenario, this tier is sufficient—if the process fails, the user simply retries.

**Azure Cosmos DB persistence** provides durable, queryable state storage for long-lived workflows. The service supports two approaches:

- **Bring Your Own (BYO) thread storage**: Configure Standard Agent Setup to write thread messages directly to your Azure Cosmos DB for NoSQL account. This requires no custom serialization code and preserves full thread fidelity automatically. Use this when raw thread history is sufficient.
- **Manual serialization**: Serialize and shape thread messages to a custom document schema. Use this when you need custom fields, analytics projections, cross-system joins, or compliance-shaped records beyond what the raw thread format provides.

The patterns below demonstrate manual serialization. Key design decisions:

- **Document schema**: Store thread ID, creation timestamp, last updated timestamp, session metadata (user ID, workflow type), and serialized messages array
- **When to persist**: After each run (frequent writes, higher cost) vs. on explicit checkpoints (less durable, lower cost)
- **Thread ID as partition key**: Enables efficient single-thread lookups but limits cross-thread analytical queries
- **Separate metadata and messages**: Store metadata in one container with rich queries, messages in another for cost efficiency

Here's the implementation pattern:

```python
from azure.cosmos import CosmosClient, PartitionKey
import json

cosmos_client = CosmosClient(url=COSMOS_ENDPOINT, credential=COSMOS_KEY)
database = cosmos_client.get_database_client("agent-sessions")
container = database.get_container_client("threads")

def persist_thread_state(thread_id, metadata):
    """Serialize thread messages to Cosmos DB"""
    messages = list(agents_client.messages.list(thread_id=thread_id))
    
    # Serialize messages to JSON-compatible format
    serialized_messages = [
        {
            "id": msg.id,
            "role": msg.role,
            "content": msg.text_messages[0].text.value if msg.text_messages else "",
            "created_at": msg.created_at
        }
        for msg in messages
    ]
    
    document = {
        "id": thread_id,
        "thread_id": thread_id,
        "metadata": metadata,
        "messages": serialized_messages,
        "last_updated": datetime.utcnow().isoformat()
    }
    
    container.upsert_item(document)

def restore_thread_from_state(thread_id):
    """Restore thread from Cosmos DB to a new thread"""
    document = container.read_item(item=thread_id, partition_key=thread_id)
    
    # Create new thread
    new_thread = agents_client.threads.create()
    
    # Replay messages
    for msg in document["messages"]:
        agents_client.messages.create(
            thread_id=new_thread.id,
            role=msg["role"],
            content=msg["content"]
        )
    
    return new_thread
```

This pattern enables session resumption after arbitrary delays. An analyst starts investment research Monday, persists state to Cosmos DB, and resumes Tuesday by restoring the thread. The agent sees complete conversation history.

**Azure Cache for Redis** adds low-latency session lookups for high-throughput systems. Redis stores thread ID → session metadata mappings. Cosmos DB remains the durable store. When a request arrives, look up metadata in Redis (sub-millisecond), load full thread state from Cosmos DB only if needed (5-10ms). This two-tier approach scales to thousands of concurrent sessions without Cosmos DB becoming a bottleneck.

## Manage context window pressure

As threads grow, costs increase and you approach the model's context limit. A thread with 100 messages containing detailed market data can exceed 100K tokens. Every run re-processes this entire context.

**Context window pressure** manifests in three ways:

1. **Cost escalation**: Token consumption grows linearly with message count
2. **Latency increase**: Longer contexts take longer to process
3. **Context overflow**: Threads eventually exceed model limits (typically 128K tokens)

Track context size proactively:

```python
def estimate_thread_tokens(thread_id):
    """Estimate total token count for a thread"""
    messages = list(agents_client.messages.list(thread_id=thread_id))
    
    # Rough estimate: 4 characters = 1 token
    total_chars = sum(
        len(msg.text_messages[0].text.value) if msg.text_messages else 0
        for msg in messages
    )
    
    return total_chars // 4

token_count = estimate_thread_tokens(thread_id)
if token_count > 50000:
    # Implement context management strategy
    apply_sliding_window(thread_id)
```

## Implement context management strategies

Three strategies manage growing threads:

**Sliding window retention** keeps only the N most recent messages in active context. Older messages are persisted externally but excluded from the active thread. When context pressure builds, create a new thread and copy only recent messages:

```python
def apply_sliding_window(thread_id, window_size=20):
    """Keep only recent messages, archive the rest"""
    messages = list(agents_client.messages.list(thread_id=thread_id))
    
    # Persist full history to Cosmos DB
    persist_thread_state(thread_id, {"archived": True})
    
    # Create new thread with recent messages only
    new_thread = agents_client.threads.create()
    recent_messages = messages[:window_size]
    
    for msg in reversed(recent_messages):  # Replay in chronological order
        agents_client.messages.create(
            thread_id=new_thread.id,
            role=msg.role,
            content=msg.text_messages[0].text.value if msg.text_messages else ""
        )
    
    return new_thread
```

Sliding window works when recent context matters most. Investment research workflows care more about the last few exchanges than the initial 50 messages of data gathering.

**Selective retention with summarization** prunes low-importance messages while preserving high-value content. Define importance criteria—keep analyst questions, final recommendations, and error messages; summarize intermediate tool results and data fetches. Replace 30 messages of raw market data with a single summarized message: "Market data collected for MSFT covering 2020-2025, showing 15% revenue CAGR."

**Importance-weighted pruning** assigns priority scores to messages. System messages and user instructions score high (9-10), agent responses with final outputs score medium-high (7-8), tool call results score low (3-4), and acknowledgments score minimal (1-2). When context pressure builds, prune lowest-scored messages first:

```python
def prune_low_importance_messages(thread_id, target_token_count):
    """Remove low-importance messages until token count drops below target"""
    messages = list(agents_client.messages.list(thread_id=thread_id))
    
    # Score messages by importance
    scored_messages = [
        (msg, calculate_importance_score(msg))
        for msg in messages
    ]
    
    # Sort by score ascending (lowest importance first)
    scored_messages.sort(key=lambda x: x[1])
    
    # Create new thread, exclude low-scored messages
    new_thread = agents_client.threads.create()
    current_tokens = 0
    
    for msg, score in reversed(scored_messages):  # Add highest-scored first
        msg_tokens = len(msg.text_messages[0].text.value) // 4 if msg.text_messages else 0
        if current_tokens + msg_tokens > target_token_count:
            break
        
        agents_client.messages.create(
            thread_id=new_thread.id,
            role=msg.role,
            content=msg.text_messages[0].text.value if msg.text_messages else ""
        )
        current_tokens += msg_tokens
    
    return new_thread
```

## Make session scoping decisions

Deciding when to create a new thread versus continuing an existing thread shapes the agent's memory behavior. Two common patterns:

**Task-scoped threading** creates one thread per discrete task. Each investment research request gets its own thread. When the research completes, persist the thread summary to Cosmos DB and close the thread. Subsequent research requests start fresh threads. This pattern keeps context focused and prevents unrelated research from polluting the thread.

**Conversation-scoped threading** creates one thread per user conversation, spanning multiple tasks. An analyst has a single long-lived thread for their entire workday, covering multiple research requests. The thread accumulates context—prior decisions, mentioned preferences, established constraints. This pattern benefits workflows where carry-over context adds value ("Use the same risk parameters as the last analysis").

For the investment research platform, the team chose task-scoped threading. Each research request is independent—the thread focuses on one stock, one time period, one set of criteria. When research completes, the final recommendation gets persisted with metadata (stock ticker, timestamp, analyst ID, decision), and the thread closes. This prevents context pollution—research on MSFT doesn't influence later research on AAPL.

## Choose context management modes in Agents v2

The session state patterns in this unit—custom Cosmos DB persistence, Redis caching, message pruning—apply to Agents v1 threads. Agents v2 introduces its own context management model with three strategies that map to the tiers you've already learned.

- **Conversation-based (server-managed history):** Create a conversation with `openai.conversations.create()` and pass `conversation.id` to each response call. The service stores all items automatically—the v2 equivalent of v1 thread persistence. See Unit 3 for code examples.
- **`previous_response_id` chaining:** Chain responses by reference without a conversation object. You control context depth on each call—the v2 equivalent of sliding window retention. See Unit 3 for code examples.
- **`store=False` (zero-data-retention):** The service doesn't persist the response. Manage your own message buffer and pass prior context explicitly in every request. Use for compliance scenarios where no data may be stored server-side.

### When custom Cosmos DB is still needed in v2

Agents v2 managed history reduces the need for custom persistence, but some scenarios still require it:

| Scenario | v2 managed history enough? | Custom Cosmos DB needed? |
|---|---|---|
| Multi-turn conversational agent | Yes—use conversation-based | No |
| Cross-session memory (user preferences, past decisions) | No—conversations don't persist across explicit deletion | Yes—store key facts and inject as system context |
| Audit trail with custom metadata | Partial—conversation items exist but aren't queryable | Yes—store conversation/response IDs with business metadata |
| `store=False` compliance workflow | No—you manage everything | Yes—your own secure store |
| Long-running research with >128K context | No—auto-truncation applies | Consider—store key facts externally and reinject |

> [!NOTE]
> The v2 service auto-truncates conversation input when it exceeds the model's context window. The conversation itself isn't modified—only the input window is trimmed. For high-value facts that must never be dropped (established risk thresholds, user preferences, earlier commitments), store them in Cosmos DB and inject them explicitly as system context at the start of each session.

## Summary

- **Thread limitations** require external persistence—service threads don't survive app restarts, support cross-instance sharing, or enable historical audit trails without Cosmos DB or similar durable storage.
- **Three persistence tiers** trade complexity for durability—in-memory for stateless lookups, Cosmos DB for long-lived resumable workflows, and Redis as a low-latency caching layer for high-throughput systems.
- **Context window pressure** manifests as cost escalation, latency increase, and eventual context overflow—track token estimates proactively and trigger management strategies before hitting model limits.
- **Context management strategies** include sliding window retention (keep recent messages), selective summarization (compress low-value messages), and importance-weighted pruning (score and remove by priority).
- **Session scoping** is an architectural decision—task-scoped threads keep context focused and prevent pollution, while conversation-scoped threads enable carry-over context across multiple related tasks.
- **Agents v2 server-managed history** reduces custom persistence needs for most scenarios—use Cosmos DB for cross-session memory, queryable audit trails, or `store=False` compliance workflows where the service stores nothing.
