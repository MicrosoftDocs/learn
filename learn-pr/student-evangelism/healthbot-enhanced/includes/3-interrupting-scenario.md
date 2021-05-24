In general, Interrupt refers to a disturbance in a process. Similarly, here an interrupting scenario causes a break in the flow of the scenario. It allows us to jump between two different scenarios. Initially the main scenario is where the bot runs and due to a keyword that it encounters, the bot switches to the sub scenario which is defined as a model. Once the Sub Scenario is complete, it then switches back to the main scenario with an interrupt message that is defined during the configuration.

## Creating a new scenario

1. To begin with this, firstly create a new scenario for an Interrupting bot as shown below.

2. Configure the bot as below:

    - Name: Any unique name (We have used "Intermediate Bot 1")

    - Description: Any simple description of what the bot will do. (We have given "A simple bot to collect the vitals from patients")

    - Scenario ID: A unique ID ("vitals")

    - Returning message: This message appears while the bot is returning back to the main bot ("Lets continue from here")

    - Interrupting Scenario: Enabled

    - Breaking Scenario: Disable

3. Make sure that an Interrupting Scenario is activated. For now, the breaking scenario is unchecked, as we want this bot to return to the main flow.  

4. Click on Create and the new scenario is created.

:::image type="content" source="../media/3-create.png" alt-text="3-a":::

In this tutorial a vital collector bot is built using some basic blocks which were discussed in the previous section. This intermediate bot 1, collects the basic vitals (Name, Age, Height, Weight, Temperature) of patients.

:::image type="content" source="../media/3-intermediate-bot-1.png" alt-text="3-b":::

Along with creating a new scenario for the bot, we also need to create a new model.

:::image type="content" source="../media/3-new-language-model.png" alt-text="3-c":::

## Creating a new model for interrupting scenario

To begin with this, firstly create a new model as shown below.

1. We can do this by sliding the mouse over to the language tab on the left bar below the scenario tab and clicking on models.  

2. Configure the model as below:  

   :::image type="content" source="../media/3-model-details.png" alt-text="3-d":::

   - **Name:** Provide a name to the model that is being created. Here it is named as vitals.

   - **Description:** Provide a suitable description.

   - **Method:** There are three methods available. For this model select RegEx Method.

   - **Regular Expression:** Once RegEx method is selected, provide a suitable JavaScript RegEx. Here enter "/^(vitals)?(!)?\s*$/i" as regex.

   - **Intent Mapping:** This is a unique intent triggered when the utterance is matched with the RegEx Pattern provided. Here map it as shown in the picture.

3. From the dropdown menu, choose vitals.

4. Click on create and the Vitals Bot is ready to use.

## Changes to the basic bot

The basic bot scenario created in the previous scenario will be used in this module to demonstrate the Interrupting and Breaking scenario. So before moving ahead, some changes need to be done to the previous scenario. So, open the scenario and add the scenario steps as shown in the picture.

:::image type="content" source="../media/3-prompt-details.png" alt-text="3-e":::

Since "vitals" is a keyword that triggers an interrupting scenario, add it to the main bot. Drag a simple Prompt Block and edit it as shown above.

:::image type="content" source="../media/3-add-block.png" alt-text="3-f":::

Place it as shown in the above picture.

While the main bot is being run, this scenario is triggered when the user enters the word "vitals" as shown in the picture below. The word vitals break the current flow of the main bot and takes the user to the new scenario for recording the user's vitals.  

:::image type="content" source="../media/3-vitals-trigger.png" alt-text="3-g1":::
:::image type="content" source="../media/3-resume-topic.png" alt-text="3-g2":::

After the patient provides the bot with all the information asked, the bot returns to the main bot to continue with the appointment process, with a returning message.
