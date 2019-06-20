# Module Design

## Title

Centralize your core services using hub and spoke Azure VNet architecture

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Virtual Networks
- Azure vNet Peering
- Azure ExpressRoute
- Azure VPN
- Azure Network Security Groups
- Azure Firewall
- Azure Virtual Machines

## Prerequisites

- Basic understanding of networking concepts in traditional and cloud networks

## Summary

Design a network architecture in Azure that allows for growth & flexibility, secure isolation of critical resources, low administrative overhead, and communication with on-premises network resources.

## Learning objectives

- Identify the requirements and components for a hub and spoke network in Azure
- Identify the components and limitations for connectivity to on-premises networks
- Identify methods to secure connectivity in a hub and spoke network

## Chunk your content into subtasks

Identify the subtasks of *Centralize your core services using hub and spoke Azure VNet architecture*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Implementing a hub-spoke network topology on Azure | Identify the requirements and components for a hub and spoke network in Azure | Exercise | 1 | Yes |
| Planning Virtual Networks on Azure | Identify the components and limitations for connectivity to on-premises networks | Knowledge Check | 2 | Yes |
| Security by design with Azure | Identify methods to secure connectivity in a hub and spoke network | Knowledge Check | 3 | Yes |
||||||

## Outline the units

1. **Introduction**

    *An organization with multiple locations across the country is planning their migration to Azure. Their VM infrastructure will have central dependencies (AD, DNS, tooling services) that they will need to isolate but still allow access to. They will also have internet-facing resources, as well as on-premises connectivity that they need to include in their design.*

2. **Implementing a hub-spoke network topology on Azure**

    List the content that will enable the learner to *Identify the requirements and components for a hub and spoke network in Azure*:

    - Hub and Spoke Architecture Foundations
        - Introduction to the Hub-Spoke topology
        - Walk through of architectural components
        - Considerations for identity and access management
        - Peering and traffic management for hub-spoke on Azure

3. **Planning virtual networks on Azure**

    List the content that will enable the learner to *Identify the components and limitations for connectivity to on-premises networks*:

    - Overview of virtual networks on Azure
        - Introduction to Azure virtual networking
        - Planning and design considerations for virtual networks
        - Peering with Azure Virtual networks
        - Deploying Azure Virtual networks connecting to an on-premise network

    - Overview of Azure ExpressRoute
        - Summary of Azure ExpressRoute
        - Using Azure ExpressRoute in a hub-spoke topology

4. **Exercise - Implementing a hub-spoke network topology on Azure**

    List the steps that apply the learning content from previous unit (separate out each language):

        1. Run a script in the Cloud Shell to create foundational hub/spoke components.
        2. Complete the steps to enable virtual networking configuration.
        3. Run through virtual networking peering in the portal
        4. Configure NSG for each vnet

5. **Knowledge check**

    What types of questions will test *Planning Virtual Networks on Azure*?

    - What are Azure Virtual Networks used for?
    - What do you need to configure for direct connections between Azure resources?
    - Which of the following is a requirement for Azure ExpressRoute?

6. **Secure your hub and spoke network**

    List the content that will enable the learner to *Identify methods to secure connectivity in a hub and spoke network*:

    - Secure network design on Azure
        - Introduction to security on Azure
        - Base components of Azure security for hub-spoke topologies

    - Azure Firewall
        - Introduction to Azure Firewall
        - Deploying Azure Firewall
        - Monitoring Azure Firewall

    - Network security with Azure Network Security Groups
        - Overview of Azure Network Security Groups
        - Defining security rules
        - Traffic Flow with Network Security Groups
        - Additional security considerations

    **Knowledge check**

    What types of questions will test *Secure your hub and spoke network*?

    - What is Azure Network Access control?
    - Which of the following is not supported when using Azure Firewall?
    - Which Azure service would you use to filter network traffic?

7. **Summary**

   *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Overview of the hub-spoke topology for learner to understand requirements and base components.
    - Talk through networking concepts and services for hybrid connectivity
    - Walk through the base capabilities of network security on Azure.
    - Whistle stop tour of traffic management and security for secure connectivity

## Notes

Azure Virtual Networking – core piece that is used to design and host the network.
Azure VNet Peering – connectivity mechanism to allow integration between different VNets
Azure ExpressRoute – Will be used to provide connectivity to on-premises data center
VPN – Will be used to provide connectivity to smaller offices
Virtual machines – Used to host both centralized services in the hub VNet as well as services in the spoke VNets
Network security groups – Used to restrict access to the services in each VNet

Resources:

Reference architecture: <https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/shared-services>
<https://techcommunity.microsoft.com/t5/Azure/Microsoft-Azure-Hub-Spoke-model-by-Enterprise-Design-1-of-4/td-p/277896>
<http://francescomolfese.it/en/2018/08/azure-networking-introduzione-al-modello-hub-spoke/>
<https://azure.microsoft.com/mediahandler/files/resourcefiles/6ce2454f-eead-4b86-9a45-7434f890fea8/Mesh_and_Hub-Spoke_Networking_on_Azure.pdf>
<http://www.deployazure.com/network/virtual-network/azure-vnet-peering-gateway-transit-hub-and-spoke/>

Comments:

Phillip Stollery (Content Master Ltd) I've moved the design doc to GitHub for you. Overall, you're approved to move forward with content creation. A couple items of feedback:

I've made some minor changes to verbiage and a unit title.

- We may want to consider swapping unit 3 and 4. It has an overview of virtual networks in Azure, but that's after we create the vnets, this might make more sense before the actual exercise. Done
- Consider doing the exercise even later, and using Azure Firewall instead of the NVA
- NVA's are tricky, and can take time, they also are typically marketplace purchases, which are not available in sandbox. Consider just making that topical to keep the exercise do-able, or do Azure Firewall instead.
- Don't use the "security by design" term. We do want to cover security, but that's not a term I've seen used with Azure virtual networking.
- Make sure to weave the scenario through the content. How does the organization apply these services and capabilities to their architecture?
