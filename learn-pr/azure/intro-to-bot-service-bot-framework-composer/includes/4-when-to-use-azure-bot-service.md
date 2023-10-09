Recall that your organization wants to automate customer chat support by using a chat bot on your website and social-networking sites. You need to determine which Azure Bot Service tool is the best choice for your needs. In this unit, you'll evaluate your company's requirements for a chat bot and compare three bot-creation tools.

## Chat bot requirements

When you're choosing a bot service, a primary consideration should be which bot-creation tool best meets your requirements. Your company's requirements for a chat bot are:

- Bots must be simple to create and manage.
- Bots must be easy to extend later with new code-based features.
- Natural language capabilities must be built into the bot without needing to develop language machine learning models.

The Azure Bot Service has several features that you can use. In this unit, you'll examine the considerations for choosing a bot service and the benefits that the Azure Bot Service provides.

## Evaluating bot-building tools

You have three primary bot-creation methods available: Power Virtual Agents, QnA Maker, and Bot Framework Composer. Each method has qualities that you'll evaluate against your requirements to choose the best fit for your organization.

### Power Virtual Agents

Use Power Virtual Agents to create powerful chat bots. These bots can answer questions posed by your customers, other employees, or visitors to your website or service. Because of the guided, no-code graphical interface, you can use the Power Virtual Agents web app to create chat bots without needing developer expertise.

Topics guide a bot's conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to enter. These phrases are matched to a specific topic using built-in natural language understanding. For instance, consider that a user enters "Open hours" into your bot. The bot's AI can match that to a topic named Store hours and then begin a conversation asking the user about which store they're asking. Ultimately, the bot then provides that store's hours of operation.

Extend Power Virtual Agents bot capability by using the Bot Framework SDK. Bot extensions can include:

- Advanced AI features
- Entities
- Variables
- Authentication
- Power Automate flows
- Skills

Power Virtual Agents does not support built-in integration of pre-configured LUIS resources, so it won't fulfill the requirements for your scenario.

### QnA Maker

Recall that QnA Maker is an Azure-based Natural Language Processing service. Use QnA Maker to create a natural conversational layer over your data. It's used to find the most appropriate answer for any input from your custom knowledge base of information.

The QnA Maker portal is a complete knowledge base authoring experience. You can import documents in their current form to your knowledge base. These documents might include an FAQ, product manual, spreadsheet, or webpage. The documents are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs.

>[!NOTE]
> The final markdown format supports rich presentation, including images and links.

Once your knowledge base is edited, you can publish the knowledge base to a working Azure Web App bot without writing any code. Test your bot in the Azure portal or download it and continue development.

QnA Maker does not support direct customization of conversation flow and logic, so it won't fulfill the requirements for your scenario.

### Bot Framework Composer and Azure Bot Service

Bot Framework Composer is an open-source, visual IDE for developers to author, test, provision, and manage conversational experiences. You can use the Azure Bot Service to host bots created in Bot Framework Composer.

>[!TIP]
> You can perform more complex activities such as integrate with dependencies (for instance, REST API) by directly modifying the code of the bot. You can do this by using the Bot Framework SDK and Visual Studio Code or other IDE.

## Choosing a bot-building tool

After evaluating the three options for bot creation, you decide that the Bot Framework Composer is the best fit for your company because:

- The visual designer makes it intuitive to create and manage bots.
- Its built-in capabilities support language understanding integration.
- If more advanced functionality is required in the future, you can extend the bots you create by using the Bot Framework SDK.
