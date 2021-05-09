You learned how you can use copy loops to deploy multiple instances of resources. In Bicep, loops can be also used with variables and outputs.

In your toy company, you need to deploy virtual networks with same subnet configuration in multiple Azure regions. You expect that you will need to add additional subnets to your virtual networks in the future, so you want to have flexibility in your Bicep templates to modify subnet configuration. As you will also be deploying multiple storage accounts in your Azure environment, you need to provide  endpoint properties of each storage account as output.

In this unit, you'll learn how you can use loops with variables and outputs.


## Variable loops

Variable loops are useful mechanism when you need to create array of properties, which you will use within declaration of resources in Bicep templates. To create variable array, you use ```for``` keyword with variable declaration.

```bicep
var items = [for i in range(1, 5): 'item${i}']

output out array = items
```

Running example above would return an array with the following values:

```json
[
  "item1",
  "item2",
  "item3",
  "item4",
  "item5"
]
```

This example is simple demonstration how you define variables with loops. Typically, you would create more complex objects inside variable array that you could use within resource declaration. In example below, it's shown how you can use variable loops to create ```subnets``` property that is required when declaring virtual network resources in your Bicep templates.

```bicep
param subnetDefinitions array = [
  {
    name: 'frontend'
    iprange: '10.10.0.0/24'
  }
  {
    name: 'backend'
    iprange: '10.10.1.0/24'
  }
]

var subnets = [for subnet in subnetDefinitions: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.iprange
  }
}]

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet'
  location: resourceGroup().location
  properties:{
    addressSpace:{
      addressPrefixes:[
        '10.10.0.0/16'
      ]
    }
    subnets: subnets
  }
}
```

In the example above, you specified property ```subnets``` in virtual network declaration with variable, which was created by using variable loop.

> [!TIP]
> Variable loops can be useful when creating resources with multiple properties and you need flexibility in template to be able to define number of properties during deployment time. You can think of scenario where you need to create virtual machine with multiple data disks or create multiple firewall rules for Azure Firewall. Using variable loops you can make definition of such resources more flexible and reusable.

## Output loops

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
