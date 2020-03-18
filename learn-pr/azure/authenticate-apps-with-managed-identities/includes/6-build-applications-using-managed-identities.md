Managed identity delegates the responsibility for creating and managing identity information for your services and other resources to Azure. Azure stores identity information in Active Directory. You can then assign access policies, which determine the identities that access your resources.

You've created an Azure VM and assigned a system-managed identity. You want apps running on this VM to authenticate requests to Azure resources. Instead of using passwords ro shared keys, you'll use the system-assigned managed identity.

In this unit, you'll learn more about how applications can use managed identities for authentication. You'll also see how to define an authorization policy with Azure Key Vault, to enable an authenticated identity to read secret information.

## Managed identities

You'll recall from an earlier unit that Azure supports system-assigned identities and user-assigned identities. A system-assigned identity is created and managed by Azure, and is closely tied to a specific resource. For example, if you create a VM with a system-assigned identity, Azure creates the identity automatically, and associates it with the VM. If the VM is deleted, the identity also disappears.

User-assigned identities are independent of any specific resource. Create a user-assigned identity manually, and assign it to a specific resource or service, such as your stock-tracking app. When the app runs, it uses the user-assigned identity. Assign access rights to this identity for the Azure resources that the app needs to access. You could use this approach to deploy your app on multiple VMs. The app uses this single user-assigned identity, instead of setting up a system-assigned identity for each VM.

## Create and manage a user-assigned identity

You can create a user-assigned identity using the Azure portal, or from the command line. The example below uses the Azure CLI:

```azurecli
az identity create \
  --name <identity name>
  --resource-group <resource group>
```

You can view a list of identities, including system-assigned identities, with the following command. Note the principal ID of your identity. Azure uses this ID to assign and verify privileges:

```azurecli
az identity list \
  --resource-group <resource group>
```

When you've created an identity, you can use the principal ID returned by the previous command to associate it with your resources. To use the identity with an Azure function app, use this command:

```azurecli
az functionapp identity assign \
  --name <function app name> \
  --resource-group <resource group> \
  --role <principal id>
```

The function app will run using this identity, and can access the resources available to that identity.

The commands vary from resource to resource. For example, to grant the identity the ability to read and list keys from Azure Key Vault, use the following command:

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

Azure Key Vault provides the means of delegating the authentication process. The `AzureTokenServiceProvider` class has the `KeyVaultTokenCallback` property, which returns a delegate. An application uses this delegate to generate and authenticate the access token for the Key Vault service, based on the managed identity of the app. A `KeyVaultClient` object, which is used to access secrets in a key vault, can invoke the delegate using an `AuthenticationCallback` object. The code below shows how to create a `KeyVaultClient` object that authenticates the managed ID of an app.

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