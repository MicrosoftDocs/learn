resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: vm
  name: 'InstallCustomScript'
  location: location
  properties: {
    // ...
  }
}
