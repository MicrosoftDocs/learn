You've spent the preceding units learning v1 production patterns and v2 equivalents side by side. This unit brings it together as a structured migration guide. You'll update SDK packages, rewrite client initialization, migrate each API surface, and verify the result — with side-by-side code for every major change.

> [!NOTE]
> A [migration tool](https://aka.ms/agent/migrate/tool) is available to help automate this migration. It migrates code constructs such as agent definitions, thread creation, message creation, and run creation. It doesn't migrate state data (past runs, threads, or messages). Use the tool for initial code conversion, then apply the production patterns in this guide for the loop and tool handling changes. Examples in this unit use Python. For C#, JavaScript, and Java equivalents, see the [full migration guide](https://learn.microsoft.com/azure/foundry/agents/how-to/migrate).

## Understand the migration scope and timeline

Agents v1 (the `azure-ai-agents` SDK with `AgentsClient`) retires **March 31, 2027**. Plan your migration with enough lead time to test production workloads — the migration tool automates most code changes, but production verification takes time.

High-level migration steps:

1. Update SDK packages
2. Update client initialization
3. Migrate agent creation to versioned agents
4. Migrate threads and message creation to conversations
5. Migrate runs and polling to responses
6. Migrate tool handling from `requires_action` to output item iteration
7. Verify behavior and retire v1 code paths

## Update SDK packages and client initialization

### SDK packages

Replace the v1 package with the v2 package:

**Before (Agents v1):**
```bash
pip install azure-ai-agents
pip install azure-identity
```

**After (Agents v2):**
```bash
pip install "azure-ai-projects>=2.0.0"
pip install azure-identity
```

> [!IMPORTANT]
> `azure-ai-projects` 2.x is incompatible with 1.x. Update all imports across your codebase at the same time as the package upgrade.

### Client initialization

The single-client architecture changes to a split client architecture.

**Before (Agents v1):**
```python
from azure.ai.agents import AgentsClient
from azure.identity import DefaultAzureCredential

agents_client = AgentsClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)
```

**After (Agents v2):**
```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

project = AIProjectClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)
openai = project.get_openai_client()
```

Use `project` for all agent creation and versioning. Use `openai` for all conversations and responses.

## Migrate agent creation and versioning

Agents are no longer created per-request with a GUID-based ID. They're now **named, versioned assets** created once and referenced by name.

**Before (Agents v1):**
```python
agent = agents_client.create_agent(
    model="gpt-4.1",
    name="investment-analyst",
    instructions="You are an expert investment analyst for Contoso Capital.",
    tools=[{"type": "function", "function": market_data_schema}],
)
# agent.id = "asst_abc123..." (GUID used in all subsequent calls)
```

**After (Agents v2):**
```python
from azure.ai.projects.models import PromptAgentDefinition, FunctionTool

agent = project.agents.create_version(
    agent_name="investment-analyst",
    definition=PromptAgentDefinition(
        model="gpt-4.1",
        instructions="You are an expert investment analyst for Contoso Capital.",
        tools=[FunctionTool(market_data_schema)],
    ),
)
# agent.name = "investment-analyst" (used in all subsequent calls)
# agent.version = "1" (auto-assigned)
```

In production, call `create_version()` during deployment, not on every request. Reference the agent by name in response calls.

## Migrate threads and runs to conversations and responses

This section covers the most significant code changes: thread creation, message injection, run creation, and the polling loop.

### Thread creation → Conversation creation

**Before (Agents v1):**
```python
thread = agents_client.threads.create()
agents_client.messages.create(
    thread_id=thread.id,
    role="user",
    content="Analyze MSFT",
)
```

**After (Agents v2):**
```python
conversation = openai.conversations.create()
# Initial input is passed directly in responses.create() — see below
# Or add items to the conversation explicitly:
openai.conversations.items.create(
    conversation_id=conversation.id,
    items=[
        {
            "type": "message",
            "role": "user",
            "content": "Analyze MSFT",
        }
    ],
)
```

### Run creation and polling → Response creation

The v1 polling loop — the most complex code in any v1 agent — is replaced by a single synchronous call.

**Before (Agents v1):**
```python
run = agents_client.runs.create_and_process(
    thread_id=thread.id,
    agent_id=agent.id,
)

# Status polling loop
while run.status in ("queued", "in_progress"):
    time.sleep(1)
    run = agents_client.runs.get(thread_id=thread.id, run_id=run.id)

if run.status == "completed":
    messages = list(agents_client.messages.list(thread_id=thread.id))
    result = messages[0].text_messages[0].text.value
elif run.status == "failed":
    print(f"Run failed: {run.last_error.code}: {run.last_error.message}")
```

**After (Agents v2):**
```python
response = openai.responses.create(
    input="Analyze MSFT",
    conversation=conversation.id,
    extra_body={
        "agent_reference": {
            "name": "investment-analyst",
            "type": "agent_reference",
        }
    },
)

# No polling loop — response is synchronous
for item in response.output:
    if item.type == "message":
        for part in item.content:
            if hasattr(part, "text"):
                result = part.text
```

The `AgentRunStatus` taxonomy (`queued`, `in_progress`, `completed`, `requires_action`, `failed`, `expired`, `cancelled`, `cancelling`) does not exist in v2. The response either succeeds or raises an exception — handle failures with standard Python `try/except`.

## Migrate tool handling

### `requires_action` loop → output item iteration

The v1 tool submission pattern — polling for `requires_action`, calling `submit_tool_outputs_and_poll()` — is replaced by iterating output items.

**Before (Agents v1):**
```python
run = agents_client.runs.create_and_process(thread_id=thread.id, agent_id=agent.id)

while run.status == "requires_action":
    tool_calls = run.required_action.submit_tool_outputs.tool_calls
    tool_outputs = []
    for tool_call in tool_calls:
        result = execute_tool(tool_call.function.name, tool_call.function.arguments)
        tool_outputs.append({"tool_call_id": tool_call.id, "output": result})
    run = agents_client.runs.submit_tool_outputs_and_poll(
        thread_id=thread.id,
        run_id=run.id,
        tool_outputs=tool_outputs,
    )
```

**After (Agents v2):**
```python
import json

def run_with_tools(conversation_id, user_input, agent_name):
    response = openai.responses.create(
        input=user_input,
        conversation=conversation_id,
        extra_body={"agent_reference": {"name": agent_name, "type": "agent_reference"}},
    )

    tool_results = []
    for item in response.output:
        if item.type == "tool_call" and item.tool_type == "function":
            result = execute_tool(
                item.function.name,
                json.loads(item.function.arguments),
            )
            tool_results.append({
                "type": "tool_result",
                "tool_call_id": item.id,
                "output": result,
            })

    if tool_results:
        response = openai.responses.create(
            input=tool_results,
            conversation=conversation_id,
            extra_body={"agent_reference": {"name": agent_name, "type": "agent_reference"}},
        )

    return response
```

### Tool availability changes

Several tools changed availability between v1 and v2. Review this table before migrating:

| Tool | Agents v1 (classic) | Agents v2 (new) |
|---|---|---|
| Azure AI Search | GA | GA |
| Code Interpreter | GA | GA |
| File Search | GA | GA |
| Function | GA | GA |
| Grounding with Bing Search | GA | GA |
| MCP | Preview | **GA** |
| OpenAPI | GA | GA |
| **Azure Functions** | **GA** | **Removed** — use Function tool via MCP |
| **Web Search** | Not available | **GA** |
| **Image Generation** | Not available | **Preview** |
| **Agent to Agent (A2A)** | Not available | **Preview** |
| Connected Agents | Preview | Removed — use Workflow and A2A tool |
| Browser Automation | Preview | Preview |
| Computer Use | Preview | Preview |

> [!IMPORTANT]
> If your v1 agents use **Azure Functions tool**, you must migrate to the **Function tool** (via MCP or OpenAPI) before upgrading to v2. There is no direct equivalent — plan this change as part of your migration scope.

## Verify the migration

After updating your code, run through this verification checklist before promoting to production:

1. **Package imports compile** — no `azure.ai.agents` imports remain in migrated files
2. **Agent creation succeeds** — `create_version()` returns an object with `name` and `version` fields
3. **Conversation creation succeeds** — `openai.conversations.create()` returns a conversation with an `id` starting with `conv_`
4. **Single-turn response works** — `responses.create()` returns output items with at least one message item
5. **Tool calls execute** — if your agent uses function tools, confirm tool call items appear in `response.output` and results are submitted correctly
6. **Multi-turn context retained** — send two responses to the same conversation and confirm the agent references the first response in the second
7. **Error handling works** — force an error (invalid input or model overload) and confirm your `try/except` catches it correctly

### Common migration mistakes

| Mistake | Symptom | Fix |
|---|---|---|
| Using project client for responses | `AttributeError` on `project.responses` | Use `openai.responses.create()` |
| Writing a `requires_action` polling loop | Loop never triggers | Remove the loop — v2 has no `requires_action` |
| Passing GUID `agent_id` where name is expected | `404 Not Found` | Pass `agent.name` string, not `agent.id` |
| Not iterating `response.output` for tool calls | Tools appear to do nothing | Check for `tool_call` items in `response.output` |
| Expecting `run.last_error` on failure | `AttributeError` | Catch exceptions with `try/except` |

## Summary

- **SDK and client changes** are the first migration step — replace `azure-ai-agents` with `azure-ai-projects>=2.0.0`, and replace single `AgentsClient` with `AIProjectClient` (admin) + `project.get_openai_client()` (runtime).
- **Agent creation** moves from GUID-based `create_agent()` to named, versioned `create_version()` — agents become durable Foundry assets, not per-request objects.
- **The polling loop is eliminated** — replace `run.status` polling and `AgentRunStatus` checks with a single synchronous `responses.create()` call; handle failures with standard exception handling.
- **Tool handling** moves from `requires_action` + `submit_tool_outputs_and_poll()` to iterating `response.output` for `function_call` items and passing `function_call_output` results as input to the next response.
- **Tool availability changes require architectural decisions** — Azure Functions tool is removed in v2 (migrate to Function tool via MCP), while Web Search, Image Generation, and A2A are new additions exclusive to v2.
