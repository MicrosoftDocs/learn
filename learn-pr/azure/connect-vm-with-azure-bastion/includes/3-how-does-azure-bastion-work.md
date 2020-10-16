

<!--Add in diagram - update diagram so it's numbered and has a flow-->
<!--The browser connects to the Bastion host over the internet by using the public IP associated to Bastion. You're then connected to the VM-->

An Azure Bastion deployment is per virtual network or peered virtual network, not per subscription, account, or virtual machine. After you provision an Azure Bastion service in your virtual network, the RDP/SSH experience is available to all your VMs in the same virtual network.

:::image type="icon" source="../media/3-bastion-architecture-overview.png" border="false" alt-text="Diagram that shows the process of connecting to a VM through the Azure portaly by using Azure Bastion.":::

1. **Connect to VM in the Azure portal** - In the Azure portal, on the VM overview page, select **Connect** > **Bastion** > **Use Bastion** and enter your credentials for the VM. All connections to Azure Bastion are enforced through Azure Active Directory token-based authentication and all traffic is encrypted over HTTPS.
1. **Browser connects to Bastion host** - The browser connects to Azure Bastion over the internet using the public IP of the Bastion host. 
1. **Bastion connects to VM** - Azure Bastion host servers are designed and configured to withstand attacks while providing access to workloads sitting behind the bastion host. Internally, Azure Bastion is a scale set and has the capability to resize itself as the number of sessions increases.

   Azure Bastion hosts are deployed in a separate subnet within the virtual network. This subnet, AzureBastionSubnet, is a secure platform managed subnet. No other Azure resources can be deployed in this subnet and you should not change the subnet name.  
1. **RDP or SSH session opens in the browser** - Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device. The Bastion service packages the session information using a custom protocol. The packages are transmitted using TLS.


## No need to manage network security groups

If you haven't deployed and configured a specific network security group for your organization, then you don't need to do anything. Bastion works with the default network security group that's created with new VM.

If they have NSG deployed and configured, then they need to make sure Bastion can connect to VMs via RDP/SSH. "As a best practice,"..."add the Azure Bastion Subnet IP address range in this rule to allow only Bastion to be able to open these ports on the target VMs in your target VM subnet."  Also needs to allow:
      - Allow TCP access from the Azure Gateway Manager on ports 443 or 4443. The Azure Gateway Manager facilitates portal connections to the Bastion service. 
      - Allow TCP access from the internet on port 443.
      - Allow outbound TCP access from the Azure Cloud on port 443. This facilitates diagnostic logging."

   Reference: https://docs.microsoft.com/azure/bastion/bastion-nsg

   ***How to deploy Bastion host (high-level overview)***

   - Prereqs: address space
   - Create in portal - two methods:
     - Create the BastionSubnet and deploy the Bastion Host as a part of the VNet creation experience (new). Include screenshots to show how this is done and the resources you end up with. ID suggests illustration that provides overview of process.
     - Or if you have existing VNet/VM, add subnet & then deploy bastion host from VM connection. (This is what we'll show in exercise.)
   - Create by using Azure PowerShell: show sample commands from https://docs.microsoft.com/azure/bastion/bastion-create-host-powershell
   - CLI: https://docs.microsoft.com/azure/bastion/create-host-cli
   -  What gets created when you deploy (Show this in next unit exercise?)-->