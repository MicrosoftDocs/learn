@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the storage account. This name must be globally unique.')
param storageAccountName string = 'stor2${uniqueString(resourceGroup().id)}'

var storageAccountSkuName = 'Standard_LRS'
var storageBlobDataContributorRoleId = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor.
var storageAccountContainerName = 'todo'
var managedIdentityName = 'todo'

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

    resource container 'containers' = {
      name: storageAccountContainerName
    }
  }
}

module managedIdentity 'todo-identity.bicep' = { // TODO use MCR address here
  name: 'managed-identity'
  params: {
    managedIdentityName: managedIdentityName
    roleDefinitionIds: [
      storageBlobDataContributorRoleId
    ]
  }
}
