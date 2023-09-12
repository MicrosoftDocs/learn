Your organization is moving systems to Azure. You need to understand how Azure can help you protect the credentials for these systems.

Here, you learn how to use Azure Key Vault to meet security guidelines for storing information such as credentials and secrets.

## Separate your code and credentials by using Azure Key Vault

The Azure Key Vault service helps you securely store your secrets and keys. Any sensitive information that must be kept secure is a good candidate for Azure Key Vault. Sensitive information can range from passwords and keys to connection strings, such as database connection strings. 

Certificates also need to be secure. An example is x509 certificates for HTTPS/SSL connections, which consist of a private key and public key.

When you use Azure Key Vault, your secrets aren't visible to anyone. Even Microsoft can't view them. Azure Key Vault uses powerful algorithms and hardware security modules to help keep your keys and secrets secure. Hardware security modules are designed to resist tampering and other forms of unauthorized use.

An organization might find that parts of its code for an application have leaked or are in the wrong place because of a version control mistake. The source code might show the organization's credentials. If the organization used Azure Key Vault to store its secrets, the application code would be free of credentials. In Key Vault, the application code and the credentials are entirely separated. If someone accesses the application code, the credentials are secure, and not visible in the application.

The organization has eliminated what might have been a serious problem, by separating these concerns. If credentials have to be changed, there's no need to update the applications. The organization would update the credentials in the key vault, and all applications would automatically point to them.

Azure Key Vault also lets you monitor how and when your secrets and keys are used. You can monitor activity on your vault and enable logging. All this logging data can be archived on Azure Storage, streamed for real-time reporting, or fed into Azure Monitor logs. This way, you can draw real insights from usage on your secrets and keys.

Azure Key Vault is supported on many Azure services, including database services, storage services, and app services.

## Secure a secret by using Azure Key Vault

You can interact with Azure Key Vault by using the Azure CLI, PowerShell, Azure Resource Manager templates, the Azure portal, and SDKs for many languages.

The following example in Azure CLI shows how you would create a key vault to store a secret password:

```azurecli
# Create a key vault
az keyvault create --name "Your-Vault" --resource-group "YourResourceGroup" --location westus
```

Now you can add your secret to this vault:

```azurecli
# Add a secret
az keyvault secret set --vault-name "Your-Vault" --name "YourStoredPassword" --value "KlhOM901BkLx"
```

Verify that the secret has been added:

````azurecli
# Verify your secret
az keyvault secret show --name "YourStoredPassword" --vault-name "Your-Vault"
````

You now have a key vault with a secret stored in it.
