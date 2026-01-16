## Manage AI

Managing AI operations is about keeping your AI work consistent and reliable. Create an [AI Center of Excellence](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence) to guide strategy, choose the right framework (MLOps or GenAIOps), and standardize SDKs and APIs. Use sandboxes for safe experimentation and simplify tuning with tools like [Copilot Tuning.](/copilot/microsoft-365/copilot-tuning-overview) 

Tip: For more information, consider the [Introduction to AI Center of Excellence](/training/modules/intro-ai-center-excellence/) training module.

:::image type="content" source="../media/manage-operations.png" alt-text="Diagram of the main management areas.":::


### AI deployment 

Use the deployment model that fits how your org works, usually one Foundry instance per business unit, with separate projects for each use case. Deploy in the correct Azure regions for performance and compliance. Monitor resources with Azure Monitor and manage configurations and costs through the [Foundry Management Center](/azure/ai-foundry/control-plane/how-to-manage-compliance-security). Use API Management when multiple apps are deployed.

### AI models 

Track every model version and use centralized governance to control updates. Continuously monitor models for drift so you can retrain or adjust as needed. Use Foundry and Azure AI tools to keep models compliant and consistent across teams.

### AI costs 

Monitor AI resource usage so teams understand their spending. Use clear cost-allocation structures like separate projects or subscriptions. Set budgets and alerts, right size compute, and scale only when needed. Central teams can enforce cost-saving policies to keep expenses predictable.

### AI data

Managing AI data means ensuring its accurate, secure, and compliant. Create and maintain golden datasets so teams have a consistent, trusted source for testing and validation. Build secure, validated data pipelines so only clean, approved data reaches your models. And stay updated on data sensitivity changes, remove sensitive data when needed, and retrain models if classifications change.

### AI business continuity

To keep AI services running during disruptions, you need a solid continuity plan that includes constant monitoring, multi-region deployments, and regular disaster-recovery testing. Continuous monitoring helps you catch issues early as models, data, and usage patterns evolve. 

Deploying AI workloads—both generative and traditional—across multiple Azure regions provides redundancy and prevents outages. Use tools like Azure Front Door and Traffic Manager for automatic failovers. Strong version control and automated backups make it easy to restore models, pipelines, and configurations when something goes wrong. 
