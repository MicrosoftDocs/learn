
To build highly resilient enterprise grade applications on Azure, a well-designed network is critical. Carefully the IP schema, being sure to not conflict with existing private IP space. Carefully choose the connectivity type, Virtual WAN or Hub and Spoke. Select ExpressRoute providers or ExpressRoute Direct and peering locations to get onto the MIcrosoft backbone with the least latency possible. Finally, plan segmentation and secure connectivity to PaaS services. 

# Helpful Links

Full Enterprise Scale Landing Zone networking documentation: https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity

## DNS
For detailed information on this DNS configuration see here: <https://docs.microsoft.com/azure/private-link/private-endpoint-dns>
For more information on private DNS, see <https://docs.microsoft.com/azure/dns/private-dns-scenarios>

## Topology

Network Virtual Appliance routing: <https://docs.microsoft.com/azure/virtual-wan/scenario-route-through-nva> 
To move from hub and spoke to VWAN see: <https://docs.microsoft.com/azure/virtual-wan/migrate-from-hub-spoke-topology>
VWAN Limits <https://docs.microsoft.com/azure/virtual-wan/virtual-wan-faq#is-there-a-network-throughput-or-connection-limit-when-using-azure-virtual-wan>
Azure Limits https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits  

## Connectivity

ExpressRoute: https://docs.microsoft.com/azure/expressroute/expressroute-introduction 
ExpressRoute Direct: <https://docs.microsoft.com/azure/expressroute/expressroute-erdirect-about> 
NPM <https://docs.microsoft.com/azure/expressroute/how-to-npm>
Peering locations: <https://docs.microsoft.com/azure/expressroute/expressroute-locations> 
NAT Gateway: <https://docs.microsoft.com/azure/virtual-network/nat-gateway-resource> 

# Segmentation
<https://docs.microsoft.com/azure/virtual-network/security-overview>
<https://docs.microsoft.com/azure/firewall/overview>

# Encyption
To enable ExpressRoute direct with MACSec, follow the guidance here: <https://docs.microsoft.com/azure/expressroute/expressroute-howto-macsec>

