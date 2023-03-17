Let's create another interrupting bot to help patients check their temperature and other vitals, if they haven't so far. The patient can reach this bot by entering the word **temperature**. That entry breaks the flow of the original bot and runs this new one. 

To create this bot, you're building a breaking scenario and then creating a model.

Let's start by creating a second interrupting bot that works like a breaking scenario. After that, we'll connect it to the main bot by using a keyword that calls the interrupting bot. We can start by selecting **New**  in the top left corner on the **Scenario Management** page.

## Create a breaking scenario

1. Configure the scenario with the following details:  

   :::image type="content" source="../media/4-health-bot-create-breaking-scenario.png" alt-text="Screenshot that shows the selections for configuring a breaking scenario.":::

   - **Name:** Enter **Intermediate Bot 2**.
   - **Description:** Enter **An interrupting bot which checks the patient's temperature and breaks**.
   - **Scenario ID:** Enter **temperature**.  
   - **Returning Message:** Enter **Please start your process again**.  
   - **Interrupting scenario:** Turn on this toggle.
   - **Breaking scenario:** Turn on this toggle, because we need to see how the breaking scenario works.

1. Select **Create**.

You can now create a scenario to collect temperature information from the patient, based on your learnings from the previous sections.

:::image type="content" source="../media/4-health-bot-edit-breaking-scenario.png" alt-text="Screenshot of the editor view of a bot that collects temperature information.":::

## Create a model for the breaking scenario

Our bot gives messages about the temperature of the patient. We're using only prompt, yes/no, and statement blocks to build the bot.  

1. Configure the model with the following details:

   :::image type="content" source="../media/4-health-bot-language-model.png" alt-text="Screenshot that shows the regular expression configuration for the model.":::

   - **Name:** Enter **temperature**.
   - **Description:** Enter **temperature**.
   - **Method:** Select **RegEx**.
   - **Regular Expression:** Enter `/^(temperature)?(!)?\s*$/i`.
   - **Intent mapping:** Enter **temperature**.

1. From the dropdown list, select **temperature**. Then select **Create**.

When we run the main bot, and the patient enters the word **temperature**, the flow breaks and Intermediate Bot 2 starts running.  

:::image type="content" source="../media/4-flow-break.png" alt-text="Screenshot that shows the Web Chat preview of the temperature bot.":::

The bot displays the temperature for the patient and asks if they want to check more vitals. When the patient chooses **No**, the bot ends the scenario and never returns to the main bot.

:::image type="content" source="../media/4-flow-resume.png" alt-text="Screen shot that shows redirecting to the main bot.":::
