[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

In the previous exercise, you created an initial Bicep file that contains the toy truck virtual machine and the associated resources. However, the Bicep template doesn't follow best practices, and it's a little hard to read. In this unit, you'll refactor the file.

During the process, you'll:

> [!div class="checklist"]
>
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Update the resource symbolic names

1. Open the *main.bicep* file in Visual Studio Code.

1. Select the symbolic name for the network security group resource, which is named `networkSecurityGroups_ToyTruckServer_nsg_name_resource` or a similar name.

   Rename the symbolic name. You can choose to select F2, or select and hold (or right-click) and select **Rename Symbol**.

   Enter the name `networkSecurityGroup` and press Enter. Visual Studio Code updates the name and all of the references inside the file.

1. Repeat this process for each resource, and rename them as listed below:

   > [!NOTE]
   > TODO might not be the same names

   | Resource type | Current symbolic name | New symbolic name |
   |-|-|-|
   | Public IP address | `publicIPAddresses_ToyTruckServer_ip_name_resource` | `publicIPAddress` |
   | Virtual network | `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_resource` | `virtualNetwork ` |
   | Virtual machine | `virtualMachines_ToyTruckServer_name_resource` | `virtualMachine` |
   | Subnet | `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_default` | `defaultSubnet` |
   | Network interface | `networkInterfaces_toytruckserver686_name_resource` | `networkInterface` |

## Fix the redundant parameter

Notice there is a parameter named similarly to `networkSecurityGroups_NSG_westus_externalid`. Its default value is the resource ID of the network security group. This is an example of an error in the export process: the network security group is defined within the template, so it shouldn't be specified by using a parameter. Here, you will update the template to dynamically obtain its resource ID from the network security group resource.

1. Delete the parameter named `networkSecurityGroups_NSG_westus_externalid`.

1. In the `virtualNetwork` resource, notice that the Bicep extension for Visual Studio Code detects the missing parameter as a problem and indicates this with a red squiggly line.

   :::image type="content" source="../media/5-virtual-network-nsg-problem.png" alt-text="TODO" border="true":::

1. Update the virtual network's `networkSecurityGroup.id` property to `networkSecurityGroup.id`:

   :::code language="bicep" source="code/5-virtual-network-nsg-fixed-1.bicep" highlight="16" :::

## Remove the redundant subnet resource

The virtual network's subnet is currently defined twice: once in the `virtualNetwork` resource, and again as its own child resource named `defaultSubnet`. It doesn't make sense to define it twice.

1. Delete the `defaultSubnet` resource.

   Notice that the `networkInterface` resource now displays an problem, since it refers to the default subnet's resource ID:

   :::image type="content" source="../media/5-network-interface-subnet-problem.png" alt-text="TODO" border="true":::

1. Update the `virtualNetwork` resource to include an `existing` reference to the subnet, which enables you to refer to the subnet within your Bicep code without defining it again:

   :::code language="bicep" source="code/5-virtual-network-nsg-fixed-2.bicep" highlight="28-30" :::

1. Update the `networkInterface` resource to refer to the subnet's resource ID:

   :::code language="bicep" source="code/5-network-interface-fixed.bicep" highlight="15" :::

## Change the parameters to variables

The parameters in the current template don't really need to be parameters. Here, you'll convert them to variables. At the same time, you'll rename them to more meaningful names.

1. Select the symbolic name for the `virtualMachines_ToyTruckServer_name` parameter. Rename it to `virtualMachineName`.

1. Change the parameter to a variable. Remember to remove the type, since variable definitions don't include types:

   ```bicep
   var virtualMachineName = 'ToyTruckServer'
   ```

1. Repeat the process for each parameter, and rename them as listed below:

   | Current parameter name | New variable name |
   |-|-|
   | `networkInterfaces_toytruckserver686_name` | `networkInterfaceName` |
   | `publicIPAddresses_ToyTruckServer_ip_name` | `publicIPAddressName` |
   | `networkSecurityGroups_ToyTruckServer_nsg_name` | `networkSecurityGroupName` |
   | `virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name` | `virtualNetworkName` |

1. Verify that your variable list looks similar to the following:

   :::code language="bicep" source="code/5-variables.bicep" :::

## Update the resource locations

All of the resources currently use a hard-coded location. Here, you'll add a parameter so that the template becomes more reusable.

1. At the top of the file, add a new parameter and a description decorator to make its purpose clear:

   ```bicep
   @description('The location into which the resources should be deployed.')
   param location string = resourceGroup().location
   ```

1. Update each resource to use the `location` parameter instead of the hard-coded `westus` location.

## Remove unnecessary properties

- pip
    - ipAddress
    - ipTags
- todo more

## Add parameters

TODO
 - PiP SKU
 - VNet IP range
 - VM SKU
 - vm adminUsername (and add adminPassword)
 - nic privateIPAddress

TODO managed disk resource ID