@description('The Azure region into which the resources should be deployed.')
param location string

@description('The name of the storage account. This name must be globally unique.')
param storageAccountName string

@description('The SKU of the storage account.')
param storageAccountSkuName string

@description('The list of blob container names.')
param storageAccountContainerNames array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSkuName
  }
  properties: {
    supportsHttpsTrafficOnly: true
    allowSharedKeyAccess: false
  }

  resource blobService 'blobServices' existing = {
    name: 'default'
  }
}

resource blobContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = [for storageAccountContainerName in storageAccountContainerNames: {
  parent: storageAccount::blobService  
  name: storageAccountContainerName
}]

@description('The name of the storage account.')
output storageAccountName string = storageAccount.name
