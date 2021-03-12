Your bot currently relies on detecting regular expressions that identify specific words like "weather" and "help". It could be improved by the ability to understand more complex natural language input. Microsoft Azure Cognitive Services offers a robust language understanding capability in the form of the Language Understanding technology. The Bot Framework Composer offers the Language Understanding recognizer as a means to access the Language Understanding technology.

The use of the Language Understanding recognizer requires a bit more work than the regular expressions you have been using. You will need to have a Language Understanding service Azure resource with an authoring key, and you will need to provide some sample utterances to train a model to recognize the user's intent in the messages they submit.

## Add a Language Understanding trigger for a *cancel* dialog

 At any point in a bot conversation, the user may decide to cancel the interaction. In this exercise, you will implement a cancel action that can be triggered using natural language phrases.

1. In the navigation pane, under the **getWeather** dialog, select **BeginDialog** to open it in the authoring canvas.
1. Select the **Prompt for text** action where the user is asked for their zipcode, and in the properties pane, on the **Other** tab, in the **Prompt configurations** section, set the **Allow interruptions** property to **true**.
1. In the navigation pane, add a new dialog named **cancel** to the top-level **WeatherBot** bot.
1. In the navigation pane, under the new **cancel** dialog, select **BeginDialog** to open it in the authoring canvas.
1. Add a **Send a response** action, and set its **Language Generation** text to **- Cancelling.**.
1. After the **Send a response** action, add a new **Dialog Management** > **Cancel all active dialogs**. When this action is initiated, it will cancel any active and all active dialogs and send the user back to the main dialog.

    The **cancel** activity flow should look like this:

    ![Cancel trigger activity flow](../media/cancel-dialog.png#lightbox)

    Now you need to define an intent recognizer trigger to recognize the cancel request.

1. In the navigation pane, select the **getWeather** dialog, and in its properties pane, verify that under **Language Understanding**, the **Recognizer type** is set to **Default recognizer** - this recognizer type uses the Language Understanding service, rather than the regular expression recognizer you used previously.
1. In the navigation pane, add a new trigger to the **getWeather**dialog, with the following settings:
    - **What is the type of this trigger?**: Intent recognized
    - **What is the name of this trigger (LUIS)**:  cancel-lu
    - **Trigger phrases**:

        *- cancel*

        *- quit*

        *- stop*

1. In the **cancel-lu** trigger flow, add a **Dialog management** > **Begin a new dialog** action. Then, in the properties pane for the **Begin a new dialog** action, select the **cancel** trigger from the **Dialog name** drop-down.

    You may see a warning icon for your bot. By using the Language Understanding recognizer, you have added a dependency on a Language Understanding Azure resource.

## Create a Language Understanding resource in Azure

You require a Language Understanding resource before you can publish your phrases for training.

If you don't already have Language Understanding authoring and prediction resources in your Azure subscription, follow these steps to create them:

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
4. After the deployment has finished, go the resource page for the **authoring** resource and view the **Keys and Endpoint** page. Then copy one of the keys to the clipboard.
5. Back in the Bot Framework Composer, in the **&#8285;** menu for the top-level **WeatherBot** bot, select **Settings**.
6. Paste your Language Understanding authoring key into the **LUIS authoring key** property.
7. Return to the **Design** page.

## Test the natural language *cancel* functionality

1. Restart your bot and test in the emulator.
1. Enter your name, and then *what's the weather?*
1. When prompted for a zipcode, enter *I want to stop* and the bot should respond with the message **Cancelling.**
1. When you have finished testing, close the emulator and composer.