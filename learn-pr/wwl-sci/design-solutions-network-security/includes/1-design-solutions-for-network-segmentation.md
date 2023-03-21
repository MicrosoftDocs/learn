In this module, you learn how to:

-  Design solutions for network segmentation
-   Design solutions for filtering traffic with network security groups
-   Design solutions for network posture measurement
-   Design solutions for network monitoring

The content in the module helps you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications.
- Experience with hybrid and cloud implementations.

## Plan for landing zone network segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network zero-trust implementation.

**Design considerations:**

-   The [zero-trust model](https://learn.microsoft.com/security/zero-trust/deploy/networks) assumes a breached state and verifies each request as though it originates from an uncontrolled network.
    
-   An advanced zero-trust network implementation employs fully distributed ingress/egress cloud micro-perimeters and deeper micro-segmentation.
    
-   Network security groups ([NSG](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview)) can use Azure [service tags](https://learn.microsoft.com/azure/virtual-network/service-tags-overview) to facilitate connectivity to Azure PaaS services.
    
-   Application security groups ([ASG](https://learn.microsoft.com/azure/virtual-network/application-security-groups)) don't span or provide protection across virtual networks.
    
-   NSG [flow logs](https://learn.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview) are now supported through Azure Resource Manager templates.
    

**Design recommendations:**

-   Delegate subnet creation to the landing zone owner. This will enable them to define how to segment workloads across subnets (for example, a single large subnet, multitier application, or network-injected application). The platform team can use Azure Policy to ensure that an NSG with specific rules (such as deny inbound SSH or RDP from internet, or allow/block traffic across landing zones) is always associated with subnets that have deny-only policies.
    
-   Use NSGs to help protect traffic across subnets, as well as east/west traffic across the platform (traffic between landing zones).
    
-   The application team should use application security groups at the subnet-level NSGs to help protect multitier VMs within the landing zone.
    
    ![Diagram that shows how application security group works.](../media/azure-asg.png)
    
-   Use NSGs and application security groups to micro-segment traffic within the landing zone and avoid using a central NVA to filter traffic flows.
    
-   Enable NSG flow logs and feed them into [Traffic Analytics](https://learn.microsoft.com/azure/network-watcher/traffic-analytics) to gain insights into internal and external traffic flows. Flow logs should be enabled on all critical VNets/subnets in your subscription as an audit-ability and security best practice.
    
-   Use NSGs to selectively allow connectivity between landing zones.
    
-   For Virtual WAN topologies, route traffic across landing zones via Azure Firewall if your organization requires filtering and logging capabilities for traffic flowing across landing zones.
    
-   If your organization decides to implement forced tunneling (advertise default route) to on-premises, we recommend incorporating the following **outbound** NSG rules to deny egress traffic from VNets directly to the internet should the BGP session drop.