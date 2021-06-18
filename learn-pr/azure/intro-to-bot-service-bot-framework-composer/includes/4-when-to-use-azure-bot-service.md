Your organization wants to automate customer chat support by using a chatbot on your website and social-networking sites. You need to be able to determine which Azure Bot Service tool is the best choice for your needs. When choosing a bot service, the primary consideration is which bot creation tool best fits the requirements. Your company's requirements for a chat bot are:

- Bots must be simple to create and manage.
- Bots must be easy to extend later with new features
- Natural language capabilities built into the bot without needing to develop language machine learning models.

The Azure Bot Service has several features that you can use. In this unit, you'll examine the considerations for choosing a bot service and the benefits that the Azure Bot Service provides.

## Choosing a bot creation tool

You have two primary bot creation methods available, Bot Framework Composer and Bot Framework SDK. Each method has qualities that you'll evaluate against our requirements to choose the best fit for you organization.

### Bot Framework Composer

The Bot Framework Composer is a visual designer that requires very little development experience or code creation. For standard bot scenarios, authoring dialog experiences with a visual designer is more efficient and enables easier modeling of more sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important. More complex activities such as integrating with dependencies such as REST Web Services are best suited towards code and  Composer bots can be extended with code after they're created. This combination provides simple bot design and creation, and it enables extensibility after the bot is deployed.

Some of the advantages of developing bots in Composer include:

- Authoring dialogs using the visual canvas can be more conducive to a conversational design versus code and enables you to focus development efforts on more complex tasks such as system integration.
- Design conversational experiences using a seamless blend of visual and code authoring.
- Existing dialogs authored in code can be leveraged by a Composer based bot.
- Language Generation (LG) provides the ability to create more natural, personalized responses resulting in engaging conversational experiences.
- Composer streamlines your bot project's codebase and provides a more accessible visual design surface which provides a unified canvas to author dialogs, responses along with language and QnA resources.
- Integrated testing within the Composer authoring experience.
- Azure provisioning for dependent resources is streamlined as part of the overall Composer experience

### Bot Framework SDK

The Bot Framework SDK allows you to build bots that can be hosted on the Azure Bot Service. The service defines a REST API and an activity protocol for how your bot and channels or users can interact. The SDK builds upon this REST API and provides an abstraction of the service so that you can focus on the conversational logic. While you don't need to understand the REST service to use the SDK, understanding some of its features can be helpful.

The Bot Framework SDK enables Azure Bot Service bot development in your favorite integrated development environment (IDE) in several languages, including C#, JavaScript, Typescript, Python, and Java (preview). Additionally, the SDK provides command line tools to help you to create, manage, and test bot assets. These tools can configure LUIS apps, build a QnA knowledge base, build models to route between components, mock a conversation, and more.

Some of the advantages of developing bots by using the Bot Framework SDK include:

- Create custom actions and activity handling logic.
- Manage bot state to retain specific conversation and user data.
- Dictate usage of specific Azure components such as storage accounts or databases to support bot functionality.
- Implement middleware for enhanced conversation flow and context from external data sources.
- Layering multiple bots into a single bot interface for complex bot scenarios.

After evaluating the two options for bot creation, you can see that the Bot Framework Composer is the best fit for your organization. THe visual designer will make bot creation simple to create and manage, it has built-in capabilities to support language understanding integration, and the bots you create can still be extended after they are created with the Bot Framework SDK if more advanced functionality is required in the future.
