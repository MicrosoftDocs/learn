Contoso's application needs to read product data as the team prepares its Azure Cosmos DB account for production. Your first decision is which identity represents that application. A developer's successful connection doesn't prove that the deployed application has access. You need a credential appropriate to each environment and a data operation that demonstrates the intended access. This unit connects those decisions without treating Contoso's scenario as a deployment procedure.

## Choose a managed identity for the application

For an application hosted on an Azure service that supports managed identities, use Microsoft Entra authentication with a managed identity as your default. Azure manages the identity's credentials, so your application doesn't store or rotate an account key or application secret. The Azure Identity library obtains access tokens for that identity, and the Azure Cosmos DB SDK uses them when it sends requests.

This choice separates the application's identity from individual developers. Contoso's operations team manages the application's hosting environment, while its security team reviews the permissions associated with the identity. A managed identity removes application-managed credentials, but it doesn't grant permission to read data. You still need an appropriate data-plane role assignment and an allowed network path.

### Match the identity to the resource lifecycle

Choose a **system-assigned managed identity** when the identity belongs to one Azure resource. Azure creates the identity for that resource and deletes it when the resource is deleted. For a single application host, choosing a system-assigned managed identity ties the identity lifecycle to the workload and avoids managing a separate identity resource.

Choose a **user-assigned managed identity** when you need an identity with an independent lifecycle. You manage it as a separate Azure resource and associate it with supported application hosts. For example, Contoso can retain the same identity when it replaces a host. Sharing that identity across hosts also shares its permissions, so separate identities remain useful when workloads need different access.

With either type, distinguish the **principal object ID**, which identifies the security principal for role assignments, from a user-assigned identity's **client ID**, which application code uses to select that identity. Substituting one for the other makes an otherwise correct configuration target the wrong identifier.

## Separate local and deployed credentials

During local development, `DefaultAzureCredential` uses a chain of credential sources. A signed-in development tool, such as the Azure CLI, can supply your developer identity. The chain also includes other sources, so don't assume that a successful call necessarily uses the account you expect. Check the available credential sources and the tenant and identity associated with your development session.

For deployed code, prefer an explicit `ManagedIdentityCredential` when managed identity is the intended authentication method. This choice prevents fallback to a developer credential or another credential source in the default chain. The Azure host must expose the selected managed identity to the application. Selecting a credential in code doesn't enable an identity on the host or attach a user-assigned identity to it.

The code in the next section uses `DefaultAzureCredential` for local development. For a production host with a system-assigned identity, replace that credential declaration with the following declaration:

::: zone pivot="csharp"

```csharp
TokenCredential credential = new ManagedIdentityCredential(
    ManagedIdentityId.SystemAssigned);
```

::: zone-end

::: zone pivot="python"

```python
from azure.identity import ManagedIdentityCredential

credential = ManagedIdentityCredential()
```

::: zone-end

For a user-assigned identity, select its client ID explicitly instead. These alternatives assume that `managedIdentityClientId` or `managed_identity_client_id` comes from your application's nonsecret configuration and identifies an identity associated with the host:

::: zone pivot="csharp"

```csharp
TokenCredential credential = new ManagedIdentityCredential(
    ManagedIdentityId.FromUserAssignedClientId(managedIdentityClientId));
```

::: zone-end

::: zone pivot="python"

```python
from azure.identity import ManagedIdentityCredential

credential = ManagedIdentityCredential(client_id=managed_identity_client_id)
```

::: zone-end

Both choices keep the data-access code unchanged. Azure Identity handles token acquisition and renewal, while the credential selection makes the intended source explicit. Your developer identity and the deployed managed identity are separate principals. Granting access to one doesn't grant access to the other.

## Connect and prove access with a read

The account endpoint tells the SDK where to send requests. It isn't a secret and doesn't authorize access by itself. Keep it in ordinary application configuration, separate from the credential. Pass a `TokenCredential` implementation to `CosmosClient` rather than an account key. In Python, pass the credential through the `credential` argument.

These examples assume an existing Azure Cosmos DB for NoSQL account, a `cosmicworks` database, and a `product` container partitioned on `/categoryId`. They also assume projects with the Cosmos DB and Azure Identity libraries and their dependencies. They don't create resources, assign roles, or load data. Supply the endpoint, an existing product's `id`, and that same product's `categoryId` as the program's three arguments. No sample product values are assumed.

For this read, the calling principal needs **Cosmos DB Built-in Data Reader** (`00000000-0000-0000-0000-000000000001`) scoped to `/dbs/cosmicworks/colls/product`. Data-plane role management isn't available in the Azure portal. An administrator uses a supported management tool, such as `az cosmosdb sql role assignment create`, with the principal's object ID. The role-based access control unit covers that configuration in detail.

::: zone pivot="csharp"

```csharp
using System;
using Azure.Core;
using Azure.Identity;
using Microsoft.Azure.Cosmos;

if (args.Length != 3)
{
    throw new ArgumentException("Provide endpoint, product ID, and categoryId.");
}

string endpoint = args[0];
string productId = args[1];
string categoryId = args[2];

TokenCredential credential = new DefaultAzureCredential();
using CosmosClient client = new CosmosClient(endpoint, credential);
Container container = client.GetContainer("cosmicworks", "product");

ItemResponse<dynamic> response = await container.ReadItemAsync<dynamic>(
    productId,
    new PartitionKey(categoryId));

Console.WriteLine($"Read succeeded. Status: {(int)response.StatusCode}");
```

::: zone-end

::: zone pivot="python"

```python
import sys
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

if len(sys.argv) != 4:
    raise ValueError("Provide endpoint, product ID, and categoryId.")

endpoint, product_id, category_id = sys.argv[1:]
credential = DefaultAzureCredential()

try:
    with CosmosClient(endpoint, credential=credential) as client:
        database = client.get_database_client("cosmicworks")
        container = database.get_container_client("product")
        item = container.read_item(item=product_id, partition_key=category_id)
        print("Read succeeded.")
finally:
    credential.close()
```

::: zone-end

The success message follows an actual item read, not merely client construction or obtaining a container reference. A successful read demonstrates that this request passes authentication, authorization, and network checks. It doesn't prove write permission or access to other containers. These short programs dispose of the client on exit. In a hosted application, reuse the client for the application lifetime rather than constructing one per request.

Learn more about [connecting with Microsoft Entra credentials and data-plane roles](/azure/cosmos-db/how-to-connect-role-based-access-control).

## Diagnose the correct security boundary

When the read fails, identify which boundary blocks the request before changing permissions. A credential problem, a missing role, and an inaccessible endpoint need different fixes:

- **Authentication:** Check whether Azure Identity can obtain a token for the intended principal. For local development, check the signed-in account and tenant. For deployment, check the host's identity configuration and any selected client ID.
- **Authorization:** Check the principal object ID, data-plane role, and resource scope. A control-plane role that manages the account doesn't itself grant item access. Don't assign broader permissions merely because a request fails.
- **Network access:** Check whether the application's environment can reach the endpoint through the account's allowed network path. A valid token doesn't bypass firewall restrictions or private endpoint requirements.

Use the exception details alongside these checks rather than treating every failure as an identity problem. For example, a forbidden response can relate to permissions or network restrictions. A not-found response also calls for checking the database, container, item ID, and partition key value. Correct credentials don't make an incorrect item address valid.

For Contoso's release evidence, record the intended principal, container scope, execution environment, and read result without recording tokens or product contents. Repeat the read from the deployed application environment: a local success doesn't validate the deployed identity or its network path. The next unit examines key-based authentication for applications that require account keys, while managed identity remains the default for supported Azure hosts.