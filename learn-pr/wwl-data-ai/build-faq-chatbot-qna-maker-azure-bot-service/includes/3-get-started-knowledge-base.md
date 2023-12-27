You can easily create a user support bot solution on Microsoft Azure using a combination of two core services:

- **Azure AI Language**: includes a custom question answering feature that enables you to create a knowledge base of question and answer pairs that can be queried using natural language input. 
- **Azure AI Bot Service**: provides a framework for developing, publishing, and managing bots on Azure.

## Creating a custom question answering knowledge base

You can use *Azure AI Language Studio* to create, train, publish, and manage question answering projects.

> [!NOTE]
> You can write code to create and manage projects using the Azure AI Language REST API or SDK. However, in most scenarios it is easier to use the Language Studio.

To create a project, you must first provision a **Language** resource in your Azure subscription. 

### Define questions and answers

After provisioning a Language resource, you can use the Language Studio's custom question answering feature to create a project that consists of question-and-answer pairs. These questions and answers can be:

- Generated from an existing FAQ document or web page.
- Entered and edited manually.

In many cases, a project is created using a combination of all of these techniques; starting with a base dataset of questions and answers from an existing FAQ document and extending the knowledge base with additional manual entries.

Questions in the project can be assigned *alternative phrasing* to help consolidate questions with the same meaning. For example, you might include a question like:

> *What is your head office location?*

You can anticipate different ways this question could be asked by adding an alternative phrasing such as:

> *Where is your head office located?*

### Test the project

After creating a set of question-and-answer pairs, you must save it. This process analyzes your literal questions and answers and applies a built-in natural language processing model to match appropriate answers to questions, even when they are not phrased exactly as specified in your question definitions. Then you can use the built-in test interface in the Language Studio to test your knowledge base by submitting questions and reviewing the answers that are returned. 

## Build a bot with Azure AI Bot Service

After you've created and deployed a knowledge base, you can deliver it to users through a bot. You can create a custom bot by using the Microsoft Bot Framework SDK to write code that controls conversation flow and integrates with your knowledge base. However, an easier approach is to use the automatic bot creation functionality, which enables you to create a bot for your deployed knowledge base and publish it as an Azure AI Bot Service application with just a few clicks.

### Connect channels

When your bot is ready to be delivered to users, you can connect it to multiple *channels*; making it possible for users to interact with it through web chat, email, Microsoft Teams, and other common communication media.

![Screenshot of A chat interface showing user input and responses from a bot.](../media/bot-solution.png)

Users can submit questions to the bot through any of its channels, and receive an appropriate answer from the knowledge base on which the bot is based.
