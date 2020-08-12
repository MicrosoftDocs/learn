You've achieved quite a bit in this module. QnA Maker is an easy way to provide answers to common questions by using existing documents or FAQ lists.

Integrating the QnA Maker service with a bot in Azure can make it easier for users interact with FAQ lists in a conversational way, so they don't have to search through long documents in a browser.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-factbot** resource group. This removes all the resources you created in this module. Here are the steps:

1. Find the **mslearn-factbot** resource group. You can select **Resource groups** in the Azure sidebar to quickly locate it, or use the global search bar at the top of the portal window.

1. Select the resource group and either right-click the row or use the ellipsis button (...) on the right side of the row to open the menu.

1. Select **Delete resource group**.

1. Type the name of the resource group and select **Delete**. Azure will remove all the resources - including the Knowledge Base in QnA Maker.

## Learn more

There is more that you can do to leverage the power of the Azure Bot Service.

- Incorporating [Dialogs](https://aihelpwebsite.com/ViewBlogPost/32)
- Add support for [FormFlow](https://blogs.msdn.microsoft.com/uk_faculty_connection/2016/07/14/building-a-microsoft-bot-using-microsoft-bot-framework-using-formflow/)
- Support natural language with [Microsoft Language Understanding and Intelligence Services (LUIS)](https://docs.botframework.com/node/builder/guides/understanding-natural-language/).

By using these features in conjunction with others, you can build sophisticated bots that respond to users' queries and commands and interact in a fluid, conversational, and non-linear manner.

For more information, and for ideas to get you started, see the [What is Microsoft Bot Framework Overview](https://blogs.msdn.microsoft.com/uk_faculty_connection/2016/04/05/what-is-microsoft-bot-framework-overview/).

If you would like to make the bot smarter, consider expanding the knowledge base with additional questions and answers. For example, you could use the [online FAQ](https://docs.microsoft.com/azure/bot-service/bot-service-resources-bot-framework-faq?view=azure-bot-service-3.0) for the Bot Framework to train the bot to answer questions about the framework itself.
