To build highly resilient, enterprise-grade applications on Azure, a well-designed network is critical. Carefully plan the IP schema so you don't conflict with existing private IP space. Carefully choose the connectivity type: Azure Virtual WAN or hub and spoke. Select Azure ExpressRoute providers or ExpressRoute Direct and peering locations to get onto the Microsoft backbone with the least latency possible. Finally, plan segmentation and secure connectivity to platform as a service (PaaS) services.

## Learn more

To Learn more about networking design principles for enterprise-scale architecture, see the following articles.

### Landing zone

- [Full enterprise-scale landing zone networking documentation](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity?azure-portal=true)

### DNS

- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns?azure-portal=true)
- [Azure DNS Private Zones scenarios](/azure/dns/private-dns-scenarios?azure-portal=true)

### Topology

- [Network Virtual Appliance routing](/azure/virtual-wan/scenario-route-through-nva?azure-portal=true)
- [Migrate to Azure Virtual WAN](/azure/virtual-wan/migrate-from-hub-spoke-topology?azure-portal=true)
- [Azure Virtual WAN limits](/azure/virtual-wan/virtual-wan-faq#is-there-a-network-throughput-or-connection-limit-when-using-azure-virtual-wan?azure-portal=true)
- [Azure subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?azure-portal=true)

### Connectivity

- [ExpressRoute](/azure/expressroute/expressroute-introduction?azure-portal=true)
- [ExpressRoute Direct](/azure/expressroute/expressroute-erdirect-about?azure-portal=true)
- [Configure Network Performance Monitor for ExpressRoute](/azure/expressroute/how-to-npm?azure-portal=true)
- [ExpressRoute connectivity partners and peering locations](/azure/expressroute/expressroute-locations?azure-portal=true)

### Segmentation

- [Network security groups](/azure/virtual-network/security-overview?azure-portal=true)
- [What is Azure Firewall?](/azure/firewall/overview?azure-portal=true)

### Encryption

- [Configure MACsec on ExpressRoute Direct ports](/azure/expressroute/expressroute-howto-macsec?azure-portal=true)