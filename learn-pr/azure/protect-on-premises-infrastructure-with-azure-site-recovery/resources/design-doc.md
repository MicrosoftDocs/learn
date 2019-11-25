# Title

Protect your on-premises infrastructure with Azure Site Recovery

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Site Recovery

## Prerequisites

- Basic understanding of Azure virtual machines
- Basic understanding of Azure virtual networking
- Basic understanding of disaster recovery concepts

## Summary

Provide disaster recovery for your on-premises infrastructure by managing and orchestrating replication, failover, and failback of VMware virtual machines, Hyper-V virtual machines, and physical servers with Azure Site Recovery.

## Learning objectives

1. Identify the features and protection capabilities Azure Site Recovery provides to on-premises infrastructure
1. Identify the requirements for enabling protection of on-premises infrastructure

## Chunk your content into subtasks

Identify the subtasks of *Protect your on-premises infrastructure with Azure Site Recovery*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Business Continuity and Disaster Recovery (BCDR) and why is it important for the organization to provide disaster recovery for their applications? | Ensures a company can carry on operating after a disaster | Knowledge check | 1 | Yes |
| Discuss how to run a disaster recovery drill  | Would like to implement Azure Site Recovery to protect supported systems  | Knowledge check | 2 | Yes |
| Fail over and fail back | Would like to implement Azure Site Recovery to protect supported systems  | Knowledge check | 2 | Yes |
| Role-Based Access Control | Would like to implement Azure Site Recovery to protect supported systems  | Knowledge check | 2 | Yes |
| What workloads are supported by Azure Site Recovery? | Would like to implement Azure Site Recovery to protect supported systems  | Knowledge check | 2 | Yes |

## Outline the units

1. **Introduction**

    An organization has a data center in an earthquake zone that runs critical business applications. They need to provide disaster recovery for their applications in the event their infrastructure is damaged. They have a mixture of virtualized and physical systems, and would like to implement Azure Site Recovery to protect supported systems.

1. **Define why business continuity and disaster recover are necessary** (BCDR)
    - Why is it important for the organization to provide disaster recovery for their applications?
    - Discuss risk, especially pertinent to the business in an earthquake zone
    - Overview of features of Azure Site Recovery - Azure Backup, disaster recovery drill, failover/failback.
    - How to set up disaster recovery in Azure
    - How to monitor and test the deployment to make sure it recovers correctly

    **Knowledge Check**
    - Identify the key steps required including pre-requisites such as accounts required for VMs
    - Source environment - How do you decide what you want to replicate and where to replicate to?
    - Identify the steps in testing the deployment?

1. **Identify the workloads supported by Azure Site Recovery**
    - Detail which workloads are supported, and which have been tested by Microsoft
    - Briefly note what protection each workload has

    **Knowledge Check**
    - How can SQL Server benefit from application replication?
    - How does IIS benefit from application replication?

1. **Run a disaster recovery drill**
    - Define what a disaster recovery drill is
    - When should it be run for our company in the scenario
    - How are RTO and RPO targets useful in helping this organization keep their operations running smoothly?
    - How to test whether the drill succeeded

    **Knowledge Check**
    - Which of the following isn't a suitable environment for Site Recovery?
    - What targets must our company hit to stay within our performance targets?
    - Can the replication be done during office hours without disrupting the business?

1. **Decide whether to failover or failback**
    - Define what failover and failback is
    - What is a failback policy?
    - Explain what Flexible failovers are and how to create them
    - Describe the test that you can fail over within 30 seconds
    - In an earthquake, discuss that the failover may be for a long time because of infrastructure damage

    **Knowledge Check**
    - How does a company failover and fail back safely within company policy?
    - What recovery point might have lost data?
    - What is the correct order of steps need to happen to create a fail back?

1. **Understand Role Based Access Control**
    - Define what role-based access control (RBAC) is
    - What roles would be required by our organization?
    - Explain what permissions are needed to set up replication for new virtual machines

    **Knowledge Check**
    - Describe the built-in RBAC server roles and their permissions
    - Which of the following isn't a built-in role?

1. **Summary**
    - Learned what disaster recovery is and how Azure Site Recovery can help a company operate after a disaster
    - Can run a disaster recovery drill
    - Can failover and failback

## Notes

Details the options and capabilities for protecting on-premises environments with Azure Site Recovery. Includes overview of the requirements, server roles, and capabilities for protection. Due to the limitations of infrastructure, this will rely on quiz and scenarios for interactivity.

Supporting documentation:

About DR for VMware - https://docs.microsoft.com/azure/site-recovery/vmware-azure-about-disaster-recovery
Physical server to Azure - https://docs.microsoft.com/azure/site-recovery/physical-azure-architecture
https://docs.microsoft.com/azure/site-recovery/site-recovery-workload

*Knowledge checks won't be separate units, but included at the bottom of the learn units*
