@batchSize(1)
@batchSize(2)
resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = [for i in range(1,3): {
  name: 'app${i}'
  // ...
}]
