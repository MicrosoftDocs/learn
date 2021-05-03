@description('The name of the environment to deploy. This must be dev, test, or prod.')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string = 'dev'

@description('The unique name of the solution to deploy. This is used to ensure that resource names are unique.')
@minLength(5)
@maxLength(30)
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

@description('The number of App Service plan instances to deploy.')
@minValue(2)
@maxValue(10)
param appServicePlanInstanceCount int = 2

@description('The location (Azure region) into which the resources should be deployed.')
param location string = resourceGroup().location

@secure()
@description('SQL admin login name')
param sqlServerAdministratorLogin string

@secure()
@description('SQL admin login password')
param sqlServerAdministratorPassword string
    
var appServicePlanName = '${environmentName}-${solutionName}-plan'
var appServiceAppName = '${environmentName}-${solutionName}-app'
var appServicePlanSkuName = 'F1'
var appServicePlanSkuTier = 'Free'
var sqlServerName = '${environmentName}-${solutionName}-sql'
var sqlDatabaseName = 'Employees'
var sqlDatabaseSkuName = 'Standard'
var sqlDatabaseSkuTier = 'Standard'

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: appServicePlanSkuTier
    capacity: appServicePlanInstanceCount
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: sqlDatabaseSkuName
    tier: sqlDatabaseSkuTier
  }
}
