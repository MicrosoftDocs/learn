resource myFirstDeploymentScript 'Microsoft.Resources/deploymentScripts@2019-10-01-preview' = {
  name: 'myFirstDeploymentScript'
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/01234567-89AB-CDEF-0123-456789ABCDEF/resourcegroups/deploymenttest/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myscriptingid': {}
    }
  }
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: loadTextContent('myscript.ps1')
    retentionInterval: 'P1D'
  }
}

output scriptResult string = myFirstDeploymentScript.properties.outputs.text
