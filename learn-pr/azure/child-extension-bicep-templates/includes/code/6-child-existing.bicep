resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}
