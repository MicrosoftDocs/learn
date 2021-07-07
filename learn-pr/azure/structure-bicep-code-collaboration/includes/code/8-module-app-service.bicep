@description('The location into which your Azure resources should be deployed.')
param location string

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string

@secure()
@description('The connection string to use to access the Azure SQL database.')
param sqlDatabaseConnectionString string

@description('The SKU to use for the App Service plan.')
param appServicePlanSku object

@description('The tags to apply to each resource.')
param tags object

// Define the names for resources.
var appServiceAppName = 'webSite${resourceNameSuffix}'
var appServicePlanName = 'AppServicePLan'
var managedIdentityName = 'WebSite'
var applicationInsightsName = 'AppInsights'

var contributorRoleDefinitionId = 'b24988ac-6180-42a0-ab88-20f7382dd24c' // This is the built-in Azure 'Contributor' role.

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: appServicePlanSku
  tags: tags
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  tags: tags
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

// A user-assigned managed identity that is used by the App Service app to communicate with a storage account.
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
  tags: tags
}

// Grant the 'Contributor' role to the user-assigned managed identity, at the scope of the resource group.
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(contributorRoleDefinitionId, resourceGroup().id) // Create a GUID based on the role definition ID and scope (resource group ID). This will return the same GUID every time the template is deployed to the same resource group.
  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', contributorRoleDefinitionId)
    principalId: managedIdentity.properties.principalId
    description: 'Grant the "Contributor" role to the user-assigned managed identity so it can access the storage account.'
  }
}

resource applicationInsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  tags: tags
  properties: {
    Application_Type: 'web'
  }
}
