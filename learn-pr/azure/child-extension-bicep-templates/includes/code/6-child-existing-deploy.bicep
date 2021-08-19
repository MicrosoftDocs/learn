resource server 'Microsoft.Sql/servers@2020-11-01-preview' existing = {
  name: serverName
}

resource database 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: server
  name: databaseName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
