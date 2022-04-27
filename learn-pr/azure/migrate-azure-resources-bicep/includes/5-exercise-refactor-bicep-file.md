In the previous exercise, you created an initial Bicep file that contains the toy truck virtual machine and associated resources. However, the Bicep template doesn't follow best practices, and it's a little hard to read. In this unit, you'll refactor the file.

During the refactoring process, you'll:

> [!div class="checklist"]
>
> - Update the symbolic names for your resources and parameters.
> - Remove redundant parameters, resources, and properties.
> - Add variables and parameters to make your Bicep file reusable.

## Update the resource symbolic names

1. In Visual Studio Code, open the *main.bicep* file.

1. Select the symbolic name for the network security group resource, which is `networkSecurityGroups_ToyTruckServer_nsg_name_resource` or a similar name.

   Rename the symbolic name. You can select <kbd>F2</kbd> or select and hold (or right-click), and then select **Rename Symbol**.

   Enter the name `networkSecurityGroup` and press <kbd>Enter</kbd>. Visual Studio Code updates the name and all references inside the file.

1. Repeat this process for each resource. Rename the resources as shown in the following table:

   > [!NOTE]
   > The names of the resources in your deployment will be a little different from the names in the table. Find the resources that have names that are close to these names.

   | Resource type | Current symbolic name | New symbolic name |
   |-|-|-|
   | Public IP address | `publicIPAddresses_ToyTruckServer_ip_name_resource` | `publicIPAddress` |
   | Virtual network | `virtualNetworks_ToyTruck_vnet_name_resource` | `virtualNetwork ` |
   | Virtual machine | `virtualMachines_ToyTruckServer_name_resource` | `virtualMachine` |
   | Subnet | `virtualNetworks_ToyTruck_vnet_name_default` | `defaultSubnet` |
   | Network interface | `networkInterfaces_toytruckserver890_name_resource` | `networkInterface` |

## Remove the redundant subnet resource

The virtual network's subnet currently is defined twice. It's defined once in the `virtualNetwork` resource, and again as its own child resource named `defaultSubnet`. It doesn't make sense to define the subnet twice.

1. Delete the `defaultSubnet` resource.

   Notice that the `networkInterface` resource now displays a problem, because it refers to the default subnet's resource ID:

   :::image type="content" source="../media/5-network-interface-subnet-problem.png" alt-text="Screenshot of Visual Studio Code that shows the networkInterface resource definition, with the error highlighted.":::

1. Update the `virtualNetwork` resource to include an `existing` reference to the subnet. By adding the `existing` reference, you can refer to the subnet again within your Bicep code without defining it again:

   :::code language="bicep" source="code/5-virtual-network-nsg-fixed.bicep" highlight="25-27" :::

1. Update the `networkInterface` resource to refer to the subnet's resource ID:

   :::code language="bicep" source="code/5-network-interface-fixed.bicep" highlight="15" :::

## Change the parameters to variables

The parameters in the current template don't really need to be parameters. Here, you'll convert them to variables. At the same time, you'll rename them to more meaningful names.

1. Select the symbolic name for the `virtualNetworks_ToyTruck_vnet_name` parameter. Rename it to `virtualNetworkName`.

1. Change the parameter to a variable. Remember to remove the type because variable definitions don't include types:

   ```bicep
   var virtualNetworkName = 'ToyTruck-vnet'
   ```

1. Repeat the process for each parameter. Rename the parameters as shown in the following table:

   | Current parameter name | New variable name |
   |-|-|
   | `virtualMachines_ToyTruckServer_name` | `virtualMachineName` |
   | `networkInterfaces_toytruckserver890_name` | `networkInterfaceName` |
   | `publicIPAddresses_ToyTruckServer_ip_name` | `publicIPAddressName` |
   | `networkSecurityGroups_ToyTruckServer_nsg_name` | `networkSecurityGroupName` |

1. Verify that your variable declarations look similar to the following example:

   :::code language="bicep" source="code/5-variables.bicep" :::

   Notice that the value of the `networkInterfaceName` includes a three-digit number. The number is different between deployments. Ensure that you copy the variable's value from your reference template.

## Update the resource locations

All the resources currently use a hard-coded location. Here, you'll add a parameter so that the template becomes more reusable.

1. At the top of the file, add a new parameter and a description decorator to make the parameter's purpose clear:

   ```bicep
   @description('The location into which the resources should be deployed.')
   param location string = resourceGroup().location
   ```

1. Update each resource to use the `location` parameter instead of the hard-coded `westus` location.

## Add parameters and variables

Your template has some hard-coded values where parameters or variables would be more appropriate. Here, you'll add parameters for properties that might change between deployments and variables for values that won't.

1. At the top of the *main.bicep* file, below the `location` parameter, add the following parameters:

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
   param publicIPAddressSkuName string = 'Basic'
   
   @description('The virtual network address range.')
   param virtualNetworkAddressPrefix string
   
   @description('The default subnet address range within the virtual network')
   param virtualNetworkDefaultSubnetAddressPrefix string
   ```

   Some of the parameters have default values and others don't. Later, you'll create a parameter file to set most of these values.

1. Add the following new variable declarations:

   ```bicep
   var virtualNetworkDefaultSubnetName = 'default'
   var virtualMachineImageReference = {
     publisher: 'canonical'
     offer: '0001-com-ubuntu-server-focal'
     sku: '20_04-lts'
     version: 'latest'
   }
   ```

1. Add the following variable declaration. Replace the values with the OS disk name from your own reference template:

   :::code language="bicep" source="code/5-main-refactored.bicep" range="35":::

   The value of the `virtualMachineOSDiskName` is unique. The value is different between deployments. Ensure that you copy the variable's value from your reference template.

   > [!WARNING]
   > Ensure that you copy the values for the `virtualMachineOSDiskName` and `networkInterfaceName` variables correctly. Otherwise, Azure won't detect that you're declaring the same resources that already exist, and it might try to create new resources.

   Your variable declarations should now look like this example:

   :::code language="bicep" source="code/5-main-refactored.bicep" range="26-38" highlight="2, 4-9, 10, 11" :::

1. Update the `publicIPAddress` resource to refer to the `publicIPAddressSkuName` parameter in its `sku.name` property.

1. Update the `virtualNetwork` resource to refer to the parameters and variables:

   - Use the `virtualNetworkAddressPrefix` parameter within the virtual network's `addressSpace.addressPrefixes` property.
   - Use the `virtualNetworkDefaultSubnetName` variable for the subnet `name` properties. Make sure you change both the `subnets` property and the nested `existing` resource.
   - Use the `virtualNetworkDefaultSubnetAddressPrefix` parameter for the subnet's `addressPrefix` property.

1. Update the `virtualMachine` resource to refer to the parameters and variables:

   - Use the `virtualMachineSizeName` parameter for the `hardwareProfile.vmSize` property.
   - Use the `virtualMachineImageReference` variable for the `storageProfile.imageReference` property.
   - Use the `virtualMachineOSDiskName` variable for the `storageProfile.osDisk.name` property.
   - Use the `virtualMachineManagedDiskStorageAccountType` parameter for the `storageProfile.osDisk.managedDisk.storageAccountType` property.
   - Use the `virtualMachineAdminUsername` parameter for the `osProfile.adminUsername` property.
   - Directly below the `osProfile.adminUsername` property, add a new property named `adminPassword`. Set the property value to the `virtualMachineAdminPassword` parameter.

## Remove unnecessary properties

The export process adds redundant properties to many resources. Here, you remove the extraneous properties.

1. In the `networkSecurityGroup` resource, remove the `securityRules` property because it's empty. Remove the `properties` property because it's empty now, too.

1. In the `publicIPAddress` resource:

   - Remove the `ipAddress` property because it's automatically set by Azure.
   - Remove the `ipTags` property because it's empty.

1. In the `virtualNetwork` resource, remove the `delegations` and `virtualNetworkPeerings` properties because they're empty.

1. In the `virtualMachine` resource:

   - Remove the `storageProfile.osDisk.managedDisk.id` property because Azure automatically determines this property when the virtual machine is deployed.
     > [!IMPORTANT]
     > It's important to remove this property or your template won't deploy correctly.
   - Remove the `requireGuestProvisionSignal` property because Azure sets this property automatically.
   - Remove the `storageProfile.dataDisks` and `osProfile.secrets` properties because they're empty.

1. In the `networkInterface` resource:

   - Remove the `privateIPAddress` property from `ipConfigurations` because it's automatically set by Azure and the allocation method is _Dynamic_.
   - Remove the `dnsServers` property from `dnsSettings` because it's empty. Remove the `dnsSettings` property because it's empty now, too.

> [!TIP]
> When you work with your own templates, you'll need to determine whether there are any properties that should be removed like you've done here.
>
> In Visual Studio Code, the Bicep extension helps you set the minimum properties for a resource. After you select the <kbd>=</kbd> key in the resource definition, Visual Studio Code prompts you to select **required-properties**:
>
> :::image type="content" source="../media/5-visual-studio-code-required-properties.png" alt-text="Screenshot of Visual Studio Code that shows the required properties selection when defining a new Bicep resource.":::
>
> When you select **required-properties**, Visual Studio Code prepopulates the resource definition with the properties that are mandatory. You can refer to **required-properties** to determine whether the properties in your converted template all need to be present.
>
> The Azure quickstart templates repository is also helpful for this task. Find a quickstart template that does approximately what you're trying to do, and look at the properties it sets on the resource.

## Create a parameter file

Your parameters currently are defined as default values in your template. To make your template work well across environments, it's a good idea to create a parameter file, and to remove default values for parameters that need to change for each environment.

1. Create a new file named *main.parameters.production.json*.

1. Paste the following JSON into the *main.parameters.production.json* file.

   :::code language="json" source="code/5-parameters.json" :::

1. Update the values for the `virtualNetworkAddressPrefix` and `virtualNetworkDefaultSubnetAddressPrefix` parameters to match the IP address ranges that are specified in your reference template's virtual network resource.

   For example, here's how they are specified in a reference template. Your IP addresses might be different from IP addresses that are used in this example:

   :::code language="bicep" source="code/3-main-migrated.bicep" range="31-54" highlight="7, 14":::

1. Update your *main.bicep* file to remove the default values for the parameters you specified in the parameters file. Leave the default values for the `location` and `publicIPAddressSkuName` parameters because they likely are the same for all your environments.

## Verify your template

1. At the end of the refactor phase, your *main.bicep* file should look similar to the following example:

   :::code language="bicep" source="code/5-main-refactored.bicep" :::

   Your *main.parameters.production.json* file should look similar to the following file, although you might have different IP address ranges listed:

   :::code language="json" source="code/5-parameters-completed.json" :::

1. Select **View** > **Problems** to display the problems pane.

   No problems are indicated.

> [!TIP]
> When you work with your own templates, you might make different choices about the properties to parameterize and other customizations. Throughout this module, we provide general guidance to help you get started, but you'll need to consider your own environment and how you want to reuse your templates when you decide how to refactor your own Bicep files.
