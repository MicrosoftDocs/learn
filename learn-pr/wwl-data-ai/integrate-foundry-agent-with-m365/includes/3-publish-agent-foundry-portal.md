Publishing an agent from the Microsoft Foundry portal to Microsoft Teams and Microsoft 365 Copilot is a straightforward process. The portal guides you through creating an agent application, provisioning the required Azure resources, and generating a publishing package for distribution.

## Before you begin

Before starting the publishing process, complete these preparation steps:

### Test your agent thoroughly

Use the Foundry playground to verify your agent behaves as expected. Test various user inputs, confirm any configured tools work correctly, and check that responses are appropriate for your use case. Issues are easier to fix before publishing than after.

### Verify your permissions

Confirm you have the required role assignments:

- **Azure AI Project Manager** role on your Foundry project to publish agents
- **Azure AI User** role to invoke or chat with published agents
- Permissions to create resources in your Azure subscription
- Permissions to register applications in Microsoft Entra ID

### Register the Bot Service provider

The publishing process creates an Azure Bot Service resource. Ensure the **Microsoft.BotService** provider is registered in your Azure subscription. You can check this in the Azure portal under your subscription's **Resource providers** section.

### Prepare metadata

Gather the following information before starting:

- A display name for your agent (appears in the Teams agent store)
- A brief description of what your agent does
- Small (32x32 pixels) and large (192x192 pixels) icons in PNG format
- Your organization's name and contact details
- URLs for your privacy policy and terms of use

> [!WARNING]
> Don't include secrets, API keys, or sensitive information in any metadata fields. These fields are visible to users who discover your agent.

## Publish your agent

Follow these steps to publish your agent from the Foundry portal:

### Step 1: Select your agent version

1. Open the [Microsoft Foundry portal](https://ai.azure.com) and navigate to your project.
2. Select the agent you want to publish from your agent list.
3. Review the agent configuration to confirm it's ready for publishing.

### Step 2: Start the publishing process

1. Select **Publish** to open the publishing dialog.
2. Select **Publish** again, then choose **Publish to Teams and Microsoft 365 Copilot**.
3. The Microsoft 365 publishing configuration window opens.

### Step 3: Configure Azure Bot Service

1. The portal automatically generates an application ID and tenant ID. Note these values for troubleshooting.
2. In the **Azure Bot Service** dropdown, select **Create an Azure Bot Service** to provision a new bot resource.
3. Wait for the portal to create the Bot Service resource in your subscription.

### Step 4: Complete the metadata

Fill in the required fields:

| Field | Description |
|-------|-------------|
| **Name** | Display name for your agent in the Teams store |
| **Description** | Brief explanation of what your agent does |
| **Icons** | Upload small and large PNG icons |
| **Publisher information** | Your organization name and contact details |
| **Privacy policy** | URL to your organization's privacy policy |
| **Terms of use** | URL to your terms of service |

### Step 5: Choose your publish scope

Select the distribution scope for your agent:

- **Shared scope**: Agent appears under "Your agents" in the store. Available immediately. Best for testing and small teams.
- **Organization scope**: Agent appears under "Built by your org" in the store. Requires admin approval. Best for production deployments.

### Step 6: Prepare and optionally download the package

1. Select **Prepare Agent** to start packaging your agent.
2. Wait for the packaging process to complete (typically 1-2 minutes).
3. When ready, you can either:
   - **Download the package** to test locally before distribution
   - **Continue the in-product publishing flow** for direct distribution

## Test the publishing package in Teams

If you downloaded the package, test it in Teams before broad distribution:

1. Open Microsoft Teams.
2. Navigate to **Apps** > **Manage your apps** > **Upload an app**.
3. Select **Upload a custom app** and choose the downloaded `.zip` file.
4. Teams installs the app and shows it in your apps list.
5. Open the agent and send a test message.

Verify the following:

- [ ] The agent responds to messages
- [ ] Response content is accurate and appropriate
- [ ] Response times are acceptable
- [ ] Any configured tools work correctly

## Request admin approval for organization scope

If you published with organization scope, an administrator must approve your agent before it's available organization-wide:

1. Direct your Microsoft 365 administrator to the [Microsoft 365 admin center](https://admin.cloud.microsoft).
2. Navigate to **Agents** > **All** > **Requested**.
3. Find your agent in the list of pending requests.
4. The administrator selects **Approve request and activate**.

Once approved, the agent appears in the **Built by your org** section of the Teams agent store for all users in your tenant. App policies in your organization control which users can access the agent.

## Reassign permissions after publishing

When you publish an agent, the system creates a distinct agent identity. If your agent uses tools that access Azure resources, you need to grant permissions to this new identity:

1. In the Foundry portal, go to your published agent and note the agent application's identity information.
2. In the Azure portal, navigate to the resources your agent accesses (for example, Azure AI Search, storage accounts, or Cosmos DB).
3. Assign the appropriate RBAC roles to the published agent identity.

Without this step, tools that worked during development might fail after publishing because the new agent identity lacks the required permissions.

## Update a published agent

When you make changes to your agent in Foundry, you need to republish to update the version available in Teams:

1. Make your changes in the Foundry portal.
2. Test the changes in the Foundry playground.
3. Repeat the publishing process to create a new package.
4. For shared scope, upload the new package to Teams.
5. For organization scope, the update might require re-approval depending on your organization's policies.

Users interacting with your agent receive the updated version once the new package is deployed.
