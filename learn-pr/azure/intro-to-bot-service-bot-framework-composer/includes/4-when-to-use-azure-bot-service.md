Your organization wants to automate customer chat support by using a chatbot on your website and social-networking sites. You need to be able to determine which Azure Bot Service tool is the best choice for your needs. When choosing a bot service, the primary consideration is which bot creation tool best fits the requirements. Your company's requirements for a chat bot are:

- Bots must be simple to create and manage.
- Bots must be easy to extend later with new code-based features.
- Natural language capabilities built into the bot without needing to develop language machine learning models.

The Azure Bot Service has several features that you can use. In this unit, you'll examine the considerations for choosing a bot service and the benefits that the Azure Bot Service provides.

## Evaluating bot building tools

You have three primary bot creation methods available, Power Virtual Agents, QnA Maker, and Bot Framework Composer. Each method has qualities that you'll evaluate against our requirements to choose the best fit for you organization.

### Power Virtual Agents

Power Virtual Agents lets you create powerful chatbots that can answer questions posed by your customers, other employees, or visitors to your website or service. The You can use the Power Virtual Agents web app to create chatbots using a guided, no-code graphical interface, removing the need for code-based or developer expertise.

Topics inform the bot conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to type. These phrases are matched to a specific topic using built-in natural language understanding. For example, a user might type "Open hours" into your bot—the AI will be able to match that to the Store hours topic and begin a conversation that asks which store the customer is interested in, and then display the hours the store is open.

You can extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using the Bot Framework SDK.

### QnA Maker

QnA Maker is a Azure-based Natural Language Processing (NLP) service that allows you to create a natural conversational layer over your data. It is used to find the most appropriate answer for any input from your custom knowledge base (KB) of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents, in their current form, to your knowledge base. These documents, such as an FAQ, product manual, spreadsheet, or web page, are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs. The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, publish the knowledge base to a working Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

### Bot Framework Composer and Azure Bot Service

Bot Framework Composer, built on the Bot Framework SDK, is an open-source IDE for developers to author, test, provision and manage conversational experiences. It provides a powerful visual authoring canvas enabling dialogs, language-understanding models, knowledgebases and language generation responses to be authored from within one canvas and crucially, enables these experiences to be extended with code for more complex tasks such as system integration. Resulting experiences can then be tested within Composer and provisioned into Azure along with any dependent resources. Composer is available as a desktop application for Windows, OSX and Linux as well as a web-based component which can be customized and extended to suit your needs.

Composer offers a visual design experience that makes it easy to model of more sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important. Authoring dialog experiences with a visual designer is more efficient and enables easier modeling of more sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important. More complex activities such as integrating with dependencies such as REST API can be accomplished my directly modifying the code of your Composer-authored bot. Using Visual Studio Code or another IDE.

## Choosing a bot building tool

After evaluating the three options for bot creation, you can see that the Bot Framework Composer is the best fit for your organization. The visual designer will make bot creation simple to create and manage, it has built-in capabilities to support language understanding integration, and the bots you create can still be extended after they are created with the Bot Framework SDK if more advanced functionality is required in the future.
