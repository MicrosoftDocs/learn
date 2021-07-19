resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageAccountName
}

resource functionApp 'Microsoft.Web/sites@2020-06-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    siteConfig: {
      appSettings: [
        // ...
        {
          name: 'StorageAccountKey'
          value: storageAccount.listKeys().keys[0].value
        }
      ]
    }
  }
}
