resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  name: '${vm.name}/InstallCustomScript'
  location: location
  properties: {
    // ...
  }
}
