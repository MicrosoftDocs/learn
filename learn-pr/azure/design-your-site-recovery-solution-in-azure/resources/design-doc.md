# Title

Design your site recovery solution on Azure

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Site Recovery
- Azure Backup

## Prerequisites

- Basic knowledge of business continuity and disaster recovery practices

## Summary

Protect your applications and data from disasters with a well-designed site recovery solution.

## Learning objectives

1. Define the site recovery requirements for your applications
2. Select the proper solutions to provide site recovery for your applications

## Chunk your content into subtasks

Identify the subtasks of *Design you site recovery solution on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Developing a Business Continuity & Disaster Recovery (BCDR) Plan | tasked with designing your site recovery strategy | Knowledge Check | 1 | Yes |
| Using Azure Site Recovery | select the proper solutions to meet your recovery requirements | Knowledge Check | 2 | Yes |
| Using Azure Traffic Manager | select the proper solutions to meet your recovery requirements | Knowledge Check | 2 | Yes |
| Using Azure Databases technologies | select the proper solutions to meet your recovery requirements | Knowledge Check | 2 | Yes |

## Outline the units

1. **Introduction**

    You are a solution architect for a retailer and have been tasked with designing your site recovery strategy for your applications. The organization runs a hybrid environment, with some workloads running in the cloud and some remaining on-premises. You need to select the proper solutions to meet your recovery requirements, while keeping costs and complexity down.

1. **Develop a business continuity and disaster recovery plan**

    - Develop a BCDR Plan
        - Identify key stakeholders, key infrastructure (IaaS)
        - Identify your recovery time objective (RTO) and recovery point objective (RPO) for each system
        - Identify any PaaS requirements such as SQL Databases
        - Cover data backup and disaster recovery
        - Azure features, region pairing, availability zones, & availability sets

    **Knowledge check**

    - List the differences between Azure Backup and Azure Site Recovery and identify a scenario each should be used
    - Describe three Azure features that contribute to High Availability of VMs

1. **Use Azure Site Recovery as part of your BCDR plan**

    - Overview of Azure Site Recovery
        - Explain what Azure Site Recovery provides (Azure VM replication, on-premises VM replication, workload replication, resilience, etc.)
        - Full solution made up of Azure Site Recovery and Azure Backup - Azure Site Recovery for replication, Backup for data recovery
    - Supported replication items 
        - On-premises VMs, Hyper-V VMs, physical servers to Azure
        - Replication of on-premises VMs to a secondary site
    - Network integration with Azure Site Recovery
        - How Azure Site Recovery integrates with your IP addressing scheme, reservations, load balancers etc
        - How Azure Traffic Manager can be used for the network hand off to the replicated VM

    **Knowledge check**

    - List three key benefits of using Azure Site Recovery as part of your BCDR solution.
        - Azure VM replication
        - On-premises replication to Azure
        - Consistency with failover
    - List three key considerations relating to VM networking for replicated VMs
        - IP reservations
        - Load balanced traffic
        - IP subnet/gateway consistency

1. **Build resilience into your application services**

    - Adding geo-redundancy to cloud and on-premises workloads
    - Failing over and falling back, from your on-premises architecture to the cloud and back
    - High-availability clustering, pros and cons of active/active or active/passive architectures
    - Implementing a monitoring and notification strategy

    **Knowledge check**
    
    Using a scenario that describes the on-premises and cloud server architecture for the retailers online store. Your company has recently had a lengthy period of downtime due to a power outage. This will be a high-level diagram to enable the questions below to target it.

    - How could you enable real-time switching of traffic if there's future power issues?
    - Your company is launching in a new region, how can you ensure there aren't performance issues for the new region?
    - Identify your resources that could be restored from backups, and why

1. **Build resilience into your data services**

    - Azure Cosmos DB - with replication in multiple regions
    - SQL Automated backups
    - SQL Server Auto-failover groups
    - SQL Server Always on Availability groups

    **Knowledge check**

    - You can't lose any data in your online transactional SQL database, how should you architect its resilience?
        - Geo-replication (/azure/sql-database/sql-database-designing-cloud-solutions-for-disaster-recovery#scenario-2-azure-regions-for-business-continuity-with-maximum-data-preservation)
    - What are the benefits of moving your data workloads to Azure Cosmos DB now that your online store is moving to multiple regions?

1. **Summary**

    You firstly discovered the features and benefits of Azure Site Recovery and where it can play a part in your site recovery plan. Then you explored building better resilience and recovery abilities with Azure Traffic Manager and Azure data services.

    By the end of the module you've built a robust site recovery plan to enable your company to recover from issues if they occur in the future.

## Notes

This module should detail how to design a site recovery solution for your application, and what solutions to use to meet your requirements based on workload. Also needs to consider things like network, PaaS services, secrets and keys, and ops (monitoring, logging). Includes both on-premises and cloud workloads. Due to the breadth of content, this will likely mostly be topical in nature, so we'll want to use case studies and quiz questions for interactivity.

Supporting documentation:

https://learn.microsoft.com/azure/site-recovery/site-recovery-workload

https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service

## Review comments

I merged this, but after looking at it further, I think it still needs work. We're missing the architecture angle on this, and overly focusing on Azure Site Recovery. Units 4 and 5 go through implementation details, which is out of scope for what we want to focus on for this module. The focus of much of this is on VMs, which for modern design patterns should be a small part of what we're including in an architecture. 

We're missing details on how to handle PaaS services. We're missing details on how to choose an active/active vs active/passive architecture. There's no discussion about fault detection and what services to leverage to provide failover. There's little mention of testing. There's also a decision point about having resources readily available, vs deploying them if there's a disaster, and making sure you're deployment scripts/code/etc. has the proper protection.

I want to avoid this being solely focused on ASR. That's a fantastic solution and most definitely takes a large role as a BCDR solution, but we need to discuss how to build coverage for all of our resources if things fail, and how we need to make tradeoffs between cost and failure handling.

## Comments

Azure Backup isn't specifically a unit, mentioned but is listed in the products, should Traffic Manager and SQL Databases be also listed, or should we not be covering these?
