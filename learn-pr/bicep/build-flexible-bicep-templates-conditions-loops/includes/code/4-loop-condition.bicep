param sqlServers array = [
  {
    name: 'sqlserver-we'
    location: 'westeurope'
    environment: 'Production'
  }
  {
    name: 'sqlserver-eus2'
    location: 'eastus2'
    environment: 'Development'
  }
  {
    name: 'sqlserver-eas'
    location: 'eastasia'
    environment: 'Production'
  }
]

resource sqlServerResources 'Microsoft.Sql/servers@2020-11-01-preview' = [for sqlServer in sqlServers: if (sqlServer.environment == 'Production') {
  name: sqlServer.name
  location: sqlServer.location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  tags:{
    environment: sqlServer.environment
  }
}]
