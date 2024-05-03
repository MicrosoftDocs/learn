resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('A123b4567c-1234-1a2b-2b1a-1234abc12345', 'networking-rg')
  name: 'toy-design-vnet'
}
