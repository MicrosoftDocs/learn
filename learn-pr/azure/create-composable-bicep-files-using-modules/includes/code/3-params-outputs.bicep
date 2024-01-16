@description('The name of the storage account to deploy.')
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }

  resource blobService 'blobServices' existing = {
    name: 'default'

    resource container 'containers' = {
      name: 'mycontainer'
    }
  }
}

@description('The fully qualified Azure resource ID of the blob container within the storage account.')
output blobContainerResourceId string = storageAccount::blobService::container.id
