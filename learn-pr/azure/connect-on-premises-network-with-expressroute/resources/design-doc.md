# Module design

## Title

Connect your on-premises network to the Microsoft global network with ExpressRoute

## Role(s)

- Solution Architect

## Level

- Beginner

## Product(s)

- ExpressRoute

## Prerequisites

- Basic knowledge of networking concepts 

## Summary

Connect your on-premises systems and users to Azure and Office 365 with ExpressRoute for private, dedicated, and guaranteed throughput connectivity.

## Learning objectives

1. Identify the features and capabilities of ExpressRoute
1. Identify the use cases for using ExpressRoute to integrate traditional networks with Azure

## Chunk your content into subtasks

Identify the subtasks of *Connect your on-premises network to the Microsoft global network with ExpressRoute*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe Azure ExpressRoute | Confirm whether ExpressRoute meets their needs. Understand the service. | Knowledge Check | 1 | Yes |
| Describe how Azure ExpressRoute works | Need to understand more about the service before including it in their infrastructure. | Knowledge check | 1 | Yes |
| Describe when to use Azure ExpressRoute | Checking ExpressRoute use cases against the organization's requirements. | Knowledge check | 1 & 2 | Yes |


## Outline the units

1. **Introduction**

    A financial organization has begun migrating resources to Azure. They have systems that need to communicate between their on-premises network and Azure, and they do not want this traffic traversing the internet. They have higher bandwidth requirements and need the ability to have consistent network performance. They also use Office 365 and would like to reduce traffic over their internet pipe and send this traffic over a dedicated connection to Azure. They believe ExpressRoute meets their needs but need to understand more about the service to include it in their infrastructure.

1. **What is the Azure ExpressRoute service**

   - Describe the Azure ExpressRoute service
       - What is Azure ExpressRoute?
       - What can the service be used for?  
         - Connecting on-premises networks to Azure
         - Connecting to SaaS offerings in Azure, such as Office 365
         - What else is ExpressRoute beneficial for?
        - Call out that ExpressRoute needs to be implemented through a Provider. See [Azure Expressroute providers and locations](https://docs.microsoft.com/azure/expressroute/expressroute-locations))
    - What features and benefits does Azure ExpressRoute provide?  
        - Layer 3 connectivity
        - Connectivity to Microsoft cloud services in all regions
        - Built in redundancy 
        - Dynamic routing    
        - QoS support for Skype
   
    - Provide a high-level reference architecture, showing connectivity between on-premises and Azure networks
	
   - Describe the ExpressRoute connectivity models – CloudExchange Co-location, Point-to-Point Ethernet Connection, and Any-to-Any IPVPN Connection
        - What is the difference between each model?  Show a table listing pros and cons for each model 
	
	- Discuss security considerations when implementing ExpressRoute
	   - Can encryption can be enabled for traffic flowing over ExpressRoute circuits?
	   - Can you control who has access to create and manage the circuits?
	   - How can you ensure data is not compromised?  Summarize security options with Azure ExpressRoute.

    **Knowledge check**

      - What is the Azure ExpressRoute service?
      - What are the requirements to implement Azure ExpressRoute?
      - What security benefits does Azure ExpressRoute provide? 
      
1.  **How Azure ExpressRoute works**

       - What are the prerequisites for ExpressRoute?
           -  What needs to be configured for connectivity from on-premises to Azure?
           - What are the requirements to access services, such as Office 365, from on-premises networks?
           - What are ExpressRoute circuits, and why do I need them?
           - ExpressRoute requires you to setup and manage routing to access Microsoft cloud services.  How can you do this?
    
       - Explain what ExpressRoute Microsoft peering is
           - Why do you need ExpressRoute Microsoft Peering?
           - Which Azure services can you access with Peering?	
           - Add some steps here or a diagram showing how you can create circuits and peering
    
       - Describe the process behind linking virtual networks to an ExpressRoute circuit
           - Why is this action needed?  
           - What will it enable me to do? 
    	
       - Describe virtual network gateways and FastPath
          - Why do you need to setup a virtual network gateway?
          - What steps are required to implement this?
          - What is FastPath?
    
       - Describe high availability and failover with ExpressRoute
           - What high availability options are available with ExpressRoute?
           - Can I have more than one circuit to cover for a failure?
           - Can ExpressRoute cover multiple networks?  
    
       - Describe the role and function of ExpressRoute circuits, Local Edge routers, Microsoft Edge routers and Azure virtual networks?
            - What is the purpose of these features?
            - How do they interact with ExpressRoute?
            - Show a table listing the properties of each feature and a diagram showing where the components fit into an Azure ExpressRoute connection
    
    **Knowledge check**

      - What is Microsoft Peering?
      - What is an Azure ExpressRoute circuit?
      - What security benefits does Azure ExpressRoute provide? 
      
1. **When to use ExpressRoute**

    - Describe the general use cases for Azure ExpressRoute
        - Access low latency systems
        - Microsoft Cloud Services, such as Office365
        - Systems where data should not traverse the Internet
        - High-speed connections
        - Large datacenters, with high numbers of users and systems accessing SaaS offerings

    - List the benefits of implementing ExpressRoute
        - Mention the advantages of using ExpressRoute with Office365
        - SLA targets
        - Latency
        - Security benefits

    - Contrast with other connectivity options: Point to SIte, Site to Site
        - Is ExpressRoute the best connection tool for a company to use?
        - Summarize factors to consider, such as SLA, security, latency, connectivity HA, limits 
        - Possibly use a table here showing the pros and cons of ExpressRoute and its alternatives
        - Pricing details for ExpressRoute compared with Point-to-Site and Site-to-Site VPNs
	    - Briefy compare scenarios for using each connectivity option

    **Knowledge check**

      - When should you use Azure ExpressRoute compared to Azure Site to Site connectivity?
      - Which connection type is best to use for Office 365 users?
      
1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
      - Learned about use cases for Azure ExpressRoute
      - Learned about the features of Azure ExpressRoute and the benefits they provide
      - Learned how to implement Azure ExpressRoute

## Notes

This module will have interactivity only through knowledge checks due to the physical requirements of ExpressRoute.

ExpressRoute documentation: https://docs.microsoft.com/azure/expressroute/expressroute-introduction  
