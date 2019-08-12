# Title

Protect your Azure infrastructure with Azure Site Recovery

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Site Recovery

## Prerequisites

- Basic understanding of Azure virtual machines
- Basic understanding of Azure virtual networking

## Summary

Provide disaster recovery for your Azure infrastructure by managing and orchestrating replication, failover, and failback of Azure virtual machines with Azure Site Recovery.

## Learning objectives

1. Protect Azure virtual machines with Azure Site Recovery
1. Run a disaster recovery drill to validate protection
1. Failover and failback your virtual machines

## Chunk your content into subtasks

Identify the subtasks of *Protect your Azure infrastructure with Azure Site Recovery*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Azure Site Recovery | now wish to configure protection for them to fail over to a secondary Azure region in the event of a disaster | Knowledge Check | 1 | Yes |
| Setting up Azure Site Recovery  | now wish to configure protection for them to fail over to a secondary Azure region in the event of a disaster  | Knowledge Check | 1 | Yes |
| Protect virtual machines using Azure Site Recovery  | take advantage of the replication and recovery features  | Exercise | 1 | Yes |
| What is a disaster recovery drill?| take advantage of the replication and recovery features | Exercise | 2 | Yes |
| Failover and failback |  now wish to configure protection for them to fail over to a secondary Azure region in the event of a disaster  | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    Your organization has recently suffered an outage due to building damage from a hurricane. To prevent this from happening in the future, they are now moving their infrastructure to Azure as they wish to take advantage of the replication and recovery features it offers. They have a number of virtual machines running in Azure already, and now wish to configure protection for them to fail over to a secondary Azure region in the event of a disaster.

1. **What is Azure Site Recovery?**

    Overview of features of Azure Site Recovery:

    - Azure virtual machine protection
    - Snapshots and recovery points
    - Replication process to secondary region
    - Accelerated Networking support
    - Disaster recovery drills
    - Flexible failover and failback

1. **Prepare for disaster recovery with Azure Site Recovery**

    - Discuss Recovery Services Vaults
    - Target resources
    - Outbound network connectivity & URLs
    - Updating Azure VM certs
    - Account permissions, Site Recovery Contributor, and Site Recovery Operator

1. **Exercise - Set up disaster recovery with Azure Site Recovery**

    Create the following in Azure portal:

    - Create a vault
    - Verify target resources
    - Configure outbound network connectivity
    - Verify Azure VM certificates
    - Enable replication

1. **Run a disaster recovery drill**

    - What is a disaster recovery drill
    - Why should you test them (BCDR policy, verify setup of replication)
    - Discuss test failover/flexible failover
    - Difference between a drill and production failover

1. **Exercise - Run a disaster recovery drill**

    Using the Azure portal:

    - Using the previously created environment
    - Failover the environment to secondary region as created in previous exercise
    - Monitor it to ensure it succeeded and verify any failures

1. **Failover and Failback using Azure Site Recovery**

    - What is failover
    - What is reprotection and why is it important
    - What is failback
    - Discuss flexible fail overs
    - Monitoring Azure Site Recovery

1. **Exercise - Failover and failback using Azure Site Recovery**

    Using PowerShell:

    - Failover the virtual machine(s) to the secondary region
    - Reprotect the virtual machines
    - Monitor the failover and test connectivity to virtual machines, (Ping, RDC)

    Using the Azure portal:
    - Failback from secondary to primary region
    - Monitor the failback

1. **Summary**

In this unit, you have learned about the benefits of Azure Site Recovery and how it fits into a companies BCDR policy. You have protected a virtual machine against disaster and tested its replication integrity with a disaster recovery drill. You have also learned about failing over an environment, reprotecting it and then failing back.

## Notes

Detail the features of Azure Site Recovery for protecting resources (primarily VM-based) in Azure. Go through a basic activity of setting up Azure Site Recovery, failing over, and failing back.
Supporting documentation:

Enable replication - https://docs.microsoft.com/azure/site-recovery/azure-to-azure-tutorial-enable-replication

Run a disaster recovery drill - https://docs.microsoft.com/azure/site-recovery/azure-to-azure-tutorial-dr-drill

Fail over and fail back - https://docs.microsoft.com/azure/site-recovery/azure-to-azure-tutorial-failover-failback
