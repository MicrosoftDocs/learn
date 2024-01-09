Your R&D team needed a new Azure Cosmos DB database to store the data it collects when it tests the new drone it's developing. The team asked you to make sure that all successful attempts to access the data are logged. The team also wanted you to log access to another storage account that it already created for storing design documents.

By using Bicep, you were able to create a template with child resources. You used the template to create an Azure Cosmos DB account, database, and container. You used extension resources to configure the diagnostics settings for the Azure Cosmos DB account and send its logs to a Log Analytics workspace. You also used the `existing` keyword so that you could add diagnostics settings to the R&D team's storage account.

Creating comprehensive and powerful Bicep templates requires you to understand child and extension resources. Without using these features of the Bicep language, you would be limited in what you can model in your infrastructure as code templates.

## Learn more

- [Child resources](/azure/azure-resource-manager/bicep/child-resource-name-type)
- [Extension resources](/azure/azure-resource-manager/bicep/scope-extension-resources)
- [Extension resource types](/azure/azure-resource-manager/management/extension-resource-types)
