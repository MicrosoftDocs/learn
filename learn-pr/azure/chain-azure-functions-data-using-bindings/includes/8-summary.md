This module was about integrating data and services into your functions. We started with a quick tour of the binding types that show up when you add them to a function. Then, we looked at reading data from an Azure Cosmos DB by using an input binding. Azure Functions takes care of managing connection strings, and we saw how it's easy to read data in our code by using the binding. Finally, we focused our attention on writing data to different sources with the help of output bindings.

This journey is summarized in the following table, which shows the different bindings that you used in each of the units listed.

| Learning Unit | Triggers | Input bindings | Output bindings |
|---|---|---|---|
| [Explore input and output binding types](../2-explore-input-and-output-binding-types-portal-lesson.yml) | _HTTP_ | _HTTP_ | _HTTP_ |
| [Read data with input bindings](../4-read-data-with-input-bindings-portal-lesson.yml) | _HTTP_ | _HTTP_<br/>_Azure Cosmos DB_ | _HTTP_ |
| [Write data with output bindings](../6-write-data-with-output-bindings-portal-lesson.yml) | _HTTP_ | _HTTP_<br/>_Azure Cosmos DB_ | _HTTP_<br/>_Azure Cosmos DB_<br/>_Azure Queue Storage_ |

You can apply the approaches you learned here to add and test bindings in your functions. Here are a few interesting ideas to get more practice with bindings and to build on what you learned.

* Create another function to read from Blob storage and use other input bindings that we didn't use in this module.

* Create another function to write to more destinations by using other supported output binding types.

* In the preceding unit, we introduced a queue and posted messages to it with an output binding. As a next step, consider adding another function that reads the messages in the queue and prints the **MESSAGE TEXT** to the console with `console.log()`.

As we saw in this module, the Azure portal offers easy-to-use features to start building functions and connecting them to data and other services.

If you're interested in doing serverless integrations like these with visual workflows and little or no custom code, check out [Azure Logic Apps](https://azure.microsoft.com/services/logic-apps/) as well.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

The following resources are related to the subjects covered in this module that you might find interesting:

* [Azure Functions documentation](/azure/azure-functions/)
* [Azure Serverless Computing Cookbook](https://azure.microsoft.com/resources/azure-serverless-computing-cookbook/)
* [Quickstart: Azure Queue Storage client library for JavaScript](/azure/storage/queues/storage-nodejs-how-to-use-queues)
* [Introduction to Azure Cosmos DB: SQL API](/azure/cosmos-db/sql-api-introduction)
* [A technical overview of Azure Cosmos DB](https://azure.microsoft.com/blog/a-technical-overview-of-azure-cosmos-db/)
* [Azure Cosmos DB documentation](/azure/cosmos-db/)