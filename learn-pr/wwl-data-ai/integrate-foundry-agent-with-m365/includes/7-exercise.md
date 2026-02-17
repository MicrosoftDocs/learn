In this exercise, you create an agent in Microsoft Foundry, configure it with instructions to help users with common questions, and publish it to Microsoft Teams. By the end, you'll have a working agent accessible directly in Teams chat.

## Prerequisites

Before starting this exercise, ensure you have:

- An Azure subscription with permissions to create resources
- Access to the Microsoft Foundry portal (ai.azure.com)
- **Azure AI Project Manager** role on your Foundry project
- A Microsoft 365 subscription with access to Microsoft Teams
- Permissions to upload custom apps to Teams (or admin assistance to do so)

## Create a Foundry project

If you don't already have a Foundry project, create one:

1. Go to the [Microsoft Foundry portal](https://ai.azure.com).
2. Select **Create an agent** from the home page.
3. Enter a name for your project, such as **teams-agent-demo**.
4. Select **Create** and wait for the resources to be provisioned.

The portal automatically deploys a model and creates a default agent for your project.

## Configure your agent

Set up your agent with instructions and test it in the playground:

### Step 1: Define the agent instructions

1. In your Foundry project, select your agent to open the agent designer.
2. In the **Instructions** field, enter the following:

   ```
   You are a helpful assistant for the Contoso company. Your role is to answer questions about company policies and help employees find information.

   Guidelines:
   - Be professional and friendly
   - If you don't know the answer, say so honestly
   - Keep responses concise but complete
   - Ask clarifying questions if the user's request is unclear

   You can help with:
   - General company information
   - Common workplace questions
   - Directing users to the right resources
   ```

3. Adjust the instructions to match a scenario relevant to your organization if desired.

### Step 2: Test in the playground

1. In the agent designer, locate the chat playground panel.
2. Send test messages to verify your agent responds appropriately:

   - "Hello, can you help me?"
   - "What can you help me with?"
   - "Who should I contact about IT issues?"

3. Review the responses and adjust your instructions if needed.
4. Test several different types of questions to verify behavior.

## Publish to Microsoft Teams

Now publish your agent so it's accessible in Teams:

### Step 1: Start the publishing process

1. With your agent selected in the Foundry portal, select **Publish**.
2. In the publishing dialog, select **Publish** again.
3. Choose **Publish to Teams and Microsoft 365 Copilot**.

### Step 2: Configure Azure Bot Service

1. Note the automatically generated application ID and tenant ID.
2. In the **Azure Bot Service** dropdown, select **Create an Azure Bot Service**.
3. Wait for the Bot Service resource to be created in your subscription.

### Step 3: Enter metadata

Fill in the required information:

| Field | Example value |
|-------|---------------|
| **Name** | Contoso Assistant |
| **Description** | Helps employees find company information and answers policy questions |
| **Icons** | Upload 32x32 and 192x192 PNG icons (or use placeholder icons for testing) |
| **Publisher** | Your organization name |
| **Privacy policy** | https://contoso.com/privacy (use your organization's URL) |
| **Terms of use** | https://contoso.com/terms (use your organization's URL) |

> [!TIP]
> For testing purposes, you can use placeholder URLs for privacy policy and terms of use. Replace them with actual URLs before production deployment.

### Step 4: Choose publish scope

1. Select **Shared scope** for this exercise. This option lets you test immediately without waiting for admin approval.
2. Select **Prepare Agent**.
3. Wait for the packaging process to complete.
4. Select **Download** to save the publishing package to your computer.

## Test your agent in Teams

Upload the package to Teams and verify it works:

### Step 1: Upload to Teams

1. Open Microsoft Teams (desktop or web client).
2. Navigate to **Apps** > **Manage your apps**.
3. Select **Upload an app** > **Upload a custom app**.
4. Select the `.zip` file you downloaded from Foundry.
5. Wait for Teams to install the agent.

### Step 2: Start a conversation

1. Find your agent in your apps list (it may appear under **Built for you** or **Personal apps**).
2. Select the agent to open a chat.
3. Send a greeting: "Hello!"
4. Verify the agent responds according to your configured instructions.

### Step 3: Test different scenarios

Test your agent with various inputs:

- "What can you help me with?"
- "Tell me about yourself"
- "I have a question about vacation policy" (the agent should acknowledge it doesn't have specific policy data)
- Try an off-topic question to see how the agent handles it

## Verify the integration

Complete this checklist to confirm successful publishing:

- [ ] Agent responds to messages in Teams
- [ ] Responses match the behavior you saw in the Foundry playground
- [ ] Response times are reasonable (typically a few seconds)
- [ ] The agent handles unclear questions appropriately

## Clean up resources

If you created resources specifically for this exercise and don't need them:

1. In the Foundry portal, you can delete the agent if no longer needed.
2. In the Azure portal, locate and delete the Bot Service resource created during publishing.
3. In Teams, go to **Apps** > **Manage your apps** and remove the uploaded agent.

> [!NOTE]
> Keep the resources if you plan to continue developing this agent or use it as a foundation for further learning.

## Summary

In this exercise, you:

- Created an agent in Microsoft Foundry with custom instructions
- Tested the agent in the Foundry playground
- Published the agent to Microsoft Teams using the direct publishing workflow
- Verified the agent works correctly in Teams

You now have experience with the complete workflow from agent creation to Teams deployment. You can use this foundation to build more sophisticated agents with additional capabilities.
