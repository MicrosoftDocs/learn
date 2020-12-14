The interactions with the weather bot so far has been through text.  Users enter text for their intentions and the bot responds with text. While text is often a suitable way to communicate, you can enhance the experience through the use of other interaction methods such as buttons or cards.  Buttons present options for the user to select from, helping direct the conversation. Cards present a more visually appealing interaction for users as well.

In the next set of exercises, you will add buttons to the weather bot and then enhance the response through the use of a card depicting weather conditions.

## Add buttons

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. In the navigation pane, under the **getWeather** action, selecy **BeginDialog**.
1. In the **Authoring canvas**, select the **Promot for text** action that contains the prompt for the zipcode.
1. In the **Properties** pane, update **Prompt for text** with the following text value.

    ```json
    [Activity
        Text = What is your zip code?
        SuggestedActions = help | cancel
    ]
    ```

    > [!Tip]
    > Ensure that you remove the dash (-) before the original text in the **Prompt for text** area, otherwise you will get an error.

## Add a card

1. In the **True** path after checking the response from the HTTP weather service, edit the **Send a response** action for the weather report and the existing template with this text.

```json
[ThumbnailCard
    title = Weather for ${dialog.weather.city}
    text = ${DescribeWeather(dialog.weather)}. The temperature is ${dialog.weather.temp}&deg;.
    image = ${dialog.weather.icon}
]
```

This template will use the same variables as before for the weather condition but also adds a title to the card that will be displayed, along with an image for the weather condition. Restart your bot and test in the emulator.  Testing the current condition for New Orleans, Louisiana displayed the card depicted in this image.

    :::image type="content" source="../media/weather-card.png" alt-text="Bot card response showing New Orleans name with icon for mist":::

1. Restart the bot and test it with the Bot Framework Emulator.
1. Enter "weather" and review the user interface for entering your zipcode. Then, when you enter the zipcode, review the card that is displayed in the response.
1. When you have finished testing, close the Bot Framework Emulator.

>[!Tip]
>For more information on using adaptive cards, see the [adaptive cards](https://docs.microsoft.com/adaptive-cards/getting-started/bots) topic.
