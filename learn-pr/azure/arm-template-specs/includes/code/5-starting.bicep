param location string = resourceGroup().location
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
