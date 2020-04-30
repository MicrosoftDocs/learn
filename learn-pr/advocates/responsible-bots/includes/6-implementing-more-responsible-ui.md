# Implementing More Responsible UI Principles

By now, we have added most of the functionality to our bot, but some small pieces are missing. In this unit, we will make small improvements to the bot to implement more  **Responsible Conversational UI** principles.

# Providing Help

When a user starts using a bot for the first time, he or she does not always know what to say. Even though we all know how speak a human language, bots natural language understanding capabilities are not always up to the standards. That's why it is very helpful to provide user with some examples of possible commands that bot will definitely understand.

Also, in many cases all functionality of a bot is not immediately clear, and giving a brief overview with sample commands is extremely helpful to the user.

>[!TIP]
>Make sure that a user never feels lost, and he always knows what to do as the last resort. This can be achieved by implementing **help** command, or giving **menu** of possible options.

Let's add **help** command to our bot! Because we are using QnA Maker already, all we need to do is to add corresponding text to the knowledge base through the QnA Maker UI.

1. Visit [QnA Maker Portal][QnAPortal] and sign in with your Microsoft Account
2. Open the knowledge base we have created in the previous unit.
3. Click on **+ Add QnA Pair**
![QnA KB Editing](../media/QnAAddPair.png)
4. Type in different phrases that can bring up the help message, for example:
   - *What can I say?*
   - *Help*
   - *I do not know what to do*
5. As a response, provide some explanatory text about the bot functionality, with the exact examples of phrases.
```markdown
This bot can help you with **capitals** of countries. For example, you can say:
 * What is the capital of India?
 * In which country is Paris located?
 * What is the population of Beijing?

You can also look up some **definitions**:
 * What is a capital?
 * What is the definition of country?
```
>[!TIP]
You can use markdown syntax to make your message more readable. You can even include URLs to some images (but do not overcomplicate)!
6. After you have added the help message, click on **Save and Train**
7. When training is done - click **PUBLISH** to put the model online.

At this point you can start your bot code in Visual Studio and see how it works in the Emulator. 

>[!TIP]
>You can design complex multi-turn help system with QnA Maker using [follow-up prompts and multi-turn conversations][QnAFollowUp].

# Meaningful Welcome Message

Original Echo Bot code contained the functionality to send  user a welcome message. Function `OnMembersAddedAsync` in `Bots\EchoBot.cs` is responsible for monitoring new users in a chat, and when new user enters - it sends him/her a welcome message.

This welcome message ideally should serve three important purposes:
 * Inform a user that he is **talking to a bot**.
 * Outline the **bot's goal**, possibly showing some limitations and typical use cases
 * Make it clear to the user what he can do, for example, mention **help** command that he can user to find more details, or **menu** command to enter menu system with options.

 Providing meaningful welcome message is a simple thing to do, but it can go a long way. The difficult thing here is to fit all those three important points into one concise message that will look reasonably nice in a small messenger screen. Here is a welcome message I have created for our bot:

```csharp
readonly string welcomeText = 
    "Hello!\n"+
    "I am a teaching assistant bot that will help you learn **Geography**. I will not be able to teach you, but I can definitely help! Feel free to ask me about different countries and their capitals. If not sure, start with **what can I say?**";
        
readonly string unknownText = 
    "I am not sure I understand you fully.\n"+
    "If you are not sure what to say, ask **what can I say?**";
```

I have also changed the message that the bot displays if it does not understand the command, and moved those messages into string constants in the `EchoBot` class, so they are easy to modify. 

Here is how the initial conversation with our bot might look like:

![Welcome Message and Help](../media/HelpConversation.png)

# More Visual Interaction

Interacting with a bot using plain text solves most of the problems, but sometimes it is useful to be able to communicate through more visual means. Bot Framework supports that by using the following mechanisms:

 * A user can send an **attachment** to the bot, which can be a picture, a document, or essentially any file. Programmatically we receive the URL of that document, and can do whatever we want with it. Learn more about attachments [in the documentation][BotAttachments].
 * A bot can return back an **adaptive card**, which is a way to represent richer content than just text. A card can contain an image, a button, or a carousel of images. Learn more about cards [in this documentation][AdaptiveCards].

With attachments and adaptive cards, you can have many different ways of interacting with a bot:

 * A bot can take some pictures as an input, and use cognitive services to extract some information from them. For example, a user can send pictures of printed documents, and the bot will be able to get the text using OCR.
 * You can also ask the user to send things like his/her location to retrieve points of interest nearby. However, you need to make sure that messengers you are planning to use support locations.
 * Adaptive cards can be used to organize menu-based interaction with the bot, instead of natural text. Menus are more clear to use, but it takes more time to navigate to the exact position in the hierarchy. However, you can always use some mixture of menu-driven interaction and natural text phrases.

To add some more visual interactions to our bot, let's display country flags as part of the messages that mention countries. To do that, we first need to find some data on country flags - for example, we can use [this page on Wikipedia][WikiFlags]. We have collected the list of URLs for all country flags, and put them into [countryflags.csv][CountryFlagsFile] file. We do not need to download actual pictures, because during the bot dialog we just need to send back the URL, and the original flag from Wikipedia will be displayed.

To incorporate those changes to our code, we will put `countryflags.csv` into our bot project, and add `GetFlag` function into our `CountryData` class. We will store the URLs corresponding to country names into a `Dictionary`:
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
In the bot itself, we will change slightly the logic for displaying a country corresponding to a given capital inside `ProcessLuisResult` function:
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

To create an attachment, we use `MessageFactory` object. There are many different functions that correspond to different attachment types. We use simplest one that provides text with some corresponding `ContentUrl`.

>[!TIP]
>Some messages support markdown syntax, including image embedding. In this case, we might just use normal text message with image embedding command, instead of more complex adaptive card mechanism. However, you always need to check how those markdown messages will be rendered by all messenger platforms that you are planning to use.

Here is how our conversation with attachment look like in the emulator:
![Flag ConversationYerevan](../media/FlagConversation.png)

>[!NOTE]
>In this example, we can see one more potential problem: the spelling of non-English names can differ, and our system does not support different possible transliteration for Yerevan, a capital of Armenia. When developing responsible bots we need to be careful and support different possible transliterations, or offer suggestions in case of slight variations in city names.

>[!NOTE]
>The code for the application at this point is available [in this github repository][GitFlag]




[QnAPortal]: https://qnamaker.ai
[QnAFollowUp]: https://docs.microsoft.com/en-us/azure/cognitive-services/qnamaker/how-to/multiturn-conversation
[BotAttachments]: https://docs.microsoft.com/ru-ru/azure/bot-service/bot-builder-howto-add-media-attachments?view=azure-bot-service-4.0&tabs=csharp
[AdaptiveCards]: https://docs.microsoft.com/adaptive-cards/getting-started/bots
[WikiFlags]: https://en.wikipedia.org/wiki/National_flag
[CountryFlagsFile]: http://github.com/#TODO
[GitFlag]: https://github.com/MicrosoftDocs/learn-responsible-bots/tree/t4.0-flags