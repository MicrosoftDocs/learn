@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The type of environment. This must be nonprod or prod.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var appServiceAppName = 'toy-website-${resourceNameSuffix}'
var appServicePlanName = 'toy-website-plan'
var toyManualsStorageAccountName = 'toyweb${resourceNameSuffix}'

// Define the SKUs for each component based on the environment type.
var environmentConfigurationMap = {
  nonprod: {
    appServicePlan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
    toyManualsStorageAccount: {
      sku: {
        name: 'Standard_LRS'
      }
    }
  }
  prod: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 2
      }
    }
    toyManualsStorageAccount: {
      sku: {
        name: 'Standard_ZRS'
      }
    }
  }
}

var toyManualsStorageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${toyManualsStorageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${toyManualsStorageAccount.listKeys().keys[0].value}'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'ToyManualsStorageAccountConnectionString'
          value: toyManualsStorageAccountConnectionString
        }
      ]
    }
  }
}

resource toyManualsStorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: toyManualsStorageAccountName
  location: location
  kind: 'StorageV2'
  sku: environmentConfigurationMap[environmentType].toyManualsStorageAccount.sku
}
