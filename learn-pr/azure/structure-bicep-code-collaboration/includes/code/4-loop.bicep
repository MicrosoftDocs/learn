param cosmosDBAccountName string = 'toywebsite-${uniqueString(resourceGroup().id)}'
param cosmosDBDatabaseThroughput int = 400
param location string = resourceGroup().location

var cosmosDBDatabaseName = 'Website'

var cosmosDBContainerDefinitions = [
  {
    name: 'customers'
    partitionKey: '/customerId'
  }
  {
    name: 'orders'
    partitionKey: '/orderId'
  }
  {
    name: 'products'
    partitionKey: '/productId'
  }
]

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-04-01' = {
  parent: cosmosDBAccount
  name: cosmosDBDatabaseName
  properties: {
    resource: {
      id: cosmosDBDatabaseName
    }
    options: {
      throughput: cosmosDBDatabaseThroughput
    }
  }
}

resource cosmosDBContainers 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2020-04-01' = [for cosmosDBContainerDefinition in cosmosDBContainerDefinitions: {
  parent: cosmosDBDatabase
  name: cosmosDBContainerDefinition.name
  properties: {
    resource: {
      id: cosmosDBContainerDefinition.name
      partitionKey: {
        kind: 'Hash'
        paths: [
          cosmosDBContainerDefinition.partitionKey
        ]
      }
    }
    options: {}
  }
}]
