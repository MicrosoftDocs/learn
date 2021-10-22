@description('The Azure region into which the resources should be deployed.')
param location string

@description('The name of the App Service plan.')
param appServicePlanName string

@description('The SKU of the App Service plan.')
param appServicePlanSku object

@description('The name of the App Service app. This name must be globally unique.')
param appServiceAppName string

@description('The settings to configure on the App Service app.')
param appServiceAppSettings array

@description('The fully qualified resource ID of the user-assigned managed identity that should be assigned to the App Service app.')
param managedIdentityResourceId string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: appServicePlanSku
}

resource appServiceApp 'Microsoft.Web/sites@2018-11-01' = {
  name: appServiceAppName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentityResourceId}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: appServiceAppSettings
    }
  }
}

output appServiceAppDefaultHostName string = appServiceApp.properties.defaultHostName
