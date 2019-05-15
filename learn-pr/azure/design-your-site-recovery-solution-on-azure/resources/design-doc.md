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
| Developing a Business Continuity & Disaster Recovery (BCDR) Plan | Outlines what a BCDR Plan is and why you should have one | Knowledge Check | 1 | Yes |
| Working with Azure Site Recovery | Understand the use cases and features of Azure Site Recovery | Knowledge Check | 1 | Yes |
| Review your Site Recovery Solution | Explore how Azure Site Recovery fits in to your specific recovery requirements | Knowledge Check | 2 | Yes |
| Preparing your environment for Site Recovery | Explore what preparation is needed before setting up Site Recovery | Knowledge Check | 2 | Yes |
| Setting up Site Recovery | Explore what is needed to action the setup of Site Recovery | Knowledge Check | 2 | Yes |
| Monitoring Site Recovery | Explore how to actively monitor Site Recovery | Knowledge Check | 2 | Yes |

## Outline the units

*Add more units as needed for your content*


1. **Introduction**

    You are a solution architect for a retailer and have been tasked with designing your site recovery strategy for your applications. The organization runs a hybrid environment, with some workloads running in the cloud and some remaining on-premises. You need to select the proper solutions to meet your recovery requirements, while keeping costs and complexity down.

1. **Developing a Business Continuity and Disaster Recovery Plan (BCDR)**
   
    List the content that will enable the learner to *Develop a Business Continuity and Disaster Recovery Plan*: 

    - Develop a BCDR Plan
        - Identify key stakeholders, key infrastructure (IaaS)
        - Identify your recovery time objective (RTO) and recovery point objective (RPO) for each system
        - Identify any PaaS requirements such as SQL Databases
        - Cover data backup and disaster recovery
        - Azure features, region pairing, availability zones, & availability sets 

    **Knowledge check**

    What types of questions will test *Developing a Business Continuity and Disaster Recovery Plan*?

    - List the differences between Azure Backup and Azure Site Recovery and identify a scenario each should be used
    - Describe three Azure features that contribute to High Availability of VMs

1. **Working with Azure Site Recovery**

    List the content that will enable the learner to *Work with Azure Site Recovery*:

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

    What types of questions will test *Working with Azure Site Recovery*?

    - List 3 key benefits of using Azure Site Recovery as part of your BCDR solution..
        - Azure VM replication
        - On-premises replication to Azure 
        - Consistency with failover
    - List 3 key considerations relating to VM networking for replicated VMs
        - IP reservations
        - Load balanced traffic
        - IP subnet/gateway consistency

    

1. **Preparing your environment for Azure Recovery**

   Following on from the introduction scenario, you have created your BCDR plan and are now looking to protect your servers using Site Recovery in the easiest way possible. Those servers already in Azure will be replicated to a secondary region, and those located on-premises on your VMware platform will be replicated into Azure.

   
   Azure virtual machines

   - Explore Azure network security group configuration to allow replication to a different region for Azure virtual machines, Site Recovery URLs for the firewall, 
   - Network mapping and IP addresses after a failover, DHCP/static, subnet, target resources created in the secondary region with same settings as source
   - Include diagram of a region failover
   - ExpressRoute, what it is, and integration with Site Recovery

   On-premises VMware virtual machines

   - VMware on-premises machines, talk about existing virtual network adaptors and how, if more than one, they have to be connected to the same network. Upon failover to Azure the total adaptors are replicated with the machine
   - Connecting to replicated virtual machines, different IP or retain existing.. explore subnet failover to retain the IP addresses of the machines
   - Include a subnet failover diagram
   - Explore why you may choose to use ExpressRoute and the integration of that with Site Recovery.
   - Explore replication when using ExpressRoute and the hub and spoke topology

   On-premises physical & Hyper-V machines

   - Explain how physical and Hyper-V servers can have multiple network adaptors and how before a migration they need to be all connected to the same network as the primary, or disconnected altogether. Site Recovery replicates the exact amount of networks cards as the source server 
   - Mention the Recovery Services Vault and how it can be used before a migration to assign the network adaptors which have been detected
   - Walk through considerations post migration, including connecting to your replicated machines, whether they retain the same IP address or get a new one.

   Include diagram of a failed over infrastructure which relates to either VMware, physical, or Hyper-V virtual machines replicated from on-premises.

   **Knowledge check**

   What types of questions will test *Preparing your environment for Azure Recovery*?

    - Which of the following are valid Site Recovery URL's which must be allowed through the firewall?
    - What happens to a VMs network adaptors during migration when the source VM has several connected to different networks?


1. **Setting up Site Recovery**

    Azure virtual machines

    - Explore information needed when setting up replication for Azure to Azure replication
    - Source, source location, deployment model, source subscription, resource group (break all of these out into more detail)
    - Target location, subscription, resource group, virtual network, storage accounts, availability sets, availability zones (break all of these out into more detail)
    - Define a replication policy to set retention and app consistent snapshot frequency
    - Multi VM consistency (replicate them together in a replication group if running same workload), max 16 machines in a group
    - Explore reasons to the fully test after setup
    - Explore the replication of Azure disk encrypted machines and how you would copy your keys to the disaster recovery region and the permissions required to do so, mention access policies

    On-premises VMware virtual machines

    - Explore capacity planning before setup of disaster recovery, max daily change rate to local process server, detail the configuration server and the process server
    - Explore additional process servers if more than 200 source machines or a daily churn of 2TB
    - Bandwidth considerations, throttling so not to saturate the network
    - Explore the Azure site recovery deployment planner tool for VMware workloads and what it offers
    - Setting up the configuration server, (OVA template)
    - Setup your target environment in Azure to receive the replicated machines
    - Explore creating your replication policy and associating a configuration server to it
    - Explore how the mobility service is needed in a VMware migration environment and what is does

    On-premises Hyper-V and physical machines

    - Explore setting up the source environment and installing the configuration server

    - MySQL install and the settings of the configuration server

    - Access to the required URLs in Azure for the configuration server

    - Choosing protection goals, (specifying a **To Azure** and **not virtualized/other** for physical servers)

    - Setting up the target environment, selecting your subscription and deployment model, validate settings

    - Setting up the replication policy and associating your configuration server

    - Setting up the mobility service to capture data writes on the machine and forward to Site Recovery process server

      **Knowledge check**

      What types of questions will test *Setting Up Site Recovery*?

    - What format does the configuration download come in?
        - OVA, OVF, .exe
    - Which particular feature of the configuration server installs the mobility service on to     the replicated VM's?


1. **Monitoring Site Recovery**

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

    What types of questions will test *Review your Site Recovery Solution*?

    - What are the 3 roles that your account must have in order to perform an Azure to Azure Replication/Failover?
    - What is the name of the intermediary server that facilitates that proxies on-premises replication traffic to your Azure Subscription? 

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    You firstly discovered the features and benefits of Azure Site Recovery/Backup and the key questions/ fact finding topics to put together a Business Continuity & Disaster Recovery Plan. You then learnt how you would setup Replication/Recovery of a VM which is already in Azure, compared with that of a VM which was hosted on-premises using VMware.

## Notes

This module should detail how to design a site recovery solution for your application, and what solutions to use to meet your requirements based on workload. Also needs to consider things like network, PaaS services, secrets and keys, and ops (monitoring, logging). Includes both on-premises and cloud workloads. Due to the breadth of content, this will likely mostly be topical in nature, so we'll want to use case studies and quiz questions for interactivity.

Supporting documentation:

https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-workload

https://docs.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service