# Title

Design your migration to Azure

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Migrate
- Azure Site Recovery
- Azure Database Migration Service

## Prerequisites

- Knowledge of cloud and traditional architecture concepts
- Knowledge of networking, compute, and database systems

## Summary

Minimize the time and resources required to migrate your on-premises environment to Azure. Assess your current systems with Azure Migrate, and migrate them with Azure Site Recovery and Azure Database Migration Service.

## Learning objectives

1. Discover how Azure Migrate can assess your existing workloads and plan your Azure Migration.
1. Discover how Azure Site Recovery and the Azure Database Migration Service can migrate your systems to Azure. 

## Chunk your content into subtasks

Identify the subtasks of *Design your migration to Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Azure Migration Planning Process | The initial thought process before starting an Azure Migration | Knowledge Check | 1 | Yes |
| Working with Azure Migrate | Outlines Azure Migrate and use cases | Knowledge Check | 1 | Yes |
| Working with Azure Site Recovery | Outlines Azure Site Recovery | Knowledge Check | 2 | Yes |
| Working with the Azure Database Migration Service | Outlines the Azure Database Migration Service and use cases | Knowledge Check| 3 | Yes

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You are the solution architect for a manufacturing company that is planning to move several data centers to Azure. You have been tasked with planning your migration, and need to identity the tools and services you can use to help you plan and execute your migration. Your workloads consist primarily of VMware virtual machine based workloads with data stored in relational databases.

1. **Plan your Azure migration**

    List the content that will enable the learner to *gain knowledge of the Azure Migration Planning Process*:

    - Assess
        - Create a Cloud Migration Plan, Involve Key Stakeholders, Calculate Costs, Application Discovery
    - Migrate
        - Plan your migration strategy, Identify Tools, Apply the strategy 
    - Optimise
        - Analyse Costs, Review improvement opportunities
    - Secure and Monitor
        - Secure your Servers and Data, Monitor Servers Performance

    *Knowledge check*

    What types of questions will test *Azure Migration Planning Process*?

    - What is the first stage of the Azure Migration Process?
    - In what stage would you consider the tools to be used to perform the migration?

1. **Assess your environment with Azure Migrate**

    List the content that will enable the learner to *Working with Azure Migrate*:

    - Features of/Reasons to use Azure Migrate
        - Discover & Assess current workloads for On Premise VM's within VMware
        - Plan a Migration
        - Perform the Migration of VM's (Discuss OVA tool)
    - How it works
        - Components of Azure Migrate
        - Port Requirements
        - What happens next..
    - Current Limitations of Azure Migrate
        - Not to be used to migrate On Premise Physical Servers

   *Knowledge check*

    What types of questions will test *Working with Azure Migrate*?

    - List 3 reasons to use Azure Migrate..
    - What ports would need to open between your On Premise Environment and your Azure Portal?
    - What are the current limitations of Azure Migrate?

1. **Migrate servers with Azure Site Recovery**

    List the content that will enable the learner to *Work with Azure Site Recovery*:
    
    - How can Azure Site Recovery assist with a Migration?
        - Migrate/Replicate On Premise Physical Servers to Azure
        - Workload Replication to Azure from On Premise
    - Prepare for a Migration with Azure Site Recovery
        - Account Replication Permissions
        - Creating an ASR (Azure Recovery Services Vault)
        - Creating an Azure VNET to replicate to
    - On Premise Migration Tasks
        - Set a replication goal
        - Setup your source environment
        - Setup the target environment
        - Set a replication policy
        - Source Server Supported O/S's

   *Knowledge check*

    What types of questions will test *Working with Azure Site Recovery*?

    - List 3 reasons to use Azure Site Recovery..
    - List all pre-requisite tasks required to perform an On Premise to Azure migration?
    - What are the supported source server O/S's for an Azure Site Recovery Migration?

1. **Migrate databases with Azure Database Migration Service**

    List the content that will enable the learner to *Work with the Azure Database Migration Service*:

    - Why use the Azure Database Migration Service?
        - Familiar tools, Uses Data Migration Assistant, Identifies Compatibility Issues
        - Migrates existing logins etc
    - Supported Source and Target Version of SQL
        - Source list and Target List (versions)
    - What types of Migration scenario are supported
        - Offline (One Time)/Online (Continuous Sync)
    - Supported Network topologies for the Migration
        -  Hybrid Workload, Managed Isolated Instance, Cloud to Cloud (Shared VNET/Isolated VNET) 
    - Prerequisites for using the Database Migration Service
        - VNET for the Service
        - Appropriate NSG rules allowing ports, 442, 53, 9354, 445, 12000
        - Enable TCP/IP protocol
        - Create an Azure SQL Instance in subscription
        - DL the Data Migration Assistant
        - Ensure Credentials are all obtained & correct

   *Knowledge check*

    What types of questions will test *Working with the Azure Database Migration Service*?

    - List 3 reasons to use the Azure Database Migration Service..
    - What ports are needed to be open to perform a successful migration?
    - You receive an error when trying to connect to your Source SQL Server relating to permissions? why is this.. (Control Server Permissions on connection account needed) 

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

     - Layed out the initial strategy to employ when considering a migration to Azure
     - Identified that Azure Migrate can be used to migrate machines which are already Virtual
     - Identified that Azure Site Recovery can provide a method to migrate non Virtual         Machines 
     - Identified that the Azure Database Migration Service should be used to migrate current workloads on SQL (whether Virtual or Physical) to an Azure SQL instance.

## Notes

Discusses using Azure Migrate to assess your existing workloads, then using Azure Site Recovery and Azure Database Migration Service to migrate. Identify the capabilities of each service, and how to select the appropriate migration tool for your workload. This will likely be a topical module with interactivity coming from scenarios and quiz questions.

Supporting documentation:

Azure Migrate - https://docs.microsoft.com/azure/migrate/migrate-overview

Azure Site Recovery - https://docs.microsoft.com/azure/site-recovery/site-recovery-overview

Azure Database Migration Service - https://docs.microsoft.com/azure/dms/dms-overview
