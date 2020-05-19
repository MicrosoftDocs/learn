# Module Design

## Title

Design a hybrid network architecture on Azure

## Role(s)

- Solution architect

## Level

- Intermediate

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
| On-premises network integration on Azure | Identify the methods to integrate on-premises networks with Azure | Knowledge Check | 1 | Yes |
| Using Azure ExpressRoute for hybrid networks | Identify the methods to integrate on-premises networks with Azure | Knowledge Check | 2 | Yes |
| Working with hybrid networks on Azure | Identify the methods to integrate on-premises networks with Azure | Knowledge Check | 2 | Yes |
| Choosing a hybrid network architecture on Azure | Select the appropriate hybrid network solution for given use cases | Knowledge Check | 3 | Yes |
||||||

## Outline the units

1. **Introduction**

    *A global enterprise is planning their migration to Azure. They will need to integrate resources in Azure with their on-premises networks and are unsure which technology is best suited for their use case. They have a central datacenter that needs connectivity to Azure, and several remote offices that will also need connectivity to Azure. They need to understand the pros and cons of each option, and when to select the various technologies for hybrid connectivity.*

2. **On-premises network integration on Azure**

    List the content that will enable the learner to *Identify the methods to integrate on-premises networks with Azure*:

    - Azure virtual networks
        - About Azure virtual networks
        - Traffic management and Azure VNets
        - Connecting Azure VNets

    - VPN Gateways on Azure
        - Overview of VPN gateways
        - Run through VPN gateway connection topologies
        - VPN gateway configuration
        - VPN gateway reference architecture

    What types of questions will test *Identify the methods to integrate on-premises networks with Azure*?

    - Where is a point to site VPN connection established?
    - What connectivity speed is required for a site-to-site VPN?
    - Which of the following do VPN connections on Azure always require?

3. **Using Azure ExpressRoute for hybrid networks**

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

    What types of questions will test *Identify the methods to integrate on-premises networks with Azure*?

    - Which of the following is a valid connectivity model for Azure ExpressRoute?
    - Which type of IP addresses can be used for routing with Azure ExpressRoute?
    - Which architectural topology is suitable for high bandwidth and a highly available network?

4. **Working with hybrid networks on Azure**

    List the content that will enable the learner to *Identify the features and limitations of each method of network integration*:

    - Summary of hybrid network patterns
        - VPN Connections
            - Features of VPN Connections
            - Limitations of VPN Connections
        - Azure ExpressRoute
            - Features of ExpressRoute Connections
            - Limitations of ExpressRoute Connections
        - Hub-Spoke Topology Overview
            - Introduction to hub-spoke architecture
            - When to consider a hub-spoke architecture

    What types of questions will test *Identify the features and limitations of each method of network integration*?

    - What is a typical workload for a hub-spoke architecture?
    - What is required to control where traffic is routed in a virtual network?
    - What is the method for connecting virtual networks on Azure?

5. **Choosing a hybrid network architecture on Azure**

    List the content that will enable the learner to *Select the appropriate hybrid network solution for given use cases*:

    - Azure Hybrid Networking
        - Scenarios for Azure VPN gateways (inc security, cost, performance, scalability and redundancy)
        - Scenarios for Azure ExpressRoute (inc security, cost, performance, scalability and redundancy)
        - Hybrid Networking Capability Matrix including key decision points.

    What types of questions will test *Select the appropriate hybrid network solution for given use cases*?

    - What is a valid use case for using Azure ExpressRoute?
    - When would an organization want to use a VPN connection for failover?
    - Which is a key consideration for all Azure hybrid architectural patterns?

6. **Summary**

    *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Overview of VPN connections on Azure.
    - Overview of Azure ExpressRoute.
    - Walk-through peering with Azure Virtual Networks.
    - Capability matrix and use cases for understanding when to choose a particular service or architecture.
    - Whistle stop tour of hybrid network concepts on Azure.

## Notes

Azure VPN Gateway – Used to connect to on-premises networks over the internet through VPN. Uses, pros, and cons of this option will be covered. For the example scenario, VPN will be used to connect to smaller locations that don’t have enough traffic demands to necessitate ExpressRoute.

Azure ExpressRoute – Used to provide a private, dedicated connection to Azure. Uses, pros, and cons of this option will be covered. For the example scenario, ExpressRoute will be used to connect the headquarters location and data centers to Azure due to the higher traffic requirements.

Azure ExpressRoute with VPN failover – Used to provide a cost-effective failover option for ExpressRoute. Uses, pros, and cons of this option will be covered. For the example scenario, VPN failover will be used for the data center locations to ensure there is continuous connectivity to Azure in the event of a circuit provider failure.

Azure Virtual Network – Used to provide a location for gateways and for resources that need connectivity.

Resources:

Reference architecture: <https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/>
<https://blogs.msdn.microsoft.com/azurecat/2018/11/21/hybrid-cloud-architecture-on-azure-portal/>
<https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways>

## Feedback

- Unit 5 isn't going to work. We don't have the ability to do ExpressRoute in sandbox. I expect this entire module to be conceptual with the only hands on interactivity coming from quizzes. **DW - Removed the exercise now**

- Move the knowledge check questions into the end of the units to slim down the overall number of units this module contains. 12 is too many. This will drop it to 8, and if unit 5 is removed that will put the total at 7. **Moved knowledge checks to one big quiz at the end, assuming i've understood your comments correctly**

- Can you expand on the details that are intended to be covered in 8. Creating Azure virtual networks? We have other modules that detail the ins and outs of virtual networks, so unless we're covering more advanced topics here, let's make sure this is needed and is of value. **It was simply a high level overview to cover a little about virtual networks nothing more the title was poorly named! I did raise the question about duplication in this module before i started the design, happy to remove if needs be**

I'm ok with this, but make sure these are real-world scenarios so the learner can pick the right options based on requirements. Use the quiz questions to help reinforce this.

- Make unit 10 one or two scenarios with quiz questions. Really test the learner to ensure they understand when the various connectivity types apply in various scenarios. Include decision points around cost, performance, security, redundancy, and plans for growth. **My thoughts were to run through the above for each architectural pattern anyway, I've tweaked the unit slightly**
