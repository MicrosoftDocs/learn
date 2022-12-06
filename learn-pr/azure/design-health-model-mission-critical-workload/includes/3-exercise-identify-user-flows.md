To design a health model for their workload, the Contoso Shoes organization needs to become familiar with application architecture and understand the key Azure services involved.

In this module, two user flows in the health model are defined as follows:

- List catalog items: Dependent on the Azure Data Catalog Rest API.
- Add comment: Dependent on the Catalog API and the background processor.

The final layer of the health model includes the following Azure resources: App Service, Azure Functions, Azure Cosmos DB, Azure Key Vault, and Azure Event Hubs.

![Diagram showing the architecture for this layered health model.](../media/layered-health-model.png)

## List catalog items

The list catalog items user flow is dependent on the Azure Data Catalog Rest API. The health model considers its health state to be healthy when both the front end and the Azure Data Catalog Rest API are healthy.

## Add comment

The add comment user flow is dependent on the Azure Data Catalog Rest API and the background processor. The health model considers its health state to be healthy when the front-end web application, the Azure Data Catalog Rest API, and the background processor are all healthy.
