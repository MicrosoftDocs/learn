RDP and SSH are very often the primary means used to connect to remote IaaS VMs. But exposing these management ports to the internet poses significant security risks. In this unit, we'll discuss how you can connect securely with these protocols by deploying Azure Bastion at the public side of your perimeter network. In this unit, you'll learn about: 

-  The Azure Bastion architecture
- How Azure Bastion provides secure RDP/SSH connections to hosted VMs
- The requirements for Azure Bastion to help to evaluate its relevance in your organization


## Azure Bastion architecture

The following diagram displays the architecture of a typical Azure Bastion deployment, and describes the end to end connection process. In this diagram, an Azure Bastion host is deployed in a virtual network that contains a number of Azure VMs. The virtual network is protected by a network security group.

:::image type="content" source="../media/bastion-architecture.png" alt-text="A diagram displays the architecture of Azure Bastion. Three VMs are protected by a network security group that enables RDP and SSH traffic from an Azure Bastion subnet. The Bastion supports communications only via TCP port 443 from the Azure portal.":::

> [!NOTE]
> The protected VMs and the Azure  Bastion host are connected to the same virtual network, although in different subnets.

The typical connection process, described in the preceding, proceeds as follows:

1. An administrator connects to the Azure portal using any HTML5 browser over a connection secured with TLS. The administrator selects the VM they want to connect to.
2. The portal connects over a secured connection to Azure Bastion via a network security group protecting the virtual network that hosts the targeted VM.
3. Azure Bastion initiates a connection to the target VM. 
4. The RDP or SSH session opens in the browser on the administrator console. Azure Bastion streams the session information through custom packages. These packages are protected by TLS.

By using Azure Bastion, you bypass the need to directly expose RDP/SSH to the internet on a public IP. Instead, you connect to Azure Bastion securely with SSL, and it connects to the target VMs using a private IP. 

## Usage requirements

Administrators that wish to connect through Azure Bastion to IaaS VMs in Azure require the Reader role on the following components:

- The target VM 
- The network interface card (NIC) with private IP on the target VM
- The Azure Bastion resource

When you deploy Azure Bastion, you deploy it to its own subnet within a virtual network or peered virtual network. 

> [!TIP]
> The subnet must be called AzureBastionSubnet.

Because Azure Bastion is protected by the virtual network's network security group, your network security group needs to support the following traffic flow:

- **Inbound**. 
   - RDP and SSH connections from the Azure Bastion subnet to the target VM subnet
   - TCP port 443 access from the internet to the Azure Bastion public IP
   - TCP access from Azure Gateway Manager on ports 443 or 4443. 
- **Outbound**. 
   - TCP access from the Azure platform on port 443 to support diagnostic logging.

> [!NOTE]
> Azure Gateway Manager manages portal connections to the Azure Bastion service.



