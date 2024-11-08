param location string = resourceGroup().location
param storageAccountName string = 'sa${uniqueString(resourceGroup().id)}'
param storageAccountSkuName string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  tags: {
    CostCenter: 'Marketing'
    DataClassification: 'Public'
    Owner: 'WebsiteTeam'
    Environment: 'Production'
  }
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
