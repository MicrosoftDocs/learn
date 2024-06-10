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
@description('The name of the Application Insights instance.')
var applicationInsightsName = 'appinsights-deposits'

@description('The name of the app service plan.')
var appServicePlanName = 'plan-deposits'

@description('The name of the Log Analytics Workspace.')
var logAnalyticsWorkspaceName = 'log-deposits'

// Resource - App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

// Resource - Web App
resource webApplication 'Microsoft.Web/sites@2023-12-01' = {
  name: webApplicationName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }     
      ]
    }    
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

// Resource - Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Resource - Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
