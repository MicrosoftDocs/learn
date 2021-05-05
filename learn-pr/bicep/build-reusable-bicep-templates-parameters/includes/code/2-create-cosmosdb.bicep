resource account 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: accountName
  location: location
  properties: {
    locations: cosmosDBAccountLocations
  }
}
