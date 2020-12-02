To deploy Azure Stack HCI you’ll select supported workloads, determine the best hardware set-up, and evaluate how to work with Azure services.

## Scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It’s working almost entirely on site with most computers running either Winders Server or Linux operating systems. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In an effort to consolidate and modernize, Contoso IT migrated some applications to Azure IaaS and platform as a service (PaaS) services. A number of highly regulated workloads must remain in the on-premises datacenters.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first is a group of heavily used Microsoft SQL Server instances hosting transactional databases for the Contoso's loan origination department. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso's securities department. This workload replaces an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso's Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before she makes the investment, the CIO wants to verify the extra expense will help deliver a modern solution and speed up datacenter consolidation. She also wants to make sure it brings a consistent management approach. The solution should draw on existing IT skills, and if possible, integrate with some of the cloud services that Contoso is already benefiting from, such as Azure Monitor. It's also critical the new solution provides high availability and resiliency. Contoso needs protection from localized failures and the ability to recover quickly after a disaster to another location.

IT management has started its search for solutions that would satisfy these requirements. Your role, as the lead system engineer, is to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

## Learning objectives

After completing this module, you'll be able to:

- Plan for Azure Stack HCI.
- Deploy Azure Stack HCI.
- Validate deployment of Azure Stack HCI.
- Integrate Azure Stack HCI with Azure.

## Prerequisites

To get the best learning experience from this module, you should have the basic knowledge of the following concepts:

- Azure.
- Windows Server Hyper-V.
- Windows Server software-defined storage.
- Windows Server software-defined networking.
