Azure Arc-enabled SQL Managed Instance offers a resilient solution for deploying the Microsoft SQL Server database engine in a wide range of hybrid scenarios.

## Example scenario

Suppose you work for a New York-based financial services company with a global customer base and several US government contracts. Your on-premises environment contains several SQL Server databases hosted in overseas datacenters that are subject to data residency requirements. It also includes the US government contract-related data that need to be fully isolated from the internet. 

As the lead of the IT infrastructure engineering team, you assist solution architects, data engineers, and software developers with modernizing internal and public-facing services and applications. Your recent efforts led to your company adopting Kubernetes as the internal standard for container orchestration. Following the directives from company’s technology leadership to minimize the administrative overhead, streamline the operational model, and increase the resiliency of business-critical workloads, you decided to migrate the on-premises databases to the Azure Arc-enabled SQL Managed Instance platform.

The migration plan raised some resiliency concerns. The SQL Server databases hosted in overseas datacenters need to be highly available and must support an automatic failover within the same physical location in case of a localized failure. Access to the US government contract-related data is considered business-critical and must allow for disaster recovery, with a manual failover to another US-based datacenter in case of an incident affecting the availability of the local one.

An additional important resiliency consideration relates to backups. The existing data stores are currently configured with automatic backup, which supports point-in-time restore. It is essential that the migrated databases offer the same capability.

## What will you be doing?

In this module, you’ll explore the high availability and disaster recovery capabilities of Azure Arc-enabled SQL Managed Instance. 

## What is the main goal?

By the end of this module, you will be able to:

- Describe the point-in-time restore functionality of Azure Arc-enabled SQL Managed Instance.
- Describe the high availability features of Azure Arc-enabled SQL Managed Instance.
- Describe the disaster recovery features of Azure Arc-enabled SQL Managed Instance.
