Often you need to deploy multiple instances of resources. By adding copy loops to Bicep templates, you can avoid having to repeat multiple resource definitions for each instance and dynamically set number of instances to deploy.

For your toy company, you need to deploy backend infrastructure, including Azure SQL Server to support launch of new toy. Each country where toy is going to be available, needs to have a dedicated Azure SQL Server. Azure SQL Server needs to be physically located in same country or compliant Azure region to follow data protection laws. You want to use flexible Bicep template for deployment. Template should allow you to specify in which regions to deploy Azure SQL Servers using deployment parameters.

In this unit, you will learn how to deploy multiple instances of resources by using _copy loops_.

## Copy loop

When you define resource in Bicep template, you can use ```for``` keyword in the resource declaration, followed by iteration properties. Typically you would iterate over an array of objects to create multiple instances of resource. The following example deploys multiple storage accounts with their names specified as parameter values.

```bicep
param storageAccounts array = [
  'saauditus'
  'saauditeurope'
  'saauditapac'
]

resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-01-01' = [for storageName in storageAccounts: {
  name: storageName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
```

In example above, copy loop would iterate through each item in array. Result would be three storage accounts, each deployed with name specified by corresponding item in array.

> [!TIP]
> You can use copy loops on *resource* as well as on *module* declaration.

> [!NOTE]
   > Number of iterations in copy loop is limited to 800. Therefore you cannot iterate through array that has more than 800 elements when using copy loop.

## Resource iteration by index

In some situations, you may want to use index-based loop definition. To implement it in Bicep template, you can use ```range()``` function. To use index-based loop, you would use range function in the following way:

```bicep
resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-01-01' = [for i in range(0,3): {
  name: 'sa${i}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
```

As ```range(startIndex, count)``` function takes two parameters and returns an array of integers, above example would deploy three storage accounts with names ```sa0```, ```sa1``` and ```sa2```.

Bicep allows you to iterate through array resources and retrieve index of element in array while running copy loops. In example below you use array ```sqlLocations``` to define locations where you want to deploy Azure SQL Servers and you use index ```i``` to generate sequential name for each Azure SQL Server deployed. Note that index is zero based, so you add ```+1``` to index value when generating name. as you want SQL Server names to start with number one.

```bicep
param sqlLocations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

resource sqlServerResources 'Microsoft.Sql/servers@2020-11-01-preview' = [for (sqlLocation, i) in sqlLocations: {
  name: 'sqlserver-${i+1}'
  location: sqlLocation
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}]
```

## Filter iterations in loops

When building flexible Bicep templates, you may come in situation where you would want to use copy loops together with condition to deploy resource. Similarly as you added condition to deploy resources in previous Learn units, you can use condition with copy loops. You can do that by adding ```if``` keyword following loop declaration with ```for``` keyword. 

In following example, you use array of objects as parameter to define couple of SQL Server properties for deployment. You use condition inside copy loop to deploy only SQL Servers where ```environment``` property of object in array equals ```Production```.

```bicep
param sqlServers array = [
  {
    sqlname: 'sqlserver-we'
    location: 'westeurope'
    environment: 'Production'
  }
  {
    sqlname: 'sqlserver-eus2'
    location: 'eastus2'
    environment: 'Development'
  }
  {
    sqlname: 'sqlserver-eas'
    location: 'eastasia'
    environment: 'Production'
  }
]

resource sqlServerResources 'Microsoft.Sql/servers@2020-11-01-preview' = [for sqlserver in sqlServers: if (sqlserver.environment == 'Production') {
  name: sqlserver.sqlname
  location: sqlserver.location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  tags:{
    environment: sqlserver.environment
  }
}]
```

Above example would deploy SQL Servers named ```sqlserver-we``` and ```sqlserver-eas```, as only objects with those names in array have ```environment``` values matching ```Production```.
