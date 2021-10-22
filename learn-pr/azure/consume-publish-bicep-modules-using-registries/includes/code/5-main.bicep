@description('TODO')
param location string = resourceGroup().location

@description('TODO')
param storageAccountName string = 'stor2${uniqueString(resourceGroup().id)}'

@description('TODO')
param appServiceAppName string = 'app${uniqueString(resourceGroup().id)}'

var appServicePlanName = 'todo-myplan'
var appServicePlanSku = {
  name: 'F1'
  capacity: 1
}
var storageAccountSkuName = 'Standard_LRS'
var storageBlobDataContributorRoleId = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor.
var storageAccountContainerName = 'todo'

module storageAccount 'br/ToyCompanyRegistry:storage:v1' = {
  name: 'storageAccount'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageAccountSkuName: storageAccountSkuName
    storageAccountContainerNames: [
      storageAccountContainerName
    ]
  }
}

module managedIdentity 'todo-identity.bicep' = {
  name: 'managedIdentity'
  params: {
    managedIdentityName: 'application-identity'
    roleDefinitionIds: [
      storageBlobDataContributorRoleId
    ]
  }
}

module app 'br/ToyCompanyRegistry:app:v1' = {
  name: 'app'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    appServicePlanSku: appServicePlanSku
    appServiceAppName: appServiceAppName
    appServiceAppSettings: [
      {
        name: 'ManagedIdentityClientId'
        value: managedIdentity.outputs.managedIdentityClientId
      }
      {
        name: 'StorageAccountName'
        value: storageAccount.outputs.storageAccountName
      }
      {
        name: 'StorageAccountContainerName'
        value: storageAccountContainerName
      }
    ]
    managedIdentityResourceId: managedIdentity.outputs.managedIdentityResourceId
  }
}
