Production agents require robust event handling that responds to every run lifecycle event—not just success, but tool requests, failures, timeouts, and cancellations. Microsoft Foundry Agent Service exposes a rich run status taxonomy that tells you exactly why an agent stopped. Understanding and handling each status is the foundation of production-grade agentic loops.

> [!IMPORTANT]
> This module teaches the Assistants-style API (Agents v1), which uses threads, runs, and messages. Microsoft Foundry has also introduced a Responses API (Agents v2) with updated terminology (Conversations, Items, Responses) and a unified `azure-ai-projects` 2.x SDK. The Agents v1 API remains supported through March 31, 2027. If you're building a new greenfield workload, review the [migration guide](https://learn.microsoft.com/azure/foundry/agents/how-to/migrate) to evaluate which generation fits your needs.

## Review the basic run lifecycle

As you know from your earlier work with agents, the basic pattern is straightforward: create a thread, add a user message, create a run, poll until completion, and read the results. The `AgentRunStatus` enum represents where the run stopped and determines what action comes next.

```python
from azure.ai.agents import AgentsClient
from azure.identity import DefaultAzureCredential

agents_client = AgentsClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

# Basic pattern you've used before
# agent was created previously with agents_client.create_agent()
thread = agents_client.threads.create()
agents_client.messages.create(thread_id=thread.id, role="user", content="Analyze MSFT")
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)
messages = list(agents_client.messages.list(thread_id=thread.id))
```

This pattern works for simple scenarios, but production agents face eight distinct run outcomes that require different engineering responses.

## Understand the run status taxonomy

The run status represents the agent's **stop reason**—why it stopped executing and what action comes next. Each status requires a specific engineering decision.

| Status | Meaning | Next Action |
|--------|---------|-------------|
| `completed` | Agent finished successfully | Read results and terminate loop |
| `requires_action` | Agent called tools and awaits results | Submit tool outputs to continue |
| `failed` | Agent encountered an error | Check `last_error` and decide: retry, fallback, or fail |
| `cancelled` | Manual cancellation requested | Clean up resources and exit |
| `expired` | Run exceeded maximum timeout | Log timeout and retry with simpler prompt |
| `in_progress` | Agent is still executing | Continue polling |
| `cancelling` | Cancellation in progress | Wait for final `cancelled` status |
| `queued` | Run is waiting to start | Continue polling |

The `requires_action` status is the most critical. When an agent calls a tool function, the run pauses with `required_action.type == "submit_tool_outputs"`. Your code must execute the tool, then submit results using `submit_tool_outputs_and_poll()`:

```python
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)

while run.status == "requires_action":
    tool_calls = run.required_action.submit_tool_outputs.tool_calls
    tool_outputs = []
    
    for tool_call in tool_calls:
        # Execute the function locally
        result = execute_tool(tool_call.function.name, tool_call.function.arguments)
        tool_outputs.append({"tool_call_id": tool_call.id, "output": result})
    
    # Submit results and continue
    run = agents_client.runs.submit_tool_outputs_and_poll(
        thread_id=thread.id,
        run_id=run.id,
        tool_outputs=tool_outputs
    )
```

The `failed` status provides granular error information through `run.last_error.code` and `run.last_error.message`. Common error codes include `rate_limit_exceeded`, `invalid_prompt`, and `context_length_exceeded`. Each requires a different recovery strategy—retries with exponential backoff for rate limits, prompt simplification for context length errors, or immediate failure for invalid configurations.

## Manage context accumulation

The thread's message history grows with every iteration. This growth is both strength and challenge. Agents remember prior context—the market data from three turns ago, the risk thresholds set at the start. But every message consumes tokens and costs money.

**Context budget management** becomes critical in long-running loops. Track two metrics: message count and estimated token usage. A thread with dozens of messages containing detailed market data consumes substantial context on every run:

```python
messages = list(agents_client.messages.list(thread_id=thread.id))
message_count = len(messages)
estimated_tokens = sum(len(msg.text_messages[0].text.value) // 4 for msg in messages if msg.text_messages)

if estimated_tokens > 50000:
    # Context budget exceeded—see Unit 5 for context management strategy implementations
    pass
```

Once a thread approaches the model's context window limit (commonly 128K tokens), you face three options: prune old messages, summarize historical context into a compact system message, or start a new thread with a handoff summary. For the Contoso Capital investment research scenario, selective retention works well—keep analyst questions and final recommendations, summarize intermediate market data fetches, and discard low-value acknowledgments.

## Design loop termination strategies

Production agentic loops need explicit termination conditions. Without them, a loop can run indefinitely, consuming budget without delivering value. Three strategies work in practice:

**Max iteration limits** cap the number of run-submit cycles. Set this based on task complexity—a simple classification might allow 3 iterations, while complex multi-step research allows 10-15. Always include a maximum to prevent runaway loops:

```python
MAX_ITERATIONS = 10
iteration = 0

while iteration < MAX_ITERATIONS:
    run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)
    
    if run.status == "completed":
        break
    elif run.status == "requires_action":
        # Handle tool submission
        pass
    
    iteration += 1
```

**Cost-based stopping** tracks cumulative token usage or elapsed time. If an agent workflow has a $5 budget, stop when costs approach $4.80:

```python
cumulative_cost = 0.0
BUDGET_LIMIT = 5.00

while cumulative_cost < BUDGET_LIMIT:
    run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)
    cumulative_cost += estimate_run_cost(run)  # Calculate based on usage
```

**Semantic completion detection** inspects the agent's final message for completion indicators. If the last message contains phrases like "Analysis complete" or includes a structured output with a `status: "final"` field, terminate the loop. This requires careful prompt engineering to ensure agents signal completion reliably.

## Choose between streaming and polling

Microsoft Foundry Agent Service supports two execution patterns: polling and streaming. Polling calls `runs.create_and_process()` and waits for completion. Streaming uses event callbacks to receive status updates as they occur:

```python
from azure.ai.agents.models import MessageDeltaChunk, ThreadRun, AgentStreamEvent

# Polling pattern - simpler, suitable for most scenarios
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)

# Streaming pattern - real-time updates for UI feedback
with agents_client.runs.stream(thread_id=thread.id, agent_id=agent.id) as stream:
    for event_type, event_data, _ in stream:
        if isinstance(event_data, ThreadRun) and event_data.status == "completed":
            run = event_data
        elif isinstance(event_data, MessageDeltaChunk):
            print(event_data.text, end="")
        elif event_type == AgentStreamEvent.ERROR:
            print(f"Stream error: {event_data}")
        elif event_type == AgentStreamEvent.DONE:
            break
```

Polling is the right choice for backend workflows where latency matters less than code simplicity. Streaming is essential for user-facing applications where you display agent reasoning in real time. The event handling logic is identical—both patterns produce the same `AgentRun` object with the same status values.

## How Agents v2 changes the execution model

The patterns in this unit—run status handling, `requires_action` loops, context tracking—are Agents v1 constructs. Unit 3 covers the Foundry Responses API (Agents v2), which changes the execution model in two key ways.

**The `AgentRunStatus` taxonomy is gone.** In v2, `responses.create()` is synchronous: it returns output items directly or raises an exception. There's no status enum to poll, no `requires_action` to check, and no `submit_tool_outputs_and_poll()` to call. You replace the entire polling loop with a single call and an output item iterator.

**Tool handling moves from status to output items.** In v1, the agent signals tool needs via `requires_action` and you submit a batch of outputs to resume the run. In v2, tool calls appear as typed items in `response.output`. You iterate the output, find `tool_call` items, execute them locally, and pass the results as input to the next `responses.create()` call.

Unit 3 covers these changes in detail with side-by-side code. The v1 patterns in this unit remain valid—they're the foundation for the migration work in Unit 7.

## Summary

- **Run status taxonomy** drives every loop decision—eight distinct statuses (`completed`, `requires_action`, `failed`, `expired`, and others) each require a specific engineering response, not generic error handling.
- **Tool output submission** is the critical path for `requires_action`—the loop must execute local tool functions and return results via `submit_tool_outputs_and_poll()` to continue agent execution.
- **Context accumulation** grows linearly with message history, requiring proactive token tracking and pruning strategies (summarization, sliding window, or thread restart) before hitting model context limits.
- **Loop termination strategies** prevent runaway execution—combine max-iteration caps, cost-based budgets, and semantic completion detection to keep resource consumption predictable.
- **Streaming vs. polling** is a deployment decision—polling simplifies backend workflows while streaming enables real-time UI feedback, but both produce identical run status outcomes.
