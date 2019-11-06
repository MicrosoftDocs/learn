Your organization is moving systems to Azure. You need to understand how Azure can help you protect the credentials for these systems.

Here, you'll learn about Azure Key Vault, and how you can use it to secure information such as credentials and secrets.

## Separate your code and credentials by using Azure Key Vault

The Azure Key Vault service helps you securely store your secrets and keys. Any sensitive information that must be kept secure is a good candidate for Azure Key Vault. Sensitive information can range from passwords and keys to connection strings, such as database connection strings. Certificates also need to be secure. An example is x509 certificates for HTTPS/SSL connections, which consist of a private key and public key.

When you use Azure Key Vault, your secrets aren't visible to anyone. Even Microsoft can't view them. Azure Key Vault employs powerful algorithms and hardware security modules to help keep your keys and secrets secure. Azure Key Vault keeps your keys in a secure device. This device is designed to actively resist tampering and other forms of unauthorized use.

An organization might find that parts of its code for an application have leaked or are in the wrong place because of a version control mistake. The source code might show the organization's credentials. If organization had used Azure Key Vault to store their secrets, the application code would be free of credentials. In Key Vault, the application code and the credentials are entirely separated. If someone accessed the application code, the credentials would be secure and not visible in the application.

By separating these concerns, the organization has eliminated what might have been a serious problem. If credentials have to be changed, there's no need to update the applications. The organization would update the credentials in the key vault, and all applications would automatically point to them.

Azure Key Vault is also sophisticated enough to let you monitor how and when your secrets and keys are used. Azure Key Vault lets you monitor activity on your vault, and enable logging. All this logging data can be archived on Azure Storage, streamed for real-time reporting, or fed into Azure Monitor logs. This way, you can draw real insights from usage on your secrets and keys.

Azure Key Vault is supported on many Azure services, including database services, storage services, and app services.

## Secure a secret by using Azure Key Vault

You can interact with Azure Key Vault using the Azure CLI, PowerShell, Azure Resource Manager templates, the Azure portal, and through SDK's for many languages.

Below is an example in Azure CLI, showing how you would create an Azure key vault and securely store a secret password the vault:

```azurecli
# Create a key vault
az keyvault create --name "Your-Vault" --resource-group "YourResourceGroup" --location westus
```

Now you can add your secret to this vault:

```azurecli
# Add a secret
az keyvault secret set --vault-name "Your-Vault" --name "YourStoredPassword" --value "KlhOM901BkLx"
```

You've added a secret to your vault. You can verify the secret has been created by using the following command:

````azurecli
# Verify your secret
az keyvault secret show --name "YourStoredPassword" --vault-name "Your-Vault"
````

You've created a new Azure Key Vault, and then saved a secret to be kept secure in the key vault.
