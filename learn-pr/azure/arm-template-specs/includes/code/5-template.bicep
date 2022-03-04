@description('The Azure region into which the Cosmos DB resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the Cosmos DB account. This name must be globally unique, and it must only include lowercase letters, numbers, and hyphens.')
@minLength(3)
@maxLength(44)
param cosmosDBAccountName string = 'toy-${uniqueString(resourceGroup().id)}'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: cosmosDBAccountName
  kind: 'GlobalDocumentDB'
  location: location
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    backupPolicy: {
      type: 'Continuous'
    }
  }
}
