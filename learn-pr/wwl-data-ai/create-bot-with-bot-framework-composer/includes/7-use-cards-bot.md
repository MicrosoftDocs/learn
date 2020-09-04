The interactions with the weather bot thus far, has been through text.  Users enter text for their intentions and the bot responds with text. While text is a usable interaction, you can enhance the experience through the use of other interaction methods such as buttons or cards.  Buttons present options for the user to select from, helping direct the conversation. Cards present a more visually appealing interaction for users as well.

In the next set of exercises, you will add buttons to the weather bot and then enhance the response through the use of a card depicting weather conditions.

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. You will update the getWeather dialog to present suggested actions for the user during the zipcode prompt.
1. Select the **getWeather** action in the **Navigation** pane.
1. In the **Authoring canvas**, locate and select the **Bot Asks** action that contains the prompt for the zipcode.
1. In the **Properties** pane, update the **Prompt for text** with the following text value.

    ```dos
    [Activity
        Text = What is your zip code?
        SuggestedActions = help | cancel
    ]
    ```

    > [!Tip]
    > Ensure that you remove the dash (-) before the text in the **Bot Asks** text area, otherwise you will get an error.

1. Restart the bot and test in the emulator to see the results of the suggested actions.

## Add a card

1. With your weather bot still open in the Bot Framework Composer, edit the **Send a response** action for the weather report by replacing the existing template with this text.

```dos
[ThumbnailCard
    title = Weather for ${dialog.weather.city}
    text = The weather is ${dialog.weather.weather} and ${dialog.weather.temp}&deg;
    image = ${dialog.weather.icon}
]
```

This template will use the same variables as before for the weather condition but also adds a title to the card that will be displayed, along with an image for the weather condition. Restart your bot and test in the emulator.  Testing the current condition for New Orleans, Louisiana displayed the card depicted in this image.

:::image type="content" source="../media/weather-card.png" alt-text="Bot card response showing New Orleans name with icon for mist":::

>[!Tip]
>For more information on using adaptive cards, see the [adaptive cards](https://docs.microsoft.com/adaptive-cards/getting-started/bots) topic.