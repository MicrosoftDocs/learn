Consider the following two Bicep files.

_main.bicep_:

```bicep
module storage1 'modules/stor.bicep' = {
  name: 'my-storage'
}
```

_modules/stor.bicep_:

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'mystorageaccount'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
```
