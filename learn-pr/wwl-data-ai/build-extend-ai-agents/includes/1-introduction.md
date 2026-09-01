A chat model can generate a response. Add trusted knowledge, live information, and tools that take action, and it becomes an agent you can build with Microsoft Foundry.

## Explore the scenario

You work at **Caldova**, a pharmaceutical manufacturer that needs to make more of a product than its factories can produce. You build an assistant that helps the planning team decide whether to move work between factories or use an approved partner.

:::image type="content" source="../media/intro-production-choice.png" alt-text="Diagram that shows Caldova factory options: a blue factory with a plus sign and a purple factory with a check mark.":::

## Understand agents and tools

A chat model and an agent both use a large language model (LLM). On its own, the model *predicts the next most likely word* from patterns in its training data. It has no access to Caldova policies or live systems. An **AI agent** is a software service that adds **knowledge** and **tools**. These capabilities ground answers in business data, retrieve current information, and support actions.

:::image type="content" source="../media/agent-vs-chat-model.png" alt-text="Diagram that shows a chat model predicting the next word compared with an agent that adds knowledge and tools to answer accurately.":::

For Caldova, this combination lets the assistant understand a supply chain request, choose the appropriate capability, and return a grounded answer or business action.

:::image type="content" source="../media/intro-agent-scenario.png" alt-text="Diagram that shows a Caldova agent answering a capacity-planning question using grounded supply chain policies and tools.":::

Microsoft Foundry Agent Service provides the managed environment for the Caldova assistant. Each task adds the capability needed for the next supply chain request, progressing from grounded answers to live lookups, analysis, and business actions.
