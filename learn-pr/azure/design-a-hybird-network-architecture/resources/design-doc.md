# Module Design

## Title

Design a hybrid network architecture on Azure

## Role(s)

- Solution architect

## Level

- Beginner

## Product(s)

- Azure VPN Gateway
- Azure ExpressRoute
- Azure Virtual Networks

## Prerequisites

- Knowledge of basic networking concepts (subnets, IP addressing, etc.)
- Familiarity with Azure virtual networking

## Summary

A customer has traditional on-premises infrastructure that they need to connect to resources in Azure. They need to select the appropriate connectivity method for their use cases, balancing functionality, cost, and security.

## Learning objectives

- Identify the methods to integrate on-premises networks with Azure
- Identify the features and limitations of each method of network integration
- Select the appropriate hybrid network solution for given use cases

## Chunk your content into subtasks

Identify the subtasks of *Design a hybrid network architecture on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Creating VPN Connections on Azure | Identify the methods to integrate on-premises networks with Azure | Knowledge Check | 1 | Yes |
| Using Azure ExpressRoute for hybrid networks | Identify the methods to integrate on-premises networks with Azure | Exercise & Knowledge Check | 1 | Yes |
| Overview of the Hub and Spoke Topology on Azure | Identify the methods to integrate on-premises networks with Azure | Knowledge Check | 1 | No - 5|
| Creating Azure Virtual Networks | Identify the features and limitations of each method of network integration | Exercise | 2 | No - 4 |
| Choosing a hybrid network architecture on Azure | Select the appropriate hybrid network solution for given use cases | Exercise | 3 | Yes |
||||||


## Outline the units

1. **Introduction**

    *A global enterprise is planning their migration to Azure. They will need to integrate resources in Azure with their on-premises networks and are unsure which technology is best suited for their use case. They have a central data center that needs connectivity to Azure, and several remote offices that will also need connectivity to Azure. They need to understand the pros and cons of each option, and when to select the various technologies for hybrid connectivity.*

2. **Creating VPN Connections on Azure**

    List the content that will enable the learner to *Creating VPN Connections on Azure*:

    - VPN Gateways on Azure
        - Overview of VPN Gateways
        - Run through VPN gateway connection topologies
        - VPN Gateway configuration
        - VPN gateway reference architecture

3. **Knowledge check**

    What types of questions will test *Identify the methods to integrate on-premises networks with Azure*?

    - Where is a point to site VPN connection established?
    - What connectivity speed is required for a site-to-site VPN?
    - Which of the following do VPN connections on Azure always require?

4. **Using Azure ExpressRoute for hybrid networks**

    List the content that will enable the learner to *Identify the methods to integrate on-premises networks with Azure*:

    - What is Azure ExpressRoute
        - Introduction to Azure ExpressRoute
        - Azure ExpressRoute circuits
        - Coexisting connections and Azure ExpressRoute
        - Azure ExpressRoute and virtual networks
        - Peering with Azure ExpressRoute
        - Azure ExpressRoute reference architecture
    
    - Using Azure ExpressRoute with VPN failover
        - Recap of Azure VPN connections and Azure ExpressRoute
        - Gateway and vNET configurations
        - Reference architecture for Azure ExpressRoute with VPN failover

5. **Exercise - Using Azure ExpressRoute for hybrid networks**

    List the steps that apply the learning content from previous unit (separate out each language):

    1. Run a script in the Cloud Shell to create a base architecture using ExpressRoute.
    1. Complete steps to complete the ExpressRoute workflow.
    1. Git clone source code to deploy VPN Gateway.
    1. Run through steps to configure VPN Gateway for failover.
    1. Run through using Azure Connectivity Toolkit for monitoring connectivity.

6. **Knowledge check**

    What types of questions will test *Using Azure ExpressRoute for hybrid networks*?

    - Which of the following is a valid connectivity model for Azure ExpressRoute?
    - Which type of IP addresses can be used for routing with Azure ExpressRoute?
    - Which architectural topology is suitable for high bandwidth and a highly available network?

7. **Overview of the Hub and Spoke Topology on Azure**

    List the content that will enable the learner to *Overview of the Hub and Spoke Topology on Azure*:

    - What is a hub-spoke topology
        - Introduction to hub-spoke architectures
        - When a hub-spoke architecture should be considered

8. **Creating Azure Virtual Networks**

    List the content that will enable the learner to *Identify the features and limitations of each method of network integration*:

    - Azure Virtual Networks
        - About Azure Virtual Networks
        - Traffic management with Azure Virtual Networks
        - Connecting Azure Virtual Networks

9. **Knowledge check**

    What types of questions will test *Overview of the Hub and Spoke Topology on Azure & Creating Azure Virtual Networks*?

    - What is a typical workload for a hub-spoke architecture?
    - What is required to control where traffic is routed in a virtual network?
    - What is the method for connecting virtual networks on Azure?

10. **Choosing a hybrid network architecture on Azure**

    List the content that will enable the learner to *Select the appropriate hybrid network solution for given use cases*:

    - Summary of hybrid network patterns
        - VPN Connections
        - Azure ExpressRoute
        - Hub-Spoke Topology

    - Azure Hybrid Networking
        - Considerations for Azure VPN gateways
        - Considerations for Azure ExpressRoute
        - Considerations for Azure ExpressRoute with VPN failover
        - Hybrid Networking Capability Matrix
        - Topology selection criteria and considerations

11. **Knowledge check**

    What types of questions will test *Choosing a hybrid network architecture on Azure*?

    - What is a valid use case for using Azure ExpressRoute?
    - When would an organization want to use a VPN connection for failover?
    - Which is a key consideration for all Azure hybrid architectural patterns?

12. **Summary**

    *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Overview of VPN connections on Azure.
    - Overview of Azure ExpressRoute.
    - Walkthrough peering with Azure Virtual Networks.
    - Capability matrix and use cases for understanding when to choose a particular service or architecture.
    - Whistle stop tour of hybrid network concepts on Azure.

## Notes

Azure VPN Gateway – Used to connect to on-premises networks over the internet through VPN. Uses, pros, and cons of this option will be covered. For the example scenario, VPN will be used to connect to smaller locations that don’t have enough traffic demands to necessitate ExpressRoute.

Azure ExpressRoute – Used to provide a private, dedicated connection to Azure. Uses, pros, and cons of this option will be covered. For the example scenario, ExpressRoute will be used to connect the headquarters location and data centers to Azure due to the higher traffic requirements.

Azure ExpressRoute with VPN failover – Used to provide a cost-effective failover option for ExpressRoute. Uses, pros, and cons of this option will be covered. For the example scenario, VPN failover will be used for the data center locations to ensure there is continuous connectivity to Azure in the event of a circuit provider failure.

Azure Virtual Network – Used to provide a location for gateways and for resources that need connectivity.

Resources:

Reference architecture: https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/
https://blogs.msdn.microsoft.com/azurecat/2018/11/21/hybrid-cloud-architecture-on-azure-portal/
https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways
