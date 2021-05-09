@allowed([
  'Development'
  'Production'
])
param environmentName string
param location string = resourceGroup().location
param auditStorageAccountName string = 'toyaudit${uniqueString(resourceGroup().id)}'

var storageAccountSkuName = 'Standard_LRS'

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (environmentName == 'Production') {
  name: auditStorageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
}

resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2020-11-01-preview' = if (environmentName == 'Production') {
  parent: server
  name: 'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
    storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion).keys[0].value : ''
  }
}
