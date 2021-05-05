resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: 'toydesigndocs'
}

resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  scope: storageAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy design documents storage account.'
  }
}
