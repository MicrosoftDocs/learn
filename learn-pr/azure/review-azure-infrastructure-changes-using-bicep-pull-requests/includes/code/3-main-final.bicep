@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the App Service app to deploy. This name must be globally unique.')
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@description('The name of the storage account to deploy. This name must be globally unique.')
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@description('The type of the environment. This must be nonprod or prod.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var processOrderQueueName = 'processorder'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }

  resource queueServices 'queueServices' existing = {
    name: 'default'

    resource processOrderQueue 'queues' = {
      name: processOrderQueueName
    }
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    storageAccountName: storageAccount.name
    processOrderQueueName: storageAccount::queueServices::processOrderQueue.name
    environmentType: environmentType
  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
