resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}
