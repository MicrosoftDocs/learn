Unit 2 covered the Agents v1 run lifecycle in depth — eight status values, polling loops, tool output submission. That model works well, but the Foundry Agents v2 Responses API is a different design with a simpler execution model and a modernized SDK. Before applying production patterns in Units 4–6, you need to understand how the v2 model maps to what you already know.

## Map Agents v2 runtime components to Agents v1 concepts

Agents v2 uses three runtime components: **agents**, **conversations**, and **responses**. Each maps directly to a v1 concept, but with meaningful behavioral differences.

| Agents v1 | Agents v2 | Key difference |
|-----------|-----------|----------------|
| Assistant / agent (GUID-based) | Agent (name + version) | Agents are now named, versioned assets stored in Foundry — not ephemeral GUIDs |
| Thread (messages only) | Conversation (items) | Conversations store messages, tool calls, tool outputs, and other data as typed items |
| Run (async, polled) | Response (synchronous or background) | Responses return output items directly — no status enum to poll |
| Message | Item | Items are typed: message, function_call, function_call_output, and others |

The most significant conceptual shift is the run → response change. In v1, you create a run and poll its status until it reaches `completed`, `requires_action`, or a terminal state. In v2, a `responses.create()` call either succeeds and returns output items, or fails with an exception. There's no status loop to write for the common case.

## Initialize the split client architecture

Agents v1 used a single `AgentsClient` for everything. Agents v2 splits responsibilities across two clients:

- **Project client** (`AIProjectClient`): creates and versions agents, manages agent definitions. This is the admin plane.
- **OpenAI client** (obtained from the project client): creates conversations and generates responses. This is the runtime plane.

```python
import os
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

# Initialize the project client
project = AIProjectClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

# Obtain the OpenAI client from the project client
openai = project.get_openai_client()
```

> [!IMPORTANT]
> In v2, conversations and responses always use the `openai` client, not the `project` client. Using the project client for `responses.create()` is the most common migration mistake and produces a runtime error.

## Implement the v2 core agent loop

With both clients initialized, the core agent loop follows a clean four-step pattern: create an agent version, create a conversation, generate a response, and read the output.

```python
from azure.ai.projects.models import PromptAgentDefinition

# Step 1: Create a versioned agent (use project client)
agent = project.agents.create_version(
    agent_name="investment-analyst",
    definition=PromptAgentDefinition(
        model="gpt-4.1",
        instructions=(
            "You are an expert investment analyst for Contoso Capital. "
            "Analyze stocks using provided market data tools."
        ),
    ),
)

# Step 2: Create a conversation (use openai client)
conversation = openai.conversations.create()

# Step 3: Generate a response (use openai client)
response = openai.responses.create(
    input="Analyze MSFT and provide a buy/hold/sell recommendation.",
    conversation=conversation.id,
    extra_body={
        "agent_reference": {
            "name": agent.name,
            "type": "agent_reference",
        }
    },
)

# Step 4: Read output items
for item in response.output:
    if item.type == "message":
        for part in item.content:
            if hasattr(part, "text"):
                print(part.text)
```

Agents are durable assets in Foundry — you create a version once and reuse it by name across many response calls. In production, you typically call `create_version()` during deployment, not on every request.

## Handle tool call output items

In v1, when an agent needed a tool, the run entered `requires_action` and you submitted outputs via `submit_tool_outputs_and_poll()`. In v2, function calls appear as items in `response.output`. You iterate the output, find `function_call` items, execute the functions locally, then generate a new response with the results as input.

```python
import json
from openai.types.responses.response_input_param import FunctionCallOutput

def run_agent_with_tools(conversation_id, user_input, agent_name):
    """Run one agent turn, handling any function calls in the response."""
    response = openai.responses.create(
        input=user_input,
        conversation=conversation_id,
        extra_body={
            "agent_reference": {
                "name": agent_name,
                "type": "agent_reference",
            }
        },
    )

    # Iterate output items to find function calls
    function_outputs = []
    for item in response.output:
        if item.type == "function_call":
            result = execute_tool(
                item.name,
                json.loads(item.arguments)
            )
            function_outputs.append(
                FunctionCallOutput(
                    type="function_call_output",
                    call_id=item.call_id,
                    output=result,
                )
            )

    # If there were function calls, submit results and get the final response
    if function_outputs:
        response = openai.responses.create(
            input=function_outputs,
            conversation=conversation_id,
            extra_body={
                "agent_reference": {
                    "name": agent_name,
                    "type": "agent_reference",
                }
            },
        )

    return response
```

The key difference from v1: there's no status polling. The response object is always the final output or a set of tool calls to execute — never an intermediate state.

## Choose a context management strategy

Agents v2 provides three context management strategies, each suited to different scenarios.

**Conversation-based (server-managed history):** The service stores all items in the conversation object. Reference the same `conversation.id` across response calls — the agent sees full history automatically. This is the closest equivalent to v1 threads.

```python
# All responses use the same conversation_id — history is managed server-side
response1 = openai.responses.create(input="Analyze MSFT", conversation=conversation.id, ...)
response2 = openai.responses.create(input="Now compare to GOOG", conversation=conversation.id, ...)
```

**`previous_response_id` chaining (stateless):** No conversation object is needed. Pass the ID of the previous response to carry forward context. Each response stores its own history, and you chain them by reference. This gives you more control over context without a persistent conversation object.

```python
# Stateless chaining — no conversation needed
response1 = openai.responses.create(input="Analyze MSFT", ...)
response2 = openai.responses.create(
    input="Now compare to GOOG",
    previous_response_id=response1.id,
    ...
)
```

**`store=False` (zero-data-retention):** The service doesn't persist the response. You must carry forward the conversation context yourself by passing previous output items as input to the next request. Use this for compliance scenarios where no data may be stored server-side.

| Strategy | Server stores history | Control over what's retained | Use when |
|---|---|---|---|
| Conversation | Yes | Service manages | Long-lived sessions, debugging, cross-session continuity |
| `previous_response_id` | Yes (per response) | You control the chain | Stateless flows, flexible branching |
| `store=False` | No | Full control | Zero-data-retention environments |

> [!NOTE]
> If a conversation exceeds the model's context window, the service auto-truncates input — the conversation itself is not modified. For high-value content that must always be retained, use the custom persistence patterns from Unit 5.

## Apply streaming and background execution modes

Agents v2 supports the same streaming and polling modes as v1, plus a new **background mode** for long-running tasks.

**Background mode** runs the agent asynchronously and returns immediately. Use it for tasks that may take minutes, such as image generation, deep research, or complex code execution. Poll the response status by ID until it completes.

```python
# Launch a long-running agent task in background mode
response = openai.responses.create(
    input="Generate a comprehensive equity research report for MSFT covering 2020-2025.",
    conversation=conversation.id,
    background=True,
    extra_body={
        "agent_reference": {
            "name": "research-analyst",
            "type": "agent_reference",
        }
    },
)

# response.status is "in_progress" — poll until complete
import time
while response.status == "in_progress":
    time.sleep(2)
    response = openai.responses.retrieve(response.id)

# Read final output
for item in response.output:
    if item.type == "message":
        for part in item.content:
            if hasattr(part, "text"):
                print(part.text)
```

Background mode also supports disconnect/reconnect: store the `response.id` and retrieve it from any process or instance. This complements the session state patterns from Unit 5 — background responses are naturally resumable.

**Decision guide:**

| Mode | When to use |
|---|---|
| Synchronous (default) | Backend workflows, short-to-medium tasks |
| Streaming | User-facing applications, real-time output display |
| Background | Long-running tasks (minutes), disconnect/reconnect scenarios |

## Summary

- **Three runtime components** map v1 to v2: agents (name + version) replace GUID-based agents; conversations (typed items) replace threads (messages only); responses replace runs with direct output item returns.
- **Split client architecture** is the first code change in any v2 migration — use `AIProjectClient` for agent admin and `project.get_openai_client()` for all conversations and responses.
- **Tool call handling** moves from a `requires_action` polling loop to explicit output item iteration — find `function_call` items in `response.output`, execute locally, and submit results as `function_call_output` items to the next response call.
- **Context management** offers three strategies: conversation-based (server-managed history), `previous_response_id` chaining (stateless, flexible), and `store=False` (zero-data-retention compliance).
- **Background mode** enables long-running agent tasks with disconnect/reconnect support — launch with `background=True`, store the response ID, and poll until completion.
