targetScope = 'subscription'

module networkModule 'modules/network.bicep' = {
  scope: resourceGroup('Networking')
  name: 'networkModule'
}
