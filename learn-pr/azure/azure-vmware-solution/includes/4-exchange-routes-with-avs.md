﻿Contoso has a hybrid environment comprised of an on-premises site, Azure cloud services, and Azure VMware Solution private cloud. The following sections demonstrate unique networking considerations for hybrid environments to consider.

## Network paths in Azure VMware Solution private cloud

Azure VMware Solution private cloud contains a management segment which is used to run infrastructure services such as vSAN, NSX Data Center, private cloud management, etc. Additionally, there can be one or more network segments for running applications – commonly referred as workload segments. Management and workload segments both use the private IP address space. Virtual machines (VMs) running on a workload segment can communicate with each other. However, extra configuration is required for workload segment VMs to communicate outside of Azure VMware Solution private cloud which is discussed in the [Default outbound internet connectivity for Azure VMware Solution](../2-outbound-internet-connectivity.yml) unit.

## Network paths in Azure

Contoso connected their Azure VMware Solution private cloud to Azure through an ExpressRoute gateway. This ExpressRoute gateway is deployed inside of a Hub Azure virtual network (VNet). Hub Azure VNet uses a private IP address space. Hub Azure VNet is also connected with an on-premises site through ExpressRoute gateway. Additionally, Hub Azure VNet is connected with other Azure VNets through Azure VNet Peering. Contoso are also planning to run their favorite NVA inside of hub VNet.

## Enabling network path exchange between Azure VMware Solution and Azure

Contoso wants to enable exchanging routes across multiple sources such as their on-premises environment, ExpressRoute gateway, and NVA. Contoso's IT team is familiar with such route exchanges using Border Gateway Protocol (BGP). They would like to continue using BGP. In Azure, BGP route exchange is enabled using a service called Azure Route Server. Azure Route Server (ARS) can set up the NVA's private IPs as its BGP peer. Once done, ARS shares its routes with the NVA and learn from them. ARS also uses branch-to-branch connectivity to connect with ExpressRoute gateway. This ExpressRoute gateway is connected with Azure VMware Solution. ARS can then exchange routes with Azure VMware Solution's management and workload segments.

You now have a good understanding of how to exchange routes. In the next unit, you'll practice implementing route exchanges.
