There may be times when you wish to write your own logic to resolve conflicts between items. This can be accomplished by using a Custom conflict resolution policy.

A custom resolution policy will use a stored procedure to resolve conflicts between items in different regions. All custom stored procedures must be implemented with the following JavaScript function signature.

```javascript
function <function-name>(incomingItem, existingItem, isTombstone, conflictingItems)
```

Each of these four parameters is required in the function:

| **Parameter** | **Description** |
| --- | :--- |
| **existingItem** | The item that is already committed |
| **incomingItem** | The item that's being inserted or updated that generated the conflict |
| **isTombstone** | Boolean indicating if the incoming item was previously deleted |
| **conflictingItems** | Array of all committed items in the container that conflicts with incomingItem |

An example implementation of a stored procedure to resolve conflict by using the **/metadata/sortableTimestamp** would include the following code.

```javascript
function resolveConflicts(incomingItem, existingItem, isTombstone, conflictingItems) {
  if (!incomingItem) {
    if (existingItem) {
      __.deleteDocument(existingItem._self, {});
    }
  } else if (isTombstone) {
  } else {
    if (existingItem) {
      if (incomingItem.metadata.sortableTimestamp > existingItem.metadata.sortableTimestamp) {
        return;
      }
    }
    var i;
    for (i = 0; i < conflictingItems.length; i++) {
      if (incomingItem.metadata.sortableTimestamp > conflictingItems[i].metadata.sortableTimestamp) {
        return;
      }
    }
    delete (conflictingItems, incomingItem, existingItem);
  }

  function delete (documents, incoming, existing) {
    if (documents.length > 0) {
      __.deleteDocument(documents[0]._self, {}, function (err, responseOptions) {
        documents.shift();
        delete (documents, incoming, existing);
      });
    } else if (existing) {
      __.replaceDocument(existing._self, incoming);
    } else {
      __.createDocument(collection.getSelfLink(), incoming);
    }
  }
}
```

You can use the .NET SDK for Azure Cosmos DB SQL API to configure the custom conflict resolution policy. To start this example, a container named **products** will be created with a custom conflict resolution policy.

```csharp
string databaseName = "cosmicworks";
string containerName = "products";
string partitionKey = "/categoryId";
string sprocName = "resolveConflicts";

Database database = client.GetDatabase(databaseName);

ContainerProperties properties = new(containerName, partitionKey)
{
    ConflictResolutionPolicy = new ConflictResolutionPolicy()
    {
        Mode = ConflictResolutionMode.Custom,
        ResolutionProcedure = $"dbs/{databaseName}/colls/{containerName}/sprocs/{sprocName}",
    }
};

Container container = database.CreateContainerIfNotExistsAsync(properties);
```

Finally, a stored procedure named **resolveConflicts** is created to support the conflict resolution policy.

```csharp
StoredProcedureProperties properties = new (sprocName, File.ReadAllText(@"code.js"))

await container.Scripts.CreateStoredProcedureAsync(properties);
```

Alternatively, a custom conflict resolution policy can be configured without a stored procedure. In this scenario, conflicts are written to a conflicts feed. Your application code can then manually resolve conflicts in the feed.

Using .NET you can configure a container for manual conflict resolution using this code sample.

```csharp
Database database = client.GetDatabase("cosmicworks");

ContainerProperties properties = new("products", "/categoryId")
{
    ConflictResolutionPolicy = new ConflictResolutionPolicy()
    {
        Mode = ConflictResolutionMode.Custom
    }
};

Container container = database.CreateContainerIfNotExistsAsync(properties);
```
