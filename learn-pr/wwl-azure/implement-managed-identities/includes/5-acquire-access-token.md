A client application can request managed identities for Azure resources app-only access token for accessing a given resource. The token is based on the managed identities for Azure resources service principal. The recommended method is to use the `DefaultAzureCredential`.

The Azure Identity library supports a `DefaultAzureCredential` type. `DefaultAzureCredential` automatically attempts to authenticate via multiple mechanisms, including environment variables or an interactive sign-in. The credential type can be used in your development environment using your own credentials. It can also be used in your production Azure environment using a managed identity. No code changes are required when you deploy your application.

> [!NOTE]
> `DefaultAzureCredential` is intended to simplify getting started with the SDK by handling common scenarios with reasonable default behaviors. Developers who want more control or whose scenario isn't served by the default settings should use other credential types.

The `DefaultAzureCredential` attempts to authenticate via the following mechanisms, in this order, stopping when one succeeds:

1. **Environment** - The `DefaultAzureCredential` reads account information specified via environment variables and use it to authenticate.
1. **Managed Identity** - If the application is deployed to an Azure host with Managed Identity enabled, the `DefaultAzureCredential` authenticates with that account.
1. **Visual Studio** - If the developer authenticated via Visual Studio, the `DefaultAzureCredential` authenticates with that account.
1. **Azure CLI** - If the developer authenticated an account via the Azure CLI `az login` command, the `DefaultAzureCredential` authenticates with that account. Visual Studio Code users can authenticate their development environment using the Azure CLI.
1. **Azure PowerShell** - If the developer authenticated an account via the Azure PowerShell `Connect-AzAccount` command, the `DefaultAzureCredential` authenticates with that account.
1. **Interactive browser** - If enabled, the `DefaultAzureCredential` interactively authenticates the developer via the current system's default browser. By default, this credential type is disabled.

##  Examples

The following examples use the Azure Identity SDK that can be added to a project with this command:

```bash
dotnet add package Azure.Identity
```

### Authenticate with `DefaultAzureCredential`

This example demonstrates authenticating the `SecretClient` from the [Azure.Security.KeyVault.Secrets](https://github.com/Azure/azure-sdk-for-net/tree/Azure.Identity_1.8.2/sdk/keyvault/Azure.Security.KeyVault.Secrets) client library using the `DefaultAzureCredential`.

```csharp
// Create a secret client using the DefaultAzureCredential
var client = new SecretClient(new Uri("https://myvault.vault.azure.net/"), new DefaultAzureCredential());
```

### Specify a user-assigned managed identity with `DefaultAzureCredential`

This example demonstrates configuring the `DefaultAzureCredential` to authenticate a user-assigned identity when deployed to an Azure host. It then authenticates a `BlobClient` from the [Azure.Storage.Blobs](https://github.com/Azure/azure-sdk-for-net/tree/Azure.Identity_1.8.2/sdk/storage/Azure.Storage.Blobs) client library with credential.

```csharp
// When deployed to an azure host, the default azure credential will authenticate the specified user assigned managed identity.

string userAssignedClientId = "<your managed identity client Id>";
var credential = new DefaultAzureCredential(new DefaultAzureCredentialOptions { ManagedIdentityClientId = userAssignedClientId });

var blobClient = new BlobClient(new Uri("https://myaccount.blob.core.windows.net/mycontainer/myblob"), credential);
```

### Define a custom authentication flow with `ChainedTokenCredential`

While the `DefaultAzureCredential` is generally the quickest way to get started developing applications for Azure, more advanced users may want to customize the credentials considered when authenticating. The `ChainedTokenCredential` enables users to combine multiple credential instances to define a customized chain of credentials. This example demonstrates creating a `ChainedTokenCredential` which attempts to authenticate using managed identity, and fall back to authenticating via the Azure CLI if managed identity is unavailable in the current environment. The credential is then used to authenticate an `EventHubProducerClient` from the [Azure.Messaging.EventHubs](https://github.com/Azure/azure-sdk-for-net/tree/Azure.Identity_1.8.2/sdk/eventhub/Azure.Messaging.EventHubs) client library.

```csharp
// Authenticate using managed identity if it is available; otherwise use the Azure CLI to authenticate.

var credential = new ChainedTokenCredential(new ManagedIdentityCredential(), new AzureCliCredential());

var eventHubProducerClient = new EventHubProducerClient("myeventhub.eventhubs.windows.net", "myhubpath", credential);
```
