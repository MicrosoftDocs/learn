Copy loops can be powerful mechanism that enables you to create flexible and reusable Bicep templates. To use all loops advantages, it is important to understand how you can control loops execution and how you can use nested loops. In this unit, you will learn how to control execution of copy loops and how to use nested loops in Bicep.

## Controlling loop parallelism

When using copy loops, Resource Manager creates resources in parallel in non-deterministic order. When you created initial deployment in loops exercise in previous unit, both Azure SQL Servers were created in parallel. This optimizes deployment time as all resources in loop are being deployed at same time. In some cases however, you want to deploy resources in loop in sequence.

### Batch size decorator

In Bicep you can specify for your copy loops to be executed in sequence by using ```batchSize``` decorator. The decorator can be used on resource or module declaration where ```for``` keyword is used to declare copy loop. The decorator accepts one integer parameter with value equal or greater than 1.

When the decorator is specified the resources or modules part of the same declaration will be deployed sequentially in batches of the specified size. Each batch will be deployed concurrently. With serial mode, Resource Manager creates a dependency on earlier instances in the loop, so it doesn't start one batch until the previous batch completes. For purely sequential deployment, you set the batch size to 1.

The following example deploys 4 storage accounts 2 at a time:

```bicep
@batchSize(2)
resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-01-01' = [for i in range(0,4): {
  name: 'serialstorageaccount${i}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
```

## Nested loops

Some scenarios, such as deploying multiple child resources along with parent, require you to use loop inside another loop. Bicep supports nested loops.

### Nested loops example

In your toy company you need to deploy virtual networks in every country where toy will be launched. Every virtual network needs different address space and two subnets. In following example you can see how you could deploy required virtual networks using nested loops. This template would give you flexibility to add additional virtual networks and subnets in future.

Example below also demonstrates how you can create array property using a loop. In example ```subnets``` is a property of virtual network and it needs to be declared as an array. We use loop to create array with subnet configuration we need.

```bicep
param vnetLocations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

var numberOfSubnets = 2

resource vnets 'Microsoft.Network/virtualNetworks@2020-11-01' = [for (location, i) in vnetLocations : {
  name: 'vnet-${location}'
  location: location
  properties: {
    addressSpace:{
      addressPrefixes:[
        '10.${i}.0.0/16'
      ]

    }
    subnets: [for j in range(1, numberOfSubnets): {
      name: 'subnet-${j}'
      properties: {
        addressPrefix: '10.${i}.${j}.0/24'
      }
    }]
  }
}]
```

Note that in example above there are two loops. First loop deploys virtual networks by iteration through location values provided in parameter ```vnetLocations```. Second loop is nested inside first loop and deploys required number of subnets in each virtual network as specified by variable ```numberOfSubnets```.
