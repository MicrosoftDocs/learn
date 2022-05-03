Connect your remote Azure App Service resource to your remote Azure Cosmos DB resource.

## Connecting Azure resources

This module allows the App Service to connect to the Cosmos DB resource using the connection string. Because there are several connection methods depending on which Azure resources you are using and which authentication you want to enforce, always refer to the documentation for the specific resources you would like to connect.

Connection methods come in a few varieties:

* Authentication provided by the resource, such as a connection string or key.
* Authenticate as an app: this method passes the App's information to the next Azure resource.
* Authenticate as a user: this method passes the user's information to the next Azure resource.

## Azure Cosmos DB connection strings

This module has the App Service authenticate to Cosmos DB with the connection string provided by Cosmos DB. This connection string needs to be used as an **app setting** in the App Service to provide this connection. 