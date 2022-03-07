resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}
