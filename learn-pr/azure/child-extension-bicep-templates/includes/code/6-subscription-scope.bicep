resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('f0750bbe-ea75-4ae5-b24d-a92ca601da2c', 'networking-rg')
  name: 'toy-design-vnet'
}
