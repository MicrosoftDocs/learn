resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-09-01' = [for i in range(1,4): {
  name: 'sa${i}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
