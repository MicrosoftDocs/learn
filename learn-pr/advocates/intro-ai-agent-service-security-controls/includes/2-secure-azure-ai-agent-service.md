In Azure AI Foundry, Agents are associated with projects and projects are located within hubs. Hubs are the primary top-level Azure resource for Azure AI Foundry and provide a central way for a team to govern security, connectivity, and computing resources across playgrounds and projects. Typically, an IT Admin or technical lead manages a hub. These IT Admins or technical leads can use hubs to govern infrastructure, including virtual network setup, customer-managed keys, managed identities, and policies, and configure relevant Azure AI services. Once a hub is created, developers can create projects from it and access shared company resources without needing an IT administrator's repeated help.

Projects function as isolated development spaces, allowing developers and data scientists to build, test, and deploy AI systems. Each time a new project gets created within a hub, it automatically inherits that hub's security settings. Agents, being part of projects, can leverage the resources and configurations set at both the hub and project levels.

You can apply security controls through the Azure AI Foundry interface or by applying security controls through the Azure portal. When you deploy a hub and project, these resources are stored within a resource group in your Azure subscription. The Azure AI Foundry provides an abstracted way of interacting with these security controls without requiring an understanding of Azure administration principles.  Azure AI Foundry allows you to configure role based access control roles. Within the Azure portal, you can configure the following security settings at the Azure AI Hub level:

- Role based access control
- Network access
- Monitoring alerts, metrics and logs

At the Azure AI project level, you can configure role based access control, monitoring alerts, metrics, and logs, but can't configure network access restrictions. In most scenarios you'll configure security controls related to Azure AI Agents Service agents at the hub level. When you need to have different sets of security controls, you'll host Azure AI Agent Service agents in different Azure AI hubs.
