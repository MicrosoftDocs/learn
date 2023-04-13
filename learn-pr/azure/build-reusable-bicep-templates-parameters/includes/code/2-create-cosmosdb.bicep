resource account 'Microsoft.DocumentDB/databaseAccounts@2022-08-15' = {
  name: accountName
  location: location
  properties: {
    locations: cosmosDBAccountLocations
  }
}
