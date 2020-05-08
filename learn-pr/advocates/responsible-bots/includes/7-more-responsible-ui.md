We've added a good amount of functionality to our bot, but a few small pieces are missing. In this unit, we'll make some improvements to our bot to implement more **responsible conversational UI** principles.

## Help your users

When a user starts to work with a bot for the first time, they don't always know what to say. The user audience for a bot often speaks several languages across different cultures. Although a bot can be designed with natural language understanding, the capabilities can still be limited. In many cases, all of the functionality available in a bot isn't immediately clear. Users find it helpful when a bot provides a brief overview and sample commands that it definitely understands.

> [!TIP]
> Design your bot so users can't _get lost_ in the functionality. Always provide a "last resort" option, so users can keep going. A good approach is to have a **help** feature with a **menu** of tasks and commands that the bot understands.

Let's add a **help** feature to our bot! Because we're already using QnA Maker, all we need to do is add corresponding text to the knowledge base through the QnA Maker UI.

1. Go to the [QnA Maker portal][QnAPortal]. Sign in with your Microsoft account or work or school account.

1. Open the knowledge base we created in the previous unit.

1. Select **+ Add QnA Pair**.

    ![The QnA Maker knowledge base edit dialog.](../media/qna-maker-add-pair.png)

1. Enter some phrases that will access the **help** feature in the bot.

    Here are some examples:
    - What can I say?
    - Help
    - I do not know what to do

1. Add the message the bot will use to respond to the help request.

    Briefly describe the bot functionality and give examples of phrases that the bot understands.

    ```markdown
    This bot can help you with **capitals** of countries.
    For example, you can say:

    * What is the capital of India?
    * In which country is Paris located?
    * What is the population of Beijing?
   
    You can also look up some **definitions**:

    * What is a capital?
    * What is the definition of country?
    ```

    > [!TIP]
    > Use Markdown syntax to make your message more readable. You can include URLs for some images (but don't overcomplicate)!

1. After you add the help message, select **Save and Train**.

1. After the model training is done, select **PUBLISH** to push the model online.

Now you can start your bot code in Visual Studio, and see how it works in the Emulator.

> [!TIP]
> You can design a complex multi-turn help system with QnA Maker by using [follow-up prompts and multi-turn conversations][QnAFollowUp].

## Show a welcome message

The **Echo Bot** template includes functionality to send the user a welcome message. The `OnMembersAddedAsync` function in the `Bots\EchoBot.cs` file monitors new users in a chat session. When a new user enters the chat session, the bot sends a welcome message to the user.

A welcome message provides three important pieces of information:

- Informs the user that they're **talking to a bot**.
- Outlines the **bot's primary purpose**. As an option, shows limitations and typical use cases.
- Explains **what the user can do** with the bot. Mentions the **help** feature. Shows the **menu** of options and examples of understood phrases.

It's easy to add a meaningful welcome message to a bot. A good welcome helps to build trust with your users. The difficult task is to share all pieces of information in a single message that fits on a small screen.
 
Here's a sample welcome message for our bot:

```csharp
readonly string welcomeText = 
    "Hello!\n"+
    "I am a teaching assistant bot that will help you learn **Geography**. I will not be able to teach you, but I can definitely help! Feel free to ask me about different countries and their capitals. If not sure, start with **What can I say?**";
        
readonly string unknownText = 
    "I am not sure I understand you fully.\n"+
    "If you are not sure what to say, ask **What can I say?**";
```

We need to respond to a user, when the bot doesn't understand the user's input. The sample phrases shown in the code snippet are saved as string constants in the `EchoBot` class. You can modify these constants as needed.

Here's an example of an initial conversation between our bot and a user:

![A sample welcome message and help feature for our bot.](../media/help-conversation.png)

## Add visual interactions

Users can accomplish most tasks by using plain text to interact with a bot. Sometimes it's helpful to communicate with the bot through more visual means. The Bot Framework supports visual interaction in the following ways:

- A user can send an **attachment** to the bot. An attachment can be a picture, a document, or most any file. When the bot receives the URL of the file, the bot processes the content according to the bot's functionality. To learn more about attachments, read about the [Bot Service][BotAttachments].
- A bot can return an **adaptive card** to the user. An adaptive card is a way to represent richer content than just text. A card can contain an image, a button, or a carousel of images. To learn how to use this approach, see how to get started with [adaptive cards][AdaptiveCards].

Attachments and adaptive cards offer several methods for interacting with a bot:

- A bot can receive pictures as input, and use Cognitive Services to extract data from the pictures. A user can send pictures of printed documents. The bot can use optical character recognition (OCR) to parse the text from the pictures.
- A bot can ask the user to send information, and then act on the received data. When a user sends their location, the bot can retrieve nearby points of interest. To use this method, any messenger with which the bot connects must support location data.
- Adaptive cards can be used to organize menu-based interaction with the bot, instead of natural text. Visual menus can be more clear for the user than text -only menus. A visual menu can take more time to navigate to reach the required option. A mixture of menu-driven interaction and natural text phrases can be a good approach.

To add visual interaction to our bot, let's display country flags as part of the messages that mention countries.

We'll use [data about country flags][WikiFlags] that's available on the internet at Wikipedia. The list of URLs for the country flags is stored in the [countryflags.csv][CountryFlagsFile] file. We don't need to download the actual pictures. The bot will return the URL to the user, and the flag picture from the internet site will be displayed.

Here's how we update our code to support this interaction:

- Add the `countryflags.csv` file to our bot project.
- Add the `GetFlag` function to our `CountryData` class.
- Store the URLs corresponding to each country name in a `Dictionary` structure.

```csharp
protected Dictionary<string,string> Flags { get; set; }

public CountryData(string fn,string cf)
{
    ...
    Flags = new Dictionary<string, string>();
    foreach (var x in (File.ReadAllLines(cf).Skip(1)))
    {
        var t = x.Split(',');
        Flags.Add(t[1].ToLower(), t[0]);
    }
}
```

Next, we need to slightly change the logic for our bot.
We need to display a country according to a given capital that's stored inside the `ProcessLuisResult` function:

```csharp
    case "get_country":
        var cou = CData.GetCountry(loc);
        var fl = CData.GetFlag(cou);
        if (fl != null)
        {
            await turnContext.SendActivityAsync(
                MessageFactory.ContentUrl(fl, "image/png", 
                text: $"{loc} is the capital of {cou}"));
        }
        else
        {
            await turnContext.SendActivityAsync(cou == null
                    ? $"I do not know the city named {loc}"
                    : $"{loc} is the capital of {cou}");
        }
        break;
```

To create an attachment, we use the `MessageFactory` object. There are different functions that correspond to different attachment types. We'll use the simplest approach that provides text with the corresponding `ContentUrl` data.

> [!TIP]
> Some messages support Markdown syntax, including image embedding. For our bot, we'll use normal text messages with an image embedding command. We won't support the more complex adaptive card mechanism. Be sure to test how Markdown messages are rendered by all messenger platforms that you plan to support.

Here's how our conversation with support for attachments looks in the Visual Studio Emulator:

![An example conversation with support for attachments in VS Emulator.](../media/flag-conversation.png)

> [!NOTE]
> In this example, we can see another potential problem. The spelling of non-English names can differ. Our bot doesn't support different transliterations for *Yerevan*, the capital of *Armenia*. To develop a responsible bot, we need to support different possible transliterations. An even better approach is to offer suggestions that provide slight variations in city names.

The code for this stage of our bot development is available in the [Microsoft Learn > Responsible bots > Flags][GitFlag] GitHub repository.

## Support language diversity

In the first unit, we learned that an ideal responsible bot supports diversity. There are many different ways to add language diversity.

- Store multiple sets of output messages, so the bot can switch between different conversation styles.
- Examine the emotional sentiment of the user's utterances to detect the appropriate style to use. Azure [Text Analytics][TextAnalytics] can detect user sentiment.
- Offer chit-chat functionality with [Project Personality Chat][PersonalityChat].
- Design your bot to support multiple languages. This implementation is helpful for users, but it requires significant development effort. Switching between output languages can be as simple as selecting different sets of output messages, but support for language understanding requires separate LUIS models.
- Support multiple languages by using **automatic translation** with the Azure Cognitive Services [Translator Text API][TranslatorAPI]. The API offers automatic [language detection][LangDetection] of user input messages. The API [translates][Translation] output messages to the user's language.

To incorporate translation into our bot, we can use the concept of [Bot Framework Middleware][Middleware]. We can add this component to pre-process and post-process all messages to and from the user. The Middleware component can:

- Detect the language of the incoming message.
- Translate the incoming message into English.
- Complete all standard processing steps, including LUIS and QnA Maker operations that are trained on English phrases.
- Translate the result message into the user's language.

In more complex scenarios, we can include language-switching logic. This logic can confirm the user's language, and use the language for the duration of the session.

The code to use the translation middleware is available in the [Microsoft > BotBuilder-Samples > Multilingual bot][BotTranslateSample] GitHub repository.

## Add dialog interactions

So far, all interactions with our bot have been based on the request-response pattern. Our bot can't track the context of a conversation. There are scenarios where interaction with the user can involve consecutive steps.

- Fill in multiple fields on a form.
- Confirm the user's actions.
- Choose a series of items from the menu.

Our bot includes a game built with phrases that test a student's knowledge of capital cities for countries. We can upgrade our game, so the bot switches between modes. In the new mode, the game randomly selects a country and asks the user to enter the capital city (or the other way around). To stop playing, the user enters "end" and the game displays their score.

We can add this new mode by using the Bot Framework concept of [dialogs][BotDialogs]. A dialog defines a separate branch of conversation. In our bot, the new branch of conversation is a "capital game" dialog. When the user starts a dialog, the conversation is handled by different programming logic. The operation logic continues until the dialog ends, or the user starts a different dialog. The dialog concept helps to decompose complex conversation logic into simple modular parts, and combine these parts together into a complex conversation flow.

> [!NOTE]
> We're not going to implement dialogs in this course. To learn more about dialogs, see the [Microsoft > BotBuilder-Samples > Custom dialogs][BotDialogsSample] GitHub repository. You can also read about [Azure Bot Service and the dialog concept][BotDialogs].

## Request feedback

Another important feature that we can implement with dialogs is collecting feedback. One of the principles of responsible conversational UI is to give users the opportunity to provide feedback. How can a bot determine when the user is ready to end the session?

The bot detects "end-of-conversation" phrases by using LUIS. A bot responds to the user and starts the "good-bye" dialog. The dialog collects multi-step feedback from the user and stores it in a database for further processing.

> [!IMPORTANT]
> A **good** responsible bot always gives the user the opportunity to provide feedback!

## Support speech

Bots should welcome diversity. A responsible conversational bot accepts user input as text or speech--from a keypad, mouse, or touch-screen, and also from a microphone.

Add a speech interface to your bot with the Azure [Speech Service][SpeechSDK]. The Bot Framework supports embedding speech data into messages in the form of **Simple Speech Markup Language** (SSML). Update your bot code to [add speech to messages][AddSpeech]. The bot also needs speech support from the conversation client. Web chat control integrates with the Microsoft Speech SDK to support both text-to-speech and speech-to-text.

> [!NOTE]
> To support more communication channels, you can receive speech as an attachment, and convert the attachment to text on the server side by using the [Speech SDK][SpeechSDK].

In this unit, we reviewed several ways to improve our bot and provide a robust conversational UX for our users. We learned that the Bot Framework provides all the necessary means to build responsible bot UI.

<!-- Links -->
[QnAPortal]: https://qnamaker.ai
[QnAFollowUp]: https://docs.microsoft.com/azure/cognitive-services/qnamaker/how-to/multiturn-conversation
[BotAttachments]: https://docs.microsoft.com/azure/bot-service/bot-builder-howto-add-media-attachments?view=azure-bot-service-4.0&tabs=csharp
[AdaptiveCards]: https://docs.microsoft.com/adaptive-cards/getting-started/bots
[WikiFlags]: https://en.wikipedia.org/wiki/National_flag
[CountryFlagsFile]: https://github.com/#TODO
[GitFlag]: https://github.com/MicrosoftDocs/mslearn-responsible-bots/tree/t4.0-flags
[TextAnalytics]: https://docs.microsoft.com/azure/cognitive-services/text-analytics/
[PersonalityChat]: https://aischool.microsoft.com/conversational/learning-paths/advanced-conversational-ai/ttmb-implementing-project-personality-chat
[TranslatorAPI]: https://azure.microsoft.com/services/cognitive-services/translator-text-api/
[LangDetection]: https://docs.microsoft.com/azure/cognitive-services/translator/quickstart-detect?pivots=programming-language-csharp
[Translation]: https://docs.microsoft.com/azure/cognitive-services/translator/quickstart-translate?pivots=programming-language-csharp
[MiddleWare]: https://docs.microsoft.com/azure/bot-service/bot-builder-concept-middleware?view=azure-bot-service-4.0
[BotTranslateSample]: https://github.com/microsoft/BotBuilder-Samples/tree/master/samples/csharp_dotnetcore/17.multilingual-bot
[BotDialogs]: https://docs.microsoft.com/azure/bot-service/bot-builder-concept-dialog?view=azure-bot-service-4.0
[BotDialogsSample]: https://github.com/microsoft/BotBuilder-Samples/tree/master/samples/csharp_dotnetcore/19.custom-dialogs
[SpeechSDK]: https://docs.microsoft.com/azure/cognitive-services/speech-service/
[AddSpeech]: https://docs.microsoft.com/azure/bot-service/rest-api/bot-framework-rest-connector-text-to-speech?view=azure-bot-service-4.0
