Consider the following Bicep files:

*main.bicep*:

```bicep
targetScope = 'managementGroup'

module myModule 'module.bicep' = {
  scope: subscription('f0750bbe-ea75-4ae5-b24d-a92ca601da2c')
  name: 'my-module'
}
```

*module.bicep*:

```bicep
targetScope = 'subscription'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'my-policy'
  // (other properties related to the policy definition)
}
```
