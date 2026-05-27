Task decomposition transforms static agent orchestration into adaptive workflows that respond to actual request complexity. Prompt chaining sequences reasoning within a single agent—each step's output feeds the next, keeping the large language model (LLM) focused on one analytical problem at a time. It's the right pattern when your workflow has natural stages where each step depends on the previous step's output before it can start.

When the task itself is unpredictable, a meta-agent planner decides the decomposition at runtime rather than relying on a structure you've hardcoded. Plan-and-execute architectures give you a checkpoint between planning and execution so you can review the plan before running it. Reflection and replanning extend this further—when mid-execution findings change what's needed, the system updates its plan rather than continuing down the wrong path.

Agent handoff protocols enable peer-to-peer task transfers while preserving context integrity. Comprehensive handoff message schemas enforce completeness, ensuring receiving agents have all necessary context without needing follow-up queries. Context preservation prevents context collapse in handoff chains—maintaining base context plus incremental deltas rather than repeatedly resummarizing. Acknowledgment patterns let receiving agents confirm capability before accepting a handoff, which catches routing mismatches early.

Decomposition granularity determines the balance between specialization quality and coordination overhead. Optimal granularity varies by task type—Contoso Capital found that economic analysis worked better with a single agent while public company research benefited from three-agent decomposition. Task boundaries work best at natural capability interfaces where one agent's complete output is what the next agent needs. Over-decomposition patterns like nano-tasking and redundant coordination add overhead without adding quality.

For Contoso Capital's research platform, these patterns enable a system that routes simple stock price queries to direct execution while decomposing complex investment thesis requests into multi-step analytical workflows. The meta-agent planner adapts decomposition depth based on query characteristics—routing each request to the right level of complexity rather than applying the same architecture to everything.

## Learn more

- [Microsoft Agent Framework handoff orchestration](https://learn.microsoft.com/agent-framework/workflows/orchestrations/handoff)—`HandoffBuilder`, context synchronization, and autonomous mode patterns covered in this module
- [AI agent orchestration patterns](https://learn.microsoft.com/azure/architecture/ai-ml/guide/ai-agent-design-patterns)—architecture reference for sequential, concurrent, group chat, handoff, and Magentic patterns
- [What is Microsoft Foundry Agent Service?](https://learn.microsoft.com/azure/foundry/agents/overview)—agent types, tools, and workflows in the Foundry platform
