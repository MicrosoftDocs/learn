## Design PaaS AI Workloads

When you're designing AI workloads on Azure PaaS, focus on three things: choose the right compute for generative AI, use the right services for traditional (nongenerative) AI, and secure networking to protect your data and manage access. Together, these considerations help ensure your AI solutions are scalable, secure, and aligned with your workload requirements.

### Select resources for generative AI

[Generative AI](/azure/cloud-adoption-framework/scenarios/ai/platform/resource-selection) refers to artificial intelligence that produces original content—such as text, images, audio, video, or code—by applying patterns identified in extensive datasets. Generative AI uses multiple resources to process input data and produce meaningful outputs. 

In this example, Microsoft Foundry orchestrates the answer to a user’s search query. AI Search uses grounding data to provide an answer. 

:::image type="content" source="../media/generative-workflow.png" alt-text="Diagram of a generative workflow.":::

To build effective applications, select resources that ground AI models and deliver accurate results. Ensure you match the right tools to the type of AI you’re building. For generative AI you’re basically taking a user question, finding the right data to ground the answer, and passing everything through a model. That means you pick a generative AI platform (Foundry or Azure OpenAI), an orchestrator to handle the workflow, something like Azure AI Search to retrieve relevant data, and the place where your data lives, such as Blob Storage.

> [!NOTE]
> For more information, check out the [Introduction to generative AI and agents](/training/modules/fundamentals-generative-ai/) training module. This resource covers the basics of generative AI such as large language models (LLMs), crafting prompts, and working with AI agents. 

### Select resources for nongenerative AI

[Nongenerative AI](/azure/cloud-adoption-framework/scenarios/ai/platform/resource-selection) encompasses systems that analyze, classify, predict, or optimize existing data, without generating new content. Nongenerative AI workloads use platforms, compute resources, data sources, and data processing tools to support machine learning tasks. 

In this example, an AI app uses Azure AI Services and Azure Machine Learning to provide a response. 

:::image type="content" source="../media/nongenerative-workflow.png" alt-text="Diagram of a nongenerative workflow.":::

Select resources that help you build AI workloads with prebuilt or custom solutions. You send data into a model and get results—no grounding step required. You can use prebuilt AI services if you want something simple with no extra compute, or Azure Machine Learning if you need to train or customize a model. Either way, you choose the compute you need, your data source, and any optional processing tools.

### Select networking resources

:::image type="content" source="../media/network-concepts-2.png" alt-text="Diagram of a virtual network with software concepts.":::

Keep your AI workloads inside a [secure virtual network](/azure/cloud-adoption-framework/scenarios/ai/platform/networking) and avoid exposing anything to the public internet. Use private endpoints so services like Foundry, Azure AI Services, Storage, Key Vault, and Container Registry all communicate privately over the Azure backbone.

Control traffic tightly. Use a Bastion-connected jump box for safe admin access, restrict outbound traffic to only what your workloads need, and use network security groups to enforce least‑privilege access between resources.

Finally, monitor your environment. Azure Firewall protects and inspects outbound traffic, and Azure Web Application Firewall shields any public-facing AI apps from common attacks, helping you run AI workloads securely and confidently.
