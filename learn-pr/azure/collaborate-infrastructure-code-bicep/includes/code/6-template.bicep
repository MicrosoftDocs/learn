@description('The location into which your Azure resources should be deployed.')
param location string = resourceGroup().location

@description('Select the type of environment you want to provision. Allowed values are Production and Test.')
@allowed([
  'Production'
  'Test'
])
param environmentType string

@description('A unique suffix to add to resource names that need to be globally unique.')
param resourceNameSuffix string = uniqueString(resourceGroup().id)

@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

// Define the names for resources.
var appServiceAppName = 'webSite${resourceNameSuffix}'
var appServicePlanName = 'AppServicePLan'
var sqlServerName = 'sqlserver${uniqueString(resourceGroup().id)}'
var sqlDatabaseName = 'ToyCompanyWebsite'
var managedIdentityName = 'WebSite'
var applicationInsightsName = 'AppInsights'

// Define the SKUs for each component based on the environment type.
var environmentConfigurationMap = {
  Production: {
    appServicePlan: {
      name: 'S1'
      capacity: 2
    }
    sqlDatabase: {
      name: 'Standard'
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
    sqlDatabase: {
      sku: {
        name: 'Basic'
      }
    }
  }
}

var contributorRoleDefinitionId = 'b24988ac-6180-42a0-ab88-20f7382dd24c' // This is the built-in Azure 'Contributor' role.
var sqlDatabaseConnectionString = 'Data Source=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};User Id=${sqlServerAdministratorLogin}@${sqlServer.properties.fullyQualifiedDomainName};Password=${sqlServerAdministratorLoginPassword};'

resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
    version: '12.0'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: environmentConfigurationMap[environmentType].sqlDatabase.sku
}

resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2014-04-01' = {
  parent: sqlServer
  name: 'AllowAllWindowsAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {} // This format is required when working with user-assigned managed identities.
    }
  }
}

resource webSiteConnectionString 'Microsoft.Web/sites/config@2020-06-01' = {
  parent: appServiceApp
  name: 'connectionstrings'
  properties: {
    DefaultConnection: {
      value: sqlDatabaseConnectionString
      type: 'SQLAzure'
    }
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(contributorRoleDefinitionId, resourceGroup().id)

  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', contributorRoleDefinitionId)
    principalId: managedIdentity.properties.principalId
  }
}

resource applicationInsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
