## Hub-and-spoke anatomy

Hub-and-spoke orchestration treats spoke agents as executable tools on the hub agent. When you create the hub agent in Foundry Agent Service, you define function tool schemas that correspond to invoking each spoke agent. The hub's language model decides which spokes to invoke based on the user request, generates function calls, and your orchestration code executes those calls by running the spoke agents. The hub receives tool results, reasons about them, and decides whether to invoke additional spokes or synthesize a final response.

This design creates clear separation of concerns. The hub agent's system prompt describes the overall workflow and decision logic—"You coordinate investment research by delegating to specialized analysis agents. First invoke market analysis, then risk assessment, then compliance checking." Each spoke agent's prompt describes only its domain expertise—"You analyze equity market conditions and return a structured market report." The hub knows what order to invoke spokes; spokes know how to perform their specialized tasks.

Spoke agents become function definitions on the hub — you don't manually implement these functions in Python. Each function's implementation is simply "invoke spoke agent X and return its output," and your orchestration loop handles the tool execution when the hub requests it.

## Registering spoke agents as tools

Foundry Agent Service accepts tool definitions in OpenAI function calling format. Each spoke agent becomes one function definition. For Contoso Capital's investment platform, the market analysis spoke becomes a `invoke_market_analysis_agent` function.

```python
market_analysis_tool = {
    "type": "function",
    "function": {
        "name": "invoke_market_analysis_agent",
        "description": "Analyzes current market conditions for specified asset classes. Returns structured market report with price trends, volatility indicators, and sector performance.",
        "parameters": {
            "type": "object",
            "properties": {
                "asset_classes": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "Asset classes to analyze: equities, fixed_income, derivatives, commodities"
                },
                "analysis_depth": {
                    "type": "string",
                    "enum": ["summary", "detailed"],
                    "description": "Level of analysis detail required"
                }
            },
            "required": ["asset_classes"]
        }
    }
}
```

The function description guides the hub's language model in deciding when to invoke this spoke. If the user requests "analyze equity market conditions," the LLM recognizes that `invoke_market_analysis_agent` with `asset_classes: ["equities"]` satisfies that request. The parameters schema defines what information the spoke needs—you can include optional parameters like analysis depth to give the hub control over spoke behavior.

When you create the hub agent, you pass all spoke tool definitions to the agent constructor. The hub's LLM then has access to these functions and can generate tool calls requesting their execution.

## Orchestrator implementation

Your orchestrator implements the hub's execution loop: receive user input, run the hub agent until it requests tool execution, invoke spoke agents for any tool calls, submit results back to the hub, and repeat until the hub generates a final response. Foundry Agent Service uses the Assistants API pattern—you create a thread, add a user message, create a run, and poll the run status until completion.

```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential
import os
import asyncio

# Initialize unified client
client = AIProjectClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

# Create spoke agents
market_agent = client.agents.create_agent(
    model="gpt-4o",
    name="market_analysis_agent",
    instructions="You analyze equity market conditions and return structured market reports."
)

risk_agent = client.agents.create_agent(
    model="gpt-4o", 
    name="risk_assessment_agent",
    instructions="You assess investment risk based on market data and return risk scores."
)
```

Next, define the function tools that represent each spoke agent. The hub agent receives these tool definitions so its LLM can generate function calls requesting spoke execution during orchestration.

```python
# Define spoke invocation tools
spoke_tools = [
    {
        "type": "function",
        "function": {
            "name": "invoke_market_analysis_agent",
            "description": "Analyzes market conditions for specified asset classes",
            "parameters": {
                "type": "object",
                "properties": {
                    "asset_classes": {"type": "array", "items": {"type": "string"}}
                },
                "required": ["asset_classes"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "invoke_risk_assessment_agent",
            "description": "Assesses investment risk based on market analysis results",
            "parameters": {
                "type": "object",
                "properties": {
                    "market_data": {"type": "string"}
                },
                "required": ["market_data"]
            }
        }
    }
]

# Create hub agent with spoke tools
hub_agent = client.agents.create_agent(
    model="gpt-4o",
    name="research_orchestrator",
    instructions="You coordinate investment research by delegating to specialized agents. First invoke market analysis, then risk assessment based on market results.",
    tools=spoke_tools
)
```

The `invoke_spoke` function handles calling a spoke agent. It creates a new thread, posts the parameters as a user message, runs the spoke agent, and polls for completion with a timeout. If the spoke fails or times out, it returns a structured fallback response instead of raising an exception.

```python
async def invoke_spoke(spoke_name: str, parameters: dict, timeout: float = 30.0) -> str:
    """Invoke a spoke agent and return its response with timeout handling."""
    spoke_agent = market_agent if "market" in spoke_name else risk_agent
    
    try:
        # Create a thread and run for this spoke invocation
        thread = client.agents.threads.create()
        client.agents.messages.create(
            thread_id=thread.id,
            role="user",
            content=f"Analyze: {parameters}"
        )
        
        run = client.agents.runs.create(
            thread_id=thread.id,
            agent_id=spoke_agent.id
        )
        
        # Poll for completion with timeout
        deadline = asyncio.get_event_loop().time() + timeout
        while run.status in ["queued", "in_progress"]:
            if asyncio.get_event_loop().time() > deadline:
                # Timeout - return partial/fallback result
                return f"{{\"status\": \"timeout\", \"spoke\": \"{spoke_name}\"}}"
            
            await asyncio.sleep(0.5)
            run = client.agents.runs.get(
                thread_id=thread.id,
                run_id=run.id
            )
        
        if run.status == "completed":
            messages = list(client.agents.messages.list(
                thread_id=thread.id
            ))
            assistant_msg = next(
                (msg for msg in reversed(messages) if msg.role == "assistant"), None
            )
            return assistant_msg.content[0].text.value if assistant_msg else ""
        else:
            # Handle failures with graceful degradation
            return f"{{\"status\": \"error\", \"spoke\": \"{spoke_name}\", \"reason\": \"{run.status}\"}}"
    
    except Exception as e:
        # Circuit breaker: log failure, return fallback
        return f"{{\"status\": \"exception\", \"spoke\": \"{spoke_name}\", \"error\": \"{str(e)}}\"}}"}
```

The main orchestration loop creates a thread for the hub agent and polls the run status. When the hub generates tool calls (`requires_action` status), the loop invokes corresponding spoke agents, collects their results, and submits them back to the hub, allowing it to continue reasoning.

```python
async def orchestrate_hub(user_query: str):
    """Execute hub agent with spoke invocations."""
    thread = client.agents.threads.create()
    client.agents.messages.create(
        thread_id=thread.id,
        role="user",
        content=user_query
    )
    
    run = client.agents.runs.create(
        thread_id=thread.id,
        agent_id=hub_agent.id
    )
    
    while run.status in ["queued", "in_progress", "requires_action"]:
        run = client.agents.runs.get(
            thread_id=thread.id,
            run_id=run.id
        )
        
        # Handle tool calls (spoke invocations)
        if run.status == "requires_action":
            tool_calls = run.required_action.submit_tool_outputs.tool_calls
            tool_outputs = []
            
            for tool_call in tool_calls:
                function_name = tool_call.function.name
                arguments = json.loads(tool_call.function.arguments)
                
                # Invoke spoke agent
                result = await invoke_spoke(function_name, arguments)
                tool_outputs.append({
                    "tool_call_id": tool_call.id,
                    "output": result
                })
            
            # Submit spoke results back to hub
            client.agents.runs.submit_tool_outputs(
                thread_id=thread.id,
                run_id=run.id,
                tool_outputs=tool_outputs
            )
        
        await asyncio.sleep(0.5)
    
    # Return final hub response
    messages = list(client.agents.messages.list(
        thread_id=thread.id
    ))
    assistant_msg = next(
        (msg for msg in reversed(messages) if msg.role == "assistant"), None
    )
    return assistant_msg.content[0].text.value if assistant_msg else ""
```

The orchestration loop handles the `requires_action` run status, which signals that the hub agent generated tool calls. For each tool call, you invoke the corresponding spoke agent and collect its output. The `submit_tool_outputs` call sends spoke results back to the hub, allowing it to continue reasoning.

## Partial failure recovery

Production orchestration must handle spoke failures gracefully. When a spoke agent times out or returns an error, you have three recovery strategies: fallback responses, circuit breakers, and graceful degradation.

Fallback responses provide substitute data when a spoke fails. If the market analysis spoke times out, you might return cached market data from 30 minutes ago rather than failing the entire workflow. The hub agent receives the fallback data with a status indicator—`{"status": "fallback", "data": {...}, "age_minutes": 30}`—allowing it to adjust its final synthesis. For non-critical information enrichment spokes, you can return empty results and let the hub proceed with available data.

Circuit breakers prevent repeated invocation of failing spokes. Track consecutive failure counts per spoke—after three consecutive failures, stop invoking that spoke for a cooldown period. This prevents cascading failures where the hub repeatedly invokes a broken spoke, wasting time and tokens. The circuit breaker returns immediately with a "circuit open" status, and the hub can proceed without that spoke's contribution.

Graceful degradation means producing partial results rather than complete failure. If three of four market analysis sub-agents succeed, return the three successful analyses with a completeness indicator. The hub's prompt guides it to synthesize partial results with appropriate caveats—"Market analysis is based on equities, fixed income, and commodities data; derivatives analysis was unavailable."

Failure handling belongs in the orchestration layer, not in individual spokes. Each spoke simply performs its task and reports success or failure — the orchestrator owns retry logic, fallback selection, and partial result synthesis because it has workflow-level context that individual spokes don't.

## Concurrent spoke invocation

A basic hub-and-spoke implementation serializes all spoke invocations—invoke market analysis, wait for completion, invoke risk assessment, wait for completion. When spokes are independent, this serialization wastes time. Foundry Agent Service supports concurrent tool execution—when the hub's LLM generates multiple tool calls in one response, invoke them in parallel.

The Assistants API returns all tool calls that the agent requests in a single response. You can invoke all corresponding spokes concurrently using `asyncio.gather`, collect results, and submit all tool outputs back to the hub in one call. This pattern cuts latency for independent spokes—if market analysis takes 10 seconds and risk assessment takes 8 seconds, concurrent execution completes in 10 seconds instead of 18.

Be cautious with concurrent invocation when spokes have dependencies. If the hub generates tool calls for both market analysis and risk assessment in the same response, but risk assessment needs market analysis results, executing them concurrently produces incorrect results. The hub's prompt should guide it to invoke dependent spokes in separate rounds—"Always complete market analysis before invoking risk assessment." This ensures the hub sees market analysis tool results before deciding to invoke risk assessment.

> [!TIP]
> Imagine your hub agent generates tool calls for both a market analysis spoke and a risk assessment spoke in the same response, but risk assessment depends on market analysis results. How would you redesign the hub's system prompt and orchestration logic to prevent this dependency violation while still allowing independent spokes to run concurrently?

Hub-and-spoke coordinates spokes sequentially, which works well when spoke outputs depend on each other. Contoso Capital's market analysis pipeline has independent agents that waste time running one after another. The next unit builds the parallel execution pattern, including the synchronization barriers and quorum policies that make concurrent agent workflows reliable.

## Key points

- **Spoke agents as tools** is the key architectural pattern—register each spoke as a function definition on the hub agent, letting the LLM decide which spokes to invoke based on the user request
- **Orchestration loop** handles `requires_action` status by invoking spoke agents for each tool call, collecting results, and submitting them back to the hub for continued reasoning
- **Partial failure recovery** uses three strategies—fallback responses (cached or substitute data), circuit breakers (stop invoking broken spokes after consecutive failures), and graceful degradation (partial results with completeness indicators)
- **Concurrent spoke invocation** cuts latency by running independent spokes in parallel via `asyncio.gather`, but requires prompt engineering to prevent the hub from requesting dependent spokes in the same round
- **Failure handling belongs in the orchestration layer**—individual spokes simply report success or failure, while the orchestrator implements retry logic, fallback selection, and partial result synthesis
