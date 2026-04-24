The generative AI development lifecycle is iterative, and evaluation is the feedback mechanism that tells you whether a change actually improved the system. Strong evaluation practices help you measure response quality, retrieval quality, safety, and reliability before you ship a feature and after you change prompts, data, or models.

:::image type="complex" source="../media/generative-ai-lifecycle.png" alt-text="A screenshot of the flow of the generative AI development lifecycle. The steps include define your use case, map, measure, mitigate, and operate. Governance is a concept that occurs during all phases of the lifecycle. There are arrows around the lifecycle since the process is iterative.":::
   The image illustrates the 'Generative AI Development Lifecycle' with a flowchart-style diagram. The diagram is set on a light background and uses a blue and white color scheme with accent colors for icons. The lifecycle begins with 'Define your use case' on the left, which leads into a large rounded rectangle containing the main stages of the process. Within this main area, there are five key components arranged horizontally: map, measure, mitigate, operate, govern. The layout implies a sequential flow from Map to Operate, with Govern overarching all stages. A large arrow forms a loop around the entire process, starting from 'Define your use case', moving clockwise through all stages, and then returning to the beginning. This suggests a continuous, iterative lifecycle for AI development.
:::image-end:::

While every step in the process is essential to building trustworthy generative AI solutions, the measurement phase is where teams verify that an application is behaving as intended. Microsoft Foundry provides evaluation, results analysis, and observability capabilities that help you assess models, retrieval-augmented generation (RAG) systems, and agents in a repeatable way. This module introduces the key concepts for choosing evaluation data, selecting evaluators, and interpreting results.

## Learning objectives

By completing this module, you're able to:

- Apply best practices for choosing evaluation data
- Explain when to use real-world, synthetic, and adversarial data
- Describe the scope of built-in evaluators
- Choose evaluators that fit your use case
- Interpret evaluation results and use them to guide mitigations

## Prerequisites

- An Azure subscription - [Create one for free](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn)
- Familiarity with Azure and the Azure portal
