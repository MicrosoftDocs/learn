This module was all about integrating data and services into your functions. We started off with a quick tour of the binding types that show up when you add them to a function. We then looked at reading data from an Azure Cosmos DB by using an input binding. The platform takes care of managing connection strings, and we saw how easy it is to read data in our code by using the binding. Finally, we focused our attention on writing data to different sources with the help of output bindings. This journey is summarized in the following table:

[!INCLUDE [summary table](./summary-table.md)]

You can apply the approaches you have learned here to add and test bindings in your functions. Here are a few interesting ideas to get more practice with bindings and to build on what you have learned here.

* Create another function to read from Blob storage and other input bindings that we haven't used in this module.

* Create another function to write to more destinations by using other supported output binding types.

* In the preceding unit, we introduced a queue and posted messages to it with an output binding. As a next step, consider adding another function that reads the messages in the queue and prints out the **MESSAGE TEXT** to the console with `console.log()`.

As we saw in this module, the Azure portal offers easy-to-use features to start building functions and connecting them to data and other services.

If you're interested in doing serverless integrations like these with visual workflows and little or no custom code, check out Azure Logic Apps as well.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Additional Resources

Although this is not intended to be an exhaustive list, the following are some resources related to the topics covered in this module that you might find interesting:

* [Azure Functions documentation](https://docs.microsoft.com/azure/azure-functions/)
* [The Azure Functions Challenge](https://aka.ms/afc)
* [Azure Serverless Computing Cookbook](https://azure.microsoft.com/resources/azure-serverless-computing-cookbook/)
* [How to use Queue storage from Node.js](https://docs.microsoft.com/azure/storage/queues/storage-nodejs-how-to-use-queues)
* [Introduction to Azure Cosmos DB: SQL API](https://docs.microsoft.com/azure/cosmos-db/sql-api-introduction)
* [A technical overview of Azure Cosmos DB](https://azure.microsoft.com/blog/a-technical-overview-of-azure-cosmos-db/)
* [Azure Cosmos DB documentation](https://docs.microsoft.com/azure/cosmos-db/)
