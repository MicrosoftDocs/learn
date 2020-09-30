The ability of a bot to understand a user's intent is a critical aspect of good bot design and interaction. In the exercises you have completed in this article so far, the use of basic regular expressions have been the mechanism for understanding what the user is asking. Microsoft Azure Cognitive Services offers a robust language understanding capability in the form of the Language Understanding (LU) technology. The Bot Framework Composer offers the LUIS recognizer as a means to access the Language Understanding technology.

The use of the LUIS recognizer requires a bit more work than the regular expressions you have been using. You will need to have a LUIS service with accompanying authoring key and you will need to provide some training data that is used to "capture" the user's intent in the messages they exchange.

While you do not require expert knowledge of Language Understanding to complete this exercise, it may be helpful to have some knowledge of how it works. We do not teach LUIS in this article but you can learn more by going through the [Language Understanding](https://docs.microsoft.com/learn/modules/add-basic-conversational-intelligence/) training.

## Update your recognizer for LUIS

You will update the **Recognizer Type** in the main dialog for the weather bot, from **Regular Expression** to **LUIS**. In the following exercises, you will integrate language understanding with the LUIS recognizer in place of the regular expression intents used in the previous exercises. The reason for the change is to help address the issue identified earlier in the training about understanding a user's intent.  For example, the weather bot has only recognized the inputs of *weather*, *help*, and *cancel*. We know that users will enter different phrases, or intents, when asking for the weather conditions.  Example input phrases might be, *weather*, *give me the current weather conditions*, *get weather*, *what is the weather*, etc. 

Language Understanding, and the LUIS service, will offer the ability to accept sample intents, train an AI language model, and then recognize many input phrases that are asking about weather, even if you have not created an exhaustive list.

## Update the recognizer

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. In the **Navigation** pane, select the **GetWeatherBot** item. Ensure that none of the actions are selected.

    :::image type="content" source="../media/get-weather-bot-selection.png" alt-text="GetWeatherBot selected in navigation pane":::

1. In the **Properties** pane, select **LUIS** from the drop-down for **Recognizer Type**.
1. The main dialog is now configured to use a LUIS recognizer as opposed to a regular expression recognizer.

## Add triggers for language understanding

In this exercise, you will add triggers for each of our current inputs, *weather*, *help*, and *cancel*. Delete the triggers you created for the regular expression recognizer, from previous exercise, to avoid naming conflicts in the triggers. You will create new triggers based on LUIS, adding *training data* to the configuration for each trigger. Language Understanding will use the entered phrases in the trigger as the training data, to understand user intent.

1. Select **+ Add** in the toolbar and then **Add trigger on GetWeatherBot**.
1. In the **Create a trigger** dialog, add the configuration as listed here:
    1. Type of trigger is set to **Intent recognized**
    1. Name of this trigger (Luis) set to **cancel**
    1. In **Trigger phrases**, enter three phrases, each preceded by a dash, **- cancel**, **- please cancel that**, and **- stop that**.
    1. Select **Submit** to create the **cancel** trigger.
    1. The trigger will open in the **Authoring canvas**. You will set a **Condition** property to check the **score** of the intent.
    1. In the **Properties** pane, locate the **Condition** property and enter the following text, **#Cancel.Score >= 0.8**.

    >[!Tip]
    >Setting this condition to **Score >= 0.8** instructs the bot to *not* fire the cancel trigger if LUIS returns a score of les than 80%. The Language Understanding service evaluates the phrases entered, compares them to **intents** in the trained data, and then returns a score indicating how closely the phrase or word(s) match the intent.

1. Create another trigger at the same level with the following information:
    1. Type of trigger is **Intent recognized**
    1. Name of the trigger is **weather**
    1. Phrases are: **- get weather**, **- weather**, and **- how is the weather**
1. Create another trigger at the same level with the following information:
    1. Type of trigger is **Intent recognized**
    1. Name of the trigger is **help**
    1. Phrases are: **- help**, **- I need help**, **- please help me**, **- can you help**
1. Because you are creating new triggers, you must also link them to the appropriate dialogs for the bot to respond.
1. Select the **help** trigger, then select the **+** symbol, **Dialog management**, and finally **Begin a new dialog**.
1. When the action is added to the **help** trigger, select **help** from the **Dialog name** drop-down.

    :::image type="content" source="../media/attach-dialog-trigger.png" alt-text="Attaching the help dialog to the help trigger":::

1. Repeat the same procedure to attach the **getWeather** and **cancel** dialogs to the proper triggers.

## Create a LUIS resource and authoring key

You require a LUIS authoring key and resource before you can publish your phrases for training. The following exercise guides you through the creation of the resource on Microsoft Azure. You will require an active Azure subscription to create this resource.

1. Sign in to the Azure portal.
1. In the left pane, select + Create a resource.
1. In the Search the Marketplace box, type LUIS, and then press Enter.
1. In the search results, select Language Understanding.
1. Select Create.
1. Leave the Create options set to Both.
1. Choose a subscription.
1. Enter a unique name for your LUIS service.
1. Create a new resource group named LearnRG.
1. For Authoring Location, choose the one nearest you.
1. For Authoring pricing tier, select F0
1. Set your Prediction location to the same region you chose for Authoring location
1. For Prediction pricing tier, select F0. If F0 is not available, select S0 or other free/low cost tier.
1. Select Review + Create.
1. If the validation succeeds, select Create.
1. After the deployment has finished, go the resource page for the service. You'll need one of the displayed subscription keys for later exercises. Locate the Resource Management section and then select the Keys and Endpoints section to see the two created keys.

## Publish the model and test language understanding

1. Ensure that you have copied a key from your LUIS authoring resource in the Azure portal.
1. To have the Bot Framework Composer publish the LUIS model you created in the trigger phrases, select **Start Bot** or **Restart Bot**.
1. Composer presents you with a **Publish LUIS models** dialog.  Paste your **LUIS authoring key** into the **LUIS Primary key:** field on the dialog.
1. Select **OK** to publish the model.
1. Once the model is published, select the **Test in emulator** option.
1. Test the bot with various phrases, different from the ones you entered in the model, to see how Language Understanding interprets your phrases and calls the proper trigger and dialog.

Now that you have the basics of adding Language Understanding to your bot, feel free to explore more options in your bot by adding different dialogs to accomplish other tasks. Then, practice adding more LU phrases and testing your bot again. Visit the [Language Understanding Concepts](https://docs.microsoft.com/composer/concept-language-understanding) page to learn more about integrating LU into your bot with the Composer.