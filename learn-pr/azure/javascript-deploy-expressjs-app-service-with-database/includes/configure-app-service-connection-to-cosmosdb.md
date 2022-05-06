Use a connection string to connect your remote Azure App Service resource to your remote Azure Cosmos DB resource.

## Connecting Azure resources

There are several connection methods depending on which Azure resources you're using and which authentication you want to enforce, always refer to the documentation for the specific resources you would like to connect for the most up-to-date information.

## Connection strings and keys

Authentication _secrets_ provided by the resource, such as a connection string or key, are available from many Azure resources. These secrets are specific to the originating resource and not to the identity of the user of the secret (such as App Service). These Azure resources provide 2 secrets for connectivity:

* **2 Developers**: One form of these secrets is 2 secrets, which you would hand out to 2 separate developers or connecting resources. Each secret can be cycled for a new secret.  CosmosDB provides 2 connection strings for your resource.
* **Read/Read-write**: Another form of these secrets in a **read** and a **read/write** form where the developer would need to use the correct secret based on their scenario. 

Once you have the connection secret, you can directly store it in an **app setting** for the App Service. When you need to rotate the secret, you need access to the original Azure resource (such as Cosmos DB) to generate a new secret. Then you need to place this secret in the using resource (such as App Service).

:::image type="content" source="../media/app-service-connect-app-setting-connection-string.png" alt-text="Conceptual image showing connection from App Service to Cosmos DB with a connection string.":::

If you want to restrict access to the App Service, you may choose to store the secret in an **Azure Key Vault** then reference the secret by the App Service as an app setting.

:::image type="content" source="../media/app-service-connect-key-vault-reference.png" alt-text="Conceptual image showing connection from App Service to Cosmos DB with a secret from Key Vault.":::

These two connections methods require no code changes to the app deployed to App Service. If you would prefer to programmatically get your secrets, you don't need to use app settings.

## Connection via identity

A more secure method of connection requires the connecting resource, such as App Service, to pass an identity to the connected Azure resource, such as Cosmos DB. This identity can either be the resource itself, such as App Service, or the user of the resource. This type of secure connection in Azure is known as a [managed identity](/azure/app-service/tutorial-connect-overview). 

:::image type="content" source="../media/app-service-connect-app-identity-credentials.png" alt-text="Concepetual image showing identity used to access an Azure resource from App Service.":::

## Which connection to choose?

This module uses a connection string stored in an app setting in the App Service, as the most convenient in a developer experience flow. As your project grows in security requirements, you'll eventually want to store the connection string in Key Vault and access it from App Service. Managed identity isn't currently a choice because the MongoDB client libraries don't support this authentication. 