## Why parallel execution matters

Contoso Capital's risk assessment agent and market analysis agent operate independently—risk assessment evaluates portfolio exposure to volatility, while market analysis examines current pricing trends. Running these agents sequentially wastes time. If market analysis takes 12 seconds and risk assessment takes 10 seconds, sequential execution takes 22 seconds. Parallel execution completes in 12 seconds, the maximum of the two agent runtimes.

For multi-agent workflows with independent tasks, parallel execution cuts latency proportionally to the number of concurrent agents. Four agents running in parallel complete in roughly the time of the slowest agent, rather than the sum of all agents. This matters in production scenarios where users wait for investment research reports—reducing report generation from 90 seconds to 25 seconds improves perceived responsiveness dramatically.

The implementation pattern is fan-out and fan-in. Fan-out spawns multiple agent tasks simultaneously. Fan-in waits for all (or some threshold of) agents to complete before proceeding. Your orchestration code manages synchronization to ensure downstream agents only see complete results from their upstream dependencies.

## Fan-out pattern implementation

Python's `asyncio` library provides native support for concurrent task execution. You spawn multiple agent runs concurrently using `asyncio.create_task` for each agent, then await their completion together. Azure AI Foundry Agent Service supports concurrent API calls—you can create multiple agent runs simultaneously without blocking.

```python
import asyncio
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential
import os

client = AIProjectClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

async def run_agent(agent_id: str, user_input: str, timeout: float = 30.0) -> dict:
    """Run a single agent and return its result with status."""
    try:
        thread = client.agents.threads.create()
        client.agents.messages.create(
            thread_id=thread.id, 
            role="user", 
            content=user_input
        )
        
        run = client.agents.runs.create(
            thread_id=thread.id,
            agent_id=agent_id
        )
        
        # Poll for completion with timeout
        deadline = asyncio.get_event_loop().time() + timeout
        while run.status in ["queued", "in_progress"]:
            if asyncio.get_event_loop().time() > deadline:
                return {"status": "timeout", "agent_id": agent_id, "result": None}
            
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
            return {
                "status": "success", 
                "agent_id": agent_id,
                "result": assistant_msg.content[0].text.value if assistant_msg else ""
            }
        else:
            return {"status": "error", "agent_id": agent_id, "result": None}
    
    except Exception as e:
        return {"status": "exception", "agent_id": agent_id, "error": str(e)}

async def parallel_research_agents(market_agent_id: str, risk_agent_id: str, esg_agent_id: str):
    """Execute three research agents in parallel with minimum quorum requirement."""
    
    # Fan-out: spawn all agents concurrently
    market_task = asyncio.create_task(
        run_agent(market_agent_id, "Analyze current equity market conditions", timeout=15.0)
    )
    risk_task = asyncio.create_task(
        run_agent(risk_agent_id, "Assess portfolio risk exposure", timeout=15.0)
    )
    esg_task = asyncio.create_task(
        run_agent(esg_agent_id, "Evaluate ESG compliance", timeout=20.0)
    )
    
    # Fan-in: wait for all agents with individual timeouts
    results = await asyncio.gather(market_task, risk_task, esg_task, return_exceptions=True)
    
    # Apply minimum-quorum policy
    successful_results = [r for r in results if isinstance(r, dict) and r["status"] == "success"]
    
    if len(successful_results) < 2:
        # Fail: need at least 2 of 3 agents to succeed
        return {
            "status": "insufficient_quorum",
            "successful_count": len(successful_results),
            "required_count": 2
        }
    
    return {
        "status": "success",
        "market_analysis": next((r["result"] for r in results if r.get("agent_id") == market_agent_id and r["status"] == "success"), None),
        "risk_assessment": next((r["result"] for r in results if r.get("agent_id") == risk_agent_id and r["status"] == "success"), None),
        "esg_evaluation": next((r["result"] for r in results if r.get("agent_id") == esg_agent_id and r["status"] == "success"), None)
    }
```

The fan-out pattern creates three concurrent tasks, each running an independent agent. `asyncio.gather` implements the synchronization barrier—it blocks until all tasks complete (or raise exceptions). The `return_exceptions=True` parameter prevents one agent failure from canceling other agents—instead, exceptions are returned as results that you can handle individually.

## Synchronization barriers and partial results

`asyncio.gather` provides an all-or-nothing synchronization barrier—wait for all tasks to complete. For optional enrichment agents, you might want partial results. Python's `asyncio.wait` offers more flexible synchronization with completion criteria.

With `asyncio.wait(tasks, return_when=asyncio.FIRST_COMPLETED)`, you get results as soon as one task completes. This pattern supports racing multiple agents—invoke three different market data providers concurrently and use whichever responds first. With `return_when=asyncio.FIRST_EXCEPTION`, you stop waiting as soon as any task fails, implementing fail-fast logic.

For Contoso Capital's scenario, the market analysis and risk assessment agents are critical—the workflow fails if either fails. The ESG evaluation agent is optional enrichment—if it succeeds, include ESG data in the final report, but don't fail the workflow if ESG evaluation times out. You implement this with threshold-based quorum logic: require at least two of three agents to succeed.

The quorum policy inspects the `results` from `asyncio.gather` and counts successful completions. If fewer than the required threshold succeed, the workflow fails with an `insufficient_quorum` status. If the threshold is met, return partial results with missing fields set to `None`. Downstream synthesis agents check for `None` values and adjust their output accordingly.

## Race condition prevention

When multiple agents write to shared state concurrently, you need synchronization to prevent data corruption. Contoso Capital's agents contribute sections to a shared research document. If two agents write simultaneously, one agent's output can overwrite the other's, producing an incomplete document.

The safest pattern for agent orchestration is queue-based merge after all agents complete. Each agent writes to isolated storage—agent A writes to `document_section_a`, agent B writes to `document_section_b`. After the synchronization barrier, a single merge task combines sections into the final document. This eliminates concurrent writes entirely.

If you need real-time updates as agents complete, implement write serialization with locks. Python's `asyncio.Lock` provides mutual exclusion—only one coroutine holds the lock at a time. Agents acquire the lock before writing, ensuring sequential writes even when agents complete at different times.

```python
document_lock = asyncio.Lock()
shared_document = {"sections": []}

async def agent_with_document_write(agent_id: str, section_content: str):
    """Agent that writes to shared document with lock protection."""
    result = await run_agent(agent_id, "Generate analysis")
    
    # Acquire lock before writing
    async with document_lock:
        shared_document["sections"].append({
            "agent": agent_id,
            "content": section_content,
            "timestamp": datetime.now().isoformat()
        })
    
    return result
```

The lock prevents interleaved writes, but it serializes write operations even though agents run in parallel. This limits parallelism benefits—if agents spend most of their time generating content (good), lock contention is minimal. If agents write frequently (problematic), contention degrades performance back toward sequential execution.

## Timeout and deadline propagation

Each parallel agent needs an individual timeout to prevent indefinite waiting. If you have a 60-second deadline for the entire workflow and run four agents in parallel, each agent gets a per-agent timeout that ensures the workflow completes within the deadline.

The calculation depends on whether agents run in rounds or fully in parallel. For one parallel round, divide the total deadline by the number of sequential rounds plus buffer. For two rounds (first round has two parallel agents, second round has one dependent agent), and a 60-second deadline: first round agents get 25 seconds each, second round gets 25 seconds, leaving 10 seconds for orchestration overhead.

You pass the timeout parameter to each `run_agent` call. The agent's polling loop compares current time against the deadline and returns a timeout status if the deadline passes. Downstream code treats timeouts as partial failures subject to your quorum policy.

## Handling partial failures with quorum policies

When one of four parallel agents fails, should the entire workflow fail? The answer depends on agent criticality. Contoso Capital defines three failure policies: fail-fast, best-effort, and minimum-quorum.

Fail-fast aborts the workflow as soon as any agent fails. Use fail-fast when all agents are critical and partial results have no value. Implement with `return_when=asyncio.FIRST_EXCEPTION` and cancel remaining tasks when one fails.

Best-effort proceeds with whatever results are available. If three of four agents succeed, use those three results and note the missing data in the final output. This policy works for enrichment scenarios where partial data is better than no data.

Minimum-quorum requires a threshold of successful agents before proceeding. For Contoso Capital's research platform, compliance regulations require at least two of three market analysis sub-agents (equities, fixed income, derivatives) to succeed. If only one succeeds, the analysis is too incomplete to meet compliance standards. You implement quorum by counting successful results and comparing against the threshold.

The code example earlier shows minimum-quorum implementation—count successful results, compare against the required threshold (2), and return an `insufficient_quorum` status if the threshold isn't met. Downstream orchestration handles insufficient quorum as a workflow failure that might trigger retry or human escalation.

## Parallel execution performance considerations

Parallel execution improves latency but increases infrastructure load. Running four agents concurrently creates four simultaneous API calls to Azure AI Foundry. Each agent consumes token quota, and all consume it simultaneously. If your deployment has rate limits, concurrent execution can hit throttling errors where sequential execution would succeed.

Monitor deployment utilization and set concurrency limits based on quota. If your deployment handles 1,000 tokens per minute and each agent uses 500 tokens, you can safely run two concurrent agents but four would risk throttling. Implement a semaphore to limit concurrent agent tasks.

```python
semaphore = asyncio.Semaphore(2)  # Limit to 2 concurrent agents

async def run_agent_with_limit(agent_id: str, input: str):
    async with semaphore:
        return await run_agent(agent_id, input)
```

The semaphore ensures that at most two agents run concurrently, even if you spawn four tasks. The third and fourth tasks wait until one of the first two completes and releases the semaphore.

The core orchestration patterns are implemented. What varies across teams is which framework makes them easiest to express—and the trade-offs between Azure ecosystem integration and control flow explicitness are the subject of the next unit.

## Batching as a complementary scaling technique

Spawning concurrent agents and synchronizing them with `asyncio.gather` reduces latency by parallelizing independent tasks. Batching reduces overhead by grouping multiple similar requests into a single API call. These are complementary scaling techniques: spawning addresses latency, batching addresses throughput and cost.

Three batching patterns apply in multi-agent systems:

- **Batched LLM calls**—when multiple agents share the same prompt template with different input values, batch inference sends all inputs in one API call rather than N individual calls. Azure OpenAI batch deployments support this pattern, reducing per-request overhead and enabling higher total throughput within rate limits.
- **Batched embedding generation**—when an agent ingests multiple documents for knowledge retrieval, batch embedding generates vectors for all documents in a single call to the embedding endpoint. This is significantly more efficient than embedding one document at a time and is essential during indexing pipelines that process hundreds or thousands of documents.
- **Batched tool calls**—when downstream tools support batch APIs (Azure Cosmos DB bulk operations, Azure AI Search batch indexing, Azure Blob Storage batch uploads), design tool implementations to accumulate requests and submit them as batches. Individual agents contribute to the batch; the tool layer submits the batch when a size or time threshold is met.

Choose batching when throughput matters more than latency—batch processing is inherently higher latency (you wait to fill the batch) but achieves lower cost-per-unit and higher total throughput than individual calls. For Contoso Capital's nightly portfolio analysis that processes thousands of securities, batching embedding generation and LLM calls reduces both cost and API quota consumption compared to real-time individual processing.

## Unit summary

- **Fan-out/fan-in** is the core parallel pattern—spawn concurrent agent tasks with `asyncio.create_task`, synchronize at a barrier with `asyncio.gather`, then process collected results.
- **Quorum policies** define failure tolerance—fail-fast aborts on any failure, best-effort proceeds with available results, and minimum-quorum requires a configurable threshold of successful agents.
- **Race condition prevention** uses queue-based merge (each agent writes to isolated storage, merge after barrier) or `asyncio.Lock` for real-time shared document updates.
- **Timeout and deadline propagation** divides total workflow deadlines across sequential rounds plus orchestration buffer, ensuring individual agent timeouts fit within the overall constraint.
- **Concurrency limits** via `asyncio.Semaphore` prevent parallel execution from exceeding deployment rate limits—set the semaphore value based on your token quota capacity.
