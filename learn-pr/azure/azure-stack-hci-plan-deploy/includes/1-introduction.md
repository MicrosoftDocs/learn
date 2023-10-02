To deploy Azure Stack, HCI you’ll select supported workloads, determine the best hardware configuration, and evaluate how to work with Azure services.

## Scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It’s working almost entirely on-premises, with most computers running either Windows Server or Linux operating systems. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

To consolidate and modernize, Contoso IT migrated some applications to Azure infrastructure as a service (IaaS) and platform as a service (PaaS) services. Several highly regulated workloads must remain in the on-premises datacenters.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first is a group of heavily used Microsoft SQL Server instances hosting transactional databases for Contoso's loan-origination department. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso's securities research department. This workload will replace an aging Windows Server 2012 R2-based Remote Desktop Services (RDS) deployment.

Contoso's Chief Information Officer (CIO) realizes that implementing these workloads requires additional hardware investment, but wants to verify that the extra expense will help deliver a modern solution, speed up datacenter consolidation, and provide a consistent management approach. The solution should draw on existing IT skills and, if possible, integrate with cloud services from which Contoso is already benefiting, such as Azure Monitor. It's also critical that the new solution provides high availability and resiliency. Contoso needs protection from localized failures and the ability to recover quickly to another location should disaster strike.

IT management is searching for solutions that satisfy these requirements. As lead system engineer, you must assist with the search and implement a proof-of-concept environment that helps identify the most viable solution.

## Learning objectives

After completing this module, you'll be able to:

- Plan for Azure Stack HCI.
- Deploy Azure Stack HCI.
- Validate deployment of Azure Stack HCI.
- Integrate Azure Stack HCI with Azure.

## Prerequisites

To get the best learning experience from this module, you should have the basic knowledge of the following concepts:

- Azure
- Windows Server Hyper-V
- Windows Server software-defined storage
- Windows Server software-defined networking
