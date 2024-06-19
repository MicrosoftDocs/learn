You already created an Azure VM and assigned a system-managed identity. The apps that run on this VM should authenticate requests to Azure resources. Instead of using passwords to shared keys, you'll use the system-assigned managed identity.

In this unit, you'll learn more about how applications can use managed identities for authentication. You'll see how to use Azure Key Vault to define an authorization policy, and you'll enable an authenticated identity to read secret information.

## Managed identities

In an earlier unit, you learned that Azure supports system-assigned managed identities and user-assigned managed identities. Azure creates and manages a system-assigned managed identity. It's closely tied to a specific resource. For example, if you create a VM that has a system-assigned managed identity, Azure creates the identity automatically. Azure associates the identity with the VM. If the VM is deleted, the identity is also deleted.

User-assigned managed identities are independent of any resource. You create a user-assigned managed identity manually, then you assign it to a resource or service, such as your stock-tracking app. When the app runs, it uses the user-assigned managed identity. You assign access rights to this identity for the Azure resources that the app needs to access. You could use this approach to deploy your app on multiple VMs. The app uses this user-assigned managed identity instead of setting up a system-assigned managed identity for each VM.

## Create and manage a user-assigned managed identity

You can create a user-assigned managed identity in the Azure portal or from a command prompt. The following command uses the Azure CLI:

```azurecli
az identity create \
  --name <identity name>
  --resource-group <resource group>
```

Run the following command to view a list of identities, including system-assigned managed identities. Note the principal ID of your identity. Azure uses this ID to assign and verify privileges.

```azurecli
az identity list \
  --resource-group <resource group>
```

After you create an identity, you can use the principal ID to associate the identity with your resources.

To use the identity with an Azure function app, run the following command:

```azurecli
az functionapp identity assign \
  --name <function app name> \
  --resource-group <resource group> \
  --role <principal id>
```

The function app uses this identity to run. It can access the resources that are available to the identity.

The required commands vary from resource to resource. For example, to grant the identity the ability to read and list keys from Azure Key Vault, run the following command:

```azurecli
az keyvault set-policy \
    --name <key vault name> \
    --object-id <principal id> \
    --secret-permissions get list
```

To delete a user-assigned managed identity, run the following command:

```azurecli
az identity delete \
  --name <identity name>
  --resource-group <resource group>
```

## Use managed identity with Azure Key Vault

The [DefaultAzureCredential](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/README.md#defaultazurecredential) provider allows you to use managed identities for authentication when our application is deployed to Azure, and use local developer credentials during development. To use DefaultAzureCredential, you'll need to install the Azure.Identity package:

```PowerShell
dotnet install Azure.Identity
```

Using the `DefaultAzureCredential`, we can now create an authenticated `SecretClient`.

```csharp
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential());
```

After creating our client, we retrieve a named secret.

```csharp
KeyVaultSecret secretWithValue = await client.GetSecretAsync(secret.Name).ConfigureAwait(false);
```
