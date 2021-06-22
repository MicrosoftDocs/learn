param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'

var templateSpecName = 'StorageWithoutSAS'
var templateSpecVersion = '1.0'

resource templateSpec 'Microsoft.Resources/templateSpecs@2019-06-01-preview' existing = {
  name: templateSpecName

  resource version 'versions' existing = {
    name: templateSpecVersion
  }
}

resource storageAccountTemplateSpec 'Microsoft.Resources/deployments@2021-01-01' = {
  name: 'storageAccountTemplateSpec'
  properties: {
    mode: 'Incremental'
    templateLink: {
      id: templateSpec::version.id
    }
    parameters: {
      storageAccountName: {
        value: storageAccountName
      }
    }
  }
}
