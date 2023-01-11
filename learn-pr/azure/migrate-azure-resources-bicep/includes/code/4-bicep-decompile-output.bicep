@description('Location for resources.')
param location string = resourceGroup().location

@allowed([
  'prod'
  'dev'
  'test'
])
@description('The list of allowed environment names.')
param environment string = 'prod'

@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
@description('The list of allowed App Service Plan SKUs.')
param appServicePlanSku string = 'P1v3'

@minValue(1)
@maxValue(10)
@description('The number of allowed App Service Plan instances.')
param appServicePlanInstanceCount int = 1

var appServicePlanName_var = 'plan-${environment}-001'

resource appServicePlanName 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName_var
  location: location
  sku: {
    name: appServicePlanSku
    capacity: appServicePlanInstanceCount
  }
  kind: 'app'
  properties: {}
}

output appServicePlanId string = appServicePlanName.id
