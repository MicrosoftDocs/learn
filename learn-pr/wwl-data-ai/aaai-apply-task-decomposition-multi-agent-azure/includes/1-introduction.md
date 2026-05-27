Contoso Capital's research platform handles highly variable requests—some need a one-paragraph summary, others require exhaustive multi-source analysis spanning days. The orchestration patterns you learned in the previous module work well when you know the task structure at design time, but task decomposition is different. It's runtime intelligence that adapts how a complex task is broken apart and routed based on what the task actually requires.

Task decomposition transforms static routing into adaptive workflows. Instead of predefined agent pipelines, you design systems where a meta-agent analyzes incoming requests and creates execution plans dynamically. This approach handles the inherent variability in analytical work—a research request about a mature public company follows a different path than one about a pre-IPO startup with limited data.

In this module, you learn to:

- Design prompt chaining workflows that sequence analytical reasoning steps
- Implement LLM-driven adaptive task decomposition with meta-agent planners
- Configure agent handoff protocols that preserve context across specialist transfers
- Optimize decomposition granularity to balance specialization quality against coordination overhead

You start by examining prompt chaining—the foundation for structured multi-step reasoning within a single agent's workflow.
