In today's connected world, people use a variety of technologies to communicate. For example:

- Voice calls
- Messaging services
- Online chat applications
- Email
- Social media platforms
- Collaborative workplace tools

We've become so used to ubiquitous connectivity, that we expect the organizations we deal with to be easily contactable and immediately responsive through the channels we already use. Additionally, we expect these organizations to engage with us individually, and be able to answer complex questions at a personal level.

## Conversational AI

While many organizations publish support information and answers to frequently asked questions (FAQs) that can be accessed through a web browser or dedicated app, the complexity of the systems and services they offer means that answers to specific questions are hard to find. Often, these organizations find their support personnel being overloaded with requests for help through phone calls, email, text messages, social media, and other channels.

Increasingly, organizations are turning to artificial intelligence (AI) solutions that make use of AI agents, commonly known as *bots* to provide a first-line of automated support through the full range of channels that we use to communicate. Bots are designed to interact with users in a conversational manner, as shown in this example of a chat interface:

![A chat interface showing user input and responses from a bot](../media/bot.png)

> [!NOTE]
> The example shown here is a chat interface, such as you might find on a web site; but bots can be designed to work across multiple channels, including email, social media platforms, and even voice calls. Regardless of the channel used, bots typically manage conversation flows using a combination of natural language and constrained option responses that guide the user to a resolution.

Conversations typically take the form of messages exchanged in turns; and one of the most common kinds of conversational exchange is a question followed by an answer. This pattern forms the basis for many user support bots, and can often be based on existing FAQ documentation. To implement this kind of solution, you need:

- A *knowledge base* of question and answer pairs - usually with some built-in natural language processing model to enable questions that can be phrased in multiple ways to be understood with the same semantic meaning.
- A *bot service* that provides an interface to the knowledge base through one or more channels.
