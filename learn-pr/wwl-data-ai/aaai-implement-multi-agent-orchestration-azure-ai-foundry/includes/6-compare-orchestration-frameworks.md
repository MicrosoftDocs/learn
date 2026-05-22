## The orchestration framework landscape

As of 2026, four frameworks dominate Python-based multi-agent orchestration: Microsoft Semantic Kernel (accessed through the Microsoft Agent Framework in Microsoft Foundry), LangGraph (part of the LangChain ecosystem), AutoGen (from Microsoft Research), and CrewAI. Each framework embodies a different mental model for how agents compose and coordinate. Your choice affects not just syntax but architectural patterns—some frameworks make hub-and-spoke natural while others favor supervisor patterns.

The frameworks aren't mutually exclusive in a single system. You might use Semantic Kernel for your main orchestration (because of Azure integration) and invoke a LangGraph sub-workflow for complex conditional routing within one sub-domain. But each framework has a primary architectural philosophy that shapes how you think about agent composition. Understanding these philosophies helps you select the right tool for Contoso Capital's requirements.

Framework selection balances technical factors (Azure integration, control flow expressiveness) with organizational factors (team expertise, support contracts, compliance requirements). Unlike choosing a UI framework where you're locked in for years, orchestration frameworks are relatively thin adapters—you can migrate between frameworks if requirements change, though it requires re-implementing coordination logic.

## Microsoft Agent Framework

Microsoft Agent Framework (`pip install agent-framework agent-framework-foundry`) is the primary recommendation for new Microsoft Foundry multi-agent projects. It is the direct successor to both Semantic Kernel and AutoGen, created by the same Microsoft teams. The framework introduces a data-flow Workflow model that gives developers explicit, type-safe control over multi-agent execution paths—combining Semantic Kernel's enterprise features (managed identity, telemetry, middleware) with AutoGen's simpler agent abstractions, plus new graph-based workflow orchestration.

The mental model is data flow: define executors (agents, functions, or sub-workflows) as nodes and connect them with typed edges. The Workflow routes data explicitly through edges—no message broadcasting, strong type safety throughout, and graph-level checkpointing for long-running workflows. Hub-and-spoke patterns map naturally to a central orchestrator executor with spoke executors as downstream nodes. Concurrent patterns use fan-out edges with join semantics.

Microsoft Foundry integration is native through `FoundryChatClient` from `agent_framework.foundry`. Authentication uses `DefaultAzureCredential` with managed identity support. Agents run on Foundry Agent Service with durable identity and conversation persistence stored in the cloud.

```python
from agent_framework import Agent
from agent_framework.foundry import FoundryChatClient
from azure.identity import DefaultAzureCredential
import os

agent = Agent(
    client=FoundryChatClient(
        project_endpoint=os.environ["PROJECT_ENDPOINT"],
        model="gpt-4o",
        credential=DefaultAzureCredential(),
    ),
    name="market_analyst",
    instructions="You analyze market trends",
)
result = await agent.run("Analyze current equity market conditions")
```

Choose Agent Framework when you need strong Azure ecosystem integration combined with explicit, auditable workflow control. If Contoso Capital's orchestration needs to interact with Microsoft 365 (SharePoint, Teams), Azure services (Cosmos DB, Azure Functions), or enterprise authentication (Entra ID), Agent Framework provides native support through the Microsoft plugin ecosystem and managed identity credential flow.

**Semantic Kernel** (`pip install semantic-kernel`) remains a fully supported, stable option for teams with existing SK investments. It integrates with Microsoft Foundry through `AzureAIAgent` in `semantic_kernel.agents`, maintains a rich plugin ecosystem covering Microsoft 365 and Azure services, and uses the familiar `Kernel`-centric programming model. For new projects, Microsoft recommends Agent Framework. For existing Semantic Kernel codebases, continue with SK and migrate on your own timeline using the published [migration guide from Semantic Kernel to Agent Framework](https://learn.microsoft.com/agent-framework/migration-guide/from-semantic-kernel/).

## LangGraph

LangGraph models multi-agent workflows as state graphs. Nodes represent agent invocations or computation steps, edges represent transitions between nodes, and state is an object that flows through the graph. You define nodes for each agent or processing step, define edges that connect nodes based on conditions, and execute the graph to coordinate agent workflow.

LangGraph asks you to draw your workflow before writing code: define nodes for each agent invocation or processing step, connect them with directed edges, and label each edge with a transition condition. The framework executes the graph by moving state from node to node according to those conditions, which makes every execution path visible and debuggable.

```python
from langgraph.graph import StateGraph

workflow = StateGraph()
workflow.add_node("market_analysis", market_agent_node)
workflow.add_node("risk_assessment", risk_agent_node)
workflow.add_node("compliance_check", compliance_agent_node)

# Define transitions
workflow.add_edge("market_analysis", "risk_assessment")
workflow.add_conditional_edges(
    "risk_assessment",
    route_based_on_risk_score,
    {"high_risk": "compliance_check", "low_risk": END}
)
```

Supervisor patterns express naturally in LangGraph. A supervisor node evaluates agent outputs and returns routing decisions—"high_risk" routes to compliance checking, "low_risk" proceeds to final synthesis. Conditional edges implement this routing. Retries also express cleanly—a supervisor edge can route back to the same node to re-execute an agent with modified parameters.

Microsoft Foundry integration for agent execution requires custom node implementations—LangGraph has no built-in support for invoking Foundry Agent Service directly. You implement nodes that call `AIProjectClient` from `azure-ai-projects` to invoke agents, managing thread creation, message posting, run polling, and state serialization yourself. This adds boilerplate compared to Agent Framework but gives you precise control over agent invocation. For observability, native Foundry integration is available via the `langchain-azure-ai` package, which provides `AzureAIOpenTelemetryTracer` for sending OpenTelemetry traces to Azure Monitor and Foundry Observability—useful for satisfying the regulatory audit trail requirements that often motivate LangGraph adoption.

LangGraph earns its extra integration work when control flow explicitness matters more than ecosystem integration. If Contoso Capital needs to demonstrate regulatory compliance by showing execution traces ("we ran compliance checks immediately after risk assessment, as required by regulation X"), LangGraph's explicit graph provides auditable evidence. For workflows with complex conditional branching (different paths for different market conditions), the graph model prevents the implicit branching in conversation-based orchestration from becoming unmaintainable.

## AutoGen

AutoGen organizes agents as participants in a shared group conversation. Each agent watches the discussion, decides when it has something to add, and posts a message. A group chat coordinator handles turn-taking—either round-robin (each agent speaks in order) or dynamic (agents contribute only when they have something relevant).

```python
from autogen import GroupChat, GroupChatManager, AssistantAgent

market_agent = AssistantAgent(name="market_analyst", llm_config={"model": "gpt-4o"})
risk_agent = AssistantAgent(name="risk_assessor", llm_config={"model": "gpt-4o"})
compliance_agent = AssistantAgent(name="compliance_checker", llm_config={"model": "gpt-4o"})

group_chat = GroupChat(
    agents=[market_agent, risk_agent, compliance_agent],
    messages=[],
    max_round=10
)
manager = GroupChatManager(groupchat=group_chat)
```

This pattern excels at collaborative reasoning scenarios. Contoso Capital might use AutoGen for investment committee simulations—multiple agents debate whether to recommend an investment, critique each other's reasoning, and converge on consensus. The conversation format captures the deliberation process naturally.

Microsoft Foundry integration is indirect. AutoGen agents can call Azure OpenAI endpoints (which Foundry deployments provide), but AutoGen doesn't use the Agent Service—agents exist only in your process runtime, not as durable Foundry resources. You lose managed identity benefits and conversation persistence that Foundry provides.

AutoGen excels at scenarios where agent collaboration through group conversation produces better results than sequential delegation. Microsoft released a formal [AutoGen to Microsoft Agent Framework migration guide](https://learn.microsoft.com/agent-framework/migration-guide/from-autogen/), positioning Agent Framework as the strategic successor for new projects. AutoGen's `RoundRobinGroupChat`, `GroupChat`, and `GraphFlow` patterns all have direct equivalents in Agent Framework's Workflow model. For existing AutoGen workloads, AutoGen remains maintained and functional. For new projects that require collaborative agent reasoning or adversarial review patterns, prefer Agent Framework's Workflow orchestration, which provides the same group interaction capabilities with stronger type safety and native Azure Foundry integration.

## CrewAI

CrewAI frames orchestration as team management: your agents are specialists with defined roles, backstories, and goals; a "crew" acts like an org chart where a manager delegates tasks and collects outputs.

```python
from crewai import Agent, Task, Crew

market_analyst = Agent(
    role="Market Analyst",
    goal="Analyze market trends and identify opportunities",
    backstory="Experienced equity analyst with 10 years in financial markets"
)

research_task = Task(
    description="Analyze Q4 market performance",
    agent=market_analyst
)

crew = Crew(agents=[market_analyst], tasks=[research_task])
result = crew.kickoff()
```

CrewAI's abstraction hides orchestration complexity—you define high-level goals and let the framework handle coordination. This accelerates prototyping but reduces control. When workflows need custom retry logic, partial failure handling, or complex synchronization, CrewAI's abstraction becomes limiting.

Azure integration is minimal—CrewAI can call Azure OpenAI endpoints but doesn't integrate with Agent Service or managed identity. For production Foundry deployments, you're effectively using only Azure OpenAI compute while managing agent orchestration entirely in your code.

CrewAI is the right choice for rapid prototyping or scenarios where high-level task delegation suffices. If Contoso Capital needs to build a proof-of-concept multi-agent research system in one week, CrewAI's abstractions let you focus on agent roles rather than orchestration mechanics. For production systems requiring fine-grained control, observability, and Azure ecosystem integration, CrewAI's abstractions limit the control you need.

## Framework comparison matrix

| Framework | Azure Ecosystem | Control Flow | Primary Pattern | Production Maturity |
|-----------|-----------------|--------------|-----------------|---------------------|
| Microsoft Agent Framework | Native Foundry integration, managed identity, M365 plugins | Explicit (data-flow Workflow graph) | Workflow orchestration, hub-and-spoke, concurrent | High - recommended successor to Semantic Kernel and AutoGen, with production support from Microsoft |
| Semantic Kernel | Native Foundry integration, managed identity, M365 plugins | Implicit (conversation-based) | Hub-and-spoke, group chat, handoff | High - stable, actively maintained, with migration guide to Agent Framework available |
| LangGraph | Execution: custom nodes, Observability: native via `langchain-azure-ai` | Explicit (state graph) | Supervisor, sequential pipelines | High - widely used in production |
| AutoGen | Azure OpenAI only, no Agent Service | Implicit (group conversation) | Collaborative group chat | Legacy/maintained - Microsoft recommends Agent Framework for new projects |
| CrewAI | Azure OpenAI only, no Agent Service | High-level abstraction | Task delegation, hierarchical teams | Low-Medium - newer framework, less production evidence |

For most new Microsoft Foundry projects, Agent Framework or Semantic Kernel is the right starting point—both integrate natively with Foundry and are actively maintained by Microsoft. If your scenario demands auditable execution traces for regulatory compliance and you're willing to implement custom Foundry nodes, LangGraph earns that extra integration work. AutoGen remains a strong fit when group conversation among agents genuinely produces better outputs than sequential delegation—investment committee simulations being the clearest example. CrewAI works well for prototyping, but plan to migrate before production quality requirements become constraints.

## The framework-agnostic insight

The orchestration patterns you learned—hub-and-spoke, hierarchical, supervisor, parallel execution with quorum policies—exist independent of framework choice. Hub-and-spoke expresses naturally in Semantic Kernel but you can implement it in LangGraph with a central coordinator node. Supervisor patterns express naturally in LangGraph but you can implement them in Semantic Kernel with evaluator agents.

Framework selection is a tactical decision based on ecosystem fit, control flow preferences, and team skills. The strategic architecture decisions—which orchestration pattern solves your coordination problem, how to handle partial failures, when to execute agents in parallel—apply regardless of framework. Learn the patterns first, then choose the framework that makes those patterns easiest to implement for your specific environment and requirements.

For Contoso Capital's Microsoft Foundry investment platform, Microsoft Agent Framework provides the best forward-looking production path: native Foundry integration eliminates authentication boilerplate, managed agent hosting provides durable agent identity, and Microsoft support contracts cover production issues. If regulatory requirements demand explicit control flow graphs for auditing, use LangGraph for those sub-workflows while keeping Foundry Agent Service as the underlying agent runtime. If the team has significant existing Semantic Kernel investments, continue with SK—it integrates fully with Foundry and has a migration path to Agent Framework when ready.

Now that you understand framework trade-offs and selection criteria, you're ready to implement Contoso Capital's hierarchical research orchestration in a hands-on exercise.

## Key points

- **Microsoft Agent Framework** provides native Microsoft Foundry integration with a data-flow Workflow model, managed identity, and M365 plugins—the recommended choice for new multi-agent projects and direct successor to both Semantic Kernel and AutoGen.
- **Semantic Kernel** remains a stable, fully supported option with strong M365 ecosystem integration and implicit conversation-based control flow—a published migration guide to Agent Framework is available for teams ready to transition.
- **LangGraph** models workflows as explicit state graphs with conditional edges, making execution paths auditable and debuggable—ideal for regulatory compliance. Agent execution requires custom Foundry node implementations, but native observability is available via `langchain-azure-ai`.
- **AutoGen** organizes agents as conversation participants in group discussions, excelling at collaborative reasoning and adversarial review—Microsoft now recommends Agent Framework for new projects, with a formal migration guide available.
- **CrewAI** offers high-level role-based abstractions that accelerate prototyping but sacrifice fine-grained control needed for production failure handling and observability.
- **Framework choice is tactical, not strategic**—orchestration patterns (hub-and-spoke, hierarchical, supervisor) are framework-agnostic. Choose the framework that makes your chosen pattern easiest to implement for your ecosystem.
