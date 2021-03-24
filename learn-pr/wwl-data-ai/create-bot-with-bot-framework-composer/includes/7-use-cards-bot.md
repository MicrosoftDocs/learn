The interactions with the weather bot so far have been through text.  Users enter text for their intentions and the bot responds with text. While text is often a suitable way to communicate, you can enhance the experience through the use of other interaction methods such as buttons or cards.  Buttons present options for the user to select from, helping direct the conversation. Cards present a more visually appealing interaction for users as well.

## Add buttons

1. In the navigation pane, under the **getWeather** action, select **BeginDialog**.
2. In the authoring canvas, select the **Prompt for text** action that contains the prompt for the zipcode.
3. In the properties pane, update **Prompt for text** with the following value (Ensure that you remove the **-** dash along with the existing text).

    ```json
    [Activity
        Text = What is your zip code?
        SuggestedActions = help | cancel
    ]
    ```

## Add a card

1. In the **True** path after checking the response from the HTTP weather service, edit the **Send a response** action for the weather report and the existing template with this text.

```json
[ThumbnailCard
    title = Weather for ${dialog.weather.city}
    text = ${DescribeWeather(dialog.weather)}. The temperature is ${dialog.weather.temp}&deg;.
    image = ${dialog.weather.icon}
]
```

This template will use the same variables as before for the weather condition but also adds a title to the card that will be displayed, along with an image for the weather condition.

2. Restart the bot and test it with the Bot Framework Emulator.
3. Enter "weather" and review the user interface for entering your zipcode. Then, when you enter the zipcode, review the card that is displayed in the response.
4. When you have finished testing, close the emulator and stop the bot.

    For more information on using adaptive cards, see the [adaptive cards](https://docs.microsoft.com/adaptive-cards/getting-started/bots) topic.
