param deployStorageAccount bool

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = if (deployStorageAccount) {
  name: 'teddybearstorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  // ...
}
