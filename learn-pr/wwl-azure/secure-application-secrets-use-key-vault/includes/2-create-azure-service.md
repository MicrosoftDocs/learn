Centralizing storage of application secrets in Azure Key Vault allows you to control their distribution. Key Vault greatly reduces the chances that secrets may be accidentally leaked. With Key Vault, application developers no longer need to store security information in their application. Thus, eliminating the need to make this information part of the code. In this case, an application needs to connect to a database. Instead of storing the connection string in the app code, you'll store it securely in Key Vault.

Apps securely access the information by using URIs allowing them to retrieve specific versions of a secret after the application’s key or secret is stored in Azure Key Vault.

Azure Key Vault provides the following services:

 -  **Secrets Management** \- Store and tightly control access to tokens, passwords, certificates, API keys, and other secrets.
 -  **Key Management** \- Use as a key management solution to create and control the encryption keys used to encrypt data.
 -  **Certificate Management** \- Azure Key Vault is a service for provisioning, managing, and deploying public and private Secure Sockets Layer/Transport Layer Security (SSL/TLS) certificates for use with Azure and your internal connected resources.

In this unit, you'll create a new Azure Key Vault service for holding your application secrets.

From the Bash Git prompt, run the commands below to create an Azure Key Vault instance. The name of the service should be globally and adjusted accordingly in case the randomly generated name is already in use.

```Bash
KEYVAULT_NAME=kv-$APPNAME-$UNIQUEID
az keyvault create \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku standard
```

> [!NOTE]
> The name can contain only lowercase letters, numbers and hyphens. The `$LOCATION` and `$RESOURCE_GROUP` variables contain the name of the Azure region and the resource group into which you deployed the Azure Spring Apps service in the previous exercise.

> [!NOTE]
> Running the commands will take approximately 2-4 minutes to run.
