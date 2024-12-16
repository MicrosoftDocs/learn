param virtualNetworkName string
param virtualNetworkAddressPrefix string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: virtualNetworkName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkAddressPrefix
      ]
    }
  }
}
