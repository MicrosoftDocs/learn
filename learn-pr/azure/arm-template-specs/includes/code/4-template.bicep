param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'

module storageAccountTemplateSpec 'ts:f0750bbe-ea75-4ae5-b24d-a92ca601da2c/sharedTemplates/StorageWithoutSAS:1.0' = {
  name: 'storageAccountTemplateSpec'
  params: {
    storageAccountName: storageAccountName
  }
}
