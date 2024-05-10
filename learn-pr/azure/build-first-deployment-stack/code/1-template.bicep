// Parameters
@description('The name of the app service plan.')
param appServicePlanName string = 'plan-deposits'

@description('The location for all resources.')
param location string = 'eastus'

@description('The name of the web application')
param webApplicationName string = 'webapp-${uniqueString(resourceGroup().id)}'

// Resource - App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// Resource - Web App
resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: webApplicationName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
