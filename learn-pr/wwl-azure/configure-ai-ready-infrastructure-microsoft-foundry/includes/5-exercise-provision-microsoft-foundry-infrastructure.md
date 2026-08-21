This unit contains two exercises that guide you through provisioning current Microsoft Foundry infrastructure and connecting a project to an external Azure service.

**Exercise 1: Create a Foundry resource and project**

This exercise establishes the top-level governance resource and a project for one AI use case.

**Exercise 2: Create a project-level service connection**

This exercise connects an existing Azure AI Search service to the project and configures explicit permissions for a Foundry agent to use the search index.

## Exercise 1: Create a Foundry resource and project

In this exercise, you create a Foundry project by using the current Foundry portal. If you don't have a suitable Foundry resource, the portal can create one as part of the project workflow.

### Scenario
Your company is developing an enterprise AI platform with separate projects for customer support, recommendations, and inventory forecasting. Create a Foundry resource as the governance boundary and a project for the customer support application.

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.
- **Permissions**: You need a role that can create Foundry resources and projects, such as **Foundry Account Owner** or **Foundry Owner**, at the subscription or resource-group scope. If you assign access to other users, you also need permission to create role assignments.

### Create the project

1. Open the [Microsoft Foundry portal](https://ai.azure.com).
1. Create a new project.
1. Enter **customer-support** as the project name.
1. Select an existing Foundry resource, or create a resource in a supported region.
1. Finish creating the project, and then open it.
1. Select **Manage** > **Project details**.
1. Record the project name, project endpoint, parent Foundry resource, and resource group.

### Assign developer access

1. On the project's **Users** tab, select **Add user**.
1. Select a test user or Microsoft Entra security group that requires development access.
1. Select **Add**.
1. Confirm that the user or group has the **Foundry User** role on the project.

### Verify project identity access

1. In the Azure portal, open the parent Foundry resource.
1. Select **Access control (IAM)**, and check the role assignments for the project's managed identity.
1. If the identity doesn't have access, assign it the **Foundry User** role on the Foundry resource.

> [!NOTE]
> Role names might still display their previous Azure AI names while the Foundry role-name update rolls out. The role IDs and core permissions are unchanged.

## Estimated time
20 minutes

## Exercise 2: Create a project-level service connection

Project connections reference Azure resources outside the Foundry resource. Those resources retain separate authorization and networking boundaries. In this exercise, you configure the documented keyless Azure AI Search tool workflow for a Foundry agent by assigning Search roles to the project managed identity before adding the connection.

### Scenario
The customer support project needs an Azure AI Search index to ground a Foundry agent's responses. Connect an existing search service to the project by using Microsoft Entra ID authentication.

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.
- **Azure AI Search**: Use an existing search service and index that you have permission to configure.
- **Permissions**: You need permission to assign roles on the search service and add a project connection.

### Assign search roles

1. In the Azure portal, open the Azure AI Search service.
1. Under **Settings**, select **Keys**, and then select **Both** to enable key-based and role-based access control authentication.
1. Select **Access control (IAM)** > **Add role assignment**.
1. Assign **Search Index Data Contributor** to the customer-support project's managed identity.
1. Assign **Search Service Contributor** to the same identity.

### Add the project connection

1. Return to the customer-support project in the Foundry portal.
1. Select **Manage** > **Project details** > **Connected resources**.
1. Select **Add connection** > **Azure AI Search**.
1. Browse for and select the search service.
1. Select Microsoft Entra ID authentication, and then add the connection.
1. Confirm that the search service appears on the **Connected resources** tab.

If the connection returns a 401 or 403 error, confirm that both role assignments target the project managed identity and allow time for new assignments to propagate.

For current connection options and troubleshooting guidance, see [Connect an Azure AI Search index to Foundry agents](/azure/foundry/agents/how-to/tools/ai-search).

## Estimated time
15 minutes
