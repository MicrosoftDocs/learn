RDP and SSH are often the primary means used to connect to remote IaaS VMs, but exposing these management ports to the internet poses significant security risks. In this unit, we describe how you can connect securely with these protocols by deploying Azure Bastion at the public side of your perimeter network. In this unit, you learn about:

- The Azure Bastion architecture.
- How Azure Bastion provides secure RDP/SSH connections to hosted VMs.
- The requirements for Azure Bastion, so that you can evaluate its relevance in your organization.

## Azure Bastion architecture

The following diagram depicts the architecture of a typical Azure Bastion deployment and describes the end-to-end connection process. In this diagram:

- Azure Bastion is deployed in a virtual network that contains several Azure VMs.
- NSGs protect the subnets in the virtual network.
- The NSG protecting the VM subnet allows RDP and SSH traffic from the Azure Bastion subnet.
- Azure Bastion supports communications only through TCP port **443** from the Azure portal or via native client (not shown).

:::image type="content" source="../media/bastion-architecture.png" alt-text="The architecture of Azure Bastion, as described in the preceding text.":::

> [!NOTE]
> The protected VMs and the Azure  Bastion host are connected to the same virtual network, although in different subnets.

The typical connection process in Azure Bastion is as follows:

1. An administrator connects to the Azure portal using any HTML5 browser by using a connection secured with TLS. The administrator selects the VM they want to connect to.
2. The portal connects over a secured connection to Azure Bastion through an NSG that's protecting the virtual network that hosts the targeted VM.
3. Azure Bastion initiates a connection to the target VM.
4. The RDP or SSH session opens in the browser on the administrator console. Azure Bastion streams the session information through custom packages. These packages are protected by TLS.

By using Azure Bastion, you bypass the need to directly expose RDP/SSH to the internet on a public IP. Instead, you connect to Azure Bastion securely with Secure Sockets Layer (SSL), and it connects to the target VMs using a private IP.

## Usage requirements

Administrators that want to connect to IaaS VMs in Azure through Azure Bastion require the Reader role on:

- The target VM.
- The network interface with private IP on the target VM.
- The Azure Bastion resource.

When you deploy Azure Bastion, you deploy it to its own subnet within a virtual network or peered virtual network.

> [!TIP]
> The subnet must be called **AzureBastionSubnet**.

Because Azure Bastion is protected by the virtual network's NSG, your NSG needs to support the following traffic flow:

- Inbound:
  - RDP and SSH connections from the Azure Bastion subnet to the target VM subnet
  - TCP port **443** access from the internet to the Azure Bastion public IP
  - TCP access from Azure Gateway Manager on ports **443** or **4443**
- Outbound:
  - TCP access from the Azure platform on port **443** to support diagnostic logging

> [!NOTE]
> Azure Gateway Manager manages portal connections to the Azure Bastion service.
