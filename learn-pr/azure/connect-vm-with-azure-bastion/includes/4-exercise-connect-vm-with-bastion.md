In this unit, you'll deploy Azure Bastion.
   
## Set up your environment

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Cloud Shell** from the menu bar in the upper right.
1. Select **Bash**.
1. Run the following command to download the scripts you'll use for this exercise. (should print out ssh key.)
    - Creates jumpbox (Windows) + "app" VM (Ubuntu) that's on a private network. 
    - Jumpbox has public IP
1. Copy SSH key to use later.

## Check resources created

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select or search for **Resource groups**.
1. Select resource group <rgn>[sandbox resource group name]</rgn>.
1. Sort the list of resources by Type.
1. The resource group should contain the resources shown in the following table.

   |Name    |Type  |Description |
   |---------|---------|---------|
   |Row1     |         |         |
   |Row2     |         |         |
   |Row3     |         |         |
   |Row4     |         |         |
   |Row5     |         |         |

## Connect to the internal app VM

1. Explain what resources are created with script and have them look at the resource group in the portal (that shows list of resources).
    1. Connect to jumpbox using RDP.
    1. From jumpbox SSH to app VM. Run some commands to demonstrate you're on the app VM.
    1. Exit from the VMs.

## Create subnet for Azure Bastion

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select or search for **Resource groups**.
1. Select resource group <rgn>[sandbox resource group name]</rgn>.
1. From the list of resources, select the virtual network.
1. Under **Settings**, select **Subnets**.
1. Select **+ Subnet** to add a subnet.
1. Enter the following information to create a subnet.

   |Field  |Name |
   |---------|---------|
   |Name    |  AzureBastionSubnet       |
   |Address range     |     10.0.1.0/24    |

1. Select **OK**.

## Deploy Bastion

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select or search for **Virtual machines**.
1. Select virtual machine **internalappvm1**.
1. Select **Connect** > **Bastion** > **Use Bastion**.
1. Enter the username **azureuser**.
1. Select SSH Private Key. 
1. Paste in the SSH private key you copied 
    1. Connect > Bastion.
    1. Run some commands to demonstrate you're on the app VM.
    1. Look at RG to see bastion resource(s) created.

## Decommission the jumpbox

    1. Go to jumpbox in resource group.
    1. Shut down and delete the jumpbox.