param virtualNetworks_ToyTruck_vnet_name string = 'ToyTruck-vnet'
param virtualMachines_ToyTruckServer_name string = 'ToyTruckServer'
param networkInterfaces_toytruckserver154_name string = 'toytruckserver154'
param publicIPAddresses_ToyTruckServer_ip_name string = 'ToyTruckServer-ip'
param networkSecurityGroups_ToyTruckServer_nsg_name string = 'ToyTruckServer-nsg'

resource networkSecurityGroups_ToyTruckServer_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: networkSecurityGroups_ToyTruckServer_nsg_name
  location: 'westus3'
  properties: {
    securityRules: []
  }
}

resource publicIPAddresses_ToyTruckServer_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: publicIPAddresses_ToyTruckServer_ip_name
  location: 'westus3'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '1.2.3.4'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualMachines_ToyTruckServer_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_ToyTruckServer_name
  location: 'westus3'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_ToyTruckServer_name}_disk1_23e6a144c4ea4049b3e2be24b78a9e81'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_ToyTruckServer_name}_disk1_23e6a144c4ea4049b3e2be24b78a9e81')
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_ToyTruckServer_name
      adminUsername: 'toytruckadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_toytruckserver154_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualNetworks_ToyTruck_vnet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  name: virtualNetworks_ToyTruck_vnet_name
  location: 'westus3'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_ToyTruck_vnet_name_default.id
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_ToyTruck_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' = {
  name: '${virtualNetworks_ToyTruck_vnet_name}/default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_ToyTruck_vnet_name_resource
  ]
}

resource networkInterfaces_toytruckserver154_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_toytruckserver154_name
  location: 'westus3'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_toytruckserver154_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"6a38849d-bd59-4eae-856e-4909f7ac1fac"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            name: 'ToyTruckServer-ip'
            id: publicIPAddresses_ToyTruckServer_ip_name_resource.id
            properties: {
              provisioningState: 'Succeeded'
              resourceGuid: '07079685-0980-4ddf-acc3-3c8797c94b9a'
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Dynamic'
              idleTimeoutInMinutes: 4
              ipTags: []
              ipConfiguration: {
                id: '${networkInterfaces_toytruckserver154_name_resource.id}/ipConfigurations/ipconfig1'
              }
              deleteOption: 'Detach'
            }
            type: 'Microsoft.Network/publicIPAddresses'
            sku: {
              name: 'Basic'
              tier: 'Regional'
            }
          }
          subnet: {
            id: virtualNetworks_ToyTruck_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_ToyTruckServer_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
}
