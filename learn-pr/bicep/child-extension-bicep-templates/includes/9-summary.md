Your R&D department needed a new Cosmos DB database to store the data they collect when they test the new drone that they are developing. They asked you to make sure that all successful attempts to access the data are logged, and also to log access to another storage account that they already created for storing design documents.

Bicep enabled you to create a template with child resources. You used this to create a Cosmos DB account, database, and container. You used extension resources to configure the diagnostic settings for the Cosmos DB account to send its logs to a Log Analytics workspace. You also used Bicep's support for referencing existing resources so that you could add diagnostic settings to the R&D team's storage account.

Creating comprehensive and powerful Bicep templates requires you to understand child and extension resources. Without using these features of the Bicep language, you would be limited in what you can model in your infrastructure as code templates.

## Learn more

- [Child resources](/azure/azure-resource-manager/templates/child-resource-name-type)
- [Extension resources](/azure/azure-resource-manager/templates/scope-extension-resources)
- [Extension resource types](/azure/azure-resource-manager/management/extension-resource-types)
