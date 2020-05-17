Managed identity delegates to Azure the responsibility to create and manage identity information for your services and other resources. Azure stores identity information in Active Directory. You can then assign access policies. These policies determine the identities that access your resources.

You already created an Azure VM and assigned a system-managed identity. The apps that run on this VM should authenticate requests to Azure resources. Instead of using passwords to shared keys, you'll use the system-assigned managed identity.

In this unit, you'll learn more about how applications can use managed identities for authentication. You'll see how to use Azure Key Vault to define an authorization policy. And you'll enable an authenticated identity to read secret information.

## Managed identities

In an earlier unit, you learned that Azure supports system-assigned identities and user-assigned identities. A system-assigned identity is created and managed by Azure. It's closely tied to a specific resource. For example, if you create a VM that has a system-assigned identity, Azure creates the identity automatically. Azure associates the identity with the VM. If the VM is deleted, the identity is also deleted.

User-assigned identities are independent of any resource. You create a user-assigned identity manually. Then you assign it to a resource or service, such as your stock-tracking app. When the app runs, it uses the user-assigned identity. You assign access rights to this identity for the Azure resources that the app needs to access. You could use this approach to deploy your app on multiple VMs. The app uses this user-assigned identity instead of setting up a system-assigned identity for each VM.

## Creating and managing a user-assigned identity

You can create a user-assigned identity in the Azure portal or from a command prompt. The following example uses the Azure CLI:

```azurecli
az identity create \
  --name <identity name>
  --resource-group <resource group>
```

Use the following command to view a list of identities, including system-assigned identities. Note the principal ID of your identity. Azure uses this ID to assign and verify privileges.

```azurecli
az identity list \
  --resource-group <resource group>
```

After you create an identity, you can use the principal ID to associate the identity with your resources. 

To use the identity with an Azure function app, use this command:

```azurecli
az functionapp identity assign \
  --name <function app name> \
  --resource-group <resource group> \
  --role <principal id>
```

The function app uses this identity to run. It can access the resources that are available to the identity.

The required commands vary from resource to resource. For example, to grant the identity the ability to read and list keys from Azure Key Vault, use the following command:

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

Use Azure Key Vault to delegate the authentication process. The `AzureTokenServiceProvider` class has the `KeyVaultTokenCallback` property, which returns a delegate. An application uses this delegate to generate and authenticate the access token for the Key Vault service, based on the managed identity of the app. 

A `KeyVaultClient` object is used to access secrets in a key vault. This object can use an `AuthenticationCallback` object to invoke the delegate. The following code shows how to create a `KeyVaultClient` object that authenticates the managed identity of an app.

```C#
KeyVaultClient keyVaultClient = new KeyVaultClient(
    new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
```

After you authenticate the managed identity, you can call the `GetSecretAsync` method of the `KeyVaultClient` object to retrieve a named secret.

```C#
string keyVaultName = ...;
string keyVaultSecretName = ...;
var secret = await keyVaultClient
    .GetSecretAsync($"https://{keyVaultName}.vault.azure.net/secrets/{keyVaultSecretName}")
    .ConfigureAwait(false);

Console.WriteLine($"Secret: {secret.Value}");
```