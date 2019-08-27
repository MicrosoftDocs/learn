In this unit, you'll do an exercise using the Azure portal. You'll deploy a Linux virtual machine and enable diagnostic logs that help with troubleshooting software-related problems. Virtual machines can be defined and deployed on Azure in the following ways: 
- Using the Azure portal.
- With a script (using the Azure CLI or Azure PowerShell).
- Using an Azure Resource Manager template. 

In all cases, you'll need to supply several pieces of information. 

## Azure CLI

[!include[](../../../includes/azure-sandbox-activate.md)]

From the Azure CLI, you'll create a virtual network and subnet. Run the following command to create the virtual network MyVNet1 and subnet frontend:

```
az network vnet create --resource-group <rgn>[sandbox resource group name]</rgn> \
--name MyVNet1 \
--address-prefix 10.10.0.0/16 \
--subnet-name frontend \
--subnet-prefix 10.10.1.0/24 \
--location NorthEurope
```

## Azure portal 
You'll create a Linux virtual machine with the portal as it walks you through the required information, giving hints and helpful messages during the creation of the virtual machine.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.
1. Search for "Virtual Machines" in the search bar and select <!--CE:Should we specify what 'it' is?-->it.
1. Select **add** and you'll be taken to the **Create a virtual machine** blade.

The virtual machine creation experience in the portal is presented in a "wizard" format to walk you through all the configuration areas. Selecting the "Next" button will take you to the next configurable section. However, you can move between the sections at will with the tabs running across the top that identify each section. When you've filled in all the required options (identified with red stars), select the **Review + Create** button at the bottom.

![Screenshot showing the create a virtual machine experience in the Azure portal.](../media/virtual-machine-wizard.png)

To start with ...
<!--CE:PLease double check all the bold in the following - without access to the UI, it's difficult for me to determine if they're all correct.-->
- Select the **Subscription** that should be billed for virtual machine hours.
- For **Resource group**, select "**<rgn>[sandbox resource group name]</rgn>**".
- In the **INSTANCE DETAILS** section, enter a name for your virtual machine, such as **WebserverVM**.
  - From the locations drop-down list, select a region close to you.
  - Leave **Availability options** as "None". This option is used to ensure the VM is highly available by grouping multiple VMs together in a set to deal with planned or unplanned maintenance events or outages.
  - Open the drop-down list to see all the options available. Ensure the image is set to **Ubuntu Server 18.04 LTS**. 
  - The **Size** field isn't directly editable and has a DS1 default size. Select the **Change size** link to explore other VM sizes. For this exercise, leave the default.

- In the **ADMINISTRATOR ACCOUNT** section, set the **Username** field to **Azureuser**. You'll use this username to sign in to the virtual machine. In the **Password** field, enter **Demouser@123**. Confirm the **Password**.

- In the **INBOUND PORT RULES** section, open the list and choose<!--CE:Should this not be in bold?--> _Allow selected ports_. Because you're using a Linux virtual machine, you want to access the desktop using SSH. Scroll the list if necessary until you find SSH (22) then select it.

![Screenshot showing the drop-down for opening the port for SSH access on the Linux virtual machine.](../media/inbound-port-rules.png)

### Configure disks for the VM

- Select **Next** to move to the Disks section.
- Select **Standard SSD** for the **OS disk type**.
- Select **Next** to move to the Networking section.

### Configure the network

Under **NETWORK INTERFACE**, ensure that the virtual network is **MyVNet1** and  subnet is **frontend**. The address space field should be 10.10.1.0/24. Select the drop-down option to find these properties. Leave everything as default and select **Next** to move to management.

### Configure management

Under **MONITORING**, select **on** to:  

- Enable Boot diagnostics.
- Enable Operating System Guest Diagnostic – this action enables the IaaS Diagnostics extension for Windows. You can then collect metrics for your virtual machine every minute.
- Access the Diagnostics Storage Account – if you have an existing storage account, select it from the drop-down menu. Otherwise, select **create new** and create a storage account. This is all done from the wizard.

![Screenshot showing the Management part of virtual machine and how to create a Storage account.](../media/virtual-machine-management.png)

### Finish configuring the virtual machine and create the image

You can explore the other tabs if you wish. The other options have reasonable defaults and there's no need to change any for the exercise. Select the **Review + create** button at the bottom of the panel. Azure runs a validation check on your options and gives details about whether the virtual machine has passed or failed. After validation, select **Create** to create and deploy the virtual machine. The Azure dashboard will show the virtual machine  that's being deployed. This procedure might take several minutes. In the next unit, you'll create an email alert based on CPU usage.
