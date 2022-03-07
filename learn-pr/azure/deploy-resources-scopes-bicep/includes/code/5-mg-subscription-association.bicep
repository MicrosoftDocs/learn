targetScope = 'tenant'

@description('The name of the management group that should contain the subscription.')
param managementGroupName string

@description('The subscription ID to place into the management group.')
param subscriptionId string

resource managementGroup 'Microsoft.Management/managementGroups@2021-04-01' existing = {
  name: managementGroupName
}

resource subscriptionAssociation 'Microsoft.Management/managementGroups/subscriptions@2021-04-01' = {
  parent: managementGroup
  name: subscriptionId
}
