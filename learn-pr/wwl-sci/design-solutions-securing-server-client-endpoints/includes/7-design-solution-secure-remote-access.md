This article describes the recommended guidance for providing remote access to virtual machines (VMs) deployed within an Azure landing zones architecture.

Azure offers different technologies for providing remote access to VMs:

- [Azure Bastion](/azure/bastion/bastion-overview), a platform as a service (PaaS) solution, for accessing VMs through a browser or through the native SSH/RDP client on your local workstation
- [Just-in-time (JIT)](/azure/defender-for-cloud/just-in-time-access-overview) access provided through Microsoft Defender for Cloud
- Hybrid connectivity options, such as Azure ExpressRoute and VPNs
- Public IP attached directly to the VM or through a NAT rule via an Azure public load balancer

The choice of which remote access solution is most appropriate depends on factors like scale, topology, and security requirements.

## Design considerations

- When available, you can use existing hybrid connectivity to Azure virtual networks via ExpressRoute or site-to-site (S2S)/point-to-site (P2S) VPN connections to provide remote access from on-premises to Windows and Linux Azure VMs.
- NSGs can be used to secure SSH/RDP connections to Azure VMs.
- JIT allows remote SSH/RDP access over the internet without having to deploy any other infrastructure.
- There are some [availability limitations](/azure/defender-for-cloud/just-in-time-access-usage) with JIT access.
  - JIT access can't be used for VMs protected by Azure firewalls controlled by Azure Firewall Manager.
- [Azure Bastion](/azure/bastion/bastion-overview) provides an extra layer of control. It enables secure and seamless RDP/SSH connectivity to your VMs directly from the Azure portal or through the [native client](/azure/bastion/connect-native-client-windows) over a secure TLS channel. Azure Bastion also negates the need for hybrid connectivity.
- Azure Bastion offers four SKU tiers. Select the appropriate tier based on your requirements:
  - **Developer**: Free tier for development and testing. Supports one VM connection at a time without virtual network peering.
  - **Basic**: Dedicated deployment with fixed capacity for production environments requiring standard connectivity.
  - **Standard**: Includes advanced features such as native client support, shareable links, IP-based connections, host scaling (2-50 instances), and file transfer.
  - **Premium**: Adds session recording for compliance requirements and private-only deployment without a public IP address.
- Review the [Azure Bastion SKU comparison](/azure/bastion/bastion-sku-comparison) to select the tier that meets your security and compliance requirements.
- Azure Bastion can be used in [Azure Virtual WAN topology](/azure/cloud-adoption-framework/ready/azure-best-practices/virtual-wan-network-topology) however there are some limitations:
  - Azure Bastion can't be deployed inside of a Virtual WAN virtual hub.
  - Azure Bastion must use `Standard` or `Premium` SKU with the `IP based connection` feature enabled. See the [Azure Bastion IP based connection documentation](/azure/bastion/connect-ip-address).
  - Azure Bastion can be deployed in any spoke virtual network connected in a Virtual WAN, for accessing virtual machines in its own or other virtual networks that are connected to the same Virtual WAN, via its associated hubs, through Virtual WAN virtual network connections; providing [routing](/azure/virtual-wan/about-virtual-hub-routing) is configured correctly.
- For environments with strict compliance requirements, consider the Premium SKU for [session recording](/azure/bastion/session-recording) capabilities that capture RDP/SSH sessions for audit purposes.

## Design recommendations

- Use existing ExpressRoute or VPN connectivity to provide remote access to Azure VMs that are accessible from on-premises.
- For highly sensitive environments, consider Azure Bastion Premium SKU with private-only deployment to eliminate public IP address exposure while maintaining secure remote access.
- In a Virtual WAN-based network topology where remote access to virtual machines over the internet is required:
  - Azure Bastion can be deployed in each spoke virtual network of the respective VMs.
  - Or you may choose to deploy a centralized Azure Bastion instance in a single spoke in your Virtual WAN topology, as shown in Figure 1. This configuration reduces the number of Azure Bastion instances to manage in your environment. This scenario requires users who sign in to Windows and Linux VMs via Azure Bastion to have a [reader role on the Azure Bastion resource and the chosen spoke virtual network](/azure/bastion/bastion-faq#peering). Some implementations might have security or compliance considerations that restrict or prevent this.
- In hub-and-spoke network topology, where remote access to Azure Virtual Machines over the internet is required:
  - A single Azure Bastion host can be deployed in the hub virtual network, which can provide connectivity to Azure VMs on spoke virtual networks via virtual network peering. This configuration reduces the number of Azure Bastion instances to manage in your environment. This scenario requires users who sign in to Windows and Linux VMs via Azure Bastion to have a [reader role on the Azure Bastion resource and the hub virtual network](/azure/bastion/bastion-faq#peering). Some implementations might have security or compliance considerations. See Figure 2.
  - Your environment might not permit granting users the reader role-based access control (RBAC) role on the Azure Bastion resource and the hub virtual network. Use Azure Bastion Basic or Standard to provide connectivity to VMs within a spoke virtual network. Deploy a dedicated Azure Bastion instance into each spoke virtual network that requires remote access. See Figure 3.
- Configure NSG rules to protect Azure Bastion and the VMs to which it provides connectivity. Follow the guidance in [Working with VMs and NSGs in Azure Bastion](/azure/bastion/bastion-nsg).
- Configure Azure Bastion diagnostic logs to be sent to the central Log Analytics workspace. Follow the guidance in [Enable and work with Azure Bastion resource logs](/azure/bastion/diagnostic-logs).
- Ensure the [required RBAC role assignments](/azure/bastion/bastion-faq#roles) are made for the users or groups that connect to the VMs via Azure Bastion are in place.
- If you connect to Linux VMs via SSH, use the feature of [connecting by using a private key stored in Azure Key Vault](/azure/bastion/bastion-connect-vm-ssh-linux#akv).
- Deploy Azure Bastion and ExpressRoute or VPN access to address specific needs like emergency break-glass access.
- Remote access to Windows and Linux VMs via public IPs directly attached to the VMs isn't recommended. Remote access should never be deployed without strict NSG rules and firewalling.
- When using JIT access, be aware that it requires Microsoft Defender for Servers Plan 2 and can't be used for VMs protected by Azure firewalls controlled by Azure Firewall Manager.

:::image type="content" source="../media/azure-virtual-wan-topology-bastion.png" alt-text="Diagram that shows Azure virtual WAN topology." lightbox="../media/azure-virtual-wan-topology-bastion.png":::

_Figure 1: Azure Virtual WAN topology._

:::image type="content" source="../media/azure-hub-spoke-bastion.png" alt-text="Diagram that shows Azure hub-and-spoke topology." lightbox="../media/azure-hub-spoke-bastion.png":::

_Figure 2: Azure hub-and-spoke topology._

:::image type="content" source="../media/azure-standalone-bastion.png" alt-text="Diagram that shows Azure standalone virtual network topology." lightbox="../media/azure-standalone-bastion.png":::

_Figure 3: Azure standalone virtual network topology._

Related reference architectures:

- [Implement a secure hybrid network - Azure Architecture Center](/azure/architecture/reference-architectures/dmz/secure-vnet-dmz?tabs=portal)
- [On-premises network using ExpressRoute - Azure Architecture Center](/azure/architecture/reference-architectures/hybrid-networking/expressroute)
