A well-planned IP addressing schema is required to ensure ease of routing and manageable firewall rules. This unit discusses considerations and recommendations for enterprise IP address planning in Azure.

# Considerations

One of the most critical considerations is to not use overlapping RFC 1918 (private) IP space with on-prem or other clouds. Keep in mind that Azure will reserve five IP addresses for each subnet in a Virtual Network. Also note that some Azure services like an ExpressRoute Gateway or Azure Firewall will require dedicated subnets.

# Recommendations

Plan the cloud IP schema well in advance, each Azure Region should get its own easily summarized range. For instance 10.1.0.0/16 is West US 2 and 10.2.0.0/16 is North Europe, etc. Make sure to stick with private IP space. Only use public IPs if you own them and are out of private IP space. Finally, be sure to not use overly large single Virtual Networks like a /16 as to not waste private IP space.
