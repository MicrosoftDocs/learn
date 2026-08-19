Your retail organization plans to deploy three AI applications this quarter: a customer support chatbot, a product recommendation engine, and an inventory forecasting model. The team currently provisions Azure AI resources independently. This scattered approach makes it difficult to apply consistent security controls, understand spending, and manage access to connected services.

Microsoft Foundry addresses these infrastructure challenges through a top-level Foundry resource and child projects. The Foundry resource is the governance boundary for networking, security, model deployments, and connections. Projects provide development boundaries where teams build and evaluate individual use cases. Connected Azure services, such as Azure AI Search, remain separate Azure resources with their own networking and access controls.

In this module, you plan a Foundry resource and project structure, select roles for administrators and developers, and connect a project to Azure AI Search by using explicit role assignments. By the end, you can provision a governed foundation for multiple AI workloads by using the current Foundry resource model.

## Learning objectives

By the end of this module, you're able to:

- Plan a Microsoft Foundry resource and project structure for multiple AI workloads
- Assign Microsoft Foundry roles at appropriate resource and project scopes
- Connect a Foundry project to Azure AI Search
- Configure managed identity access to connected Azure services

## Prerequisites

- Familiarity with Azure portal navigation and resource management
- Basic understanding of AI and machine learning concepts
- Experience with Azure resource groups and role-based access control (RBAC)
