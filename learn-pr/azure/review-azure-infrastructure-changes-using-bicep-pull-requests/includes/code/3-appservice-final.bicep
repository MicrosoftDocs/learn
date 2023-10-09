@description('The Azure region into which the resources should be deployed.')
param location string

@description('The name of the App Service app to deploy. This name must be globally unique.')
param appServiceAppName string

@description('The name of the storage account to deploy. This name must be globally unique.')
param storageAccountName string

@description('The name of the queue to deploy for processing orders.')
param processOrderQueueName string

@description('The type of the environment. This must be nonprod or prod.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'StorageAccountName'
          value: storageAccountName
        }
        {
          name: 'ProcessOrderQueueName'
          value: processOrderQueueName
        }
      ]
    }
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
