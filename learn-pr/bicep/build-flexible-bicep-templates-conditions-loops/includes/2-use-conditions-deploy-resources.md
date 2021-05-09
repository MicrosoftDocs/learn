Conditions can be used in Bicep templates to deploy resources optionally.

In your toy company, you need to deploy resources to different environments. When deploying to production environment, you need to make sure that auditing is enabled for SQL Servers. When deploying to development environment, you want auditing disabled as it is not required. You want to use single template to deploy to different types of environment.

In this unit, you'll learn how to use conditions to optionally deploy resources.

## Deploy condition

When you deploy resource in Bicep, you can provide ```if``` keyword followed by condition that should resolve to true or false value. When the value is true the resource is deployed, when the value is false, the resource is not deployed. Commonly, you evaluate condition against parameter value you provided. The following example deploys storage account based on parameter value.

```bicep
param deployStorageAccount bool

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = if (deployStorageAccount) {
  name: 'storageAccount123'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name:'Standard_LRS'
  }
}
```

### Condition evaluation

In the example above we used simple evaluation as the parameter evaluated in condition was of type ```bool```, therefore it has a value of true or false.

In Bicep you are also able to use complex expressions as condition evaluation. You can use Template functions as part of evaluation. The following example uses ```==``` binary operator in condition to validate that value of parameter matches required value.

```bicep
@allowed([
  'Development'
  'Production'
])
param environment string

resource sqlDBAudit 'Microsoft.Sql/servers/auditingSettings@2020-11-01-preview' = if (environment == 'Production') {
  name: '${server.name}/default'
  properties: {
    state: 'Enabled'
    storageEndpoint: ((environment == 'Production') ? (reference(auditStorage.id, auditStorage.apiVersion).primaryEndpoints.blob):'')
    storageAccountAccessKey: ((environment == 'Production') ? (listKeys(auditStorage.id, auditStorage.apiVersion).keys[0].value):'')
  }
}
```

In the example above, the SQL server auditing settings resource will only be deployed when parameter provided at deployment time would have value ```Production```. In the example above this is implemented using ``` if(environment == 'Production')``` condition.

You can use dependency with conditional resources as you would use it with resources without dependencies. When a conditional resource isn't deployed, Azure Resource Manager automatically removes it from the required dependencies.

In above example you can observe that conditions can be used when specifying values for properties. In statement ```storageEndpoint: ((environment == 'Production') ? (reference(auditStorage.id, auditStorage.apiVersion).primaryEndpoints.blob):'')``` reference to storage account Blob primary endpoint would be used for ```storageEndpoint``` property when condition ```environment == 'Production'``` would return ```true``` value, otherwise empty value ```''``` will be used.

> [!TIP]
> When conditionally deploying resources, make sure that whenever you are referencing conditional resource from other places in template you only use reference when resource will be deployed, otherwise don't reference resource. If you try to reference conditional resource that will not be deployed from any place in template, deployment will fail. See example above to see how this can be implemented in Bicep with conditions when specifying value for resource properties.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->