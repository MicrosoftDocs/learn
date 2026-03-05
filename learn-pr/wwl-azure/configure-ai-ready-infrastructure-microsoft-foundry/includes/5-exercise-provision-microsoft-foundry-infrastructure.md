This module contains two exercises that guide you through the process of provisioning Microsoft Foundry infrastructure by creating hub-level and project-level service connections. These connections enable secure access to external Azure services, facilitating seamless integration and management of AI workloads within Microsoft Foundry.

**Exercise 1: Create a hub-level service connection**

This exercise introduces hub-level service connections in Microsoft Foundry to enable shared access to external Azure services across multiple projects.  
- Hub-level connections centralize configuration and credentials, allowing multiple projects to reuse services like Azure AI Search for retrieval‑augmented generation scenarios.  
- Shared connections improve consistency, visibility, and governance while reducing duplicated setup and management overhead.  
- Model deployments, playground experiences, fine‑tuning workflows, and jobs can all access connected services through the hub without managing separate authorizations.

**Exercise 2: Create a project-level service connection**

This exercise focuses on project-level service connections that enable secure, scoped access to external resources within a single Microsoft Foundry project.  
- Project connections allow access to resources such as Azure Storage for datasets, model artifacts, and experiment logs while keeping isolation between projects.  
- Authentication relies on Microsoft Entra ID, using the project’s managed identity for automated jobs and user identities for interactive access.  
- This approach ensures secure, role‑based access control without sharing keys or secrets, supporting end‑to‑end AI workflows within the project workspace.

Learners can find the full list of labs and launch each exercise directly by visiting the [Manage AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2345202) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.


## Exercise 1: Create a hub-level service connection



Connections let you access objects in Microsoft Foundry portal that are managed outside of your hub. For example, they might be used for retrieving data uploaded to an Azure Storage account, using an external Azure AI Search index for Retrieval Augmented Generation, or connecting to model deployments on another AI Foundry resource. Connections support storing shared credentials, so developers can access remote objects during development without having to authenticate or request authorization. 
After connections to Microsoft Foundry are created, model deployments are accessible via playground experiences. When using fine-tuning experiences in a hub-based project, fine-tuning jobs are implicitly executed on the connected AI Foundry resource.

### Scenario
Your company is developing an enterprise AI platform using Microsoft Foundry to improve consistency, visibility, and coordination across multiple AI projects. As part of the platform's setup, your company configures connections to integrate key Azure services with the hub and its projects. An Azure AI Search service is connected at the hub level, allowing all projects within the hub to access a shared search index for retrieval-augmented generation and other search-driven use cases. In contrast, an Azure Blob Storage account is connected at the project level, ensuring that its data remains accessible only to that specific project. This configuration uses shared and project-specific resources to optimize management of hub-based projects in Microsoft Foundry.

:::image type="content" source="../media/configure-connection-integrate-azure-services.png" alt-text="Diagram shows how a company configures connections to integrate key Azure services with the hub and its projects.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
  
[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2345105)

## Estimated time
20 minutes

## Exercise 2: Create a project level service connection

When a new Microsoft Foundry project is created, it automatically has access to a set of platform-managed resources that are required for core functionality, such as temporary compute for notebooks and training jobs, default artifact storage for model checkpoints, datasets, experiment logs, and intermediate files, and built-in playground/model experiences. These resources are managed internally by Microsoft Foundry and don't appear in the project's Connected Resources pane in the Microsoft Foundry portal, nor do they require explicit connections to use. 

Explicit connections in a Microsoft Foundry project allow the project to access cloud resources that are scoped specifically to that project. For example, a project can connect to an Azure Storage account to retrieve datasets or store artifacts, or to model deployments hosted by another AI Foundry resource. Connections store credentials securely, and the required authentication and authorization methods depend on the resource type.

Many Azure resources support Microsoft Entra ID authentication, which offers secure, role-based access without sharing keys or secrets. When a project initiates a job—such as a training run or data processing workflow—Microsoft Foundry can use a managed identity to authenticate automatically to the connected resource, eliminating the need for user credentials. Users accessing the same resource interactively (for example, in a notebook or playground) use their personal Entra ID credentials, with access permissions enforced by Azure roles.

Once a project-level connection is established, external resources such as datasets or models can be used directly within the project workspace. Any fine-tuning or model deployment jobs executed in the project implicitly use the connection and the appropriate authentication method, either the managed identity for automated tasks or the user identity for interactive sessions.

###     Scenario
Your company is developing an enterprise AI platform using Microsoft Foundry projects to manage multiple AI workloads independently. As part of the platform's setup, your company configures a project-level connection to an Azure Storage account. This connection uses Microsoft Entra ID authentication, relying on the project's system-assigned managed identity to securely access the storage account without relying on user credentials. The managed identity is used to authorize automated operations initiated by the project, include reading training datasets, writing model artifacts, and log experiment results. Users accessing the project interactively, for example in a notebook or playground session, will authenticate via their individual Entra ID credentials, with access permissions enforced by the storage account's role assignments. This configuration ensures that the project can securely use Azure Storage for its workflows, while keeping the storage account scoped exclusively to that project and fully managed via Entra ID authentication.

:::image type="content" source="../media/notebook-session-authenticate-individual.png" alt-text="Diagram shows a company developing an enterprise AI platform using Microsoft Foundry projects to manage multiple AI workloads.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription.
- **Familiarity with Microsoft Foundry resource types**: To learn more, refer to [Choose an Azure resource type for AI foundry](https://azure/ai-foundry/concepts/resource-types).

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2344497)

## Estimated time
15 minutes
