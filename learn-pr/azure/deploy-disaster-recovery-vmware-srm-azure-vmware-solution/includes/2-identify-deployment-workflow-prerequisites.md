To help protect your organization’s workloads from unforeseen disasters, you must first review the company's current business continuity and disaster recovery (BCDR) plan. You need to identify the different recovery objectives and scope for the systems that need protection.

VMware SRM is a BCDR solution that helps you plan, test, and run VM recoveries between a protected VMware vCenter Server site and a recovery vCenter Server site.

## BCDR

Any loss of service can be disruptive to your staff and users. Every second that systems are unavailable can result in lost revenue for your company. Your company might also face financial penalties for failing to comply with any availability agreements it has for the services it provides.

*BCDR plans* are formal documents that companies create to cover the scope and actions they'll take when a disaster or large-scale outage occurs. The organization assesses each outage on its own merit. For example, an organization might put a BCDR plan into action when a datacenter loses power.

### Recovery time objective (RTO)

A *recovery time objective (RTO)* is a measure of the maximum amount of time your business can survive after a disaster until normal service must be restored to avoid unacceptable consequences associated with a break in continuity. For example, if an organization’s RTO is 12 hours, it means that operations can continue for 12 hours without the business's core services functioning. If the downtime is any longer, the business would face serious consequences.

### Recovery point objective

A business might decide to perform a backup every 24 hours, every 12 hours, or even in real time. However, if a disaster occurs, there's always some data loss. A *recovery point objective (RPO)* is a measure of the maximum amount of data loss that's acceptable following a disaster.

For example, if an organization performs a backup at midnight every 24 hours, and a disaster happened at 9:00 AM, then nine hours of data would be lost. If the organization’s RPO is 12 hours, a data loss of nine hours is acceptable. If the RPO is four hours, the data loss isn't acceptable.

## What is VMware SRM?

VMware SRM can contribute to your BCDR plan because it can replicate workloads from a primary site to a secondary site. If an issue occurs at the primary site, VMware SRM can be set up to automatically replicate the protected VMs to another location. You can also use VMware SRM to migrate VMs from your on-premises infrastructure to Azure VMware Solution in the cloud.

Azure VMware Solution combines VMware's Software Defined Data Center (SDDC) software with the Azure cloud service. Microsoft manages Azure VMware Solution to meet performance, availability, security, and compliance requirements.

Microsoft provides the following components to run Azure VMware Solution at scale in Azure:

- Management systems
- Networking
- Operating platform
- Back-end infrastructure operations

You can use VMware Site Recovery Manager to implement different types of recovery from:

- An on-premises VMware vCenter Server site to a recovery site in an Azure VMware Solution private cloud.
- A primary Azure VMware Solution site in one Azure region to secondary Azure VMware Solution site in another Azure region.

### Scenario 1: On-premises VMware vCenter Server site to a recovery site in an Azure VMware Solution private cloud

When you deploy VMware SRM on Azure VMware Solution, your organization can reduce the cost and overhead of managing a dedicated disaster recovery (DR) site. You can combine VMware SRM with the dynamic, on-demand scalability of Azure VMware Solution to balance the cost and recovery time needed for individual VMs.

You can replicate your VMs, create non-disruptive tests, and prepare dynamic recovery plans. A *recovery plan* specifies the order in which VMs start up on the recovery site. It includes IP addresses and optional user-specified scripts for performing custom recovery actions on the VMs.

#### Prerequisites for scenario 1

Before you can deploy protection for your on-premises VMware vCenter Server site to the recovery site in Azure VMware Solution, you must ensure that the sites meet the following prerequisites:

- **Networking**: The private-cloud environment for Azure VMware Solution must be accessible from on-premises and Azure-based resources. You can use the following services to deliver interconnectivity:

  - Azure ExpressRoute

  - Virtual private network (VPN) connections

  - Azure Virtual WAN

> [!NOTE]
> We recommend at least two gigabits per second (Gbps) throughput for ExpressRoute connectivity between on-premises and Azure VMware Solution.

- **Name resolution**: You must implement Domain Name System (DNS) resolution between on-premises SRM and virtual cloud appliances. You can use both public DNS and private DNS. With a support request, you can configure private DNS for Azure VMware Solution with appropriate conditional forwarding rules.

- The vCenter Server version must be compatible with the VMware SRM version.

- Both sites require vSphere Replication appliances that are connected to each other.

- The recovery site must have hardware, network, and storage resources that can support the same VMs and workloads as the protected site. Azure VMware Solution offers this functionality with dynamic scaling.

### Scenario 2: Primary Azure VMware Solution to a secondary Azure VMware Solution

This scenario is similar to the first, except that both the protection and recovery sites run in different Azure regions. You must deploy Azure VMware Solution in a private cloud in both the primary and secondary region. In addition, both regions must be connected with the ExpressRoute Global Reach. Both sites must include VMware SRM and vSphere Replication appliances.

The next unit explains how to set up and configure this scenario.
