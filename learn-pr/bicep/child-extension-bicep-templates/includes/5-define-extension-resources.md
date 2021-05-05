Extension resources are always attached to other Azure resources. They _extend_ the behavior of those resources with extra functionality. Some examples of common extension resources are:

| Name                | Resource type                               |
|---------------------|---------------------------------------------|
| Role assignments    | `Microsoft.Authorization/roleAssignments`   |
| Policy assignments  | `Microsoft.Authorization/policyAssignments` |
| Locks               | `Microsoft.Authorization/locks`             |
| Diagnostic settings | `Microsoft.Insights/diagnosticSettings`     |

For example, consider a lock, which can be used to prevent the deletion or modification of an Azure resource. It doesn't make sense to deploy a lock by itself - it always has to be deployed onto another resource.

## How are extension resources defined?

In Bicep, you define an extension resource in mostly the same way as a normal resource. However, you add the `scope` property to tell Bicep that the resource should be attached to another resource that's defined elsewhere in the Bicep file. You use the resource's symbolic name to refer to it. For example, here's the definition of a Cosmos DB account that we've previously created:

```bicep
resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    // ...
  }
}
```

Let's add a resource lock, which will stop anybody deleting the Cosmos DB account:

:::code language="plaintext" source="code/5-scope.bicep" highlight="2":::

Notice that the example uses the `scope` property with the Cosmos DB account's symbolic name. This tells Bicep to deploy the resource lock onto the Cosmos DB account, which means it can no longer be deleted.

## Extension resource IDs

An extension resource has a slightly different ID than other resources. It consists of its parent resource's ID, the separator `/providers/`, and then the extension resource's ID.

Let's say you deployed the Cosmos DB account above, and the account was named `toyrnd`. Here's what the lock's resource ID would look like:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd/providers/Microsoft.Authorization/locks/DontDelete
```

Here's a visual representation:

:::image type="content" source="../media/5-extension-resource-id.png" alt-text="Extension resource ID for a resource lock applied to a Cosmos DB account, split with key/value pair on a separate line." border="false":::

If you see a resource ID that start with a normal resource ID, then has `/providers/` and another resource type and name, it means you're looking at an extension resource ID.
