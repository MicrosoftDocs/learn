resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: 'toydesigndocs'
}

resource lockResource 'Microsoft.Authorization/locks@2020-05-01' = {
  scope: storageAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy design documents storage account.'
  }
}
