## Why flat orchestration patterns don't scale

Once you've decided multi-agent earns its complexity for a given workload, the next question is *how the agents coordinate*. Five foundational orchestration patterns form the baseline: concurrent orchestration (multiple agents run simultaneously), sequential orchestration (strict ordering with result passing), group chat (agents collaborate in shared conversation), handoff (one agent transfers control to another), and Magentic-One (general-purpose orchestrator with specialist subagents). These patterns share a common architectural characteristic—all agents operate at one hierarchical level with peer-to-peer relationships.

When you scale from three agents to 12 specialized agents, flat patterns exhibit three failure modes:

- **Coordination overhead grows quadratically**—with N agents, you potentially manage N(N-1)/2 relationships. A group chat with 10 participants becomes chaotic when agents speak out of turn or contradict each other.
- **Failures cascade unpredictably**—if a compliance agent fails in a flat concurrent pattern, do you abort the entire workflow or proceed with incomplete analysis?
- **No clear ownership for sub-domains**—when the equities analysis agent and the derivatives analysis agent produce conflicting risk assessments, who arbitrates that conflict?

The architectural shift you need is from flat peer relationships to hierarchical control structures. Unlike microservices that coordinate through message buses, multi-agent systems need explicit orchestration because agent outputs are often nondeterministic and require validation before downstream consumption.

## Hub-and-spoke architecture

Hub-and-spoke architecture introduces a central orchestrator agent that delegates to specialized spoke agents. The hub knows the entire workflow—what data each spoke needs, which spokes can run in parallel, how to synthesize spoke outputs into final results. Each spoke knows only its domain expertise—the market analysis spoke understands equity pricing models but doesn't know that a compliance check waits for its results.

This pattern mirrors microservices architectures with an API gateway. The gateway (hub) routes requests to backend services (spokes) and aggregates responses. Unlike an API gateway that simply routes, your hub agent makes intelligent decisions—it can retry a failed spoke invocation with modified parameters, skip optional spokes when deadlines approach, or escalate to human oversight when spoke outputs conflict.

You implement hub-and-spoke by registering each spoke agent as a callable function on the hub. When the hub's language model decides to invoke a spoke, it generates a function call. Your orchestrator code executes that function (which internally invokes the spoke agent), collects the result, and submits it back to the hub as a tool result. The hub then decides whether to invoke more spokes or synthesize a final response.

## Hierarchical orchestration

Hierarchical orchestration extends hub-and-spoke with multiple orchestration layers. Suborchestrators manage clusters of specialist agents, and a top-level orchestrator coordinates suborchestrators. Contoso Capital uses this pattern for their market analysis workflow—a market analysis suborchestrator manages equities, fixed income, and derivatives specialists, while the top-level orchestrator coordinates market analysis, risk assessment, and compliance suborchestrators.

The key architectural benefit is isolation of complexity. The top-level orchestrator operates at the business logic level—"perform market analysis, then check compliance"—without knowing that market analysis internally involves three specialist agents running in parallel. When you add a fourth specialist (cryptocurrency analysis), only the market analysis suborchestrator changes. The top-level orchestrator's logic remains unchanged.

This pattern requires careful interface design between layers. Each suborchestrator exposes a narrow contract to its parent—the market analysis suborchestrator returns a structured market report, not raw outputs from three agents. This encapsulation prevents the top-level orchestrator from becoming dependent on implementation details that change as you evolve the system.

## Supervisor and coordinator patterns

Supervisor patterns shift from prescriptive orchestration to reactive monitoring. A supervisor agent watches agent outputs and decides whether to retry, escalate, or proceed. Unlike an orchestrator that dictates agent invocation order, the supervisor responds to agent results—if the risk assessment agent returns high uncertainty scores, the supervisor requests more analysis before allowing downstream consumption.

You implement supervisors as conditional routing logic. After each agent completes, the supervisor evaluates the output against quality criteria. The evaluation can be rules-based (check for required fields, validate numeric ranges) or LLM-based (ask a judge agent whether the output is sufficient). Based on evaluation, the supervisor routes to retry, to the next agent in the workflow, or to human escalation.

Coordinators handle cross-agent state synchronization. When multiple agents write to a shared compilation document, the coordinator serializes writes to prevent conflicts. When agents have interdependencies—the compliance agent needs partial results from both market and risk agents—the coordinator manages those waiting relationships.

## Selecting the right architecture

The decision between these patterns depends on three requirements dimensions: workflow predictability, failure tolerance, and organizational domain boundaries.

| Pattern | Best when | Risk |
|---------|-----------|------|
| Hub-and-spoke | Workflow is mostly deterministic with known spoke invocation sequences | Hub becomes a single point of failure; complex hub logic is hard to debug |
| Hierarchical | Clear organizational boundaries between agent clusters; subworkflows evolve independently | Communication overhead between layers adds latency; interface versioning complexity |
| Supervisor | Agent quality varies; outputs need validation before downstream use | Supervisor evaluation logic becomes complex; retry cycles can cause indefinite delays |

Use hub-and-spoke when you need centralized control over a relatively static workflow—the investment research report follows the same steps each time, and you want one place to optimize that flow. Choose hierarchical when organizational boundaries make sense—the market analysis team and compliance team operate independently, and coupling them through a single orchestrator creates coordination bottlenecks. Adopt supervisor patterns when agent reliability is uncertain—agents call external APIs that sometimes return low-quality data, and you need quality gates before proceeding.

## Framework independence

The orchestration architectures you select are independent of the framework you use to implement them. You can build hub-and-spoke patterns with Microsoft Agent Framework, Semantic Kernel, LangGraph, AutoGen, or CrewAI. Each framework provides different abstractions that make certain patterns more natural—Semantic Kernel's plugin model fits hub-and-spoke well, while LangGraph's state graph model naturally expresses supervisor logic—but the architectural patterns themselves are framework-agnostic.

In later units, you implement these patterns in Microsoft Foundry using the Microsoft Agent Framework, then compare how different frameworks optimize for different orchestration patterns. For now, focus on the architectural concepts themselves—once you understand why each pattern exists, choosing the right implementation framework becomes a tactical decision based on ecosystem integration and team skills.

With the three architectural patterns defined and their selection criteria mapped, Unit 4 puts hub-and-spoke into practice—registering spoke agents as tools on the hub and building the orchestration loop that drives coordination.

## Multi-agent pattern vocabulary reference

These patterns appear across multi-agent systems literature under various names. The table maps each to its mechanism as used in this module.

| Named pattern | Mechanism |
|---|---|
| Hub-and-spoke | Central orchestrator delegates to specialized spoke agents registered as tools |
| Sequential | Linear prompt-chaining: output of one agent becomes input to the next |
| Parallel | Fan-out/fan-in with `asyncio.gather` and quorum policies |
| Planner | Hub acting as explicit decomposition planner before spoke dispatch |
| Maker-checker | Supervisor quality gate: maker agent produces, checker agent validates |
| Critic loop | Reflection cycle: critic agent evaluates and returns feedback to the reasoning agent |

The same pattern may appear under different vocabulary in different sources; the mechanism column provides the implementation anchor.

## Key points

- **Flat orchestration patterns don't scale** because coordination overhead grows quadratically, failures cascade unpredictably, and there's no clear ownership for cross-domain conflicts.
- **Hub-and-spoke** introduces a central orchestrator that delegates to specialized spokes—the hub makes intelligent routing, retry, and synthesis decisions rather than just forwarding requests.
- **Hierarchical orchestration** isolates complexity through suborchestrators that manage agent clusters, enabling independent evolution of subworkflows without changing top-level logic.
- **Supervisor patterns** shift from prescriptive to reactive—watching agent outputs and conditionally routing to retry, escalation, or the next step based on quality criteria.
- **Architecture selection** depends on workflow predictability, failure tolerance, and domain boundaries—hub-and-spoke for static workflows, hierarchical for organizational boundaries, supervisor for uncertain quality.
