You need a well-planned IP-addressing schema to ensure ease of routing and manageable firewall rules. This unit discusses considerations and recommendations for enterprise IP-address planning in Azure.

## Considerations

One of the most critical considerations is to not use an overlapping RFC 1918 (private) IP space with on-premises or other clouds. Keep in mind that Azure reserves five IP addresses for each subnet in a virtual network. Also note that some Azure services, like an Azure ExpressRoute gateway or Azure Firewall, require dedicated subnets.

## Recommendations

Plan the cloud IP schema well in advance. Each Azure region should get its own easily summarized range. For example: 10.1.0.0/16 is West US 2 and 10.2.0.0/16 is North Europe.

Make sure to stick with private IP space. Use public IPs only if you own them and are out of private IP space.