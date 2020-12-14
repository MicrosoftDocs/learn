The weather bot you have created works well for simple, predictable input. However, the responses from the bot are scripted and lack the expressiveness of a human-like response.

The Bot Framework Composer integrates with the Bot Framework Language Generation (LG) library. The library is a set of powerful templating and message formatting tools that let you include variation, conditional messages, and dynamic content. LG gives you greater control of how your bot responds to the user. The following exercise will guide you through integration of language generation in your bot.

## Add multiple greetings

Currently, your weather bot has only one phrase to greet users with. To add some variety in the greetings, you can add multiple phrases with different wording in each, and the bot will randomly choose one of the phrases when a new conversation is started.  To implement this, follow the steps outlined next.

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. Select the **WeatherBot** item in the navigation pane.
1. Select the **WelcomeUsers** activity in the navigation pane.
1. Select the **Send a response** action in the **Authoring canvas**.
1. In the **Properties** pane, modify the contents of the **Language Generation** text area to include the following phrases:

- **- Hello. Welcome to the Get Weather Bot. Enter "weather" to start.**
- **- Hi! I am a weather bot and can retrieve weather conditions for you. Try saying "weather".**
- **- Need to know the weather conditions? Say "weather" and I can help.**

## Manage templates

All of your bot responses can be found in the **Bot Responses** panel by selecting **Bot Responses** from the menu.  You can expand the menu to see the names in the event the icons are not clear enough.

:::image type="content" source="../media/bot-responses.png" alt-text="bot responses menu selected":::

The default view is shown in the previous image.  You can also edit the code for the responses.

1. Ensure that your weather bot is open in the Bot Framework Composer.
1. Select the **Bot Responses** menu.
1. Select the **getWeather** entry in the list of actions to view the responses for this dialog.
1. Select **Show code** to enable edit mode.  Your Composer interface should resemble the following image.

   [![Bot responses panel in edit mode with getWeather selected](../media/edit-bot-responses.png)](../media/edit-bot-responses.png#lightbox)

1. To create a template for weather condition responses, copy and paste the following text at the end of the current text in the edit pane.

```dos
# DescribeWeather(weather)
- IF: ${weather.weather=="Clouds"}
    - It is cloudy
- ELSEIF: ${weather.weather=="Thunderstorm"}
    - There's a thunderstorm
- ELSEIF: ${weather.weather=="Drizzle"}
    - It is drizzling
- ELSEIF: ${weather.weather=="Rain"}
    - It is raining
- ELSEIF: ${weather.weather=="Snow"}
    - There's snow
- ELSEIF: ${weather.weather=="Clear"}
    - The sky is clear
- ELSEIF: ${weather.weather=="Mist"}
    - There's a mist in the air
- ELSEIF: ${weather.weather=="Smoke"}
    - There's smoke in the air
- ELSEIF: ${weather.weather=="Haze"}
    - There's a haze
- ELSEIF: ${weather.weather=="Dust"}
    - There's a dust in the air
- ELSEIF: ${weather.weather=="Fog"}
    - It's foggy
- ELSEIF: ${weather.weather=="Ash"}
    - There's ash in the air
- ELSEIF: ${weather.weather=="Squall"}
    - There's a squall
- ELSEIF: ${weather.weather=="Tornado"}
    - There's a tornado happening
- ELSE:
    - ${weather.weather}
```

The template contains an IF/ELSEIF/ELSE structure and is known as a Language Generation Template. When the weather data is returned from the service, the Language Generation system will evaluate the weather.weather variable, match it to one of the clauses in the IF structure, and generate a more user-friendly response that will be displayed to the user. For the template to function, you will need to modify the design of the **getWeather** dialog.

## Modify getWeather dialog

1. Return to the **Design** page.
1. In the navigation pane, select **BeginDialog** under the **getWeather** dialog.
1. In the **true/false** flow that you created previously, select the **Send a response** action in the **true** path.  It will start with the text. *The weather in ${dialog.weather.city} is...*.
1. Replace the current text in the **Language Generation** text area with **- ${DescribeWeather(dialog.weather)} in ${dialog.weather.city}. The temperature is ${dialog.weather.temp}\&deg;.**
1. You will see the use of the **DescribeWeather** template that you created with the IF/ELSE structure above. This syntax lets you nest the DescribeWeather template inside another template. LG templates can be combined in this way to create more complex templates.
1. Test your changes by restarting the bot and testing it with the emulator. The welcome message should be one of the phrases you specified, and the response with the weather conditions should be based on the language generation template you defined.
1. When you have finished testing, close the Bot Framework Emulator.

>[!Tip]
>For more information on language generation templates, see the [language generation concept web page](https://docs.microsoft.com/composer/concept-language-generation).