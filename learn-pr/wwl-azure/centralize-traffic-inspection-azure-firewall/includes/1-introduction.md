Network security groups (NSGs) control traffic by port and IP address, but they can't filter connections by domain name or detect whether a destination is malicious. After security engineers implement network segmentation with NSGs in the previous module, Contoso's security team faces a new challenge: the Security Officer mandates that all internet-bound traffic from Azure workloads must be inspected before egress.

The team determines that per-subnet NSG rules can't enforce fully qualified domain name (FQDN)-based allow lists—critical for ensuring Azure AI agents call only authorized OpenAI endpoints—nor can NSGs apply threat intelligence feeds to block known malicious destinations. Additionally, NSGs provide limited logging compared to a centralized solution that correlates traffic patterns across multiple workloads. East-west traffic between spoke virtual networks (VNets) also requires inspection and filtering, which NSGs alone can't provide efficiently at scale. Contoso requires a centralized firewall architecture.

Here, you learn when centralized traffic inspection with Azure Firewall is needed beyond NSG capabilities. Then you how to configure firewall rules and policies to control application and network traffic. Finally, learn how to secure a Virtual WAN hub with Azure Firewall for hub-and-spoke architectures.

## Learning objectives

By the end of this module, you're able to:

- Explain when Azure Firewall is required beyond what network security groups provide, including FQDN filtering and threat intelligence-based blocking.
- Configure Azure Firewall application rules and network rules to control traffic flow from Azure workloads.
- Deploy Azure Firewall in a Virtual WAN hub to centralize traffic inspection across a hub-and-spoke architecture.
