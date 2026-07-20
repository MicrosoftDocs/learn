Once the Adventure Works team has written their agent specification—the blueprint that defines what the agent must do, how it behaves, and how they'll measure success—they know exactly what to build. Now they design it. Designing an agent means making three connected choices: which **model** powers it, how you **ground** it in your data, and how you **optimize** it to hit the targets in your specification.

:::image type="content" source="../media/agent-design-overview.png" alt-text="Diagram that shows agent design building on the agent specification and made of three connected choices: model, ground, and optimize.":::

## Choose a model

The specification says the agent answers product questions in a friendly tone. That points to a **chat completion** model like GPT-4, which is built to generate natural, conversational text. Reasoning models (such as o1) shine at math and complex logic, but that's not what a gear-recommendation agent needs.

You also choose a *size*. **Large language models (LLMs)** handle deep reasoning and broad context. **Small language models (SLMs)** like Phi-3 are cheaper and faster, and often good enough for focused tasks. Because Adventure Works expects high traffic, they weigh a smaller model to control cost per request.

:::image type="content" source="../media/choose-model.png" alt-text="Diagram that shows two model decisions: type (chat completion versus reasoning) and size (LLM versus SLM), with chat completion and SLM selected.":::

> [!TIP]
> Match the model to the task in your specification, not to the most powerful option available. A smaller model that meets your rubric saves money at scale.

## Ground the agent in your data

A base model knows a lot about the world, but nothing about Adventure Works' current inventory. To fix that, the team compares two approaches.

**Retrieval Augmented Generation (RAG)** lets the agent search external data, such as the product catalog, and use those results when answering. **Fine-tuning** instead retrains the model on task-specific examples to shape its behavior or tone.

:::image type="content" source="../media/ground-agent.png" alt-text="Diagram that shows two grounding approaches: RAG for data that changes often, and fine-tuning for consistent tone, often combined.":::

Adventure Works chooses RAG. Their catalog changes constantly as products come and go, and RAG always pulls the latest data, whereas a fine-tuned model would need retraining every time stock changes. Fine-tuning still helps when you need a consistent style or a specialized skill. For example, Adventure Works could fine-tune the model on past support chats so it always answers in the brand's warm, encouraging voice and uses the right outdoor terminology, like knowing that a "three-season tent" isn't rated for deep winter. Because style rarely changes while inventory does, many production agents combine both: fine-tuning for tone, RAG for current data.

## Optimize against your rubric

Design is iterative. The team refines the **command prompt** through prompt engineering, then measures each version against the evaluation rubric they defined earlier. Precision matters: a high-precision agent returns fewer irrelevant or incorrect recommendations, which builds shopper trust.

:::image type="content" source="../media/optimize-rubric.png" alt-text="Diagram that shows the optimization loop: refine the command prompt, run smoke tests, then automated evaluation, all measured against the rubric.":::

They lean on the test data from the specification. After each small prompt tweak, they run the **smoke tests** for quick feedback, then run a full **automated** evaluation before bigger changes for objective, repeatable scoring across the whole dataset. Each loop moves the agent closer to the quality bar the specification set.

Which grounding approach would fit *your* use case? Does your data change often, or do you mainly need a consistent tone? With the agent designed, the next step is to see how these choices fit into the full development lifecycle.
