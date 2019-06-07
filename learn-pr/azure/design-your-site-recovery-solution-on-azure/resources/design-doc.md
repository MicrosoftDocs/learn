## Title

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
| Developing a Business Continuity & Disaster Recovery (BCDR) Plan |  | Knowledge Check | 1 | Yes |
| Working with Azure Site Recovery |  | Knowledge Check | 1 | Yes |
| Review your Site Recovery Solution |  | Knowledge Check | 2 | Yes |
| Preparing your environment for Site Recovery |  | Knowledge Check | 2 | Yes |
| Setting up Site Recovery |  | Knowledge Check | 2 | Yes |
| Monitoring Site Recovery |  | Knowledge Check | 2 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You are a solution architect for a retailer and have been tasked with designing your site recovery strategy for your applications. The organization runs a hybrid environment, with some workloads running in the cloud and some remaining on-premises. You need to select the proper solutions to meet your recovery requirements, while keeping costs and complexity down.

1. **Developing a Business Continuity and Disaster Recovery Plan (BCDR)**

    - Develop a BCDR Plan
        - Identify key stakeholders, key infrastructure (IaaS)
        - Identify your recovery time objective (RTO) and recovery point objective (RPO) for each system
        - Identify any PaaS requirements such as SQL Databases
        - Cover data backup and disaster recovery
        - Azure features, region pairing, availability zones, & availability sets 

    **Knowledge check**

    - List the differences between Azure Backup and Azure Site Recovery and identify a scenario each should be used
    - Describe three Azure features that contribute to High Availability of VMs

1. **BCDR with Azure Site Recovery**

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

    - List 3 key benefits of using Azure Site Recovery as part of your BCDR solution..
        - Azure VM replication
        - On-premises replication to Azure
        - Consistency with failover
    - List 3 key considerations relating to VM networking for replicated VMs
        - IP reservations
        - Load balanced traffic
        - IP subnet/gateway consistency

1. **Monitoring Azure Site Recovery**

    - Explore the Dashboard which is used to monitor Site Recovery
        - How to use it
        - What is can monitor..
        - Replicated items
        - The testing of a failover and any configuration issues
        - Any errors
        - The health of the infrastructure as a whole
        - Recovery Plans
        - Active recovery/replication jobs
        - Monitoring of virtual machines

    **Knowledge check**

    - What are the 3 roles that your account must have in order to perform an Azure to Azure Replication/Failover?
    - What is the name of the intermediary server that facilitates that proxies on-premises replication traffic to your Azure Subscription? 

1. **Summary**

    You firstly discovered the features and benefits of Azure Site Recovery/Backup and the key questions/ fact finding topics to put together a Business Continuity & Disaster Recovery Plan. You then learnt how you would setup Replication/Recovery of a VM which is already in Azure, compared with that of a VM which was hosted on-premises using VMware.

## Notes

This module should detail how to design a site recovery solution for your application, and what solutions to use to meet your requirements based on workload. Also needs to consider things like network, PaaS services, secrets and keys, and ops (monitoring, logging). Includes both on-premises and cloud workloads. Due to the breadth of content, this will likely mostly be topical in nature, so we'll want to use case studies and quiz questions for interactivity.

Supporting documentation:

https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-workload

https://docs.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service