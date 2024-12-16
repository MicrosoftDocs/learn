In the previous exercise, you created an initial Bicep file that contains the toy truck virtual machine and associated resources. However, the Bicep template doesn't follow best practices, and it's a little hard to read. In this unit, you'll refactor the file.

During the refactoring process, you'll:

> [!div class="checklist"]
>
> - Update the symbolic names for your resources and parameters.
> - Remove redundant parameters, resources, and properties.
> - Add variables and parameters to make your Bicep file reusable.

## Update the resource symbolic names

1. In Visual Studio Code, open the _main.bicep_ file.

1. Select the symbolic name for the network security group resource, which is `networkSecurityGroups_ToyTruckServer_nsg_name_resource` or a similar name.

   Rename the symbolic name. You can select <kbd>F2</kbd> or right-click and then select **Rename Symbol**.

   Enter the name `networkSecurityGroup` and press <kbd>Enter</kbd>. Visual Studio Code updates the name and all references in the file.

1. Repeat this process for each resource. Rename the resources as shown in the following table.

   > [!NOTE]
   > The names of the resources in your deployment will be a little different from the names in the table. Find the resources that have names that are close to these names.

   | Resource type | Current symbolic name | New symbolic name |
   | ---- | ---- | ---- |
   | Public IP address | `publicIPAddresses_ToyTruckServer_ip_name_resource` | `publicIPAddress` |
   | Virtual machine | `virtualMachines_ToyTruckServer_name_resource` | `virtualMachine` |
   | Virtual network | `virtualNetworks_ToyTruck_vnet_name_resource` | `virtualNetwork` |
   | Subnet | `virtualNetworks_ToyTruck_vnet_name_default` | `defaultSubnet` |
   | Network interface | `networkInterfaces_toytruckserver890_name_resource` | `networkInterface` |

## Remove the redundant subnet resource

The virtual network's subnet is currently defined twice. It's defined once in the `virtualNetwork` resource and again as its own child resource named `defaultSubnet`. It doesn't make sense to define the subnet twice.

1. Delete the `defaultSubnet` resource.

   Notice that the `networkInterface` resource now displays a problem, because it refers to the default subnet's resource ID:

   :::image type="content" source="../media/5-network-interface-subnet-problem.png" alt-text="Screenshot of Visual Studio Code that shows the network interface resource definition. The error is highlighted.":::

1. Update the `virtualNetwork` resource to include an `existing` reference to the subnet. If you add the `existing` reference, you can refer to the subnet again in your Bicep code without defining it again:

   :::code language="bicep" source="code/5-virtual-network-nsg-fixed.bicep" highlight="25-27" :::

1. Update the `networkInterface` resource to refer to the subnet's resource ID:

   :::code language="bicep" source="code/5-network-interface-fixed.bicep" highlight="15" :::

   You will notice an error about that the expression is involved in a cycle. You'll fix that in the next step.

1. Go to the `virtualNetwork` resource's `subnets` property and remove `id: defaultSubnet.id` to resolve the error.

## Change the parameters to variables

The parameters in the template don't need to be parameters. You'll now rename the parameters to more meaningful names and convert them to variables.

1. Select the symbolic name for the `virtualNetworks_ToyTruck_vnet_name` parameter. Rename it to `virtualNetworkName`.

1. Change the parameter to a variable. Remember to remove the type because variable definitions don't include types:

   ```bicep
   var virtualNetworkName = 'ToyTruck-vnet'
   ```

1. Repeat the process for each parameter. Rename the parameters as shown in the following table.

   Notice that the value of the `networkInterfaceName` includes a three-digit number. The number is different for different deployments. Ensure that you copy the variable's value from your reference template.

   | Current parameter name | New variable name |
   | ---- | ---- |
   | `virtualMachines_ToyTruckServer_name` | `virtualMachineName` |
   | `networkInterfaces_toytruckserver890_name` | `networkInterfaceName` |
   | `publicIPAddresses_ToyTruckServer_ip_name` | `publicIPAddressName` |
   | `networkSecurityGroups_ToyTruckServer_nsg_name` | `networkSecurityGroupName` |

1. Verify that your variable declarations look like the following example:

   :::code language="bicep" source="code/5-variables.bicep" :::

## Update the resource locations

All the resources currently use a hard-coded location. You'll now add a parameter so that the template becomes more reusable.

1. At the top of the file, add a new parameter and a description decorator to clarify the parameter's purpose:

   ```bicep
   @description('The location where resources are deployed.')
   param location string = resourceGroup().location
   ```

1. Update each resource to use the `location` parameter instead of the hard-coded `westus3` location.

## Add parameters and variables

Your template has some hard-coded values where parameters or variables would be more appropriate. You'll now add parameters for properties that might change between deployments and variables for values that won't.

1. At the top of the _main.bicep_ file, below the `location` parameter, add the following parameters:

   ```bicep
   @description('The name of the size of the virtual machine to deploy.')
   param virtualMachineSizeName string = 'Standard_D2s_v3'

   @description('The name of the storage account SKU to use for the virtual machine\'s managed disk.')
   param virtualMachineManagedDiskStorageAccountType string = 'Premium_LRS'

   @description('The administrator username for the virtual machine.')
   param virtualMachineAdminUsername string = 'toytruckadmin'

   @description('The administrator password for the virtual machine.')
   @secure()
   param virtualMachineAdminPassword string

   @description('The name of the SKU of the public IP address to deploy.')
   param publicIPAddressSkuName string = 'Standard'

   @description('The virtual network address range.')
   param virtualNetworkAddressPrefix string

   @description('The default subnet address range within the virtual network')
   param virtualNetworkDefaultSubnetAddressPrefix string
   ```

   Some of the parameters have default values and others don't. Later, you'll create a parameter file to set most of these values.

1. Add the following new variable declarations below the `networkSecurityGroupName` variable:

   ```bicep
   var virtualNetworkDefaultSubnetName = 'default'
   var virtualMachineImageReference = {
     publisher: 'canonical'
     offer: '0001-com-ubuntu-server-focal'
     sku: '20_04-lts-gen2'
     version: 'latest'
   }
   ```

1. Add the following variable declaration. Replace the value with the OS disk name from your own reference template.

   :::code language="bicep" source="code/5-main-refactored.bicep" range="38":::

   The value of the `virtualMachineOSDiskName` is unique. The value is different for each deployment. Ensure that you copy the variable's value from your reference template.

   > [!WARNING]
   > Ensure that you copy the correct values for the `virtualMachineOSDiskName` and `networkInterfaceName` variables. Otherwise, Azure won't detect that you're declaring existing resources and might try to create new resources.

   Your variable declarations should now look like this example:

   :::code language="bicep" source="code/5-main-refactored.bicep" range="26-38" highlight="3, 6, 7-12, 13" :::

1. Update the `publicIPAddress` resource to refer to a parameter:

   | Property | Parameter |
   | ---- | ---- |
   | `sku.name` | `publicIPAddressSkuName` |

1. Update the `virtualMachine` resource to refer to the parameters and variables:

   | Property | Parameter or variable |
   | ---- | ---- |
   | `hardwareProfile.vmSize` | `virtualMachineSizeName` |
   | `storageProfile.imageReference` | `virtualMachineImageReference` <br> Use the variable name to replace the object's values, including the curly braces. |
   | `storageProfile.osDisk.name` | `virtualMachineOSDiskName` |
   | `storageProfile.osDisk.managedDisk.storageAccountType` | `virtualMachineManagedDiskStorageAccountType` |
   | `osProfile.adminUsername` | `virtualMachineAdminUsername` |
   | `osProfile.adminPassword ` <br> Add this property below `osProfile.adminUsername` | `virtualMachineAdminPassword` |

1. Update the `virtualNetwork` resource to refer to the parameters and variables:

   | Property | Parameter or variable |
   | ---- | ---- |
   | `addressSpace.addressPrefixes`| `virtualNetworkAddressPrefix` |
   | `subnets.name` | `virtualNetworkDefaultSubnetName` |
   | `subnets.addressPrefix` | `virtualNetworkDefaultSubnetAddressPrefix` |

1. Update the `virtualNetwork` resource's nested resource `defaultSubnet`:

   | Property | Variable |
   | ---- | ---- |
   | `name` | `virtualNetworkDefaultSubnetName` |

## Remove unnecessary properties

The export process adds redundant properties to many resources. Use these steps to remove the unneeded properties.

1. In the `networkSecurityGroup` resource, remove `properties` because the `securityRules` property is empty.

1. In the `publicIPAddress` resource, remove the following properties:

   - `ipAddress` property because it's automatically set by Azure
   - `ipTags` property because it's empty

1. In the `virtualMachine` resource, remove the following properties:

   - `storageProfile.osDisk.managedDisk.id` property because Azure automatically determines this property when the virtual machine is deployed

     > [!IMPORTANT]
     > If you don't remove this property, your template won't deploy correctly.

   - `storageProfile.dataDisks` property because it's empty
   - `osProfile.secrets` property because it's empty
   - `osProfile.requireGuestProvisionSignal` property because Azure sets this property automatically

1. In the `virtualNetwork` resource, remove the following properties:

   - `delegations` and `virtualNetworkPeerings` properties because they're empty.
   - The line for `type: 'Microsoft.Network/virtualNetworks/subnets'`

1. In the `networkInterface` resource, remove the following properties:

   - The `kind` property
   - From `ipConfigurations`: `id`, `etag`, `type`, and`privateIPAddress` because it's automatically set by Azure and the allocation method is _Dynamic_
   - From `ipConfigurations.properties`:
     - `provisioningState`
     
   - From `publicIPAddress`, `name`, `properties`, `type`, and `sku`
   - `dnsSettings` because the `dnsServers` property is empty

> [!TIP]
> When you work with your own templates, you need to determine whether there are any properties that should be removed as you did here.
>
> In Visual Studio Code, the Bicep extension helps you set the minimum properties for a resource. When you add a space after the equal sign in the resource definition, Visual Studio Code prompts you to select **required-properties**:
>
> :::image type="content" source="../media/5-visual-studio-code-required-properties.png" alt-text="Screenshot of Visual Studio Code that shows the required-properties option.":::
>
> When you select **required-properties**, Visual Studio Code populates the resource definition with the properties that are mandatory. You can refer to **required-properties** to determine whether the properties in your converted template all need to be present.
>
> The Azure Quickstart Templates repository is also helpful for this task. Find a quickstart template that does approximately what you're trying to do, and look at the properties it sets on the resource.

## Create a parameter file

Your parameters are currently defined as default values in your template. To make your template work well across environments, it's a good idea to create a parameter file, and to remove default values for parameters that need to change for each environment.

1. Create a new file named _main.parameters.production.json_.

1. Paste the following JSON into the _main.parameters.production.json_ file:

   :::code language="json" source="code/5-parameters.json" :::

1. Update the values for the `virtualNetworkAddressPrefix` and `virtualNetworkDefaultSubnetAddressPrefix` parameters to match the IP address ranges that are specified in your reference template's virtual network resource.

   For example, here's how the values are specified in a reference template. Your IP addresses might be different from the IP addresses that are used in this example.

   :::code language="bicep" source="code/3-main-migrated.bicep" range="93-118" highlight="7, 15":::

1. Update your _main.bicep_ file to remove the default values for the parameters you specified in the parameters file.

   - `virtualMachineSizeName`
   - `virtualMachineManagedDiskStorageAccountType`
   - `virtualMachineAdminUsername`

  Don't change the default values for the `location` and `publicIPAddressSkuName` parameters because those values are probably the same for all your environments.

## Verify your template

1. At the end of the refactor phase, your _main.bicep_ file should look similar to the following example:

   :::code language="bicep" source="code/5-main-refactored.bicep" :::

   Your _main.parameters.production.json_ file should look similar to the following file, although you might have different IP address ranges listed:

   :::code language="json" source="code/5-parameters-completed.json" :::

1. Select **View** > **Problems** to display the problems pane.

   No problems are indicated.

> [!TIP]
> When you work with your own templates, you might make different choices about the properties to parameterize and other customizations. Throughout this module, we provide general guidance to help you get started, but you'll need to consider your own environment and how you want to reuse your templates when you decide how to refactor your own Bicep files.
