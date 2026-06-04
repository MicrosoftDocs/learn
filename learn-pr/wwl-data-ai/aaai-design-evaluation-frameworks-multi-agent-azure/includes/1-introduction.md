You run comprehensive tests on each of the 14 specialized agents before deployment. The product search agent scores 92% accuracy on its benchmark dataset. The order management agent processes 97% of test transactions correctly. The returns agent validates 94% of refund requests without error. Each agent passes its quality gates individually—yet production telemetry reveals that 18% of complex multi-step customer interactions produce confusing or incorrect results.

A customer wants to return one item from a three-item order while upgrading another item to expedited shipping. This workflow requires coordination between the order lookup agent, the returns agent, the inventory agent, and the shipping agent. Each agent executes its isolated task: the returns agent validates the return policy, the inventory agent confirms stock availability, and the shipping agent quotes the expedited cost. But the final customer response contradicts itself—quoting a refund amount that doesn't account for the shipping upgrade cost. Individual agent evaluation metrics showed success, but the end-to-end customer journey failed.

Component-level evaluation measures whether individual agents perform their isolated tasks. System-level evaluation measures whether the multi-agent orchestration accomplishes the customer's actual goal. In this module, you learn how to design evaluation frameworks for multi-agent systems. By the end, you'll know how to:

- Define system-level success metrics that capture end-to-end task completion
- Implement LLM-as-judge evaluation for holistic quality assessment
- Design synthetic test datasets that cover multi-agent interaction scenarios
- Build regression testing pipelines that detect quality drift before it reaches production

## Four-target evaluation framework

Effective multi-agent evaluation addresses four targets, each with distinct measurement strategies:

| Evaluation target | What you measure |
|---|---|
| **Memory evaluation** | Whether the agent recalls past context correctly. Measures whether memory injection improves accuracy and whether failure modes like sliding-window amnesia and summary drift reduce quality. |
| **Knowledge evaluation** | Whether the RAG pipeline retrieves the right documents. Measured by nDCG, MRR, and downstream answer accuracy. |
| **Tool evaluation** | Whether tools return correct results within SLA. Measured by tool result validation accuracy and circuit-breaker activation rates. |
| **Prompt evaluation** | Whether prompts produce consistent, high-quality outputs across input variations. Measured by A/B variant testing with semantic diff and regression stability. |

System-level evaluation, the primary focus of this module, measures whether the combination of memory, knowledge, tools, and prompts produces correct end-to-end task completion. Individual-target evaluation identifies which layer is failing when system-level quality degrades.

By the end of this module, you'll know how to design evaluation frameworks for multi-agent systems using Azure AI Foundry and LLM-as-judge techniques, so you can detect quality problems at the system level before they reach production.
