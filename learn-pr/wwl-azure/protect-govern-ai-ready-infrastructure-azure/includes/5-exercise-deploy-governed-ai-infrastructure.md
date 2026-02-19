## Exercise 1: Control model deployment type with a custom Azure policy definition

### Estimated duration

15 minutes

### Background information
When using models from Azure AI Foundry and Azure OpenAI with Azure AI Foundry, you have the option to implement custom policies to control which type of deployment options are available to users. This ability is available for both an Azure AI Foundry project and hub-based project.

### Scenario
Your company configures custom policies in Microsoft Foundry to disable global deployments and restrict AI workloads to approved regions or data zones. This ensures compliance with regulatory and corporate requirements by keeping sensitive data within the designated residency boundaries.
:::image type="content" source="../media/control-model-deployment-custom-policy.png" alt-text="Diagram showing that Azure AI Foundry and Azure OpenAI support custom policies to control available deployment options.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create and assign policies, you should have the Owner or Resource Policy Contributor role assigned at the Azure subscription level.
- Familiarity with Azure Policy



[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346705)

## Exercise 2: Disable shared-key access for a Microsoft Foundry hub storage account

### Estimated duration
15 minutes

### Background information
Every secure request to an Azure Storage account must be authorized. By default, requests can be authorized with either Microsoft Entra credentials, or by using the account access key for Shared Key authorization. Of these two types of authorization, Microsoft Entra ID provides superior security and ease of use over Shared Key, and is recommended by Microsoft. To require clients to use Microsoft Entra ID to authorize requests, you can disallow requests to the storage account that are authorized with Shared Key.

A Microsoft Foundry hub defaults to use of a shared key to access its default Azure Storage account. With key-based authorization, anyone who has the key and access to the storage account can access data.

To reduce the risk of unauthorized access, you can disable key-based authorization and instead use Microsoft Entra ID for authorization. This configuration uses a Microsoft Entra ID value to authorize access to the storage account. The identity used to access storage is either the user's identity or a managed identity. The user's identity is used to view data in Azure Machine Learning studio or to run a notebook while authenticated with the user's identity. Machine Learning uses a managed identity to access the storage account. An example is when the managed identity runs a training job.


### Scenario
Your company is building an enterprise-grade AI platform using Microsoft Foundry to support multiple teams working on projects such as natural language processing, predictive analytics, and computer vision. To strengthen governance over sensitive AI data and prevent the risks associated with shared keys being distributed or misused, your company decided to disable key-based authorization on Azure Storage accounts associated with the Microsoft Foundry hubs and use Microsoft Entra ID, using either user identities or managed identities for secure, auditable access to storage when running notebooks, managing datasets, or executing training jobs.

:::image type="content" source="../media/disable-shared-key-access-authorize.png" alt-text="Diagram illustrating an enterprise AI platform built on Microsoft Foundry where multiple teams run AI workloads.":::

## Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription or the target resource group level.
- Familiarity with Azure Storage authorization
- Familiarity with Azure Role-Based Access Control (RBAC)

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346429)