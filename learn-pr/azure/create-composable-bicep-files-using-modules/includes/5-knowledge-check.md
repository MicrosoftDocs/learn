Consider the following two Bicep files.

*main.bicep*:

```bicep
module storage1 'modules/stor.bicep' = {
  name: 'my-storage'
}
```

*modules/stor.bicep*:

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'mystorageaccount'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
```