The core element of a Bicep template is resource, which designates an Azure resource. Each resource contains a set of generic and resource-specific properties. For example, the template used in the following example describes an Azure virtual network. While the name and location properties are generic, addressPrefix is resource specific. The Microsoft.Network/virtualNetworks@2021-05-01 string next to the resource designates its API version, and the virtualNetwork entry represents its symbolic name, which provides a way to reference the resource within the template.

In addition to the resource element, the following sample template also includes a parameter element that enables you to assign a name to the virtual network during deployment. If you don't assign a name at that time, the default value of `lnx-bcp-vnet` applies instead. The description element is an example of a decorator, as indicated by the leading "`@`" character. Its purpose is to describe the parameter's role, and its output appears beside the parameter's textbox when you use the Azure portal to review or deploy the corresponding Azure Resource Manager template. Use the following code example to provision a Linux VM by using Bicep:

```bicep
@description('Name of the virtual network')
param virtualNetworkName string = 'lnx-bcp-vnet'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
}
```

## Deploy a Linux VM by using Bicep templates

Working with Bicep involves authoring and deploying templates. To simplify and enhance the authoring experience, use Visual Studio Code with the Bicep extension. The same extension also supports Bicep-based deployments. If you prefer to trigger a deployment from a command line or as part of a scripted task, you can install and use Bicep CLI as a standalone utility or use it directly from within an Azure CLI session. The Azure CLI will install the Bicep CLI automatically during the first invocation of any `az bicep` command. However, to perform a manual installation of Bicep, run `az bicep install`.

Effectively, the process of provisioning an Azure VM running Linux by using Bicep typically involves the following sequence of high-level steps:

1. Identify a suitable VM image.
1. Identify the suitable VM size.
1. Author a Bicep template.
1. Initiate deployment of the Bicep template.

When you deploy Bicep templates, a task referred to as transpilation automatically converts them into equivalent Azure Resource Manager templates. You can also perform a conversion between the Bicep and Azure Resource Manager formats by running the `bicep build` and `bicep decompile` commands, respectively.

To identify the suitable VM image and size, follow the steps described in the earlier units of this module. This unit focuses on Bicep-specific tasks.

## Author a Bicep template

To author a Bicep template, start by launching a Visual Studio Code session with the Bicep extension installed. Next, create a file named main.bicep. Add the following content to the file, and then save the change:

> [!NOTE]
> 
> The filenames that you choose for your Bicep files are arbitrary, although it's a good practice to choose a name that reflects the file content or purpose, and you should use ".bicep" for the file extension.

```bicep
@description('The name of your virtual machine')
param vmName string = 'lnx-bcp-vm'

@description('Username for the virtual machine')
param adminUsername string

@description('Type of authentication to use on the virtual machine')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Key or password for the virtual machine')
@secure()
param adminPasswordOrKey string

@description('Unique DNS Name for the Public IP used to access the virtual machine')
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('The allowed Linux distribution and version for the VM')
@allowed([
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2204'

@description('Location for all resources')
param location string = resourceGroup().location

@description('The size of the VM')
param vmSize string = 'Standard_F4s'

@description('Name of the virtual network')
param virtualNetworkName string = 'lnx-bcp-vnet'

@description('Name of the subnet in the virtual network')
param subnetName string = 'subnet0'

@description('Name of the network security group')
param networkSecurityGroupName string = 'lnx-bcp-nsg'

var imageReference = {
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}
var publicIPAddressName = '${vmName}-pip'
var networkInterfaceName = '${vmName}-nic'
var osDiskType = 'Standard_LRS'
var subnetAddressPrefix = '10.3.0.0/24'
var addressPrefix = '10.3.0.0/16'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'ssh'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: virtualNetwork
  name: subnetName
  properties: {
    addressPrefix: subnetAddressPrefix
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
    idleTimeoutInMinutes: 4
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: imageReference[ubuntuOSVersion]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    securityProfile: json('null')
  }
}

output adminUsername string = adminUsername
output fqdn string = publicIPAddress.properties.dnsSettings.fqdn
output sshCommand string = 'ssh ${adminUsername}@${publicIPAddress.properties.dnsSettings.fqdn}'
```

> [!NOTE]
> 
> This template is based on the content of the GitHub repo [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/).

## Initiate deployment of the Bicep template

After saving the _main.bicep_ file, you can proceed with a template-based deployment. First, launch an Azure CLI session on your local computer, and run `az login` to authenticate. You'll need to provide the credentials of a user with sufficient privileges to provision resources in your Azure subscription. Next, change the current directory to the one where the _main.bicep_ file resides. Alternatively, you can start an Azure Cloud Shell Bash session and upload that file into your home directory within the Azure Cloud Shell environment.

Next, run the following command from an authenticated Azure CLI session to create a resource group, which will contain all resources that are part of the subsequent deployment:

```azurecli
az group create --name rg-lnx-bcp --location eastus
```

Before you proceed further, you might want to ensure that you're using the most recent version of Bicep CLI by running the following command:

```azurecli
az bicep upgrade
```

Finally, initiate deployment by running the following command:

```azurecli
az deployment group create --resource-group rg-lnx-bcp --template-file main.bicep --parameters adminUsername=azureuser
```

> [!NOTE]
> 
> This command includes the `--parameters` switch, which in this case sets the name of the local administrator for the Azure VM that you're deploying. Azure CLI will prompt you to provide the corresponding password because the default value of the `adminPasswordOrKey` parameter isn't set.

The Azure VM should begin running shortly, typically within a few minutes. To connect to it, identify the fully qualified domain name (FQDN) associated with its network interface by reviewing the output generated by the deployment. Alternatively, you can use the `shCommand` value. When prompted, provide the newly set password to authenticate when establishing an SSH connection.

In case you didn't record the Bicep deployment's output values, you can display them again by running the following command:

```azurecli
az deployment group show \
  --resource-group rg-lnx-bcp \
  --name main \
  --query properties.outputs
```

The JSON-formatted output should resemble the following content:

```json
{
  "adminUsername": {
    "type": "String",
    "value": "azureuser"
  },
  "fqdn": {
    "type": "String",
    "value": "lnx-bcp-vm-example.eastus.cloudapp.azure.com"
  },
  "sshCommand": {
    "type": "String",
    "value": "ssh azureuser@lnx-bcp-vm-example.eastus.cloudapp.azure.com"
  }
}
```
