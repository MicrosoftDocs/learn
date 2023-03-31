Contoso has a hybrid environment comprised of an on-premises site, Azure cloud services and Azure VMware Solution private cloud. Outlined below are some unique networking considerations for hybrid environments to consider.

## Network paths in Azure VMware Solution private cloud

Azure VMware Solution private cloud contains a management segment which is used to run infrastructure services such as vSAN, NSX-T, private cloud management, etc. Additionally, there may be one or more network segments for running applications – commonly referred as workload segments. Management and workload segments both use private IP address space. VMs running on workload segment can communicate with each other. However, additional configuration is required for workload segment VMs to be able to communicate outside of Azure VMware Solution private cloud. This is discussed in the *"Default outbound internet connectivity for Azure VMware Solution"* unit.

## Network paths in Azure

Contoso has connected their Azure VMware Solution private cloud to Azure through an ExpressRoute gateway. This ExpressRoute gateway is deployed inside of a Hub Azure Virtual Network (VNet). Hub Azure VNet uses a private IP address space. Hub Azure VNet is also connected with an on-premises site through ExpressRoute gateway. Additionally, Hub Azure VNet is connected with other Azure VNets through Azure VNet Peering. Contoso are also planning to run their favourite NVA inside of hub VNet.

## Enabling network path exchange between Azure VMware Solution and Azure

Contoso wants to enable exchanging routes across multiple sources such as their on-premises environment, ExpressRoute gateway and NVA. Contoso's IT team is familiar with such route exchanges using Border Gateway Protocol (BGP). They would like to continue using BGP. In Azure, BGP route exchange is enabled using a service called Azure Route Server. Azure Route Server (ARS) can set up the NVA's private IPs as its BGP peer. Once done, ARS will share its routes with the NVA as well as learn routes from the NVA. ARS also uses branch-to-branch connectivity to connect with ExpressRoute gateway. This ExpressRoute gateway is connected with Azure VMware Solution. ARS can then exchange routes with Azure VMware Solution's management as well as workload segments.

You now have a good understanding of how to exchange routes. In the next unit, you'll practice implementing route exchanges.
