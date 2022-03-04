/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/

// parameters
@description('Location For All Resources.')
param location string = resourceGroup().location

@allowed([
  'prod' // Production environment
  'dev' // Development environment
  'test' // Test environment
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

// variables
var appServicePlanName = 'plan-${environment}-001'

// Resource - App Service Plan 
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku // Specifies the SKU of the App Service Plan. 
    capacity: appServicePlanInstanceCount
  }
  kind: 'app' // Specifies a Windows App service Plan.
}

output appServicePlanId string = appServicePlan.id // Outputs the resource Id of the App Service Plan.
