targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'example-resource-group'
  location: 'westus'
}
