This unit provides two hands-on exercises designed to help learners configure secure AI-ready infrastructure using Microsoft Foundry and Azure services. Each exercise includes background information, a practical scenario, prerequisites, and a link to launch the exercise.

**Exercise 1: Create a Microsoft Foundry resource and project-level storage connection**
This exercise focuses on establishing a secure, scalable foundation for AI development by organizing projects under a Microsoft Foundry resource and configuring shared and project-specific storage connections.  
- A resource-based Foundry deployment enables multiple projects to inherit common governance, networking, and identity settings while still allowing project-level isolation where needed.  
- Resource-level and project-level connections define how Azure Storage is securely accessed, balancing shared collaboration with private datasets and outputs.  
- Microsoft Entra ID authentication with managed identities and RBAC provides keyless, compliant access for both automated workloads and interactive development.

**Exercise 2: Implement Microsoft Foundry standard agent setup**
This exercise demonstrates how to deploy an enterprise-grade Standard agent environment that ensures full customer ownership, security, and governance of agent data.  
- Agents are created within isolated Foundry projects and use customer-owned Azure Storage, Azure AI Search, and Azure Cosmos DB to store files, vector indexes, and conversation history.  
- Capability hosts define immutable bindings between projects and their underlying Azure resources, enforcing consistent data ownership and operational behavior.  
- Template-based provisioning integrates pre-provisioned resources with Foundry projects and managed identity authentication, enabling secure, scalable AI agents for enterprise knowledge and decision-support scenarios.

Learners can find the full list of labs and launch each exercise directly by visiting the [Manage AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2345202) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.
## Exercise 1: Create a Microsoft Foundry resource and project level storage connection


Microsoft Foundry provides a unified environment for building, managing, and deploying AI workloads. In this model, deployments can be hub-based or resource-based. A hub acts as a higher-level construct that organizes and manages multiple Microsoft Foundry resources, typically used in enterprise-scale setups that require multi-region management or shared governance across environments. A resource-based setup focuses on managing projects within a single Microsoft Foundry resource, where governance, networking, and identity settings are shared among those projects.

In a resource-based deployment, each project operates as a child resource of the Microsoft Foundry resource, inheriting its security and governance settings while enabling collaboration within a shared environment. Projects can also define their own managed identities and connections, allowing precise access control to external Azure services. By default, all projects under the same resource share core configurations such as networking, deployment settings, and integrated tools, but they can also establish project-specific connections for resources that need to remain private to an individual project.

Connections in Microsoft Foundry define secure integrations between a Foundry resource or a specific project and external Azure services, such as Azure Storage, Azure AI Search, or Key Vault. A resource-level connection created on the Foundry resource is shared with its projects, while a project-level connection is scoped to a single project to preserve data and operational isolation when required. Authentication and authorization vary depending on the target service and connection type. When using Microsoft Entra ID for Azure services, access can be granted via methods such as user identities, managed identities, or service principals, with permissions enforced through Azure role-based access control (RBAC), eliminating the need for stored keys or credentials.

### Scenario
Your company plans to establish a secure and scalable development environment using Microsoft Foundry projects to manage AI workloads such as dataset preparation, model experimentation, and fine-tuning. As part of this initiative, the company creates a Microsoft Foundry resource that hosts multiple resource-based projects, each representing a distinct team, or workload domain. This structure enables different teams to work independently on separate AI solutions while maintaining shared access to common services, infrastructure, and governance policies.

To enable access to Azure Storage, the company configures two types of connections across these projects: a shared, resource-level connection to a storage account used for storing common artifacts, and project-level connections to separate storage accounts dedicated to each project’s private datasets and outputs. Both connection types rely on Microsoft Entra ID authentication, ensuring secure, keyless access through system-assigned managed identities for automated operations and user-based credentials for interactive development in notebooks or playgrounds. This configuration balances collaboration and isolation, supporting efficient and compliant AI development across the organization.

:::image type="content" source="../media/two-connections-across-key-projects.png" alt-text="Diagram shows how to enable access to Azure Storage and configure two types of connections.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types).
- **Familiarity with Azure Storage authorization**: To learn more, refer to [Prevent Shared Key authorization for an Azure Storage account](https://azure/storage/common/shared-key-authorization-prevent?tabs=portal).
- **Familiarity with Azure Role-Based Access Control (RBAC)**: To learn more, refer to [Azure RBAC documentation](https://azure/role-based-access-control/).

### Estimated time
25 minutes

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2345108)
## Exercise 2: Implement Microsoft Foundry standard agent setup


Foundry Agent Service enables creating AI agents through a two-step flow: first establishing an agent environment, and then creating and configuring the agent using an SDK or the Azure Foundry portal.

Agents are always created within a Foundry project, which functions as an isolated workspace. Agents within the same project share access to file storage, conversation history, and search indexes. Data is isolated across projects, and agents can't access resources outside their own project. Projects are the unit of sharing and isolation within Foundry.

Foundry supports three environment configuration modes that balance speed, control, and security:
- Basic setup prioritizes rapid onboarding and uses platform-managed storage for agent state. It's compatible with OpenAI Assistants and provides the same core tools and capabilities, with added support for non-OpenAI models and integrations such as Azure AI Search and Bing.
- Standard setup builds on the Basic setup by using customer-owned Azure resources for all agent data. This provides full ownership and control over files, conversation history, and vector data, and supports enterprise compliance and governance requirements.
- Standard setup with network isolation extends the Standard setup by allowing the environment to operate entirely within a customer-managed virtual network, enabling strict control over data movement and enhanced protection against data exfiltration.

The Standard agent environment is designed for enterprise-grade security, compliance, and data governance. All agent state is stored in customer-owned Azure resources, specifically Azure Storage for file uploads and intermediate system data, Azure AI Search for vector indexes used in search and retrieval, and Azure Cosmos DB for NoSQL for conversation history, system messages, and agent metadata. This ensures that all data generated during agent configuration and user interaction remains fully under the customer’s control.

Azure Cosmos DB for NoSQL used with the Standard setup must support a minimum total throughput of 3000 RU/s, in the provisioned throughput or serverless mode. Multiple containers are used to separate end-user conversations, internal system messages, and agent metadata such as instructions, tools, and configuration details.

To control how these customer-owned resources are associated with a Foundry account and project, Microsoft Foundry uses configuration constructs known as capability hosts. Capability hosts constitute a configuration context that describes how agents operate and where their state is stored. At the account level, a capability host designates that the account is configured to use the Agents capability. At the project level, a capability host captures project-specific settings, such as agent state management. This defines whether the project uses platform-managed, multitenant storage or customer-owned, Azure resources such as Azure Storage, Azure Cosmos DB, and Azure AI Search. In Standard configurations, the project capability host defines the binding between the project and these customer-managed resources.

Capability hosts are immutable once created. They can't be modified after provisioning, so, effectively, changes to the storage model or resource associations require deleting and reprovisioning the capability host.

Provisioning standard environments isn't available directly from the Microsoft Foundry portal, but you can implement them either programmatically or via deployment templates. They allow you to automatically create a Foundry account and project, deploy a model, and configure authentication using Managed Identity. With the Standard configuration option, you can choose between automatic provisioning of the required Azure resources or referencing pre-provisioned resources via template parameters, giving you full control over how Azure Storage, Azure Cosmos DB, and Azure AI Search are connected to your project.

### Scenario
Your company is building a centralized AI platform on Microsoft Foundry to support enterprise knowledge management and decision support across multiple business units. The platform enables intelligent document retrieval, automated analysis of internal reports, and conversational insights for employees, with strict controls on data ownership and compliance. To ensure operational resilience and control over critical information, the team deploys a Standard agent environment where customer-owned Azure Storage, Azure Cosmos DB, and Azure AI Search resources are used to store documents, conversation history, and search indexes. The deployment is performed using template-based methods that reference the pre-provisioned resources. The deployment integrates these resources with a Foundry account and project, and configure an agent model to use them, providing a controlled, secure, and centralized foundation for AI-driven services that can scale across the organization.

:::image type="content" source="../media/build-centralized-ai-platform-microsoft-foundry.png" alt-text="Diagram shows a company building a centralized AI platform on Microsoft Foundry to support enterprise knowledge management.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types).

### Estimated time
25 minutes

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2345109)
