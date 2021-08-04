targetScope = 'subscription'

module networkModule 'modules/network.bicep' = {
  scope: resourceGroup('ToyNetworking')
  name: 'networkModule'
}
