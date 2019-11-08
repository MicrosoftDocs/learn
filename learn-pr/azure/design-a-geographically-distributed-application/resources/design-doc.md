# Module Design

## Title

Design a geographically distributed application

## Role(s)

- Solution Architect

## Level

- Advanced

## Product(s)

- Azure DNS
- Azure Traffic Manager
- Azure CDN
- Azure App Service
- Azure Cache for Redis
- Azure SQL Database
- Azure Cosmos DB

## Prerequisites

- Intermediate familiarity with Azure PaaS services
- Intermediate familiarity with architecture principles

## Summary

Build an application that spans multiple geographic locations for high availability and resiliency.

## Learning objectives

1. Design networking architecture for a geographically distributed application
2. Design the application architecture for a geographically distributed application
3. Design the data architecture for a geographically distributed application

## Chunk your content into subtasks

Identify the subtasks of *Design a geographically distributed application*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand geographically distributed architectures | Define an architecture that will be highly available and fault-tolerant across geographic regions | Knowledge check | 1, 2, 3 |  Yes |
| Overview of a geographically distributed networking architecture | Define an architecture that will provide high availability and fault-tolerance capabilities and identify the services to provide these features | Knowledge Check | 1 | Yes |
| Overview of a geographically distributed application architecture | Define an architecture that will provide high availability and fault-tolerance capabilities and identify the services to provide these features | Knowledge Check | 2 | Yes |
| Overview of a geographically distributed data architecture | Define an architecture that will provide high availability and fault-tolerance capabilities and identify the services to provide these features | Knowledge Check | 3 | Yes |

1. **Introduction**

    A shipping company is building a new portal on Azure for customers to create, manage, and track shipments. This portal is a critical part of their business, and needs to be highly available and tolerant of faults across geographic regions. They need an architecture that will provide these capabilities and identify the services to provide the features they need.

1. **Design a geographically distributed architecture**

    List the content that will enable the learner to *Understand geographically distributed architectures*:

    - Describe the need to adapt some principles of sound architecture to be responsive to a cloud environment, i.e. the shift toward commodity hardware and 'cattle' rather than 'pets'
    - Describe how the SLA of a cloud app is usually the composite of SLAs for all services underpinning a given app, alongside how well the app has been architected and coded to address any gaps in those SLAs
    - The system as a whole, both its component parts and how they interact, needs to be resilient.
    - SLAs are rarely 100%. One reason for this is the difficulty of securing entire regions against natural events or human error.
    - Historically, many public cloud outages are attributable to regional failures of some kind. For example, Hurricane Sandy in 2012 took out a number of Manhattan data centers.
    - Consequently, a key part of making any cloud architecture resilient and highly available is to ensure it spans more than one region and can fail over easily and reliably to a secondary region with minimal loss of data.
    - Even such a multi-regional architecture is vulnerable to data loss. No architecture can provide 100% reliability and 100% uptime, so the goal is to provide as much reliability as possible, and understand and defend any choke points with mechanisms like a queue and a retry strategy.
    - In the app from the intro scenario, with an app service, a cache, and a backend database, all of those elements need to be duplicated in another region, with mechanisms to provide for failover, and any supporting services like name resolution, authentication, and CDN not tightly coupled to deployment in a single region.
    - Azure is designed from the ground up such that regions are paired. Some services like Azure SQL provide for fault-tolerance beyond the secondary paired region, but given our app architecture uses a number of Azure services, we will design for failover in such a way that West Europe fails over to North Europe. https://docs.microsoft.com/azure/best-practices-availability-paired-regions. 

    - Proposed architecture to deal with the introductory scenario.
        - First describe how the app's networking, data, and application architecture has been designed with regard to business objectives and independently of concerns about cross-regional fault tolerance.
            - The shipping company has a website and web API hosted in Azure App Service for B2C and B2B respectively.
            - To improve scalability, static resources like images, CSS and HTML files are fetched from the Azure CDN.
            - Typically, SQL DB provides the information to fulfill website read operations (like tracking shipments). But over time that kind of data will increasingly be fetched from Redis Cache.
            - Write operations (like creating, updating and deleting shipments) are added to an Azure Queue storage queue which triggers a Function App.
            - When the Function App is triggered by the addition of a message to the queue, it attempts to write to SQL DB, and remove the message from the queue if successful.
            - Cosmos DB is used to hold overall product catalog data. Different manufacturers may describe their offerings with very different schemas, which is ideal for Cosmos DB. Again, over time, this information may be retrieved from Redis Cache instead.
            - Domain name resolution is provided by Azure DNS.
            - Website authentication is provided by Azure AD.
        - Describe how the architecture should be upgraded to provide fault-tolerance across regions.
            - You need to replicate those parts of the system which can be replicated in a pair of regions. This includes Azure App Service, Function App, Redis Cache. For other services like SQL DB and Cosmos DB it's more a case of flipping a switch so that they become present in other regions. The architecture uses some supporting services which are inherently multi-region, like Azure DNS, Azure AD, and Azure CDN. Finally, the Traffic Manager service is used as an orchestrator to switch incoming traffic from one region to another in case of regional failure.

    **Knowledge Check**
    
    What types of questions will test *Understand geographically distributed architectures*?
    
1. **Design a geographically distributed networking architecture**

    List the content that will enable the learner to *Design networking architecture for a geographically distributed application*:

    - This is a PaaS architecture based on managed services, and internet-facing, so most of the networking is intrinsically provided by Azure and doesn't require explicit design
    - We'll host domains for the app using Azure DNS:
        - Hosting service for domains
        - Provides name resolution using Azure infrastructure
        - Can be managed in concert with other components of the app, using the same tools
        - SLA: Azure guarantees that valid DNS requests receive a response from at least one Azure DNS name server 100% of the time.
    - The core component of the networking architecture is Traffic Manager:
        - A DNS-layer service which routes incoming traffic
        - Supports a variety of routing policies
        - For this architecture, 'priority' routing mode is the most appropriate, consisting of a primary service endpoint for all traffic, and a backup endpoint in another region in case the primary becomes unavailable
        - Illustrate this priority routing mode with a simplified diagram based on https://docs.microsoft.com/azure/traffic-manager/traffic-manager-routing-methods#priority-traffic-routing-method with just a single failover but clearly shown in a separate region
        - Traffic Manager uses highly configurable endpoint monitoring. You can define the protocol, port, path, custom header settings, expected status code ranges, tolerated number of failures and so on to get a continuous idea of the overall health of all parts of your application, and you can configure the system to fail over to another region if the primary endpoint becomes unreachable.
        - In the case of a regional failure, the failed region should be manually removed from Traffic Manager's rotation until all application subsystems have been definitively restored. Otherwise partial recovery of the region could lead to Traffic Manager flip-flopping between the regions.
        
    **Knowledge Check**
    
    What types of questions will test *Design a geographically distributed network architecture*?

1. **Design a geographically distributed application architecture**

    List the content that will enable the learner to *Design the application architecture for a geographically distributed application*:

    - The application architecture primarily consists of duplicating most components in a pair of regions in order to defend against regional failure. For example, Azure App Service, the Function App, and Redis Cache.
    - You can group these resources together in logical Resource Group combinations. For example the primary and secondary region App Service, Function App, and Redis Cache will be managed together in this way. This will let you manage the resources deployed to each region as a single collection.
    - Other services are inherently less tied to a single region. This is the case for Azure AD and Azure DNS. Azure Storage is also designed in such a way that data is replicated to both a primary and secondary region, and in the case of the primary region experiencing problems, provides a number of contingencies to keep reading a copy of the data and/or fail over to the secondary region.
    - Describe cases where a regional failover could cause some data loss. Data replication to the secondary region is performed asynchronously. Therefore, if a geo-failover is performed, some data loss is possible if the data can't be recovered from the primary region.
    
    **Knowledge Check**
    
    What types of questions will test *Design a geographically distributed application architecture*?

1. **Design a geographically distributed data architecture**

    List the content that will enable the learner to *Design the data architecture for a geographically distributed application*:

    - The data components of our architecture, not unlike Azure Storage, natively provides for the concept of access in more than one region, so there's no need to physically duplicate the resource in another region as you did with Azure App Service; rather we need to configure them in the portal or PowerShell to make them multi-regional.
    - Both Azure SQL and Cosmos Db support deployment to more than one region and a variety of readable and writable permutations to secondaries depending on the tier.
    - As with Azure RA-GRS, Azure SQL may only allow for read access to a secondary until the decision is made to fail over, but the queue will help to mitigate the effects of that.
    - Describe recovery point objectives (RPO) and estimated recovery time (ERT) in assessing the possible impact of regional failure.

   **Knowledge check**

    What types of questions will test *Design a geographically distributed data architecture*?

    - How can Azure CDN be configured in such a way as not to be tightly coupled to a single region?
    - When might it be appropriate to use Cosmos DB instead of Azure SQL?
    - What is the best definition of Azure SQL RPO?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

We'll have a decent amount of theory in this module, but should also provide details around what services to use to provide geographic diversity for network, application, and data.

Depending on deployment time, we may be able to leverage the following artifacts from the architecture center. If it's too complex to deploy, we can engage the team that owns those artifacts to see about adjustments.

Supporting documentation:

https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region
