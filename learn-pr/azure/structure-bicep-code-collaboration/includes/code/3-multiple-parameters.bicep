param appServicePlanSkuName string
param appServicePlanSkuCapacity int
param storageAccountSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    capacity: appServicePlanSkuCapacity
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountSkuName
  location: location
  sku: {
    name: storageAccountSkuName
  }
}
