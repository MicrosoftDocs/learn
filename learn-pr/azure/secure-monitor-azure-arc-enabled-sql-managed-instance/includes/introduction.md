Azure Arc-enabled SQL Managed Instance offers a secure and performant solution for deploying the Microsoft SQL Server database engine in a wide range of hybrid scenarios.

### Example scenario

Suppose you work for a New York-based financial services company with a global customer base and several US government contracts. Your on-premises environment contains several SQL Server databases hosted in overseas datacenters that are subject to data residency requirements. It also includes the US government contract related data that need to be fully isolated from the internet. 

As the lead of the IT infrastructure engineering team, you assist solution architects, data engineers, and software developers with modernizing internal and public-facing services and applications. Your recent efforts led to your company adopting Kubernetes as the internal standard for container orchestration. Following the directives from the company’s technology leadership to minimize the administrative overhead, streamline the operational model, and increase the resiliency of business-critical workloads, you decided to migrate the on-premises databases to the Azure Arc-enabled SQL Managed Instance platform.

The migration plan raised some security and operational concerns regarding controlling data access and performance monitoring. For authentication and authorization of its on-premises workloads, your company relies primarily on Active Directory Domain Services (AD DS), so the Information Security team expects to apply the same approach to the migrated data. Additionally, some of the overseas datacenters lack proper physical access controls, so it is important to ensure that encryption at rest can be enforced. Lastly, containerized workloads must adhere to the principle of least privilege.

From the monitoring standpoint, your company’s IT teams have experience with open-source solutions, so you prefer to leverage the existing expertise for Azure Arc-enabled SQL Managed Instance telemetry collection and analytics. However, the technology leadership is also interested in building a unified monitoring solution that would provide a single pane of glass insights into both on-premises and cloud-based workloads.

### What will you be doing?

In this module, you’ll explore the security and monitoring capabilities of Azure Arc-enabled SQL Managed Instance. 

### What is the main goal?

By the end of this module, you’ll be able to:
- Describe the security features of Azure Arc-enabled SQL Managed Instance. 
- Implement monitoring of Azure Arc-enabled SQL Managed Instance.
