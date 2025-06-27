In this exercise, you'll create a virtual network in Microsoft Azure. You'll then create two virtual machines (VMs), and use the virtual network to connect to the VMs and to the internet.

> [!IMPORTANT]
> The exercises in this module require a full Azure subscription. The exercises are optional, and are not required to complete this module. Participating in the interactive exercises in this module will result in charges billed to the Azure subscription you use to complete them. You can minimize incurred charges by cleaning up the resources you create as soon as possible. Cleanup directions are in the final unit.

## Sign in to your subscription

Sign in to Azure either by using the PowerShell cmdlet `Connect-AzAccount` on your local machine or by using [shell.azure.com/powershell](https://shell.azure.com/powershell).

## Create a resource group

First, create a resource group to contain all of the resources you'll create in this module. Name it `vm-networks` and replace `EastUS` in the following command with the name of the region in which you'd like the group to be created.

```PowerShell
$Location="EastUS" 
New-AzResourceGroup -Name vm-networks -Location $Location
```

## Create a subnet and virtual network

To create a subnet and virtual network, run the following command.

```PowerShell
 $Subnet=New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
 New-AzVirtualNetwork -Name myVnet -ResourceGroupName vm-networks -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet
```

## Create two virtual machines

All Azure VMs are connected to a virtual network. If you create a VM using Azure PowerShell and don't specify the name of an existing virtual network, Azure PowerShell creates a new virtual network automatically.

Here, we create two VMs and specify the virtual network.

1. To create the first virtual machine, run the following command to create a Windows VM with a public IP address that is accessible over port 3389 (Remote Desktop). This command creates a Windows 2016 Datacenter VM named `dataProcStage1` that uses the myVnet virtual network.

   ```PowerShell
   New-AzVm `
    -ResourceGroupName "vm-networks" `
    -Name "dataProcStage1" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "default" `
    -image "Win2016Datacenter" `
    -Size "Standard_DS2_v2" `
    -PublicIPAddressName "dataProcStage1"
    ```

    Port 3389 is opened automatically by default when you create a Windows VM in Azure.

1. Enter a user name and password for the VM. Write down user name and password. You need it later to sign in to the server.

1. Run the following command to get the public IP address for your VM so you can use it later. Copy the **IpAddress**.

   ```PowerShell
   Get-AzPublicIpAddress -Name dataProcStage1
    ```

1. Create the second VM named `dataProcStage2`.

   ```PowerShell
   New-AzVm `
    -ResourceGroupName "vm-networks" `
    -Name "dataProcStage2" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "default" `
    -image "Win2016Datacenter" `
    -Size "Standard_DS2_v2"
    ```

1. Enter a user name and password for the VM. Copy your user name and password. You need it later to sign in to the server.

## Connect to dataProcStage1 using Remote Desktop

1. Open Remote Desktop, and connect to `dataProcStage1` with the public IP address you noted from the previous steps. If you're using PowerShell locally, run the following command, and replace `publicIpAddress` with the VM's public IP address.

   ```PowerShell
   mstsc /v:publicIpAddress
   ```

1. Sign in to the remote machine with the username and the password you created.

1. In the remote session, open the Windows command prompt, and run the following command.

    ```cmd
    ping dataProcStage2 -4
    ```

1. In the results, you'll see that all requests to the `dataProcStage2` VM time out. This time-out happens because the default Windows Firewall configuration on `dataProcStage2` prevents it from responding to pings.

## Connect to dataProcStage2 using Remote Desktop

Configure the Windows Firewall on `dataProcStage2` using a new remote desktop session. You can't access `dataProcStage2` from your desktop because `dataProcStage2` doesn't have a public IP address. You'll use remote desktop from `dataProcStage1` to connect to `dataProcStage2`.

1. In the `dataProcStage1` remote session, open Remote Desktop.

1. Connect to `dataProcStage2` by name (by using `mstsc /v:dataProcStage2`). Based on the default network configuration, `dataProcStage1` can resolve the address for `dataProcStage2` using the computer name.

1. Sign in to `dataProcStage2` with the username and the password you created.

1. On `dataProcStage2`, select the Start Menu, enter **Firewall**, and press <kbd>Enter</kbd>. The **Windows Firewall with Advanced Security** console appears.

1. In the left-hand pane, select **Inbound Rules**.

1. In the right-hand pane, scroll down, right-click **File and Printer Sharing (Echo Request - ICMPv4-In)**, and then confirm that **Enable Rule** is enabled.

1. Switch back to the `dataProcStage1` remote session, and run the following command in the command prompt.

    ```cmd
    ping dataProcStage2 -4
    ```

    `dataProcStage2` responds with four replies, demonstrating connectivity between the two VMs.

You successfully created a virtual network, created two VMs that are attached to that virtual network, connected to one of the VMs and shown network connectivity to the other VM within the same virtual network. You can use Azure Virtual Network to connect resources within the Azure network. However, those resources need to be within the same resource group and subscription. Next, we'll look at VPN gateways, which enable you to connect virtual network in different resource groups, subscriptions, and even geographical regions.
