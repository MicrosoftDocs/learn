param sqlServerDetails array = [
  {
    name: 'sqlserver-we'
    location: 'westeurope'
    environmentName: 'Production'
  }
  {
    name: 'sqlserver-eus2'
    location: 'eastus2'
    environmentName: 'Development'
  }
  {
    name: 'sqlserver-eas'
    location: 'eastasia'
    environmentName: 'Production'
  }
]

resource sqlServers 'Microsoft.Sql/servers@2021-11-01-preview' = [for sqlServer in sqlServerDetails: if (sqlServer.environmentName == 'Production') {
  name: sqlServer.name
  location: sqlServer.location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  tags: {
    environment: sqlServer.environmentName
  }
}]
