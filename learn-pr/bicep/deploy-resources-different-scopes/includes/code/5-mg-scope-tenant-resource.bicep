targetScope = 'managementGroup'

param subscriptionAliasName string

resource subscription 'Microsoft.Subscription/aliases@2020-09-01' = {
  name: subscriptionAliasName
  scope: tenant()
  properties: {
    // ...
  }
}
