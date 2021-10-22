@description('TODO')
param location string

@description('TODO')
param appServicePlanName string

@description('TODO')
param appServicePlanSku object

@description('TODO')
param appServiceAppName string

@description('TODO')
param appServiceAppSettings array

@description('TODO')
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
