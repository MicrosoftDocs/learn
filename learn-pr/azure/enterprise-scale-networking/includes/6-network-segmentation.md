Network segmentation is a critical defense to slowing down a malicious actor. In this unit, there are enterprise design considerations and recommendations for network segmentation in Azure.

# Considerations

Design based on zero trust and assume breach. Systems should only be able to communicate with each other only on the ports and protocols needed by the applications. A few key items to remember are that 1. Application security groups don't span virtual networks 2. Network Security Groups (NSGs) are stateful but are not firewalls, but ACLs and 3. Azure Firewall is available as a first party service or there are third-party firewalls available in the "Azure Marketplace".

# Recommendations

Delegate subnet creation to the landing zone owner. This will enable them to define how to segment workloads across subnets (for example, a single large subnet, multitier app). The platform team can use Azure Policy to ensure an NSG with specific rules (such as deny inbound SSH or RDP from internet, or allow/block traffic across landing zones) is always associated to subnets with deny-only policies. Use NSGs to restrict traffic between subnets and other east-west traffic, use firewalls for North/South traffic. Be sure to enable NSG flow logs and feed them into Traffic Analytics in order to audit traffic or debug network flows. Use NSGs selectively for inter-landing-zone traffic but for Virtual Wan implementations, route traffic between landing zones via Azure Firewall if required.

The following figure shows a sample global enterprise deployment with datacenters spread across Europe and the United States. The deployment also has a large number of branch offices within both regions. The environment is globally connected via Virtual WAN and ExpressRoute Global Reach and segmentation is managed by Azure Firewall. 

![VWAN with Azure Firewall.](./media/globalsecurevwan.png)