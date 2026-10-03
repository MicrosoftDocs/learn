The consumer from earlier in this module works. However, Contoso must deploy and manage the process. Contoso must keep it running, monitor it, and scale it when needed. For a job that spends most of its time idle and occasionally handles a burst of category renames, deploying and managing the process requires substantial infrastructure for a small amount of logic.

The Azure Functions trigger for Azure Cosmos DB removes it. In this unit, you move the same synchronization logic into a function and see which decisions the platform takes over and which stay yours.

## What the trigger handles

The trigger runs the change feed processor on the platform's side. It polls the feed, tracks position in a lease container, distributes leases across function instances as the platform scales them, and invokes your function with each batch. Your code shrinks to the delegate body.

:::image type="content" source="../media/functions-trigger-bindings.png" alt-text="Diagram showing an Azure Cosmos DB trigger starting a function app, alongside input and output bindings." lightbox="../media/functions-trigger-bindings.png":::

Two requirements carry over unchanged from a self-hosted consumer. You still name a monitored container, and you still need a lease container, partitioned on `/id`. Scaling and reliability come from the same mechanics described earlier; the difference is who operates them.

One constraint is specific to the trigger: it supports the API for NoSQL only.

## Write the function

::: zone pivot="csharp"

In the .NET isolated worker model, the trigger is an attribute on the function's first parameter. Application setting references, written as `%SETTING_NAME%`, keep container names out of the compiled code.

```csharp
[Function("SyncCategoryName")]
public async Task Run(
    [CosmosDBTrigger(
        databaseName: "%COSMOS_DATABASE_NAME%",
        containerName: "%COSMOS_CONTAINER_NAME%",
        Connection = "COSMOS_CONNECTION",
        LeaseContainerName = "leases")] IReadOnlyList<ProductMetaItem> changes,
    FunctionContext context)
{
    if (changes is null)
    {
        return;
    }

    foreach (ProductMetaItem item in changes.Where(c => c.type == "category"))
    {
        try
        {
            await SyncCategoryNameAsync(item);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to sync category {id}", item.id);
            await WriteFailedChangeAsync(item, ex);
        }
    }
}
```

An unhandled exception fails the function invocation. The Azure Cosmos DB trigger supports function-level retry policies, but no retry policy is configured by default. Configure a retry policy for transient failures and make processing idempotent because a retry can deliver the complete batch again.

If you catch errors separately for each item, don’t only log them. Persist the failed change and error details to a durable error store before the invocation succeeds, as shown in the C# example. Otherwise, the trigger can checkpoint the batch and the failed change isn’t processed again.

::: zone-end

::: zone pivot="python"

In the Python v2 programming model, the trigger is a decorator on the function. This decorator is the shortest route to a continuous consumer in Python, because it removes the polling loop and continuation-token handling that the pull model requires.

```python
import logging
import azure.functions as func

app = func.FunctionApp()

@app.function_name(name="SyncCategoryName")
@app.cosmos_db_trigger(
    arg_name="changes",
    database_name="%COSMOS_DATABASE_NAME%",
    container_name="%COSMOS_CONTAINER_NAME%",
    connection="COSMOS_CONNECTION",
    lease_container_name="leases",
)
def sync_category_name(changes: func.DocumentList) -> None:
    for item in changes:
        if item["type"] != "category":
            continue
        try:
            sync_category(item)
        except Exception as error:
            logging.exception("Failed to sync category %s", item["id"])
            write_failed_change(item, error)
```

The per-item `try` block matters for the same reason it does in any language here: the trigger doesn't retry a batch after an unhandled exception by default, so an uncaught error can leave the remaining changes in that batch unprocessed. Configure a retry policy if you need failed invocations to retry.

::: zone-end

### Configure the connection

For an identity-based connection, the `connection` property names a prefix rather than a single setting. The runtime looks for settings that start with that prefix and assembles the connection from them, which is what lets the function authenticate with a managed identity instead of an account key.

| Setting | Value |
|:--------|:------|
| `COSMOS_CONNECTION__accountEndpoint` | `https://<account-name>.documents.azure.com:443/` |
| `COSMOS_CONNECTION__credential` | `managedidentity` |
| `COSMOS_CONNECTION__clientId` | Client ID of the user-assigned managed identity |

Assign the identity a data-plane role on the account so it can read the feed and write leases. Data-plane role assignments aren't available in the Azure portal; use `az cosmosdb sql role assignment create`.

Running locally, omit the credential settings entirely. `DefaultAzureCredential` falls back to your Azure CLI sign-in, so `az login` plus the endpoint setting in `local.settings.json` is enough.

## Create the lease container yourself

The trigger has a `CreateLeaseContainerIfNotExists` property, but using it can lead to time-consuming troubleshooting.

Creating a container is a control-plane operation, and data-plane role assignments don't grant control-plane permissions. A function that authenticates with a managed identity and has this property set to `true` fails to start, because it tries an operation its identity isn't allowed to perform. Create the lease container ahead of time with a `/id` partition key and leave the property at its default.

### Share a lease container across functions

Point two functions at the same monitored container and the same lease container without distinct prefixes, and they compete for the same leases. Each lease has one owner, so the functions divide the work instead of each receiving a complete, independent feed.

To run both independently, give each a distinct lease container prefix. The prefix is prepended to that function's lease documents, which keeps the two sets of positions independent inside one container. The alternative, a separate lease container per function, also works. Lease containers can use shared database throughput.

## Tune the trigger

Defaults are reasonable, and three settings are worth knowing when they aren't:

- **`FeedPollDelay`** sets the wait between polls once current changes are drained. The default is 5,000 milliseconds. Lower it for latency-sensitive work, at the cost of request units spent on empty polls.
- **`MaxItemsPerInvocation`** caps the batch size. Changes written by one stored procedure keep their transaction scope and arrive together, so a batch can exceed this value.
- **`StartFromBeginning`** reads the container's existing history on first run. Like every start-position setting, it applies only until leases exist.

In latest version mode, the trigger doesn't tell you whether a change was an insert or an update; it hands you the item. Latest version mode is the default and is available in every language. All versions and deletes mode includes operation-type metadata. This mode is available only in the .NET isolated worker model. It requires version 4.16.1 or later of the Azure Cosmos DB extension. It also requires the account configuration described earlier in this module.

## Choosing between a function and a hosted processor

The trigger is the better default. It removes the host, scales with the workload, and integrates with the other Azure Functions bindings, so a change can flow into a queue or a storage account without extra client code.

Reach for a self-hosted processor when you need something the trigger doesn't expose: Use this approach when you need lifecycle notifications for lease acquisition and release. You can also run the change feed estimator against your own leases. The self-hosted change feed processor supports all-versions-and-deletes mode in .NET and Java. Python and Node.js don’t provide the processor library; applications in those languages must use the pull model for all-versions-and-deletes mode. You can also run it with an existing long-running application.
