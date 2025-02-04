resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}
