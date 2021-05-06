module networkModule 'modules/network.bicep' = {
  scope: resourceGroup('Networking')
  name: 'networkModule'
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'production-nic'
  properties: {
    // ...
  }
}
