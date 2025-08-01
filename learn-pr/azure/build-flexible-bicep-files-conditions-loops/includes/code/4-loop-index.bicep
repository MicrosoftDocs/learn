param locations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

resource sqlServers 'Microsoft.Sql/servers@2024-05-01-preview' = [for (location, i) in locations: {
  name: 'sqlserver-${i+1}'
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}]
