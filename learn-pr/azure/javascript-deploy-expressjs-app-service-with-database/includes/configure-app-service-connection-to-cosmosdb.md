Connect your remote Azure App Service resource to your remote Azure Cosmos DB resource.

## Connecting Azure resources

There are several connection methods depending on which Azure resources you are using and which authentication you want to enforce, always refer to the documentation for the specific resources you would like to connect.

## Connection strings and keys

Authentication _secrets_ provided by the resource, such as a connection string or key are available from many Azure resources. These secrets are specific to the originating resource and not to the identity the secret is handed off to. These Azure resources provide 2 secrets for connectivity. One form of these secrets is 2 secrets, which you would hand out to 2 separate developers or connecting resources. Each secret can be cycled for a new secret. Another form of these secrets in a **read** and a **read/write** form where the developer would need to use the correct secret based on their scenario. Once you have the connection secret, you can directly store it in an **app setting** for the App Service. When you need to rotate the secret, you need access to the original Azure resource and the Azure App Service.

:::image type="content" source="../media/app-service-app-setting-connection-string.png" alt-text="Conceptual image showing connection from App Service to Cosmos DB with a connection string.":::

If you want to restrict access to the App Service to a group different than the owners of the connected Azure resource, you may choose to store the secret in an **Azure Key Vault** then reference the secret by the App Service as an app setting. When you need to rotate the secret, you only need access to the Azure Key Vault. 

:::image type="content" source="../media/app-service-connect-key-vault-reference.png" alt-text="Conceptual image showing connection from App Service to Cosmos DB with a secret from Key Vault.":::

These two previous methods require no code changes to the app deployed to App Service. If you would prefer to programmatically get your secrets, you don't need to use app settings.

## Connection via identity

A more secure method of connection requires the connecting resource, such as App Service, to pass an identity to the connected Azure resource, such as Cosmos DB. This identity can either be the resource itself, such as App Service, or the user of the resource. This type of secure connection in Azure is known as a [managed identity](/azure/app-service/tutorial-connect-overview). 

:::image type="content" source="../media/app-service-connect-app-identity-credentials.png" alt-text="Concepetual image showing identity used to access an Azure resource from App Service.":::