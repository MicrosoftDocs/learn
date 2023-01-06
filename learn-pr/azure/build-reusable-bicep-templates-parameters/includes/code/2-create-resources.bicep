resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: resourceTags
  sku: {
    name: 'S1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@' = {
  name: appServiceAppName
  location: location
  tags: resourceTags
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
  }
}
