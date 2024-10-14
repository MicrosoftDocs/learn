resource vnet 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}
