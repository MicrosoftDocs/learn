Extension resources are always attached to other Azure resources. They *extend* the behavior of those resources with extra functionality. 

Some examples of common extension resources are:

| Name                | Resource type                               |
|---------------------|---------------------------------------------|
| Role assignments    | `Microsoft.Authorization/roleAssignments`   |
| Policy assignments  | `Microsoft.Authorization/policyAssignments` |
| Locks               | `Microsoft.Authorization/locks`             |
| Diagnostic settings | `Microsoft.Insights/diagnosticSettings`     |
| | |

For example, consider a lock, which can be used to prevent the deletion or modification of an Azure resource. It doesn't make sense to deploy a lock by itself. It always has to be deployed onto another resource.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## How are extension resources defined?

In Bicep, you mostly define an extension resource in the same way as you define a normal resource. However, you add the `scope` property to inform Bicep that the resource should be attached to another resource that's defined elsewhere in the Bicep file. You use the resource's symbolic name to refer to it. For example, here's the definition of an Azure Cosmos DB account that you created previously:

```bicep
resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    // ...
  }
}
```

You can add a resource lock, which prevents anybody from deleting the Azure Cosmos DB account:

:::code language="bicep" source="code/5-scope.bicep" highlight="2":::

Notice that the example uses the `scope` property with the Azure Cosmos DB account's symbolic name. This property setting informs Bicep to deploy the resource lock onto the Azure Cosmos DB account, so the account can no longer be deleted.

## Extension resource IDs

An ID for an extension resource is slightly different from IDs for other resources. It consists of its parent resource ID, the separator `/providers/`, and the extension resource ID.

Say you deployed the previously mentioned Azure Cosmos DB account, and the account was named `toyrnd`. Here's what the lock's resource ID would look like:

```
/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd/providers/Microsoft.Authorization/locks/DontDelete
```

Here's a visual representation:

:::image type="content" source="../media/5-extension-resource-id.png" alt-text="Diagram that shows an extension resource ID for a resource lock that's applied to an Azure Cosmos DB account. Each element of the ID appears on a separate line." border="false":::

If you see a resource ID that starts with a normal resource ID and then includes `/providers/` and another resource type and name, you're looking at an extension resource ID.
