resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup('aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e', 'networking-rg')
  name: 'toy-design-vnet'
}
