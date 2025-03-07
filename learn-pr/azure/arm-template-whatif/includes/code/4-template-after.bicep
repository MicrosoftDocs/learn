param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-001'
  location: location
  tags: {
    CostCenter: '12345'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/15'
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: 'subnet002'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
