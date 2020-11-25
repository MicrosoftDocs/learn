To plan for and deploy Azure Stack HCI, you'll need to identify Azure Stack HCI-supported workloads, determine the optimal, workload-dependent hardware configuration, and evaluate the options for integration with Azure services.

## Scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on either Windows Server operating system or one of several Linux distributions. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, a number of highly regulated workloads have to remain in the on-premises datacenters.

Two of these workloads present a particular challenge due to their performance and resiliency requirements. The first is a group of heavily utilized Microsoft SQL Server instances hosting transactional databases for the Contoso's loan origination department. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso's securities research department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso's Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, she wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. She also wants to make sure that it helps ensure a consistent management approach that leverages existing IT skills, and if possible, integrates with some of the cloud services that Contoso is already benefiting from, such as Azure Monitor. It's also critical that the new solution provide multiple levels of high availability and resiliency thereby protecting them from localized failures, and facilitate disaster recovery to another on-premises location.

IT management has started its search for solutions that would satisfy these requirements. Your role, as the lead system engineer, is to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

## Learning objectives

After completing this module, you'll be able to:

- Plan for Azure Stack HCI.
- Deploy Azure Stack HCI.
- Validate deployment of Azure Stack HCI.
- Integrate Azure Stack HCI with Azure.

## Prerequisites

In order to get the best learning experience from this module, you should have the basic knowledge of the following:

- Azure.
- Windows Server Hyper-V.
- Windows Server software-defined storage.
- Windows Server software-defined networking.
