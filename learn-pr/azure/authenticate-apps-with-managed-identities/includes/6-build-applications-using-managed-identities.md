Managed Identity delegates the responsibility for creating and managing identity information for your services and other resources to Azure. Azure stores identity information in Active Directory. You can then assign access policies, which determine which identities can access your resources.

In the example scenario, you want to use managed identities to authenticate requests emanating from a virtual machine, to enable these requests to be able to retrieve secret information from Azure Key Vault.

In this unit, you'll learn more about how applications can use managed identities to authenticate requests. You'll see how to define an authorization policy with Azure Key Vault to enable an authenticated identity to read secret information.

## Managed Identities

Recall from an earlier unit that Azure supports system-assigned identities and user-assigned identities. A system-assigned identity is created and managed by Azure, and is closely tied to a specific resource. For example, if you create a VM with a system-assigned identity, Azure creates the identity automatically and associates it with the VM. If the VM is deleted, the identity also disappears.

User-assigned identities are independent of any specific resource. You create a user-assigned identity manually, and you can assign it to a resource or service such as an Azure Function App. When the Function App runs, it uses the specified identity. You can assign access rights to this identity to the resources that the Function App needs to access. In this way, you can closely control the privileges that the Function App has.

## Create and manage a user-assigned identity

You can create a user-assigned identity using the Azure portal or from the command line. The example below uses the Azure CLI:

```azurecli
az identity create \
  --name <identity name>
  --resource-group <resource group>
```

You can view a list of identities, including system-assigned identities, with the following command. Note the principal ID of your identity. This is the ID that Azure uses to assign and verify privileges:

```azurecli
az identity list \
  --resource-group <resource group>
```

Once you've created an identity, you can use the principal ID returned by the previous command to associate it with your resources. To use the identity with an Azure Function App, use this command:

```azurecli
az functionapp identity assign \
  --name <function app name> \
  --resource-group <resource group> \
  --role <principal id>
```

The function app will run using this identity, and will be able to access the resources available to that identity.

The commands to do this will vary from resource to resource. For example, to grant the identity the ability to read and list keys from Azure Key Vault, use the following command:

```azurecli
az keyvault set-policy \
    --name <key vault name> \
    --object-id <principal id> \
    --secret-permissions get list
```

To delete a user-assigned identity, run the following command:

```azurecli
az identity delete \
  --name <identity name>
  --resource-group <resource group>
```

## Using managed identity with Azure Key Vault

Azure Key Vault provides a short-cut for the authentication process. The `AzureTokenServiceProvider` class has the `KeyVaultTokenCallback` property, which returns a delegate that an application can use to generate and authenticate the access token for the Key Vault service, based on the managed identity of the app. A `KeyVaultClient` object, which is used to access secrets in a key vault, can invoke the delegate using an `AuthenticationCallback` object. The code below shows how to create a `KeyVaultClient` object that authenticates the managed ID of an app.

```C#
KeyVaultClient keyVaultClient = new KeyVaultClient(
    new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
```

When you've successfully authenticated the managed ID, you can call the `GetSecretAsync` method of the `KeyVaultClient` object to retrieve a named secret:

```C#
string keyVaultName = ...;
string keyVaultSecretName = ...;
var secret = await keyVaultClient
    .GetSecretAsync($"https://{keyVaultName}.vault.azure.net/secrets/{keyVaultSecretName}")
    .ConfigureAwait(false);

Console.WriteLine($"Secret: {secret.Value}");
```