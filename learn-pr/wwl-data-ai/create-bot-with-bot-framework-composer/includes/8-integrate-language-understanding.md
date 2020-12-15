Your bot currently relies on detecting regular expressions that identify specific words like "weather", "help", and "cancel". It could be improved by the ability to understand more complex natural language input. Microsoft Azure Cognitive Services offers a robust language understanding capability in the form of the Language Understanding technology. The Bot Framework Composer offers the Language Understanding recognizer as a means to access the Language Understanding technology.

The use of the Language Understanding recognizer requires a bit more work than the regular expressions you have been using. You will need to have a LUIS service with accompanying authoring key and you will need to provide some training data that is used to "capture" the user's intent in the messages they exchange.

## Update your recognizer for LUIS

You will update the **Recognizer Type** in the main dialog for the weather bot, from **Regular Expression** to **LUIS**. In the following exercises, you will integrate language understanding with the LUIS recognizer in place of the regular expression intents used in the previous exercises. The reason for the change is to help address the issue identified earlier in the training about understanding a user's intent.  For example, the weather bot has only recognized the inputs of *weather*, *help*, and *cancel*. We know that users will enter different phrases, or intents, when asking for the weather conditions.  Example input phrases might be, *weather*, *give me the current weather conditions*, *get weather*, *what is the weather*, etc. 

The Language Understanding service, offers the ability to accept sample intents, train an AI language model, and then recognize many input phrases that are asking about weather, even if you have not created an exhaustive list.

## Update the recognizer

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. In the navigation pane, select **WeatherBot**. Ensure that none of the actions are selected.

    :::image type="content" source="../media/get-weather-bot-selection.png" alt-text="WeatherBot selected in navigation pane":::

1. In the **Properties** pane, select **Default recognizer** from the drop-down for **Recognizer Type**.
1. The main dialog is now configured to use a Language Understanding recognizer instead of a regular expression recognizer.

## Add triggers for language understanding

In this exercise, you will add triggers for each of our current inputs, *weather*, *help*, and *cancel*. Delete the triggers you created for the regular expression recognizer, from previous exercise, to avoid naming conflicts in the triggers. You will create new triggers based on LUIS, adding *training data* to the configuration for each trigger. Language Understanding will use the entered phrases in the trigger as the training data, to understand user intent.

1. Select **+ Add** in the toolbar and then **Add trigger on WeatherBot**.
1. In the **Create a trigger** dialog, add the configuration as listed here:
    - **Type of trigger**: Intent recognized
    - **Name of this trigger (LUIS)**: helpPhrase
    - **Trigger phrases**: ( include the **-** prefix)
        - *- help*
        - *- help me*
        - *- I need support*
1. In the authoring canvas for the **help** trigger, select the **+** symbol and add a **Dialog management** > **Begin a new dialog** action. Then in the **Properties** pane, in the **Dialog name** list select **help** to connect this trigger to the **help** dialog.

    :::image type="content" source="../media/attach-dialog-trigger.png" alt-text="Attaching the help dialog to the help trigger":::

1. Add another trigger on **WeatherBot** with the following information:
    - **Type of trigger**: Intent recognized
    - **Name of this trigger (LUIS)**: weatherPhrase
    - **Trigger phrases**: ( include the **-** prefix)
        - *- get weather*
        - *- weather*
        - *- how is the weather?*
1. Connect the **weatherPhrase** trigger to the **getWeather** dialog.
1. Add another trigger on **WeatherBot** with the following information:
    - **Type of trigger**: Intent recognized
    - **Name of this trigger (LUIS)**: cancelPhrase
    - **Trigger phrases**: ( include the **-** prefix)
        - *- cancel*
        - *- stop*
        - *- please cancel that*
1. In the **Properties** pane for the **cancelPhrase** trigger, locate the **Condition** property and write the expression **=#cancelPhrase.score >= 0.8**.

    >[!Tip]
    >Setting this condition to **score >= 0.8** instructs the bot to *not* fire the cancel trigger if LUIS returns a score of les than 80%. The Language Understanding service evaluates the phrases entered, compares them to **intents** in the trained data, and then returns a score indicating how closely the phrase or word(s) match the intent.

1. Connect the **cancelPhrase** trigger to the **cancel** dialog.

## Create a LUIS resource and authoring key

You require a Language Understanding resource before you can publish your phrases for training.

If you don't already have Language Understanding authoring and prediction resources in your Azure subscription:

1. Open the Azure portal at [https://portal.azure.com](https://portal.azure.com?portal=true), and sign in using the Microsoft account associated with your Azure subscription.
2. Select the **&#65291;Create a resource** button, search for *language understanding*, and create a **Language Understanding** resource with the following settings:
    - **Create option**: Both
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *Choose or create a resource group (if you are using a hosted lab environment, you may not have permission to create a new resource group - use the one provided)*
    - **Name**: *Enter a unique name*
    - **Authoring location**: *Select your preferred location*
    - **Authoring pricing tier**: F0
    - **Prediction location**: *Choose the <u>same location</u> as your authoring location*
    - **Prediction pricing tier**: F0\*

    \**If F0 is not available, choose S0*

3. Wait for the resources to be created, and note that two Language Understanding resources are provisioned; one for authoring, and another for prediction. You can view both of these by navigating to the resource group where you created them.
1. After the deployment has finished, go the resource page for the **authoring** resource and view the **Keys and Endpoint** page. Then copy one of the keys to the clipboard.

## Publish the model and test language understanding

1. Ensure that you have copied a key from your authoring resource in the Azure portal.
1. To have the Bot Framework Composer publish the LUIS model you created in the trigger phrases, select **Restart Bot**.
1. When composer presents you with a **Publish LUIS models** dialog,  paste your authoring key into the **LUIS Authoring key:** field and select the region where you created your authoring resource.
1. After the model is published, test it in the Bot Framework Emulator, using various phrases, different from the ones you entered in the model, to see how Language Understanding interprets your phrases and calls the proper trigger and dialog.

Now that you have the basics of adding Language Understanding to your bot, feel free to explore more options in your bot by adding different dialogs to accomplish other tasks. Then, practice adding more LU phrases and testing your bot again. Visit the [Language Understanding Concepts](https://docs.microsoft.com/composer/concept-language-understanding) page to learn more about integrating LU into your bot with the Composer.
