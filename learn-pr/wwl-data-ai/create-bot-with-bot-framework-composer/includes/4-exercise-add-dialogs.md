In this exercise, and subsequent exercises in this training, you will work with various components in the Bot Framework Composer as you build out a bot that will retrieve weather for a zip code in the United States.

## Add a dialog to get the weather

Now that you have a working bot, you can expand its capabilities by adding dialogs for specific interactions. In this case, you'll add a dialog that is triggered when the user mentions "weather".

### Add a dialog

First, you need to define a dialog flow that will be used to handle questions about the weather.

1. In Composer, in the navigation pane, hold the mouse over the top-level node (**WeatherBot**) and in the **&#8285;** menu, select **+ Add a dialog**, as shown here:

   ![Add Dialog menu](../media/add-dialog.png)

    Then create a new dialog named **getWeather** with the description **Get the current weather condition for the provide zip code**.
1. In the navigation pane, select the **BeginDialog** node for the new **getWeather** dialog. Then on the authoring canvas, use the **+** symbol to add a **Send a response** action.
1. In the properties panel for the new action, in the **Language Generation** area, enter **- Ready to check the weather?**.

The **getWeather** activity flow should look like this:

![A dialog flow with one Send a response action](../media/getweather-dialog-1.png)

### Add a trigger for the dialog

Now you need some way for the new dialog to be initiated from the existing welcome dialog.

1. In the navigation pane, select the **WeatherBot** workflow that contains the **WelcomeUsers** dialog (this is under the top-level project node of the same name).

    ![Selected WeatherBot workflow](../media/select-workflow.png)

1. In the properties pane for the selected **WeatherBot** workflow, in the **Language Understanding** section, set the **Recognizer type** to **Regular expression recognizer**.

1. In the **&#8285;** menu for the **WeatherBot** workflow, select **Add a Trigger**.

    ![Add Trigger menu](../media/add-trigger.png)

Then create a trigger with the following settings:

- Select **Intent recognized** from the **What is the type of this trigger?** drop-down list.
- Enter **weather-regex** for the **What is the name of this trigger (RegEx)** value.
- Enter **-weather** for the **Please input regex pattern** value.

> [!NOTE]
> The text entered in the regex pattern text box is a simply regular expression pattern that will cause the bot to look for the word *weather* in any incoming message.  If weather is present, the message becomes a **recognized intent**. A (-) dash is required syntax to run correctly. 

1. Now that the trigger is created, you need to configure an action for it. In the authoring canvas for the trigger, elect the **+** symbol under your new **weather-regex** trigger node. Then in the list of actions, select **Dialog Management** and select **Begin a new dialog**.
1. With the **Begin a new dialog** action selected, in the properties pane, select the **getWeather** dialog from the **Dialog name** drop-down list to start the **getWeather** dialog you defined earlier when the **weather-regex** trigger is recognized.

    The **weather-regex** activity flow should look like this:

    ![A regex trigger begins the getWeather dialog](../media/weather-regex.png)

1. Restart the bot and use the Bot emulator to test your progress so far. After entering your name and being welcomed, enter a phrase containing "weather" (for example *What's the weather forecast?*), and your bot should respond with, **Ready to check the weather?**.
1. When you have finished testing, close the emulator, and stop the bot.

### Implement the weather dialog

The **getWeather** dialog flow so far consists of a simple message. Now you need to add actions to get the user's zipcode and retrieve the relevant weather information.

1. In the navigation pane, select the **BeginDialog** trigger under the **getWeather** dialog. 
1. Directly under the **Send a response** action you added previously, add a new **Ask a question** action for a **Text** response.
1. In the properties pane, on the **Bot asks** tab, set the **Prompt for text** to **- Enter your zipcode.**.
1. On the **User Input** tab, set the **Property** field to **user.zipcode**, and set the **Output format** field to the expression **=trim(this.value)** to remove any superfluous spaces around the user-provided value.
1. On the **Other** tab, set the following values to define validation rules for the zipcode input:
    - In the **Recognizers** areas, set the **Unrecognized Prompt** field, to **- Sorry the value '${this.value}' doesn't appear to be a valid entry.  Please enter a zip code in the form of 12345.**.
    - In the **Validation** section, enter the validation rule **length(this.value) == 5** to will check that the length of the zipcode entry is only five characters. Then set the **Invalid Prompt** field to **- Sorry, '${this.value}' is not valid. I'm looking for a 5-digit number as zip code. Please specify a zip code in the form 12345.**.
    - In the **Prompt configurations** section, set the **Default value** property to **98052**.

        By default, prompts are configured to ask the user for information *Max turn count* times (with a default of 3). When the max turn count is reached, the prompt will stop and the property will be set to the value defined in the **Default value** field before moving forward with the conversation.

    The activity flow so far should look like this:

    ![partially complete activity flow](../media/getweather-dialog-2.png)
    
1. On the authoring canvas, directly under the **user Input**** action for the user zipcode entry, select the **+** symbol to add a new action.
1. From the list of actions, select **Access external resources** and then **Send an HTTP request**.
1. Set the properties for the **HTTP request** as follows, specifying your [OpenWeather](https://openweathermap.org/price) API key:
    - **HTTP method**: GET
    - **Url**: http://weatherbot-ignite-2019.azurewebsites.net/api/getWeather?zipcode=${user.zipcode}&api_token=*Your_API_Key*
    - **Result property**: dialog.api_response

    The result can include any of the following four properties from the HTTP response:

    - **statusCode**. Accessed via **dialog.api_response.statusCode**.
    - **reasonPhrase**. Accessed via **dialog.api_response.reasonPhrase**.
    - **content**. Accessed via **dialog.api_response**.content.
    - **headers**. Accessed via **dialog.api_response.headers**.

    Additionally, if the response type is JSON, it will be a deserialized object available via **dialog.api_response.content** property.

    Now you need to add logic to the dialog flow that handles the response, which might indicate success or failure of the HTTP request. 

1. On the authoring canvas, under the **Send HTTP Request** action on the you created, add a **Create a condition** > **Branch: if/else** action. This action defines a branch in the dialog flow with **True** and **False** paths.
1. In the **Properties** of the branch action, set the **Condition** field to write the following expression:

    ```code
    =dialog.api_response.statusCode == 200
    ```

1. If the call was successful, you need to store the response in a variable. On the authoring canvas, in the **True** branch, add a **Manage properties** > **Set a Property** action. Then in the properties pane, set the properties of the **Set a Property** action as follows:
    - **Property**: dialog.weather
    - **Value**: =dialog.api_response.content

1. Still in the **True** branch, add a **Send a response** action under the **Set a property** action and set its **Language generation** text to **- The weather in ${dialog.weather.city} is ${dialog.weather.weather} and the temp is ${dialog.weather.temp}\&deg;.**
1. You also need to account for a response from the weather service that is not 200, so in the **False** branch, add a **Send a response** action and set its **Language generation** text to **- I got an error: ${dialog.api_response.content.message}.**

    For the purposes of this exercise, we will assume that an invalid zip code is the most likely cause of a failure, and if it is invalid it should be removed.

1. In the **False** branch, after the  **Send a response** action you just created, add a **Manage properties** > **Delete a property** action and set its **Property** field to **user.zipcode**.

    The finished activity flow should look like the following image:

    ![Complete activity flow](../media/getweather-dialog-3.png)

1. Restart the bot and test it in the Bot Framework Emulator. Wait for the greeting from the bot and after entering your name, enter "What is the weather like?". Then, when prompted, enter a valid U.S. zip code, such as 98004. The bot will contact the service and should respond with a small weather report statement.
1. When you have finished testing, close the emulator and stop the bot.
