Recall that your organization wants to automate customer chat support by using a chat bot on your website and social-networking sites. You need to determine which Azure Bot Service tool is the best choice for your needs. You'll evaluate your company's requirements for a chat bot and then compare three bot-creation tools.

## Chat bot requirements


When you're choosing a bot service, a primary consideration should be which bot-creation tool best meets your requirements. Your company's requirements for a chat bot are:

- Bots must be simple to create and manage.
- Bots must be easy to extend later with new code-based features.
- Natural language capabilities must be built into the bot without needing to develop language machine learning models.

The Azure Bot Service has several features that you can use. In this unit, you'll examine the considerations for choosing a bot service and the benefits that the Azure Bot Service provides.

## Evaluating bot-building tools

You have three primary bot creation methods available, Power Virtual Agents, QnA Maker, and Bot Framework Composer. Each method has qualities that you'll evaluate against your requirements to choose the best fit for your organization.

### Power Virtual Agents

Use Power Virtual Agents to create powerful chat bots. These bots can answer questions posed by your customers, other employees, or visitors to your website or service. Because of the guided, no-code graphical interface, you can use the Power Virtual Agents web app to create chat bots without needing developer expertise.

Topics inform the bot conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to enter. These phrases are matched to a specific topic using built-in natural language understanding. <!-- ID/SME: I marked up a very similar section in Mod 1. Please use that language here. Thanks! -->For example, a user might enter "Open hours" into your bot—the AI will be able to match that to the Store hours topic and begin a conversation that asks which store the customer is interested in, and then display the hours the store is open.

<!-- ID/SME: Please rework this sentence, breaking it into two shorter sentences and making it more clear. Currently, as written, it's too long and doesn't make sense. --> Extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using the Bot Framework SDK.

### QnA Maker

*QnA Maker* is an Azure-based Natural Language Processing service that allows you to create a natural conversational layer over your data. It's used to find the most appropriate answer for any input from your custom knowledge base of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents in their current form to your knowledge base. These documents might include an FAQ, product manual, spreadsheet, or <!-- ID/SME: Always one word, "webpage" and not two. Please fix globally. -->.web page. The documents are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs.

>[!NOTE]
> The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, you can publish the knowledge base to a working Azure Web App bot without writing any code. Test your bot in the Azure portal or download it and continue development.

### Bot Framework Composer and Azure Bot Service

*Bot Framework Composer* is an open-source, visual IDE for developers to author, test, provision, and manage conversational experiences. It's built on the Bot Framework SDK. It provides a robust visual authoring canvas with integrated dialog, language-understanding models, knowledge bases and language generation functionality. Implement all these features from a single design canvas. Resulting experiences can then be tested within Bot Framework Composer and provisioned into Azure along with any dependent resources.

> [!NOTE]
> Bot Framework Composer is available as a desktop application for Windows, macOS and Linux. It's also available as a web-based component that you can customize and extend.

Bot Framework Composer offers a visual design experience. This experience gives you greater design efficiency. It makes it easier for you to model more sophisticated conversational experiences where context switching, interruption, and more natural and dynamic conversation flows are important.

>[!TIP]
> More complex activities such as integrating with dependencies such as REST API can be accomplished by directly modifying the code of the bot using Visual Studio Code or another IDE.

## Choosing a bot-building tool

After evaluating the three options for bot creation, you decide that the Bot Framework Composer is the best fit for your company because:

- The visual designer makes it intuitive to create and manage bots.
- Its built-in capabilities support language understanding integration.
- If more advanced functionality is required in the future, you can extend the bots you create by using the Bot Framework SDK.
