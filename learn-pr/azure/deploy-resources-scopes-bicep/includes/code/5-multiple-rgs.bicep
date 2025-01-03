module networkModule 'modules/network.bicep' = {
  scope: resourceGroup('ToyNetworking')
  name: 'networkModule'
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: 'production-nic'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'toy-subnet-ip-configuration'
        properties: {
          subnet: {
            id: networkModule.outputs.subnetResourceId
          }
        }
      }
    ]
  }
}
