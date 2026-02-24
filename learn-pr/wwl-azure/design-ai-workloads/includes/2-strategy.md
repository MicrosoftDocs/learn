In this unit, you focus on building an AI strategy. The first step is getting familiar with the main types of AI solutions available in Azure—Software as a Service (SaaS), Platform as a Service (PaaS), and Infrastructure as a Service (IaaS). Once you understand these options, it becomes easier to choose the Azure AI solution that fits your organization’s needs.

### Adopt Microsoft software AI services (SaaS) for initial outcomes

SaaS offerings are turnkey AI solutions like Microsoft 365 Copilot, Copilot Studio, and Microsoft Fabric. These products are designed to deliver generative AI capabilities directly within familiar applications. 

:::image type="content" source="../media/software-products.png" alt-text="Diagram showing the software service products.":::

SaaS offerings require minimal setup and are ideal for organizations seeking rapid productivity gains and role-specific AI features.

- [Microsoft Copilot](/azure/copilot/overview) is a free web-grounded chat application. Copilot Pro provides better performance, capacity, and access to Copilot in certain Microsoft 365 apps.

- [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) provides web-grounded chat and in-app AI assistance across Microsoft 365 applications, integrating with your Microsoft Graph data.

- [Microsoft Fabric](/fabric/fundamentals/microsoft-fabric-overview) is a unified analytics platform for data and AI. Microsoft Fabric is a newer SaaS solution that integrates tools like Azure Data Factory, Synapse Analytics, and Power BI.

### Build AI workloads with Azure platforms (PaaS) for custom development

Platform services include Microsoft Foundry, Azure OpenAI, Azure Machine Learning, Azure Container Apps, and Azure AI services. These products provide flexible environments for developing, training, and deploying both generative and nongenerative AI models. 

:::image type="content" source="../media/platform-products.png" alt-text="Diagram of the platform service products.":::

PaaS solutions are suited for teams that need more control over their AI workflows and want to apply prebuilt APIs or custom models.

- [Microsoft Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) is a unified Azure platform-as-a-service offering for enterprise AI operations, model builders, and application development. This foundation combines production-grade infrastructure with friendly interfaces, enabling developers to focus on building applications rather than managing infrastructure.

- [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) is a unified Azure platform-as-a-service offering for enterprise AI operations, model builders, and application development. This foundation combines production-grade infrastructure with friendly interfaces, enabling developers to focus on building applications rather than managing infrastructure.

- [Azure OpenAI](/azure/ai-foundry/foundry-models/concepts/models-sold-directly-by-azure) provides access to generative AI models including a family of large and small neural network language models. Models operate within a scalable and securable cloud service on Azure.

- [Azure Container Apps](/azure/container-apps/overview) is a serverless platform that allows you to maintain less infrastructure and save costs while running containerized applications.

- Azure AI service helps create applications with customizable APIs and models. Example applications include natural language, speech, and vision processing. 

### Build AI models with Azure infrastructure services (IaaS) for maximum control

Azure infrastructure services give you the most control when your AI workload has strict performance, isolation, or compliance needs. This approach is a good fit when you need full ownership of the operating system, frameworks, and model configurations. Also when regulatory requirements limit the use of fully managed services. 

:::image type="content" source="../media/infrastructure-products.png" alt-text="Diagram of the infrastructure service products.":::

For example, a healthcare organization might deploy its workloads on Azure virtual machines. Using Azure IaaS gives the team complete control over the software, hardware, and data on those machines. While IaaS offers maximum flexibility and control, it also comes with higher operational effort and requires deeper AI and infrastructure expertise.

> [!TIP]
> Take a moment to review the [AI product decision tree](/azure/cloud-adoption-framework/scenarios/ai/strategy#microsoft-ai-decision-tree). Which AI products best align with your organization’s goals?