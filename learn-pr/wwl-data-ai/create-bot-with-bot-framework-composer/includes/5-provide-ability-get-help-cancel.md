As you design your bot, you may think that the interaction is intuitive and easy to follow. There may still be users who require guidance or help with your bot. Consider the options to help users navigate your bot. Let users test the bot and find areas where the navigation is not intuitive or users may not understand how to respond or request an action.

A user may also decide that they no longer want to continue down a path they started. Perhaps they want to start over or just cancel the current request. The Bot Framework Composer provides features that you can use to implement dialogs for help and for interrupting the conversation flow in a bot.

## Add help functionality

You can add help to your bot using a dialog. Ensure that you have your weather bot open in the Composer and follow the instructions in this exercise to add help to your bot.

1. Select the **+ Add** button and select **Add new dialog**.
1. In the **Define conversation objective** dialog, enter **help** for the **Name** field, and provide a **Description**.
1. Select **OK**.
1. Composer will open the **BeginDialog** in the **Authoring Canvas**.
1. You will now add an action for this dialog so select the **+** symbol at the bottom of the dialog and select **Send a response** from the list of options.
1. In the **Language Generation** text area in the **Properties** pane, enter some initial help text such as: **I am a weather bot! I can tell you the current weather conditions. Just say WEATHER.**.
1. To ensure that help is available when a user enters the word **help**, you need to add an **Intent Recognized trigger**. This trigger will be placed in your main dialog.
1. Select **GetWeatherBot** in navigation pane.
1. In the **Properties** pane on the right side, select **Regular Expression** from the **Recognizer Type** drop-down list.
1. Select **+ Add** and then **Add new trigger on GetWeatherBot**.
1. Complete the dialog as shown here and select **Submit**.

    :::image type="content" source="../media/help-intent.png" alt-text="Entering Intent Recognized, help, and help in the dialog fields for the trigger.":::

1. In the **Authoring canvas**, select the **+** symbol on the newly added trigger.
1. Select **Dialog management** and then select **Begin a new dialog**.
1. You specify the dialog to call when the help intent is recognized. Select **help** from the **Dialog name** drop-down list in the **Properties** panel.
1. If you test the bot right now, you will get an invalid response on the keyword **help**. You still need to configure the bot flow to handle interruptions, which are essentially what is happening when you issue a different intent.
1. Select **getWeather** in the navigation pane. Composer should open the **BeginDialog** in the **Authoring canvas**.
1. You want to handle the interruption in the place where the bot asks a question. Select the **Bot Asks (Text)** action in the **Authoring canvas**.
1. In the **Properties** pane, select the **Other** tab.
1. Scroll to the bottom of the properties and set the **Allow interruptions** property to **true**. This step will configure the conversation flow to permit interruptions and will display the help text you entered earlier in this exercise.
1. Restart your bot and test in the emulator.
1. Enter help at the prompt and note the response.

## Implement cancel

 At any point in a bot conversation, the user may decide to cancel the interaction. They may decide they no longer need to interact with the bot, they may become frustrated and want to end the interaction, or they may decide to come back later and just need to exit the conversation for now. Whatever the reason, your bot should offer the option to cancel. In this exercise, you will implement a global cancel action.

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. You will create a new dialog for the cancel action so select **+ Add** then **Add new dialog**.
1. Give it a **Name** of cancel and provide an appropriate **Description**.
1. Select the **+** symbol on the **BeginDialog** in the **Authoring canvas** and select **Send a response**.
1. In the **Language Generation** text area in the **Properties pane**, enter the text **Cancelling**.
1. Next, add a new action by selecting the **+** symbol, selecting **Dialog Management**, and then **Cancel all active dialogs**. When this action is initiated, it will cancel any active and all active dialogs and send the user back to the main dialog.
1. Next, you need to an intent recognized trigger to recognize the cancel request.
1. Select the **GetWeatherBot** item in the navigation pane.
1. Select the **+ Add** option and then select **Add new trigger on GetWeatherBot**. You add it at this level so that it is recognized across the entire bot conversation.
1. Ensure that **Intent recognized** is selected and enter **cancel** for both the name of the trigger and the regex expression.
1. Select **Submit**.
1. In the **cancel** trigger, select the **+** symbol and, choose the **Dialog management** and the **Begin a new dialog** option.
1. In the **Properties** pane, select the **cancel** trigger from the **Dialog name** drop-down.
1. You have now configured a global cancel action in your bot.
1. Select either **Start Bot** or **Restart Bot**.
1. When the bot has started, select the **Test in emulator** option.
1. When the emulator loads the conversation and greeting, enter **weather**.
1. The bot responds with a request for your zipcode, enter a valid U.S. zipcode.
1. Enter **help** and wait for the response.  You are now as deep into the conversation flow as you can go on this bot.
1. Enter **cancel** and the bot should respond with the message **Cancelling** showing that the global cancel is working.
