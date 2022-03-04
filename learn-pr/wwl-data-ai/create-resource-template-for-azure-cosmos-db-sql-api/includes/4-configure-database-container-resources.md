Each template resource uses the same resource type and version between both Azure Resource Manager and Bicep templates. If you learn how to build it in one language, you can easily learn it in the other.

> [!NOTE]
> A Bicep template does not require any "empty" template syntax. You can begin writing your definitions in a blank file.

## Account resource

The **Microsoft.DocumentDB/databaseAccounts** resource in Bicep must contain the same minimal properties as in an Azure Resource Manager template.

Here is an example of an account that has a unique name with a prefix of **csmsarm** and is deployed to **West US**.

```bicep
resource Account 'Microsoft.DocumentDB/databaseAccounts@2021-05-15' = {
  name: 'csmsbicep${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: 'westus'
      }
    ]
  }
}
```

> [!TIP]
> If this resource already exists from a previous deployment, the Azure Resource Manager will just skip the resource and move on to the next. This is very handy when building a template incrementally.

## Database resource

This example of a **Microsoft.DocumentDB/databaseAccounts/sqlDatabases** resource configures a database resource, a slight difference then the JSON template reviewed in a previous unit.

Bicep also requires resources to define a **parent** property defining relationships as opposed to the verbose **dependsOn** property.

```bicep
resource Database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-05-15' = {
  parent: Account
  name: 'cosmicworks'
  properties: {
    options: {
      
    }
    resource: {
      id: 'cosmicworks'
    }
  }
}
```

## Container resource

This **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** resource is similar to the JSON equivalent, except it defines a throughput property at this level.

```bicep
resource Container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-05-15' = {
  parent: Database
  name: 'customers'
  properties: {
    resource: {
      id: 'customers'
      partitionKey: {
        paths: [
          '/regionId'
        ]
      }
    }
  }
}
```

## Final template

Now that all resources are in place, the template file should now contain the following code.

```bicep
resource Account 'Microsoft.DocumentDB/databaseAccounts@2021-05-15' = {
  name: 'csmsbicep${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: 'westus'
      }
    ]
  }
}

resource Database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-05-15' = {
  parent: Account
  name: 'cosmicworks'
  properties: {
    options: {
      
    }
    resource: {
      id: 'cosmicworks'
    }
  }
}

resource Container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-05-15' = {
  parent: Database
  name: 'customers'
  properties: {
    resource: {
      id: 'customers'
      partitionKey: {
        paths: [
          '/regionId'
        ]
      }
    }
  }
}
```
