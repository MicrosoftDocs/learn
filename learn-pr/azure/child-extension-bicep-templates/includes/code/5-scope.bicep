resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  scope: cosmosDBAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy data Cosmos DB account.'
  }
}
