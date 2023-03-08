The Azure Health Bot service supports several built-in scenarios. For example, the bot can triage a medical condition or find information about a disease. You can also design custom scenarios in the Health Bot service that fit your organization's needs. 

## Get started with a custom scenario

1. If you don't have access to the Azure Health Bot service, [create a free account](https://azure.microsoft.com/services/bot-services/health-bot/?azure-portal=true).

1. Sign in to the Health Bot portal.

1. Select **Create new scenario**.

   :::image type="content" source="../media/2-health-bot-create-new-scenario.png" alt-text="Screenshot that shows the link for creating a new scenario.":::

1. In the **New Scenario** form, fill in the following details.

   :::image type="content" source="../media/2-health-bot-scenario-details.png" alt-text="Screenshot that shows fields for a new scenario.":::

   - **Name**: Choose a name for your custom bot. Try to keep it meaningful so that it's easy to find when you're searching for it.

   - **Description**: Enter a brief explanation of your bot so that others will know why you're creating it.

   - **Scenario ID**: Enter a unique ID for the bot. It's case-sensitive and does not allow spaces.

   - **Returning Message**: Enter a message that appears if the scenario is interrupted and then the user returns.  

   - **Interrupting scenario**: Select this toggle if you want to allow the scenario to be interrupted.

1. Select **Create**. Configuration of the scenario might take some time.

After the scenario is configured, the screen shows three main areas. In the **Editor** is the bot that you've designed. You can select **History** to see the JSON format of the bot. You can also use the history to select different versions of your bot to see your changes in JSON.

:::image type="content" source="../media/2-health-bot-editor-window-new.png" alt-text="Screenshot that shows the bot editor.":::
