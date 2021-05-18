The Health Bot Service supports several built-in scenarios. For example, the bot can triage a medical condition, or find information about a disease.

Besides the built-in scenarios, we can also design scenarios in the health bot service which fits your organization's needs. We can do this by authoring custom scenarios in this SaaS service.

## Getting started with a custom scenario

1. If you don't have an access to the [Azure Health Bot service](https://azure.microsoft.com/services/bot-services/health-bot/?azure-portal=true).

1. Login to the Microsoft Health Bot Service Portal.

   :::image type="content" source="../media/2-create-new.png" alt-text="Advanced Functionalities-1":::

1. On logging in to the Health Bot management we can see a Portal as shown above. Now select "CREATE A CUSTOM SCENARIO" from here.

1. We then see a form on the screen which will ask us a few details like,

   :::image type="content" source="../media/2-new-scenario-details.png" alt-text="Advanced Functionalities-2":::

   - NAME: Choose a name for your custom bot. Try to keep it meaningful, so that it comes in handy when you are in search of it!

   - DESCRIPTION: A brief explanation of your bot can be given here. So, others will also get to know what this bot is tailored for.

   - Scenario ID: This is a unique ID for the bot and it is case sensitive and does not allow spaces. Returning Message: This is a message specially if the scenario is interrupted and then the user returns back.  

   - Interrupting Scenario: This determines whether the scenario can be interrupted or not.

1. After filling in the details press on create. It might take some time to configure.

Once the scenario is configured, we can see a similar screen as shown...

:::image type="content" source="../media/2-configured.png" alt-text="Advanced Functionalities-3":::

The fields, visual editor, and elements provided in the Scenario Editor allow you to author, test, and debug scenarios.

There are a lot of elements in this canvas which we will go through when needed, we can see 4 main windows on the screen. There is an option to see the code of the block we have designed using the designer.

:::image type="content" source="../media/2-code.png" alt-text="Advanced Functionalities-4":::

The code section, when clicked shows the JSON format of the block.
