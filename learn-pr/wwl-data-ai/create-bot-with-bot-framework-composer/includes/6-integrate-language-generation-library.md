The Bot Framework Composer integrates with the Bot Framework Language Generation (LG) library. The library is a set of powerful templating and message formatting tools that let you include variation, conditional messages, and dynamic content. LG gives you greater control of how your bot responds to the user.

## Add multiple greetings

Currently, your weather bot has only one phrase to greet users with. To add some variety in the greetings, you can add multiple phrases with different wording in each, and the bot will randomly choose one of the phrases when a new conversation is started.

1. In the navigation pane, select the **WelcomeUsers** trigger under the **WeatherBot** dialog.
2. Select the **Send a response** action that currently sends the message *Hi! I'm WeatherBot.*.
3. In the properties pane, modify the contents of the **Language Generation** text area to include the following phrases:

    ```code
    - Hello. I'm WeatherBot. Enter "weather" to start.
    - Hi! I am WeatherBot and can retrieve weather conditions for you. Try saying "weather".
    - Need to know the weather conditions? Say "weather" and I can help.
    ```
## Create a template

All of your bot responses are based on templates, which you can create and manage.

1. Expand the **&#9776;** menu pane on the left, and select the **Bot Responses** page.
2. Select the **getWeather** entry to view the response templates that have been defined for this dialog.
3. Select **Show code** to enable edit mode. Each template is shown as a template name that begins with **#**, containing one or more responses, each beginning with a **-**.

4. To create a template for weather condition responses, add the following code at the end of the current list of templates.

```code
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

## Use the template in a response

1. Return to the **Design** page.
2. In the navigation pane, select **BeginDialog** under the **getWeather** dialog.
3. In the **true/false** flow that you created previously, select the **Send a response** action in the **true** path.  It will start with the text. *The weather in ${dialog.weather.city} is...*.
4. Replace the current text in the **Language Generation** text area with **- ${DescribeWeather(dialog.weather)} in ${dialog.weather.city}. The temperature is ${dialog.weather.temp}\&deg;.**

    This response uses the **DescribeWeather** template that you created, nested inside another template. LG templates can be combined in this way to create more complex templates. For more information on language generation templates, see the [language generation concept web page](https://docs.microsoft.com/composer/concept-language-generation).

5. Test your changes by restarting the bot and testing it with the emulator. The welcome message should be one of the phrases you specified, and the response with the weather conditions should be based on the language generation template you defined.
6. When you have finished testing, close the emulator and stop the bot.
