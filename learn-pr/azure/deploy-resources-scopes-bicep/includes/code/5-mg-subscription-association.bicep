targetScope = 'managementGroup'

@description('The name of the management group that should contain the subscription.')
param managementGroupName string

@description('The subscription ID to place into the management group.')
param subscriptionId string

resource subscriptionAssociation 'Microsoft.Management/managementGroups/subscriptions@2021-04-01' = {
  name: '${managementGroupName}/${subscriptionId}'
  scope: tenant()
}
