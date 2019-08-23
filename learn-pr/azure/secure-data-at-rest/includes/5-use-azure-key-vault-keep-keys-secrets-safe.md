The credentials for the systems that your organization is moving to Azure need to be secured. You need to understand how Azure can help you protect these credentials. By the end of this unit, you'll:

- Understand what Azure Key Vault is.
- Understand why you would use Azure Key Vault.
- Understand how you would use Azure Key Vault.

## Separate your code and credentials with Azure Key Vault

The Azure Key Vault service helps you securely store your secrets and keys. Any sensitive information that must be kept secure is a good candidate for Azure Key Vault. Sensitive information can range from passwords and keys, to connection strings, such as database connection strings. Certificates, such as x509 certificates for HTTPS/SSL connections, which would consist of a private key and public key, also need to be secure.

 Azure Key Vault is secure – your secrets aren't visible to anyone, even Microsoft. Azure Key Vault employs powerful algorithms, and hardware security modules to keep your keys and secrets secure. Using hardware security modules, Azure Key Vault keeps your keys in a secure device. This device is designed to actively resist tampering and other forms of non-authorized use.

An organization might find it's had parts of its code for an application leaked – or in the wrong place because of a version control mistake. The source code could show the organization's credentials. If they had used Azure Key Vault to keep their secrets secure, then their application code would be free of their credentials. The application code and the credentials are entirely separated. If someone accessed the application code, the credentials would be secure and not visible in the application.

By separating these concerns, the organization has eliminated what might have been a serious problem. If credentials have to be changed, there's no need to update the applications. The organization would update the credentials in the Key Vault and all applications would automatically point to them.

Azure Key Vault is also sophisticated enough to let you monitor how and when your secrets and keys are used. Azure Key Vault lets you monitor activity on your vault , and enable logging. All this logging data can be archived on Azure storage, streamed for real-time reporting, or fed into Azure Monitor logs. This way, you can draw real insights from usage on your secrets and keys.

Azure Key Vault is supported out of the box with Azure database services, storage services, app services, and many more.

## Secure a secret with Azure Key Vault

You can interact with Azure Key Vault using the Azure CLI, PowerShell, Azure Resource Manager templates, the Azure portal, and other means (Node.js/.NET).

Below is an example in Azure CLI, showing how you would create an Azure Key Vault and securely store a secret password into your Azure Key Vault:

```Azure CLI
# Create a key vault
az keyvault create --name "Your-Vault" --resource-group "YourResourceGroup" --location westus
```

Now you can add your secret to this vault:

```Azure CLI
# Add a secret
az keyvault secret set --vault-name "Your-Vault" --name "YourStoredPassword" --value "KlhOM901BkLx"
```

You've added a secret to your vault. You can verify the secret has been created by using the following command:

````Azure CLI
# Verify your secret
az keyvault secret show --name "YourStoredPassword" --vault-name "Your-Vault"

````

You've created a new Azure Key Vault, and then saved a secret to be kept secure in the key vault.
