targetScope = 'managementGroup'

@description('The name of the subscription alias to deploy.')
param subscriptionAliasName string

resource parentManagementGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  scope: tenant()
  name: 'NonProduction'
  properties: {
    displayName: 'Non-production'
  }
}

resource childManagementGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  scope: tenant()
  name: 'SecretRND'
  properties: {
    displayName: 'Secret R&D Projects'
    details: {
      parent: {
        id: parentManagementGroup.id
      }
    }
  }
}

resource subscription 'Microsoft.Subscription/aliases@2020-09-01' = {
  scope: tenant()
  name: subscriptionAliasName
  properties: {
    // ...
  }
}

module subscriptionAssociation 'modules/mg-subscription-association.bicep' = {
  name: 'subscriptionAssociation'
  scope: tenant()
  params: {
    managementGroupName: childManagementGroup.name
    subscriptionId: subscription.properties.subscriptionId
  }
}
