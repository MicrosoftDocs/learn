resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }

  resource installCustomScriptExtension 'extensions' = {
    name: 'InstallCustomScript'
    location: location
    properties: {
      // ...
    }
  }
}
