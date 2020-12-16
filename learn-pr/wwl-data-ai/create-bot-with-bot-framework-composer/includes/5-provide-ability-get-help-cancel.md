As you design your bot, you may think that the interaction is intuitive and easy to follow. There may still be users who require guidance or help with your bot. Consider the options to help users navigate your bot. Let users test the bot and find areas where the navigation is not intuitive or users may not understand how to respond or request an action.

A user may also decide that they no longer want to continue down a path they started. Perhaps they want to start over or just cancel the current request. The Bot Framework Composer provides features that you can use to implement dialogs for help and for interrupting the conversation flow in a bot.

## Add help functionality

You can add help to your bot using a dialog. Ensure that you have your weather bot open in the Composer and follow the instructions in this exercise to add help to your bot.

1. In the Bot Framework Composer, in your **WeatherBot** bot, select **+ Add** button and add a new dialog named **help**.
1. In the navigation pane, under **help**, select **BeginDialog** to open it in the **Authoring Canvas**.
1. Use the **+** symbol at the bottom of the dialog to add a **Send a response** action, and set its **Language Generation** text to **- To get the current weather conditions. Just say "weather".**.

    To ensure that help is available when a user enters the word **help**, you need to add an **Intent Recognized trigger**. This trigger will be placed in your main dialog.

1. In the **Navigation** pane, select **WeatherBot**.
1. In the **Properties** pane, in the **Language Understanding** section, set the **Recognizer type** to **Regular expression recognizer**.
1. Select **+ Add** from the toolbar and then select **Add new Trigger on WeatherBot**.
1. In the **Create a trigger** dialog that is displayed:
    - Select **Intent recognized** from the **What is the type of this trigger?** drop-down list.
    - Enter **help** for the **What is the name of this trigger (RegEx)** value.
    - Enter **help** for the **Please input regex pattern** value.

    :::image type="content" source="../media/help-intent.png" alt-text="Entering Intent Recognized, help, and help in the dialog fields for the trigger.":::

1. In the **Authoring canvas**, select the **+** symbol under your new **help** trigger node. Then in the list of actions, select **Dialog Management** and select **Begin a new dialog**.
1. To specify the dialog to call when the help intent is recognized, select **help** in the **Dialog name** drop-down list in the **Properties** pane.

    If you were to  test the bot right now, you would get an invalid response on the keyword **help**. You still need to configure the bot flow to handle interruptions, which are essentially what is happening when you issue a different intent.

1. In the navigation pane, under **getWeather**, select **BeginDialog** to open it in the **Authoring canvas**.
1. You want to handle the interruption in the place where the bot asks a question, so select the **Prompt for text** action where the user is asked for their zipcode, and in the **Properties** pane, on the **Other** tab, in the **Prompt configurations** section, set the **Allow interruptions** property to **true**.
1. Restart your bot and test in the emulator.
1. Enter "help" at the prompt and note the response.

## Implement cancel

 At any point in a bot conversation, the user may decide to cancel the interaction. They may decide they no longer need to interact with the bot, they may become frustrated and want to end the interaction, or they may decide to come back later and just need to exit the conversation for now. Whatever the reason, your bot should offer the option to cancel. In this exercise, you will implement a global cancel action.

1. In the Bot Framework Composer, in your **WeatherBot** bot, select **+ Add** button and add a new dialog named **cancel**.
1. In the navigation pane, under **help**, select **BeginDialog** to open it in the **Authoring Canvas**.
1. Use the **+** symbol at the bottom of the dialog to add a **Send a response** action, and set its **Language Generation** text to **- Cancelling.**.
1. After the **Send a response** action, add a new **Dialog Management** > **Cancel all active dialogs**. When this action is initiated, it will cancel any active and all active dialogs and send the user back to the main dialog.

    Now you need to define an intent recognizer trigger to recognize the cancel request.

1. In the navigation pane, select **WeatherBot**. Then select the **+ Add** option and then select **Add new trigger on GetWeatherBot**. You add it at this level so that it is recognized across the entire bot conversation.
1. In the **Create a trigger** dialog that is displayed:
    - Select **Intent recognized** from the **What is the type of this trigger?** drop-down list.
    - Enter **cancel** for the **What is the name of this trigger (RegEx)** value.
    - Enter **cancel** for the **Please input regex pattern** value.
1. In the **cancel** trigger flow, add a **Dialog management** > **Begin a new dialog** action Then, in the **Properties** pane for the **Begin a new dialog** action, select the **cancel** trigger from the **Dialog name** drop-down.
1. Restart your bot and test in the emulator.
1. Enter "what's the weather?", then enter a zip code and verify that the weather conditions are returned.
1. Enter **help** and wait for the response.  You are now as deep into the conversation flow as you can go on this bot.
1. Enter **cancel** and the bot should respond with the message **Cancelling.** showing that the global cancel is working.
1. When you have finished testing, close the Bot Framework Emulator.
