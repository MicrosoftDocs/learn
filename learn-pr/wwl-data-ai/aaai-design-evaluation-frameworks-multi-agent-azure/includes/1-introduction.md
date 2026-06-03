Adventure Works' platform engineering team runs comprehensive tests on each of the 14 specialized agents before deployment. The product search agent scores 92% accuracy on its benchmark dataset. The order management agent correctly processes 97% of test transactions. The returns agent properly validates 94% of refund requests. Each agent passes its quality gates individually—yet production telemetry reveals that 18% of complex multi-step customer interactions produce confusing or incorrect results.

A customer wants to return one item from a three-item order while upgrading another item to expedited shipping. This workflow requires coordination between the order lookup agent, the returns agent, the inventory agent, and the shipping agent. Each agent executes its isolated task correctly: the returns agent validates the return policy, the inventory agent confirms stock availability, and the shipping agent quotes the expedited cost. But the final customer response contradicts itself—quoting a refund amount that doesn't account for the shipping upgrade cost. Individual agent evaluation metrics showed success, but the end-to-end customer journey failed.

Component-level evaluation measures whether individual agents perform their isolated tasks correctly. System-level evaluation measures whether the multi-agent orchestration accomplishes the customer's actual goal. Here, you learn how to design evaluation frameworks for multi-agent systems. You explore how to define system-level success metrics that capture end-to-end task completion, implement LLM-as-judge evaluation for holistic quality assessment, design synthetic test datasets that cover multi-agent interaction scenarios, and build regression testing pipelines that detect quality drift before it reaches production.

## Four-target evaluation framework

Effective multi-agent evaluation addresses four targets, each with distinct measurement strategies and curriculum locations:

| Evaluation target | What you measure | Where taught in AI-500 |
|---|---|---|
| **Memory evaluation** | Whether the agent correctly recalls past context; does memory injection improve accuracy, and do failure modes like sliding-window amnesia and summary drift reduce quality? | LP3 M5 Unit 5 (context window optimization — memory impact on accuracy, cost, and latency) |
| **Knowledge evaluation** | Whether the RAG pipeline retrieves the right documents; measured by nDCG, MRR, and downstream answer accuracy | LP2 M3 Unit 3 (re-ranking quality \u2014 offline nDCG/MRR evaluation against labeled datasets) |
| **Tool evaluation** | Whether tools return correct results within SLA; measured by tool result validation accuracy and circuit-breaker activation rates | LP2 M2 Unit 3 (tool result schema validation + circuit-breaker telemetry from LP4 M1) |
| **Prompt evaluation** | Whether prompts produce consistent, high-quality outputs across input variations; measured by A/B variant testing with semantic diff and regression stability | LP2 M1 Unit 5 (A/B variant testing with semantic diff) + this module Unit 3 (LLM-as-judge prompt evaluators) |

System-level evaluation \u2014 the primary focus of this module \u2014 measures whether the combination of memory, knowledge, tools, and prompts produces correct end-to-end task completion. Individual-target evaluation identifies which layer is failing when system-level quality degrades. Use the cross-references above when a system-level quality regression requires root-cause isolation to a specific component.
