You've learned how you can use copy loops to deploy multiple instances of resources, and how to set the properties of a resource using loops. In Bicep, loops can be also used with variables and outputs.

In your toy company, you need to deploy virtual networks with the same subnet configuration across multiple Azure regions. You expect that you will need to add additional subnets to your virtual networks in the future, so you want to have flexibility in your Bicep templates to modify subnet configuration. Since you will also be deploying multiple storage accounts in your Azure environment, you need to provide the endpoints for each storage account as output so that your deployment pipelines can use this information.

In this unit, you'll learn how you can use loops with variables and outputs.

## Variable loops

Variable loops enable you to create an array, which you can use through your Bicep file. Like other loops, you use the `for` keyword to create a variable loop:

```bicep
var items = [for i in range(1, 5): 'item${i}']
```

The example above creates an array containing the values `item1`, `item2`, `item3`, `item4`, and `item5`.

Typically, you would use variable loops to create more complex objects that you could use within a resource declaration. Here's how you can use variable loops to create a `subnets` property:

::: code language="plaintext" source="code/7-loop-variable.bicep" highlight="13-18" :::

This example illustrates a good use for variable loops: turning a parameter that has simple, easy-to-understand values into a more complex object that corresponds to what the Azure resource needs to be defined. You can use variable loops to enable your parameters to just specify the key information that will change for each item in the list, and then you can use Bicep expressions or default values to set other properties.

## Output loops

<!-- TODO below -->

When you are creating templates where you want flexibility by specifying number of resources that you will need to deploy, you need same flexibility also when you need to provide information on deployed resources through template outputs. In such scenarios, you can use output loops.

You can create output loop by using ```for``` keyword within output declaration.

```bicep
var items = [
  'item1'
  'item2'
  'item3'
  'item4'
  'item5'
]

output out array = [for i in range(0, length(items)): items[i]]
```

Running example above would return an output with the following values:

```json
[
  "item1",
  "item2",
  "item3",
  "item4",
  "item5"
]
```

> [!NOTE]
   > Directly referencing a resource module or module collection is not currently supported in output loops. In order to loop outputs you need to apply an array indexer to the expression.

Typically you would use output loops when you need to provide properties for multiple instances of resources that you declared in your template. In case you'd be deploying multiple storage accounts and you need to provide some properties as output, you could use output loops as in example below.

```bicep
param regions array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

resource storageAccounts 'Microsoft.Storage/storageAccounts@2021-01-01' = [for region in regions: {
  name: take('toyloop${region}${uniqueString(resourceGroup().id)}', 24)
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

output storageInfo array = [for i in range(0, length(regions)): {
  blobEndpoint: storageAccounts[i].properties.primaryEndpoints.blob
  fileEndpoint: storageAccounts[i].properties.primaryEndpoints.file
}]
```

After deploying example above, you would get output with information on blob and file endpoints of all storage accounts, which would be deployed.
