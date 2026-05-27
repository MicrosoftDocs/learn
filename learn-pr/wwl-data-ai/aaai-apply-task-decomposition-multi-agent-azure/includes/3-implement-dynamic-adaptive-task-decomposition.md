Microsoft Agent Framework provides the model client and agent infrastructure for the dynamic task decomposition patterns in this unit. A meta-agent planner connects to a model hosted in Microsoft Foundry to analyze incoming requests and generate adaptive execution plans—selecting specialist agents and sequencing their tasks based on what each query actually requires.

## Distinguish static and dynamic decomposition approaches

Static decomposition designs task workflows at development time—you decide in advance that equity research requests follow a three-step Extract-Benchmark-Analyze sequence. This approach works well when request patterns are predictable and relatively uniform. Dynamic decomposition inverts this model: an LLM analyzes the incoming task description and decides how to decompose it at runtime.

For Contoso Capital's research platform, dynamic decomposition handles inherent request variability. A research request that asks "What's ACME Corp's current stock price?" needs one simple lookup. A request asking "Should we invest in ACME Corp given current macroeconomic conditions and sector trends?" requires multi-step analysis: retrieve financial data, analyze sector performance, assess economic indicators, synthesize investment thesis. The complexity difference is substantial, and a static decomposition forces you to either over-engineer simple tasks or under-serve complex ones.

| Decomposition type | When to use | Strengths | Limitations |
|--------------------|-------------|-----------|-------------|
| Static | Uniform task patterns, well-defined workflows | Predictable performance, easier to debug | Inflexible, can't adapt to task variance |
| Dynamic | Variable complexity, evolving requirements | Adapts to actual needs, handles edge cases | Higher coordination cost, less predictable |

Dynamic decomposition introduces a meta-agent that performs analysis before execution. This adds latency and token cost, but eliminates the mismatch between task complexity and execution plan. For high-value analytical work like investment research, the quality improvement justifies the overhead.

## Design meta-agent planner architectures

A **meta-agent planner** is a dedicated agent that receives the full task description and outputs a structured decomposition plan. It doesn't execute the task—it analyzes requirements and determines which subtasks are needed, in what sequence, and which specialized agents should handle each subtask.

The planner operates with access to an agent registry that describes available specialist capabilities. For Contoso Capital, the registry includes specialists like Financial Data Retriever (APIs for market data), SEC Filing Analyzer (document parsing and metric extraction), Economic Indicator Synthesizer (macro trend analysis), and Investment Thesis Generator (natural language recommendations). The planner's job is to match task requirements to available capabilities.

Design the planner's output as a JSON execution plan with explicit structure. Each subtask in the plan includes: a unique task ID, task description, assigned agent identifier, input dependencies (which previous tasks must complete first), and expected output format. This structured plan serves as both an execution blueprint and an audit trail—you can inspect the plan before execution to verify it makes sense.

```python
from agent_framework.foundry import FoundryChatClient
from azure.identity import DefaultAzureCredential
import json
import os

chat_client = FoundryChatClient(
    project_endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
    model=os.environ["FOUNDRY_MODEL"],
    credential=DefaultAzureCredential(),
)

# Agent capability registry
AGENT_REGISTRY = {
    "financial_data_retriever": {
        "capabilities": ["retrieve stock prices", "get financial statements", "query market data APIs"],
        "latency_estimate_sec": 2,
        "cost_per_call_usd": 0.001
    },
    "sec_filing_analyzer": {
        "capabilities": ["parse SEC filings", "extract financial metrics", "analyze MD&A sections"],
        "latency_estimate_sec": 15,
        "cost_per_call_usd": 0.05
    },
    "economic_indicator_synthesizer": {
        "capabilities": ["analyze GDP trends", "assess interest rate impacts", "evaluate sector performance"],
        "latency_estimate_sec": 8,
        "cost_per_call_usd": 0.02
    },
    "investment_thesis_generator": {
        "capabilities": ["synthesize research findings", "generate buy/hold/sell recommendations", "compose analyst reports"],
        "latency_estimate_sec": 12,
        "cost_per_call_usd": 0.03
    }
}
```

The agent registry defines each specialist's capabilities, latency estimates, and per-call costs. The meta-agent planner uses this registry to analyze a research query and create a structured execution plan—assigning subtasks to the most appropriate agents based on capability matching:

```python
def create_decomposition_plan(research_query):
    """Meta-agent planner: analyzes query and creates execution plan"""
    
    planner_prompt = f"""
You are a research task decomposition planner for investment analysis.

Research Query: "{research_query}"

Available Specialist Agents:
{json.dumps(AGENT_REGISTRY, indent=2)}

Analyze this research query and create a decomposition plan. Output JSON with this structure:

{{
  "complexity_assessment": "simple|moderate|complex",
  "estimated_total_time_sec": 0,
  "subtasks": [
    {{
      "task_id": "T1",
      "description": "Detailed task description",
      "assigned_agent": "agent_name_from_registry",
      "depends_on": ["list of prior task_ids, empty for first tasks"],
      "expected_output_format": "description of output",
      "reasoning": "why this subtask is necessary"
    }}
  ]
}}

Rules:
1. Only include subtasks necessary to answer the research query
2. Tasks with no dependencies can execute in parallel
3. Final task should always be investment_thesis_generator to synthesize findings
4. Simpler queries need fewer subtasks
5. Validate that assigned agents have required capabilities

Create the plan now:
"""
    
    response = chat_client.complete(
        messages=[{"role": "user", "content": planner_prompt}]
    )
    
    plan = json.loads(response.choices[0].message.content)
    return plan
```

The planner generates a JSON execution plan where each subtask includes a unique ID, the assigned specialist agent, dependency references, and expected output format. Tasks with no dependencies can execute in parallel. The executor processes this plan while respecting the dependency order:

```python
def execute_decomposition_plan(plan, research_query):
    """Execute the decomposition plan created by meta-agent"""
    
    completed_tasks = {}
    subtasks = plan['subtasks']
    
    # Execute tasks respecting dependency order
    while len(completed_tasks) < len(subtasks):
        for task in subtasks:
            task_id = task['task_id']
            
            # Skip already completed tasks
            if task_id in completed_tasks:
                continue
            
            # Check if dependencies are met
            dependencies_met = all(
                dep_id in completed_tasks 
                for dep_id in task['depends_on']
            )
            
            if not dependencies_met:
                continue
            
            # Gather context from completed dependencies
            context = {
                dep_id: completed_tasks[dep_id]
                for dep_id in task['depends_on']
            }
            
            # Execute the task
            result = execute_agent_task(
                agent_name=task['assigned_agent'],
                task_description=task['description'],
                context=context,
                original_query=research_query
            )
            
            completed_tasks[task_id] = result
    
    # Return final synthesis (last task in plan)
    final_task_id = subtasks[-1]['task_id']
    return completed_tasks[final_task_id]
```

The executor iterates through the plan, launching each subtask only after its dependencies complete. Context from completed tasks is gathered and passed to downstream agents, building up the Contoso Capital investment analysis incrementally. Each individual agent task is dispatched with its specific capabilities and accumulated context:

```python
def execute_agent_task(agent_name, task_description, context, original_query):
    """Execute a single agent task with provided context"""
    
    agent_capabilities = AGENT_REGISTRY[agent_name]['capabilities']
    
    task_prompt = f"""
You are a specialist agent: {agent_name}
Your capabilities: {', '.join(agent_capabilities)}

Original Research Query: {original_query}

Current Task: {task_description}

Context from Prior Tasks:
{json.dumps(context, indent=2) if context else "No prior context"}

Perform this task and return structured results as JSON.
"""
    
    response = chat_client.complete(
        messages=[{"role": "user", "content": task_prompt}]
    )
    
    # In production, parse and validate the response
    return {
        "agent": agent_name,
        "task": task_description,
        "result": response.choices[0].message.content
    }

# Example: Simple query gets minimal decomposition
simple_query = "What's Microsoft's current stock price?"
simple_plan = create_decomposition_plan(simple_query)
print(f"Simple query plan: {len(simple_plan['subtasks'])} subtasks")

# Example: Complex query gets comprehensive decomposition
complex_query = "Should Contoso Capital invest in Microsoft given current AI market trends and macroeconomic conditions?"
complex_plan = create_decomposition_plan(complex_query)
print(f"Complex query plan: {len(complex_plan['subtasks'])} subtasks")

# Execute the complex plan
result = execute_decomposition_plan(complex_plan, complex_query)
```

The meta-agent planner examines the registry and matches query requirements to agent capabilities. A simple stock price query routes directly to the Financial Data Retriever. A complex investment analysis query generates a multi-step plan involving data retrieval, document analysis, economic synthesis, and thesis generation.

## Implement plan-and-execute workflows

Plan-and-execute architecture separates planning from execution into distinct phases. The **plan phase** produces a complete decomposition without executing any subtasks. The **execute phase** runs each subtask according to the plan. This separation provides an inspection point—you can review the plan, modify it if needed, and then execute.

For regulated environments like financial research, plan inspection is valuable for compliance. Before executing a research workflow that accesses proprietary data or external APIs, a compliance officer can review the plan to ensure it follows data usage policies. Plans that access restricted datasets or violate rate limits get rejected before execution starts.

Implement the executor with dependency resolution logic. Tasks list their dependencies using task IDs, and the executor maintains a completion tracker. When all dependencies for a task are complete, that task becomes eligible for execution. Tasks with no dependencies execute immediately (potentially in parallel), and subsequent dependent tasks wait for their prerequisites.

## Enable reflection and replanning capabilities

Static plans assume the initial decomposition is correct, but real analytical work often reveals surprises. After retrieving a company's financial statements, you might discover it's in bankruptcy proceedings—completely changing the analytical approach needed. Reflection and replanning handle these mid-execution discoveries.

After executing each task (or batch of parallel tasks), inject a reflection step where the meta-agent reviews intermediate results and decides whether to continue with the current plan or replan. The reflection prompt includes: original research query, current execution plan, completed tasks and their results, remaining tasks in the plan.

The meta-agent's reflection produces one of three decisions: **continue** (plan remains valid, proceed), **modify** (adjust remaining tasks, keep completed work), or **replan** (discard remaining plan, create new plan from current state). Most executions continue without replanning, but having the capability handles edge cases gracefully.

Design reflection with a confidence threshold. If intermediate results have low confidence scores or contain unexpected findings (company unexpectedly profitable, data sources unavailable), trigger deeper reflection. For high-confidence results that align with expectations, use lightweight reflection that simply confirms continuation.

## Optimize dynamic agent selection

The meta-agent doesn't just sequence tasks—it selects which specialized agent handles each subtask based on capability matching. Provide the planner with a detailed capability catalog that describes what each specialist can and can't do. For ambiguous tasks, the planner makes selection decisions based on capability fit.

Implement capability matching with semantic similarity when exact matches don't exist. If the registry doesn't list a specialist with "analyze supply chain disruption risk" but one agent's capabilities include "assess operational risk factors and vendor dependencies," semantic matching catches this relevance. Use embeddings to compute similarity between task requirements and agent capabilities.

Track agent performance over time and feed metrics back to the planner. If the SEC Filing Analyzer consistently returns low-confidence results for certain filing types, the planner learns to route those tasks to a different agent or flag them for human review. This feedback loop creates adaptive agent selection that improves with experience.

## Calibrate decomposition depth dynamically

Not all tasks need deep decomposition. A planner that always creates 5-step plans wastes resources on simple queries. Implement confidence-based decomposition depth: for clear, simple tasks, the meta-agent creates minimal plans (1-2 steps). For ambiguous or high-stakes tasks, it creates detailed multi-step decompositions.

The meta-agent's complexity assessment (simple/moderate/complex from the example code) drives decomposition depth. Simple queries get direct execution with minimal routing overhead. Complex queries get comprehensive decomposition with validation checkpoints. This adaptive depth balances quality against cost—you don't over-engineer simple lookups, but you don't under-serve critical analysis.

Design confidence scoring into the planner's output. Each subtask includes a confidence estimate (0.0-1.0) indicating how certain the planner is that this subtask is necessary. Low-confidence subtasks trigger validation—either check with a human operator or execute a validation agent that assesses whether the subtask contributes value. High-confidence subtasks execute without extra verification.

For Contoso Capital, a research query about a well-known public company generates high-confidence plans because the analytical pattern is well-established. A query about an obscure private company generates lower-confidence plans because data availability is uncertain—the plan might need adjustment once you discover which data sources are accessible.

> [!TIP]
> **Pause and reflect:** Consider a research request that starts as a simple earnings analysis but expands mid-execution when the meta-agent discovers the company is undergoing an M&A transaction. How would you design the replanning trigger? Would you replan after every subtask, or only when a subtask returns unexpected findings? What's the cost trade-off of replanning frequency?

Now that you understand how to decompose tasks dynamically with meta-agent planners, you're ready to design handoff protocols that maintain context integrity when tasks transfer between specialized agents.

## Key takeaways

- **Static decomposition** uses fixed templates—fast but inflexible. **Dynamic decomposition** uses an LLM meta-agent planner to create adaptive plans at runtime based on request complexity.
- **Plan-and-execute** workflows separate planning from execution, letting you validate and adjust plans before committing compute resources.
- **Reflection and replanning** enable agents to revise their plan when intermediate results reveal the initial decomposition was wrong—but limit replan cycles (typically one) to prevent infinite loops.
- **Dynamic agent selection** matches subtasks to the best available agent based on capability fit and current load rather than hardcoded routing.
- **Confidence scoring** in the planner's output flags low-certainty subtasks for validation, preventing wasted execution on speculative decompositions.
