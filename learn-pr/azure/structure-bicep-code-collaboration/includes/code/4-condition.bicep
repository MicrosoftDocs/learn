@description('The location into which your Azure resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the Cosmos DB account.')
param cosmosDBAccountName string = 'toywebsite-${uniqueString(resourceGroup().id)}'

@description('Select the type of environment you want to provision. Allowed values are Production and Test.')
@allowed([
  'Production'
  'Test'
])
param environmentType string

var logAnalyticsWorkspaceName = 'toywebsite'
var cosmosDBAccountDiagnosticSettingsName = 'route-logs-to-log-analytics'

var environmentConfigurationMap = {
  Production: {
    enableLogging: true
  }
  Test: {
    enableLogging: false
  }
}

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = if (environmentConfigurationMap[environmentType].enableLogging) {
  name: logAnalyticsWorkspaceName
  location: location
}

resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = if (environmentConfigurationMap[environmentType].enableLogging) {
  scope: cosmosDBAccount
  name: cosmosDBAccountDiagnosticSettingsName
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    // ...
  }
}
