As you learned in the previous unit, Microsoft has identified [10 guidelines for developers of conversational AI][Guidelines10]. Responsible bots implement these guidelines.

**Developers are accountable for the bots they deploy**. This major principle is one of the 10 guidelines. It's also the foundation for responsible bot creation. When developers are aware of responsible conversational AI principles, they can create the best experience possible for their users.

There are lots of ways you can be accountable for your bot. The following sections describe some steps you can take to make your bot as responsible and useful as possible.

## Define your bot's purpose

It's important to communicate your bot's goal to your customers. At the beginning of the conversation, tell users which problems your bot can solve. Consider including that information in any of these areas:

- Your bot's welcome message
- Its menu
- Its help feature

When you tell users what tasks your bot can handle, they know what to expect. Also be clear about your bot's role. Introduce the bot as a technology assistant, not an expert. Then users will understand that your bot's abilities are focused rather than broad.

## Be transparent about bot technology

Tell users they're talking to a bot. From the start of the conversation, make it clear that they're not talking to a human being. Use a picture of a robot instead of a human face. The picture reminds users "who" they're talking to. Users are more likely to trust the bot if you're upfront about its limitations.

Provide access to a human operator. Program your bot to recognize when the situation moves beyond its capabilities. Whenever the bot's response requires judgment or creative thinking, have your bot hand off to a human operator. A common scenario is to use a bot dialog to collect initial information from the user. The information and conversation is then handed off to an operator to make expert decisions and provide problem-solving. This structure delegates tedious tasks to the bot and leaves the most creative part to a human operator.

## Respect privacy

Help users build trust in your bot and your company by handling their personal information in a safe way. Follow standard practices for securely requesting and using sensitive information. Collect only data that's relevant to solving the problem.

## Add intelligence

Add intelligence to your bot to make it more useful. Its responses then become more appropriate and responsible.

Azure Cognitive Services provides services that support AI functionality. These services offer a set of pre-trained, neural network models for the cloud. Their REST APIs and client library SDKs can help you build cognitive intelligence into apps.

Your bot can use the following services, which are part of Cognitive Services:

- The Language Understanding Intelligent Service (LUIS) enables your bot to understand simple natural language. With this service, your bot can figure out the overall meaning of phrases. It can also extract known entities from phrases, such as city names or dates.
- QnA Maker can help your bot answer general questions about a specific subject. This service can also provide chit-chat functionality, which can boost your bot's general conversational skills. With this capability, your bot can recognize some traditional phrases for greetings and endings of a conversation.

## Support diversity and accessibility

Make your bot responsible in the areas of diversity and accessibility by meeting these goals:

### Avoid bias

Include *diversity* in all stages of bot development to help avoid bias. When you include different genders and nationalities on your development team, you achieve stronger support for diversity.

### Support language diversity

Add language diversity to your bot to make its communication more welcoming, robust, and reliable. If your bot uses Cognitive Services to understand simple natural language, consider these options:

- Store multiple sets of output messages, so the bot can switch between different conversation styles.
- Examine the emotional sentiment of the user's input to detect the appropriate style to use. Azure Text Analytics can detect user sentiment.
- Design your bot to support multiple languages. This implementation is helpful for users, but it requires significant development effort. Switching between output languages can be as simple as selecting different sets of output messages, but support for language understanding requires separate LUIS models.
- Support multiple languages by using **automatic translation** with Cognitive Services Translator Text API. This API offers automatic language detection of user input messages. The API also translates output messages to the user's language.

To incorporate translation into a bot, use the concept of Bot Framework Middleware. You can add this component to pre-process and post-process all messages to and from the user. The Middleware component can:

- Detect the language of the incoming message.
- Translate the incoming message into English.
- Complete all standard processing steps, including LUIS and QnA Maker operations that are trained on English phrases.
- Translate the result message into the user's language.

In more complex scenarios, you can include language-switching logic. This logic can confirm the user's language and then use that language during the session.

### Be accessible

Build *accessibility practices* into your bot to broaden your potential audience. A responsible conversational bot accepts user input as text or speech - from a keypad, mouse, or touch-screen, and also from a microphone. When you include *speech support*, you make the bot usable for users with visual impairment. Your bot also becomes more attractive to users who don't want to type.

You can add a speech interface to your bot with the Azure Speech service. The Bot Framework supports embedding speech data into messages in the form of **Simple Speech Markup Language** (SSML). The bot also needs speech support from the conversation client. Web chat control integrates with the Microsoft Speech SDK to support both text to speech and speech to text.

> [!NOTE]
> To support more communication channels, you can receive speech as an attachment. You can then use the Speech SDK to convert the attachment to text on the server side.

### Be sensitive to cultural differences

Consider *cultural norms* when designing your bot. Some cultures use an informal tone, while others use more formal communication. Try to design your bot so it can adjust the conversational style to meet the culture.

## Make the geography bot responsible

Consider our earlier example of building a geography bot. Here are a few ideas for making the bot responsible:

- Show a welcome message that:

  - Informs the user that they're talking to a bot.
  - Outlines the bot's purpose.
  - Explains what the user can do with the bot.

  For example, your bot might use this welcome message:

  ```output
  Hello! I am a teaching assistant bot that will help you learn Geography. I will not be able to teach you, but I can definitely help! Feel free to ask me about different countries/regions and their capitals/major cities. If not sure, start with "What can I say?"
  ```

- Be sensitive to fairness and data complexity issues. For instance, not all countries/regions recognize some capital/major cities. Other capital/major cities change frequently. Here are some options for solving these problems:

  - Cite your data source.
  - Enable the bot to return different results based on the user's language.
  - Update the bot regularly.
  - Display a "last updated" date to make it clear how recent your data is.

- Support language diversity by storing multiple sets of output messages. Then the bot can switch between different conversation styles. You can use Azure Text Analytics to determine the appropriate style to use.

- Support multiple languages by using Cognitive Services Translator Text API for automatic translation.

- Welcome diversity by adding a speech interface to your bot with the Azure Speech service.

In this unit, we reviewed several ways to improve a bot. Providing a robust conversational UX is one example. We also learned ideas for making a geography bot useful, capable, and reliable. Azure Bot Framework is just a tool to make bot development easy. Making a bot responsible is still up to the developer!

<!-- Links -->

[Guidelines10]: https://www.microsoft.com/research/publication/responsible-bots/?azure-portal=true
