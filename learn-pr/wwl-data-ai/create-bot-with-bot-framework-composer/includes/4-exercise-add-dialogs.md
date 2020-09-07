In this exercise, and subsequent exercises in this training, you will work with various components in the Bot Framework Composer as you build out a bot that will retrieve weather for a zip code in the United States.

1. Ensure that you have installed the prerequisites and the Bot Framework Composer.
1. Start the Bot Framework Composer.
1. On the **Home** screen, select **New**.
1. Select the radio button for **Create from scratch**.
1. Select **Next**.
1. In the **Define conversation objective** dialog, change the default **Name** to **GetWeatherBot**, or a name of your choosing.
1. Select the **Location** on your computer to store the bot.
1. Provide a **Description** of the bot.
1. Select **OK**.
1. The Composer will generate some framework aspects of your bot and then open the bot in the interface.
1. Under **Filter Dialog**, select **Greeting**.
1. The designer opens in the middle of the Composer interface with some content already populated. This content in the designer, represents the **ConversationUpdate** activity that is called when a user joins a conversation with the bot. The designer shows that the bot will loop for each item (members added), includes a branch segment that will handle recipient IDs, and then a response item.
1. You can edit the title of **Greeting** by selecting the word **Greeting** in the properties pane on the right and typing in a new value.  Select the **Greeting** text and change it to **WelcomeUsers**.
1. If you start the bot right now and test it in the emulator, a generic message of **Welcome to the EmptyBot sample** text is displayed. It does not represent the design of our bot or the greeting we want to use.
1. In the **Designer pane**, select the **Send a response** item.
1. In the **Properties** panel on the right, change the default message *${WelcomeUser()}* to something more appropriate such as **Hi! I'm a friendly bot that can help with the weather. Try saying WEATHER or FORECAST.**.
1. Start, or restart the Bot, and then test it in the Bot Emulator. Once the emulator connects with the bot, your message should display as the welcome message presented to the user.
1. Next, you will add a dialog to the conversation flow. In the top toolbar, select **+ Add** and then select **Add new dialog**.
1. In the dialog, set the **Name** to **getWeather** and add a **Description** like **Get the current weather condition for the provide zip code** and select **OK**.
1. The new dialog is created and opens in the **Authoring canvas**. At the top of the dialog is the **BeginDialog** trigger. You will use the trigger to send a message to the user.
1. Select the **+** symbol in the **Authoring canvas** and select the **Send a response** action.
1. In the **Property** panel, you will notice a **Language Generation** area. Enter the following text in that area, **Ready to check the weather?**.
1. You will connect this dialog to the main dialog to make it part of the conversation flow.
1. In the **Navigation** pane, where it indicates **Filter dialog**, select the GetWeatherBot item.
1. In the **Properties** pane, locate the **Language Understanding** section.
1. Change the **Recognizer type** to **Regular Expression**.
1. Select **+ Add** from the toolbar and then select **Add new Trigger on GetWeatherBot**.
1. In the dialog that is displayed, select **Intent recognized** from the **What is the type of this trigger?** drop-down list. 
1. Enter **weather** for both the **What is the name of this trigger (RegEx)** and the **Please input regex pattern** fields.
1. Select **Submit**.

    > [!Note]
    > The text entered in the regex pattern text box is a simply regular expression pattern that will cause the bot to look for the word *weather* in any incoming message.  If weather is present, the message becomes a **recognized intent**.

1. Now that the trigger is created, you want to configure an action. Select the **+** symbol under you new trigger node.
1. In the list of options, select **Dialog Management** and then **Begin a new dialog**.
1. In the **Properties** pane, select the **getWeather** option from the **Dialog name** drop-down list.
1. This step links the recognized intent with the **getWeather** dialog that you created earlier.
1. If you test your progress so far, you can enter a phrase containing weather, or just the word **weather** by itself, and your bot should respond with, **Ready to check the weather?**, or whatever text you entered for the **getWeather** dialog.

## Set up the user request for zipcode

Now that you have the starting point for the weather bot in place, it's time to gather some information from the user and then call the weather service using the zip code. In this portion of the exercise, you will configure the getWeather dialog using the BeginDialog trigger. The task is to collect input from the user in a **Text Input** action. The **Text Input** item allows you to enter a prompt for the user and then collect the user's response in a **User Input** object. In this exercise, you will learn how to specify properties for the user input value so you can access them in later bot conversation aspects.

1. With your weather bot project open in the Bot Framework Composer, select **getWeather** in the navigation pane. 
1. If the **BeginDialog** trigger does not display in the **Authoring canvas**, select **BeginDialog** in the navigation pane.
1. Directly under the **Send a response** object, select the **+** symbol and select **Ask a question** and then **Text** from the list of options displayed.
1. You now have two nodes available for this option. The first node corresponds to the prompt that will display to the user and the second node represents the input that will be received from the user.
1. Each of these nodes also corresponds to a tab in the properties pane. **Bot asks** and **User input**.

   [![Ask a question node with properties pane](../media/ask-question.png)](../media/ask-question.png#lightbox)

1. In the **Properties** pane, select inside the text area for **Bot asks** and enter the text to prompt the user for their zip code, **Enter your zipcode**.
1. In the **Properties** pane, select the **User Input** tab.
1. The **User Input** tab has three fields that you can use for collecting the user input. Enter **user.zipcode** into the **Property** field leaving the type set to string.
1. To ensure that spaces before or after a user entry are not problematic, you will use the built-in function **trim()** to remove any whitespace before or after the user's zipcode entry.  In the **Output format** field, select **expression** from the drop-down and then enter **=trim(this.value)** as the value for the output format.
1. You also want to handle the potential for unrecognized values. Select the **Other** tab.
1. In the **Unrecognized Prompt** field, enter a value to let the user know they may have entered an invalids zipcode, **Sorry the value '${this.value}' doesn't appear to be a valid entry.  Please enter a zip code in the form of 12345**.
1. To validate the zipcode entry, select inside the **Validation Rules** field and enter **length(this.value) == 5**. This will check that the length of the zipcode entry is only five characters.  U.S.-based zipcodes can be five numbers or a five number, hyphen, and four number variant.  We are only concerned with the five number variant.
1. Provide a prompt to the user if they enter an incorrect value by selecting inside the **Invalid Prompt** field and entering the following text **Sorry, '${this.value}' is not valid. I'm looking for a 5-digit number as zip code. Please specify a zip code in the form 12345**.
1. Finally, set the **Default value** property to **98052**. You will have to scroll the **Properties** pane to see this field.

>[!Note]
>By default prompts are configured to ask the user for information Max turn count number of times (defaults to 3). When the max turn count is reached, the prompt will stop and the property will be set to the value defined in the Default value field before moving forward with the conversation.

## Make the weather report request

In this exercise, you will create an HTTP request, pass in the user's zip code, and then display the results to the user in the bot emulator.

1. Ensure you have your weather bot open in the Bot Framework Composer.
1. Directly under the last action you created for the user zipcode entry, select the **+** symbol.
1. From the list of options, select **Access external resources** and then **Send an HTTP request**.
1. Now you will configure the properties for the **HTTP request**.
1. Select the **GET** option for the **HTTP method**.
1. Enter this pre-configured URL into the **Url** text field, **http://weatherbot-ignite-2019.azurewebsites.net/api/getWeather?zipcode=${user.zipcode}&api_token=Your_API_Token**.
1. You will require a token for the service to work so visit the [**OpenWeather site**](https://openweathermap.org/price) to get your free token.  Paste that token into the *Your_API_Token* placeholder in the above Url.
1. As with any HTTP request, we need to handle the response that is returned. In the next set of steps, you will configure various properties and add a conditional statement node to handle the responses.
1. In the **Properties** pane for the **HTTP Request**, locate the **Result property** entry and enter the value, **dialog.api_response**. It sets up a property to store the response from the service.

The result can include any of the following four properties from the HTTP response:

- statusCode. Accessed via dialog.api_response.statusCode.
- reasonPhrase. Accessed via dialog.api_response.reasonPhrase.
- content. Accessed via dialog.api_response.content.
- headers. Accessed via dialog.api_response.headers.

If the Response type is Json, it will be a deserialized object available via dialog.api_response.content property.

1. Now you will add an If/Else branch node to help handle any errors that may be returned in the response.
1. Select the **+** symbol that appears beneath the **Send HTTP Request** action you created. 
1. Select **Branch: if/else** from the **Create a condition** menu.
1. In the **Properties** panel on the right, enter the following value into the **Condition** field: 
    **dialog.api_response.statusCode == 200**.
1. In the **True** branch, select the **+** symbol and then select **Set a Property** from the **Manage properties** menu.
1. In the **Properties** panel on the right, enter **dialog.weather** into the **Property** field.
1. Enter **=dialog.api_response.content** into the **Value** field.
1. Your **Property** pane should look like this image.

    :::image type="content" source="../media/set-property.png" alt-text="True branch property settings":::

1. If the status is true, you want to send a response to the user with the weather information so, while still in the **True** branch, select the **+** symbol, that appears beneath the action created in the previous step, then select **Send a response**.
1. In the **Properties** panel on the right, enter the following response to send:

    **The weather is ${dialog.weather.weather} and the temp is ${dialog.weather.temp}&deg;**

1. The flow should now appear in the **Authoring canvas** as follows:

    :::image type="content" source="../media/if-else.png" alt-text="if/else branch True settings":::

1. You also need to account for a response that is not 200, from the service.
1. Select the **+** symbol in the **False** branch, then select **Send a response**
1. Set the text of the message to: **I got an error: ${dialog.api_response.content.message}**

    > [!Note]
    >For the purposes of this exercise we will assume that if you are in this branch, it is because the zip code is invalid, and if it is invalid it should be removed so that the invalid value does not persist in the user.zipcode property.

1. To remove the invalid value from the zipcode property, select the **+** symbol that follows the **Send a response** action you created in the previous step, then select **Delete a property** from the **Manage properties** menu.
1. In the **Properties** panel on the right, enter **user.zipcode** into the **Property** field.
1. The finished branching statement should look like the following image:

    :::image type="content" source="../media/if-else-2.png" alt-text="Completed if/else branch":::

1. Ensure that you have pasted your API key from the weather service into the placeholder in the URL.
1. Select **Start Bot** or **Restart Bot** in the Composer.
1. Once the bot has started, select the **Test in emulator**.
1. Wait for the greeting from the bot and then enter **weather**.
1. When prompted, enter a valid U.S. zip code, such as 98072.
1. The bot will contact the service and should respond with a small weather report statement.
