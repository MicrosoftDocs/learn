@description('TODO')
param location string

@description('TODO')
param storageAccountName string

@description('TODO')
param storageAccountSkuName string

@description('TODO')
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

@description('TODO')
output storageAccountName string = storageAccount.name
