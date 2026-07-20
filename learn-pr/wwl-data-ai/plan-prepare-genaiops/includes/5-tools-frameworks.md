By now the Adventure Works team has planned and designed their agent: an assistant that answers shopper questions on their outdoor-gear website. What they don't have yet is a working, reliable service—and getting there takes the right tool at each stage.

:::image type="content" source="../media/overview-toolchain.png" alt-text="Diagram that shows the four GenAIOps phases: set up, customize, evaluate, and deploy, with a feedback loop from deploy back to evaluate.":::

The journey runs through four phases: setting up an environment, customizing the model, evaluating its answers, and deploying to production. Here are the tools that carry the agent through each one.

## Set up the environment

Before the team can build anything, they need a place to work. Standing up services and configuration by hand is slow and error-prone, so Adventure Works uses the [**Azure Developer CLI**](/azure/developer/azure-developer-cli/?azure-portal=true) (**azd**) with a prebuilt [AI app template](/collections/5pq0uompdgje8d?sharingId=ADFFF9D4AD9A0F29&WT_mc.id=aip-114567-cassieb&azure-portal=true) to provision and deploy everything they need in a few commands.

:::image type="content" source="../media/setup-environment.png" alt-text="Diagram that shows the set-up-the-environment phase: azd provisions resources and the Chat playground lets you try models.":::

With the environment ready, they explore models in **Microsoft Foundry**. In the Foundry portal, they open the [**Chat playground**](/azure/foundry/concepts/concept-playgrounds?azure-portal=true) and fire real shopper questions—*"Which tent handles winter camping?"*—at different models to see which answers most naturally before committing.

## Customize the model

A base model knows a lot about the world but nothing about Adventure Works' current inventory. The team closes that gap two ways. **Retrieval Augmented Generation (RAG)** lets the agent search the live product catalog and answer from what it finds, so recommendations always reflect what's in stock. They build this on [**Foundry IQ**](/azure/foundry/agents/concepts/what-is-foundry-iq?azure-portal=true), a managed, permission-aware knowledge layer over Azure AI Search, and can store and search embeddings in [**Microsoft Fabric**](https://techcommunity.microsoft.com/blog/startupsatmicrosoftblog/building-high-scale-rag-applications-with-microsoft-fabric-eventhouse/4217816?azure-portal=true) Eventhouse. **Fine-tuning** instead trains the model on examples—like past support chats—to lock in the brand's friendly tone, and [**serverless fine-tuning**](/azure/foundry-classic/concepts/fine-tuning-overview?azure-portal=true) does it without managing infrastructure. Adventure Works leads with RAG for freshness and layers in fine-tuning for voice.

:::image type="content" source="../media/customize-model.png" alt-text="Diagram that shows the customize phase: adapt the model with RAG grounding and fine-tuning, which an Azure AI agent then uses with its tools.":::

These are complementary, not competing. To act on those answers, the team wraps the model in an [**Azure AI agent**](/azure/foundry/agents/overview?azure-portal=true). The agent brings the pieces together—it grounds its replies with RAG, runs on the fine-tuned model, and calls tools like catalog search and purchase history—so it can recommend and compare gear on a shopper's behalf. A customized agent still needs proof that it answers well. That's what evaluation delivers.

## Evaluate the answers

Before the agent goes live, Adventure Works scores its answers against a **rubric**—a scoring guide that spells out what a good response looks like, such as relevant, grounded in real product data, and friendly in tone.

:::image type="content" source="../media/evaluate-answers.png" alt-text="Diagram that shows the evaluate phase: the Azure AI Evaluation SDK scores against a rubric, ASSERT runs regression tests, Content Safety filters.":::

The [**Azure AI Evaluation SDK**](/azure/ai-foundry/how-to/develop/evaluate-sdk?azure-portal=true) runs this scoring automatically, with built-in evaluators for quality (groundedness, relevance, coherence), safety (harmful or biased content), and agent behavior (intent resolution, tool-call accuracy, task adherence), plus custom evaluators for your own criteria.

To catch regressions, the team uses [**ASSERT**](/azure/foundry/observability/how-to/evaluate-agent?azure-portal=true) (Adaptive Spec-driven Scoring for Evaluation and Regression Testing), which turns the agent's rules—like *never invent a discount*—into automated tests and links each failure back to the exact request and reason, so the team knows *why* the agent fell short.

And because a public-facing agent can't afford an offensive answer, [**Microsoft Foundry Content Safety**](/azure/ai-services/content-safety/overview?azure-portal=true) flags harmful or biased responses before they reach a shopper.

## Deploy to production

With the agent scoring well, it's time to ship. Adventure Works needs it running reliably on the website, updating without downtime, and watched closely once real shoppers arrive.

:::image type="content" source="../media/deploy-production.png" alt-text="Diagram that shows the deploy phase: build and orchestrate tools (Agent Framework, LangChain) plus observe and automate (Azure Monitor, Actions).":::

To build and orchestrate the agent, Microsoft recommends the [**Microsoft Agent Framework**](/agent-framework/overview/?azure-portal=true), an open-source SDK for C# and Python that unifies Semantic Kernel and AutoGen so you can build single and multi-agent workflows one consistent way—with migration guides if you already have code in either. [**LangChain**](/azure/ai-foundry/how-to/develop/langchain?azure-portal=true) is a popular alternative for connecting models to external data, APIs, and memory.

Once it's live, the team keeps the agent healthy with a stack that builds on itself. [**Tracing**](/azure/foundry/observability/concepts/trace-agent-concept?azure-portal=true) records each request—which tools the agent called and why it answered as it did. [**Azure Monitor**](/azure/azure-monitor/overview?azure-portal=true) and [**Application Insights**](/azure/azure-monitor/app/app-insights-overview?azure-portal=true) collect those traces alongside metrics like latency, token usage, and error rates, so the team spots trouble in real time. [**GitHub Actions**](https://docs.github.com/actions?azure-portal=true) ships new versions automatically.

This closes the loop: production traffic feeds continuous evaluation that re-scores live answers against the same rubric. If quality drifts, the team catches it and cycles back to improve the agent—the same planning discipline that got it launched now keeps it trustworthy.
