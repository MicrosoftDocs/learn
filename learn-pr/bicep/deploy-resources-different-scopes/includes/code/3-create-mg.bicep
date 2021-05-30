targetScope = 'tenant'

resource parentManagementGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'NonProduction'
  properties: {
    displayName: 'Non-production'
  }
}

resource childManagementGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
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
