In the accounting-firm scenario, your organization uses Azure Virtual Desktop to provide virtualized desktops and apps.

In this unit, you'll create a virtual network, a host pool, and a Microsoft Entra-joined session host. Azure Virtual Desktop session hosts must join Microsoft Entra ID or an Active Directory domain. When you add the session host through the Azure Virtual Desktop deployment workflow, Azure automatically installs the Azure Virtual Desktop agent and boot loader and registers the virtual machine with the host pool.

[!include[](../../../includes/azure-subscription-prerequisite.md)]

## Create a subnet and virtual network for the host pool

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select the **Cloud Shell** icon, and then select **PowerShell**.
1. Run the following commands to create a resource group, subnet, and virtual network. Replace `<location>` with an Azure region near you.

   ```powershell
   $resourceGroup = 'learn-firewall-rg'
   $location = '<location>'

   New-AzResourceGroup `
     -Name $resourceGroup `
     -Location $location

   $subnetConfig = New-AzVirtualNetworkSubnetConfig `
     -Name hostSubnet `
     -AddressPrefix 10.0.0.0/24

   $virtualNetwork = New-AzVirtualNetwork `
     -Name hostVNet `
     -AddressPrefix 10.0.0.0/16 `
     -Location $location `
     -ResourceGroupName $resourceGroup `
     -Subnet $subnetConfig
   ```

   This list shows some location values you can use:

   [!include[](../../../includes/azure-sandbox-regions-note.md)]

## Configure the host pool

1. In the Azure portal, search for and select **Azure Virtual Desktop**.
1. Select **Host pools**, and then select **Create**.
1. On the **Basics** tab, enter the following values:

   | Field | Value |
   | --- | --- |
   | Subscription | Your subscription |
   | Resource group | **learn-firewall-rg** |
   | Host pool name | **learn-host-pool** |
   | Location | The region you used for the virtual network |
   | Validation environment | **No** |
   | Preferred app group type | **Desktop** |
   | Host pool type | **Pooled** |
   | Load balancing algorithm | **Breadth-first** |
   | Max session limit | **2** |

1. Select **Next: Virtual Machines**.

## Add a session host

1. On the **Virtual machines** tab, enter the following values:

   | Field | Value |
   | --- | --- |
   | Add virtual machines | **Yes** |
   | Resource group | **learn-firewall-rg** |
   | Name prefix | **learnhost** |
   | Virtual machine type | **Azure virtual machine** |
   | Virtual machine location | The region you used for the virtual network |
   | Availability options | **No infrastructure redundancy required** |
   | Security type | **Trusted launch virtual machines** |
   | Image | A current **Windows 11 Enterprise multi-session** image |
   | Number of VMs | **1** |
   | Virtual network | **hostVNet** |
   | Subnet | **hostSubnet** |
   | Network security group | **None** |
   | Public inbound ports | **No** |
   | Select which directory you would like to join | **Microsoft Entra ID** |

1. Under **Virtual Machine Administrator account**, enter a local administrator name and a password that meets the Azure VM password requirements.
1. Select **Next: Workspace**.
1. For **Register desktop app group**, select **No**.
1. Select **Review + create**, and then select **Create** after validation passes.
1. Wait for the deployment to finish.

## Check your work

At this point, Azure Virtual Desktop has created a Microsoft Entra-joined VM and registered it as a session host.

1. In the Azure portal, search for and select **Azure Virtual Desktop**.
1. Select **Host pools** > **learn-host-pool**.
1. Under **Manage**, select **Session hosts**.
1. Confirm that the new session host appears and that its status changes to **Available**. If its status is **Unavailable**, wait a few minutes, and then select **Refresh**.

Next, you'll identify the routes, DNS settings, and firewall rule types that protect this session host.
