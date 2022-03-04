Out of the box, Azure Cosmos DB’s multi-region write feature has automatic conflict management built in. Conflicts can occur when clients concurrently update the same item in multiple regions. There are three types of conflicts:

| **Type** | **Description** |
| ---: | :--- |
| **Insert** | This conflict occurs when more than one item is inserted simultaneously with the same unique identifier in multiple regions |
| **Replace** | Replace conflicts occur when multiple client applications update the same item concurrently in separate regions |
| **Delete** | Delete conflicts occurs when a client is attempting to update an item that has been deleted in another region at the same time |

The default conflict resolution policy in Azure Cosmos DB is **Last Write Wins**. This policy uses the timestamp (_ts) to determine which item wrote last. In simple terms, if multiple items are in conflict, the item with the largest value for the **_ts** property will win. In the case of a delete conflict, the operation to delete an item will always win out over other operations.

While the **_ts** property is the default for the Last Write Wins policy, you can configure any numeric property for this policy by configuring a *conflict resolution path*. You can use the .NET SDK for Azure Cosmos DB SQL API to configure the custom conflict resolution path.

In this example, a new container named **products** is created with a custom conflict resolution path of **/metadata/sortableTimestamp**.

```csharp
Database database = client.GetDatabase("cosmicworks");

ContainerProperties properties = new("products", "/categoryId")
{
    ConflictResolutionPolicy = new ConflictResolutionPolicy()
    {
        Mode = ConflictResolutionMode.LastWriterWins,
        ResolutionPath = "/metadata/sortableTimestamp",
    }
};

Container container = database.CreateContainerIfNotExistsAsync(properties);
```

> [!NOTE]
> You can only set a conflict resolution policy on newly created containers.
