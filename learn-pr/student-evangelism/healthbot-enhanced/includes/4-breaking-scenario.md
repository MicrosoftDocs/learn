Just like how we built a scenario and created a model for Interrupting Bot 1, we would create for Interrupting Bot 2.  

In Intermediate Bot 2, we are going to help patients check their temperature and other vitals, if they haven't so far. The patient can reach this Bot by entering the word "temperature". It would break the flow of the original bot and run this new Bot.

1. The scenario for Interrupting Bot 2 will have the following configurations:  

   :::image type="content" source="../media/4-edit-scenario.png" alt-text="4-a":::

   - **Name:** Interrupting Bot 2

   - **Description:** Interrupting bot which checks the patient's temperature and breaks.

   - **Scenario ID:** temperature  

   - **Returning Message:** Please start your process again.  

   - **Interrupting Scenario:** Enabled

   - **Breaking Scenario:** Enabled

1. Click on create.

   :::image type="content" source="../media/4-bot-designer.png" alt-text="4-b":::

   We can create a simple bot, which gives out messages of the temperature of the patient. Here, we have used only prompt, yes/no and statement blocks to build this bot.  

   > [!Note]
   > Make sure to enable the breaking scenario, as we need to see how it works.

1. The configuration for the Model of Intermediate Bot 2 is as follows:

   :::image type="content" source="../media/4-model-details.png" alt-text="4-c":::

   - **Name:** temperature

   - **Description:** temperature

   - **Method:** RegEx

   - **Regular Expression:** /^(temperature)?(!)?\s*$/i

   - **Intent mapping:** temperature

1. From the drop down, choose temperature and click on Create.

When we run the main bot, and the user enters the word "temperature", for checking his/her temperature, the flow breaks and Intermediate Bot 2 starts running, as shown in Fig 1.  

:::image type="content" source="../media/4-flow-break.png" alt-text="4-d1":::

:::image type="content" source="../media/4-flow-resume.png" alt-text="4-d2":::

It simply displays XYZ temperature for a user and asks the user, if they want to check more vitals. Once the user chooses 'no', the bot ends the scenario and never returns to the main bot as seen in Fig 2.
