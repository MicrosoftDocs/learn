// Parameters
@description('The location for all resources.')
param location string = 'eastus'

@description('The name of the SQL database.')
param sqlDatabaseName string = 'sqldb-${uniqueString(resourceGroup().id)}'

@description('The password of the admin user.')
param sqlServerAdminUserName string

@description('The name of the admin user.')
@secure()
param sqlServerAdminPassword string

@description('The name of the SQL server.')
param sqlServerName string = 'sql-${uniqueString(resourceGroup().id)}'

@description('The name of the web application.')
param webApplicationName string = 'webapp-${uniqueString(resourceGroup().id)}'

// Variables
@description('The name of the app service plan.')
var appServicePlanName = 'plan-deposits'

// Resource - App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// Resource - Web App
resource webApplication 'Microsoft.Web/sites@2023-12-01' = {
  name: webApplicationName
  location: location
  properties: {
    serverFarmId: appServicePlan.id  
  }
}

// Resource - SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' ={
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdminUserName
    administratorLoginPassword: sqlServerAdminPassword
  }
}

// Resource - SQL Database
resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
