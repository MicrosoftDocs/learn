

<!--Add in diagram - update diagram so it's numbered and has a flow-->
<!--The browser connects to the Bastion host over the internet by using the public IP associated to Bastion. You're then connected to the VM-->

An Azure Bastion deployment is per virtual network or peered virtual network, not per subscription, account, or virtual machine. After you provision an Azure Bastion service in your virtual network, the RDP/SSH experience is available to all your VMs in the same virtual network.

:::image type="icon" source="../media/3-bastion-architecture-overview.png" border="false" alt-text="Diagram that shows the process of connecting to a VM through the Azure portaly by using Azure Bastion.":::

1. **Connect to VM in the Azure portal** - In the Azure portal, on the VM overview page, select **Connect** > **Bastion** > **Use Bastion** and enter your credentials for the VM. All connections to Azure Bastion are enforced through Azure Active Directory token-based authentication and all traffic is encrypted over HTTPS.
1. **Browser connects to Bastion host** - The browser connects to Azure Bastion over the internet using the public IP of the Bastion host. 
1. **Bastion connects to VM** - Azure Bastion host servers are designed and configured to withstand attacks while providing access to workloads sitting behind the bastion host. Internally, Azure Bastion is a scale set and has the capability to resize itself as the number of sessions increases.

   Azure Bastion hosts are deployed in a separate subnet within the virtual network. This subnet, AzureBastionSubnet, is a secure platform managed subnet. No other Azure resources can be deployed in this subnet and you should not change the subnet name.  
1. **RDP or SSH session opens in the browser** - Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device. The Bastion service packages the session information using a custom protocol. The packages are transmitted using TLS.


## Verify Bastion works with your network security group

If you haven't deployed and configured a specific network security group for your organization, then you don't need to do anything. Bastion works with the default network security group that's created with VMs.

If you have a network security group deployed and configured for your organization, verify that Bastion can connect to your VMs through RDP or SSH. We recommend that you add an inbound rule that allows RDP and SSH connections from the Azure Bastion subnet IP address range to your VMs.

For Bastion to work, your network security group needs to allow the following traffic.

|Direction|Allow  |
|---------|---------|
|Inbound| RDP and SSH connections from the Azure Bastion subnet IP address range to your VM subnet.|
|Inbound| TCP access from the internet on port 443 to the Bastion public IP.|
|Inbound |TCP access from Azure Gateway Manager on ports 443 or 4443. The Azure Gateway Manager facilitates portal connections to the Bastion service.|
|Outbound|TCP access from the Azure Cloud on port 443. This traffic facilitates diagnostic logging.|
 
## Deploy Bastion host in the Azure portal

Before you can deploy Bastion, you need a virtual network. You can use an existing virtual network or deploy Bastion as you create a virtual network. Create a subnet in the virtual network called *AzureBastionSubnet*. If you have a VM that's on the same or a peered virtual network, you complete the deployment in the Azure portal by selecting Bastion when you connect to the VM.

The following two sections show you the steps involved for each of the Bastion deployment options in the Azure portal.

### Enable Bastion when you create a virtual network 

If you don't already have a virtual network that you want to use for Bastion, create a virtual network and enable Bastion on the **Security** tab. 

:::image type="content" source="../media/3-create-virtual-network-enable-bastion.png" alt-text="Screenshot of the security tab that allows you to enable and configure the Bastion host in the create virtual network workflow.":::

1. Select **Enable** and enter a name for your Bastion host. 
1. Add a subnet address. 
1. If you don't already have a public IP address that you want to use, select **Create new**.
1. After you create the virtual network, create VMs on this virtual network. Or peer this virtual network to the virtual network with your VMs.

### Add the subnet to an existing virtual network

For an existing virtual network, add a subnet named *AzureBastionSubnet*.

:::image type="content" source="../media/3-virtual-network-add-subnet.png" alt-text="Screenshot of the virtual network > subnets > add subnet page where the subnet name is AzureBastionSubnet.":::

As with the other deployment options, you complete the deployment by selecting Bastion when you connect to the VM. You'll see how this is done in the next unit.

## Deploy Bastion by using Azure PowerShell or the Azure CLI

If you want to use Azure PowerShell or the Azure CLI, you create a subnet, a public IP, and the Bastion resource. The following sections show you examples that you can use to deploy Bastion.

### Use Azure PowerShell to deploy Bastion

1. Create the Azure Bastion subnet by using the cmdlt `New-AzVirtualNetworkSubnetConfig`. Then add the subnet to your existing virtual network by using `Add-AzVirtualNetworkSubnetConfig`. For example, the following command assume you have already have a virtual network.

   ```powershell
   $subnetName = "AzureBastionSubnet"
   $virtualNetwork = MyVirtualNetwork
   $addressPrefix = "10.0.2.0/24"
   $subnet = New-AzVirtualNetworkSubnetConfig ` 
   -Name $subnetName ` 
   -AddressPrefix $addressPrefix `

   Add-AzVirtualNetworkSubnetConfig ` 
   -Name $subnetName `
   -VirtualNetwork $virtualNetwork `
   -AddressPrefix $addressprefix
   ```

1. Create a public IP address for Azure Bastion. The public IP address is used by Bastion to allow RDP/SSH connectivity over port 443. The public IP address must be in the same region as the Bastion resource.

   ```powershell
   $publicip = New-AzPublicIpAddress `
   -ResourceGroupName "myBastionRG" `
   -name "myPublicIP" `
   -location "westus2" `
   -AllocationMethod Static `
   -Sku Standard
   ```

1. Create a Azure Bastion resource in the AzureBastionSubnet of your virtual network.

   ```powershell
   $bastion = New-AzBastion `
   -ResourceGroupName "myBastionRG" `
   -Name "myBastion" `
   -PublicIpAddress $publicip `
   -VirtualNetwork $virtualNetwork
   ```

### Use the Azure CLI to deploy Bastion

1. Create the Azure Bastion subnet.

   ```azurecli
   az network vnet subnet create \
     --resource-group myBastionRG \
     --vnet-name MyVirtualNetwork \
     --name AzureBastionSubnet \
     --address-prefixes 10.0.2.0/24
   ```

1. Create a public IP address for Azure Bastion.

   ```azurecli
   az network public-ip create
     --resource-group MyResourceGroup \
     --name MyPublicIp \
     --sku Standard \
     --location westus2
   ```

1. Create a Azure Bastion resource

   ```azurecli
   az network bastion create \
     --name MyBastion \
     --public-ip-address MyPublicIp \
     --resource-group MyResourceGroup \
     --vnet-name MyVnet \
     --location northeurope
   ```

## Connect to VM by using Bastion