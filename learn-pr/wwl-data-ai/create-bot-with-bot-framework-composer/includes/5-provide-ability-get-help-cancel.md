As you design your bot, you might think that the interaction is intuitive and easy to follow. There may still be users who require guidance or help with your bot. Consider the options to help users navigate your bot. Let users test the bot and find areas where the navigation is not intuitive or users may not understand how to respond or request an action.

## Add *help* functionality

Users may need help with understanding how your bot works. You can add help to your bot using a dialog, and enable users to interrupt a dialog to ask for help.

1. In the navigation pane, add a new dialog named **help** to the top-level **WeatherBot** bot node. Then select the new **help** dialog's **BeginDialog** trigger to see it in the *authoring canvas.
1. Add a **Send a response** action, and set its **Language Generation** text to **- To get the current weather conditions for your area. Just say "weather".**.

    The completed activity flow should look like this:

    ![Help activity flow](../media/help-dialog.png#lightbox)

    To ensure that help is available when a user enters the word **help**, you need to add an **Intent Recognized trigger**. This trigger will be placed in your main dialog.

1. In the navigation pane, select the **WeatherBot** dialog (under the **WeatherBot** bot). Then in the properties pane, verify that the **Recognizer type** is set to **Regular expression recognizer**.
1. Add a new trigger to the **WeatherBot** dialog, with the following settings:
    - **What is the type of this trigger?**: Intent recognized
    - **What is the name of this trigger (RegEx)**:  help-regex
    - **Please input regex pattern**: help
1. In the authoring canvas for the new trigger, select the **+** symbol under your new **help** trigger node. Then in the list of actions, select **Dialog Management** > **Begin a new dialog**.
1. To specify the dialog to call when the help intent is recognized, select **help** in the **Dialog name** drop-down list in the properties pane.

    The **help-regex** trigger dialog flow should look like this:

    ![Help trigger activity flow](../media/help-trigger.png#lightbox)

1. In the navigation pane, under the **WeatherBot** dialog, select **WelcomeUsers** to open it in the authoring canvas.
1. Select the **Prompt for text** action where the user is asked for their name. Then in the properties pane, on the **Other** tab, in the **Prompt configurations** section, set the **Allow interruptions** property to **true**.
1. Restart your bot and test in the emulator.
1. When asked for your name, enter "help" and review the response.
1. When you've finished testing, close the emulator and stop the bot.
