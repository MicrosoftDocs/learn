Agent workflows often require exploring multiple reasoning paths from the same starting context. An analyst examining an investment opportunity might want to explore bull-case and bear-case scenarios simultaneously without re-running the entire data collection phase. **Fork-based sessions** enable this branching pattern through thread state management.

## Understand the fork pattern and its use cases

Fork-based sessions solve the alternative hypothesis exploration problem. Without forking, exploring multiple paths requires either re-executing the entire workflow from the start (expensive, slow) or complex manual state duplication (error-prone). Forking provides a clean abstraction: checkpoint the session state, then spawn independent branches that diverge from that point.

The pattern comes from version control systems—Git's branching model maps directly to agent sessions. Create a checkpoint (like a commit), fork multiple branches (like feature branches), explore independently, then optionally merge results.

| Use Case | Why Fork | Typical Branches |
|----------|----------|------------------|
| Investment scenario analysis | Explore bull/bear cases from same data | 2-3 (optimistic, pessimistic, baseline) |
| Diagnostic decision trees | Consider alternative diagnoses | 3-5 (per differential diagnosis) |
| Design alternatives | Generate multiple architecture proposals | 2-4 (per design approach) |
| A/B prompt testing | Test prompt variations on same input | 2-10 (per prompt variant) |

In the Contoso Capital scenario, after collecting market data and performing baseline analysis, you fork into bull-case and bear-case branches. Each branch runs the same reasoning agent with different parameters—bull case assumes 20% growth, bear case assumes 5% decline. Both branches start with identical context, diverging only in assumptions.

## Implement fork-based sessions with checkpointing

The implementation uses thread message serialization. At the fork point, serialize the thread state to durable storage. To create a fork, restore that checkpoint into a new thread, add the branch-specific instruction, and run:

```python
def create_checkpoint(thread_id, checkpoint_name, metadata=None):
    """Create a named checkpoint of thread state"""
    messages = list(agents_client.messages.list(thread_id=thread_id))
    
    checkpoint_doc = {
        "id": f"{thread_id}_{checkpoint_name}",
        "checkpoint_name": checkpoint_name,
        "parent_thread_id": thread_id,
        "created_at": datetime.utcnow().isoformat(),
        "metadata": metadata or {},
        "messages": [
            {
                "role": msg.role,
                "content": msg.text_messages[0].text.value if msg.text_messages else "",
                "created_at": msg.created_at
            }
            for msg in messages
        ]
    }
    
    # Store in Cosmos DB
    checkpoint_container.upsert_item(checkpoint_doc)
    return checkpoint_doc["id"]

def fork_from_checkpoint(checkpoint_id, branch_instruction):
    """Create a new thread from a checkpoint with diverging instruction"""
    # Load checkpoint
    checkpoint = checkpoint_container.read_item(item=checkpoint_id, partition_key=checkpoint_id)
    
    # Create new thread
    fork_thread = agents_client.threads.create()
    
    # Replay checkpoint messages
    for msg in checkpoint["messages"]:
        agents_client.messages.create(
            thread_id=fork_thread.id,
            role=msg["role"],
            content=msg["content"]
        )
    
    # Add branch-specific instruction
    agents_client.messages.create(
        thread_id=fork_thread.id,
        role="user",
        content=branch_instruction
    )
    
    # Tag the thread with metadata for lifecycle management
    thread_metadata = {
        "fork_id": f"fork_{fork_thread.id}",
        "parent_checkpoint": checkpoint_id,
        "branch_instruction": branch_instruction,
        "created_at": datetime.utcnow().isoformat()
    }
    
    return fork_thread, thread_metadata
```

The workflow looks like this: run the agent through data collection, create a checkpoint, fork into bull and bear branches, run both branches, collect results:

```python
# Phase 1: Data collection (common path)
thread = agents_client.threads.create()
agents_client.messages.create(
    thread_id=thread.id,
    role="user",
    content="Collect market data for MSFT covering 2020-2025"
)
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=data_agent.id)

# Create checkpoint after data collection
checkpoint_id = create_checkpoint(thread.id, "data_collected", {"stock": "MSFT"})

# Phase 2: Fork into scenario branches
bull_thread, bull_metadata = fork_from_checkpoint(
    checkpoint_id,
    "Analyze this data assuming 20% annual growth scenario. Provide bull-case recommendation."
)

bear_thread, bear_metadata = fork_from_checkpoint(
    checkpoint_id,
    "Analyze this data assuming 5% annual decline scenario. Provide bear-case recommendation."
)

# Phase 3: Run both forks independently (can parallelize)
bull_run = agents_client.runs.create_and_process(thread_id=bull_thread.id, agent_id=analyst_agent.id)
bear_run = agents_client.runs.create_and_process(thread_id=bear_thread.id, agent_id=analyst_agent.id)

# Phase 4: Collect results
bull_messages = list(agents_client.messages.list(thread_id=bull_thread.id))
bear_messages = list(agents_client.messages.list(thread_id=bear_thread.id))

bull_recommendation = bull_messages[0].text_messages[0].text.value
bear_recommendation = bear_messages[0].text_messages[0].text.value
```

Data collection runs once, and both scenario analyses reuse that context. Without forking, you'd run data collection twice, doubling costs and latency.

## Support conversation resumption

Fork-based patterns also enable **conversation resumption**—allowing users to interrupt long workflows and resume later. The pattern is identical: serialize thread state when the user pauses, restore it when they return.

A Contoso Capital analyst starts research at 2 PM on Friday, completes 60% of the workflow, then leaves for the weekend. The application persists the thread state to Cosmos DB. Monday morning, the analyst resumes by restoring the checkpoint into a new thread and continuing:

```python
def pause_session(thread_id, user_id):
    """Save session state when user pauses"""
    checkpoint_id = create_checkpoint(thread_id, f"pause_{user_id}", {"user_id": user_id})
    return checkpoint_id

def resume_session(checkpoint_id):
    """Resume from saved session"""
    checkpoint = checkpoint_container.read_item(item=checkpoint_id, partition_key=checkpoint_id)
    
    # Create new thread with resumed state
    resumed_thread = agents_client.threads.create()
    
    for msg in checkpoint["messages"]:
        agents_client.messages.create(
            thread_id=resumed_thread.id,
            role=msg["role"],
            content=msg["content"]
        )
    
    return resumed_thread
```

Resumption works because threads are message histories—replaying messages reconstructs the agent's context. This pattern handles not just intentional pauses but also failure recovery. If an agent run fails mid-workflow, checkpoint the state before the failure, diagnose the issue, then resume from the checkpoint with a corrected prompt or fixed tool configuration.

## Manage forked thread lifecycles

Forked threads accumulate quickly. An analyst running 10 research requests with 3 forks each creates 30 threads. Without lifecycle management, threads and their storage costs grow unbounded.

**Thread lifecycle policies** govern when to archive or delete threads:

- **Time-based expiration**: Delete threads older than 30 days unless tagged as "archived"
- **Status-based cleanup**: Delete threads with status "abandoned" or "completed" after results are extracted
- **Fork pruning**: When a fork completes, extract the final result to permanent storage, then delete the thread
- **Parent-child cleanup**: When all child forks complete, delete the parent checkpoint

Implement lifecycle management with thread metadata tags:

```python
def archive_completed_fork(thread_id, thread_metadata):
    """Extract results and delete the fork thread"""
    # Extract final messages
    messages = list(agents_client.messages.list(thread_id=thread_id))
    final_result = messages[0].text_messages[0].text.value if messages else ""
    
    # Store result in permanent archive
    archive_doc = {
        "id": thread_metadata["fork_id"],
        "parent_checkpoint": thread_metadata["parent_checkpoint"],
        "branch_instruction": thread_metadata["branch_instruction"],
        "result": final_result,
        "completed_at": datetime.utcnow().isoformat(),
        "status": "archived"
    }
    archive_container.upsert_item(archive_doc)
    
    # Thread can now be deleted (messages are preserved in archive)
    # Note: Microsoft Foundry Agent Service threads may have automatic lifecycle policies

def cleanup_old_checkpoints(days_threshold=30):
    """Delete checkpoints older than threshold"""
    cutoff_date = datetime.utcnow() - timedelta(days=days_threshold)
    
    query = "SELECT * FROM c WHERE c.created_at < @cutoff AND c.status != 'archived'"
    items = checkpoint_container.query_items(
        query=query,
        parameters=[{"name": "@cutoff", "value": cutoff_date.isoformat()}],
        enable_cross_partition_query=True
    )
    
    for item in items:
        checkpoint_container.delete_item(item=item["id"], partition_key=item["id"])
```

Lifecycle management prevents runaway storage costs. A busy system can create hundreds or thousands of threads per day, and retaining all of them indefinitely adds up. A cleanup policy (for example, deleting non-archived threads after seven days) keeps storage costs predictable.

## Understand when not to fork

Forking adds operational complexity—multiple threads to track, lifecycle policies to enforce, checkpoint storage costs. Only use fork-based patterns when the value justifies the complexity.

**Don't fork when:**
- Sequential exploration suffices (explore path A, if it fails, try path B)
- Paths are fully independent with no shared context (run separate threads from the start)
- The shared context is small (re-running setup is cheaper than fork infrastructure)

**Do fork when:**
- Expensive shared setup (data collection, document processing, context building)
- Exploring alternatives simultaneously (scenario analysis, A/B testing)
- Need to resume interrupted workflows (long-running research, diagnostic workflows)

In the Contoso Capital scenario, forking makes sense for scenario analysis where shared data collection is expensive, but not for sequential stock screening where each stock is independent with no shared context worth preserving.

## Fork sessions using the Responses API (v2)

The v1 fork pattern uses Cosmos DB serialization: serialize thread messages, create a new thread per branch, deserialize into each thread. In Agents v2, two simpler approaches eliminate the serialization step.

### Fork via `previous_response_id`

Because each response in v2 carries its own context chain, you fork by pointing multiple new responses at the same parent response ID. No serialization. No new thread creation. No Cosmos DB needed for the fork itself.

```python
# Shared context: run data collection and analysis once
base_response = openai.responses.create(
    input="Collect and analyze MSFT fundamental and technical data.",
    conversation=conversation.id,
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)

# Fork 1: Bull-case scenario—chains from base_response
bull_response = openai.responses.create(
    input="Based on the data you collected, develop a bull-case investment thesis.",
    previous_response_id=base_response.id,  # Fork point
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)

# Fork 2: Bear-case scenario—also chains from base_response, independently
bear_response = openai.responses.create(
    input="Based on the same data, develop a bear-case investment thesis with downside risks.",
    previous_response_id=base_response.id,  # Same fork point—independent branch
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)
```

Both branches share the same parent context but diverge from `base_response.id`. Each branch's subsequent responses chain from their own line—`bull_response.id` or `bear_response.id`. The branches never merge server-side.

### Fork via conversation duplication

When you need branches to accumulate many turns (and don't want a long `previous_response_id` chain), duplicate the conversation by copying its items into a new conversation.

```python
# Get all items from the shared conversation up to the fork point
items = list(openai.conversations.items.list(conversation_id=base_conversation.id))

# Create a new conversation for each branch
bull_conversation = openai.conversations.create()

# Seed the new conversation with the shared context
openai.conversations.items.create(
    conversation_id=bull_conversation.id,
    items=[item.model_dump() for item in items],
)

# Branch 1 continues in its own conversation
bull_response = openai.responses.create(
    input="Develop a bull-case investment thesis.",
    conversation=bull_conversation.id,
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)
```

### Background mode for parallel branches

Run multiple fork branches concurrently using background mode. Each branch launches immediately and the results are retrieved when all are complete.

```python
# Launch both branches in background mode—they run in parallel
bull_job = openai.responses.create(
    input="Develop a bull-case thesis.",
    previous_response_id=base_response.id,
    background=True,
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)

bear_job = openai.responses.create(
    input="Develop a bear-case thesis.",
    previous_response_id=base_response.id,
    background=True,
    extra_body={"agent_reference": {"name": "investment-analyst", "type": "agent_reference"}},
)

# Store job IDs—poll both until complete
import time
jobs = {"bull": bull_job.id, "bear": bear_job.id}
results = {}

while jobs:
    for name, response_id in list(jobs.items()):
        job = openai.responses.retrieve(response_id)
        if job.status != "in_progress":
            results[name] = job
            del jobs[name]
    if jobs:
        time.sleep(2)
```

> [!NOTE]
> The `previous_response_id` fork approach (first pattern) is simpler and doesn't require conversation management for short-to-medium depth branches. Use conversation duplication when branches will accumulate many turns over time. Background mode is the right complement for any parallel branch pattern—it lets both branches execute concurrently rather than sequentially.

## Summary

- **Fork-based sessions** solve the alternative hypothesis exploration problem by checkpointing thread state and spawning independent branches that diverge from a common starting context.
- **Checkpoint-and-restore** serializes thread messages to Cosmos DB at strategic points, enabling both scenario branching (bull/bear case analysis) and conversation resumption after interruptions or failures.
- **Efficiency gains** come from avoiding redundant computation—expensive data collection runs once, and all forked branches reuse that context rather than starting from scratch.
- **Thread lifecycle management** is essential to prevent unbounded storage growth—implement time-based expiration, status-based cleanup, fork pruning after result extraction, and parent-child cascade deletion.
- **Fork selectively**—only use forking when shared setup is expensive and parallel exploration adds value; for independent tasks with no shared context, separate threads from the start are simpler.
- **Agents v2 eliminates fork serialization overhead**—fork by pointing multiple `responses.create()` calls at the same `previous_response_id`, with no thread creation or Cosmos DB serialization required.
- **Background mode enables parallel branch execution in v2**—launch both branches with `background=True`, store the response IDs, and poll for completion concurrently.
