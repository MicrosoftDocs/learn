
To build highly resilient enterprise grade applications on Azure, a well-designed network is critical. Carefully plan the IP schema, being sure to not conflict with existing private IP space. Carefully choose the connectivity type, Virtual WAN or hub and spoke. Select ExpressRoute providers or ExpressRoute Direct and peering locations to get onto the Microsoft backbone with the least latency possible. Finally, plan segmentation and secure connectivity to PaaS services.

## Learn more

To Learn more about enterprise-scale architecture networking design principles, visit the following articles:

[Full enterprise-scalelLanding zone networking documentation](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity?azure-portal=true)

### DNS

[Azure Private Endpoint DNS configuration](https://docs.microsoft.com/azure/private-link/private-endpoint-dns?azure-portal=true)
[Azure DNS Private zones scenarios](https://docs.microsoft.com/azure/dns/private-dns-scenarios?azure-portal=true)

### Topology

[Network Virtual Appliance routing](https://docs.microsoft.com/azure/virtual-wan/scenario-route-through-nva?azure-portal=true)
[Migrate to Azure Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/migrate-from-hub-spoke-topology?azure-portal=true)
[Azure Virtual WAN limits](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-faq#is-there-a-network-throughput-or-connection-limit-when-using-azure-virtual-wan?azure-portal=true)
[Azure subscription and service limits](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits?azure-portal=true)

### Connectivity

[ExpressRoute](https://docs.microsoft.com/azure/expressroute/expressroute-introduction?azure-portal=true)
[ExpressRoute Direct](https://docs.microsoft.com/azure/expressroute/expressroute-erdirect-about?azure-portal=true)
[Configure Network Performance Manager for ExpressRoute](https://docs.microsoft.com/azure/expressroute/how-to-npm?azure-portal=true)
[ExpressRoute connectivity partners and peering locations](https://docs.microsoft.com/azure/expressroute/expressroute-locations?azure-portal=true)

### Segmentation

[Network security groups](https://docs.microsoft.com/azure/virtual-network/security-overview?azure-portal=true)
[What is Azure Firewall?](https://docs.microsoft.com/azure/firewall/overview?azure-portal=true)

### Encryption

[Configure MACsec on ExpressRoute Direct ports](https://docs.microsoft.com/azure/expressroute/expressroute-howto-macsec?azure-portal=true)
