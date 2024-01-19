In this module, you have learned about the different network segmentation options available on Azure. These include subscriptions, virtual networks (VNets), network security groups (NSGs), application security groups (ASGs), and Azure Firewall. You have also learned about common patterns for segmenting a workload in Azure from a networking perspective, including single VNet, multiple VNets that communicate through peering, and multiple VNets in a hub and spoke model. Each pattern provides a different type of isolation and connectivity, and you should choose a pattern based on your organization's needs. 

The main takeaways from this module are that segmentation is essential to maintaining your security posture, and you should capture all inbound and outbound traffic and perform near real-time analysis on that traffic to detect threats and mitigate network vulnerabilities. You should also enable Traffic Analytics and use Network Watcher packet capture regularly to get a more detailed understanding of your network traffic. Finally, you should not develop a custom solution to mirror traffic for large deployments, as the complexity and supportability issues tend to make custom solutions inefficient.

## Learning objectives

You learned how to:

-  Design solutions for network segmentation
-   Design solutions for filtering traffic with network security groups
-   Design solutions for network posture measurement
-   Design solutions for network monitoring

## Learn more with security documentation

- [Implement network segmentation patterns - Microsoft Azure Well-Architected Framework | Microsoft Learn](https://learn.microsoft.com/azure/architecture/framework/security/design-network-segmentation)
- [Azure network security groups overview | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview)
- [Microsoft Defender for DNS - the benefits and features | Microsoft Learn](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-dns-introduction)
- [Plan for traffic inspection - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-traffic-inspection)

## Learn more with reference architectures

- [Zero-trust network for web applications with Azure Firewall and Application Gateway - Azure Architecture Center | Microsoft Learn](https://learn.microsoft.com/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall)

> [!NOTE]
> This module contains AI-generated content.