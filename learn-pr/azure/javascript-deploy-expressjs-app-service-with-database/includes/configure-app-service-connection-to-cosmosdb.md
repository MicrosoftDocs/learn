Connect your remote Azure App Service resource to your remote Azure Cosmos DB resource.

## Connecting Azure resources

This module allows the App Service to connect to the Cosmos DB resource using the connection string. Because there are several connection methods depending on which Azure resources you are using and which authentication you want to enforce, always refer to the documentation for the specific resources you would like to connect.

Connection methods come in two varieties:

* Authenticate

## Azure Cosmos DB connection strings

The Cosmos DB resource provides a connection string you can use to access the resource. This connection string needs to be used as an **app setting** in the App Service to provide this connection. 