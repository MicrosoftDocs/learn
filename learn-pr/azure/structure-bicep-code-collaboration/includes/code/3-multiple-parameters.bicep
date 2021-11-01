param appServicePlanSkuName string
param appServicePlanSkuCapacity int
param storageAccountSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    capacity: appServicePlanSkuCapacity
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountSkuName
  location: location
  sku: {
    name: storageAccountSkuName
  }
}
