resource myFirstDeploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
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
    arguments: '-Name Learner'
    environmentVariables: [
      {
        name: 'Subject'
        value: 'Deployment Scripts'
      }
      {
        name: 'MySecretValue'
        secureValue: 'PleaseDoNotPrintMeToTheConsole!'
      }
    ]
    azPowerShellVersion: '3.0'
    scriptContent: '''
      param ([string]$Name)
      $output = "Hello $Name!"
      $output += "Learning about $env:Subject can be very helpful in your deployments."
      $output += "Secure environment variables (like $env:MySecretValue) are only secure if you keep them that way."
      Write-Output $output
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs['text'] = $output
    '''
    retentionInterval: 'P1D'
  }
}
