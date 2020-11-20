To plan for and deploy Azure Stack HCI, you'll need to identify Azure Stack HCI-supported workloads, determine the optimal, workload-dependent hardware configuration, and evaluate the options for integration with Azure services.

## Scenario

Contoso is a medium-size financial-services company with its headquarters in London and a branch office in New York. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on the Windows Server and Linux operating system platforms, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, several highly regulated workloads have to remain in the on-premises datacenters. 

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a group of heavily utilized Microsoft SQL Server instances that are hosting transactional databases for the Contoso’s loan-origination department, with the application tier running on Ubuntu 18.04. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso’s securities research department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional hardware investment, and before making the investment, she wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter-consolidation initiative. She also wants to ensure that it promotes a consistent management approach that leverages existing IT skills, and if possible, integrates with some of the cloud services from which Contoso is already benefiting, such as Azure Monitor. It’s also critical that the new solution provide multiple levels of high availability and resiliency, thereby protecting them from localized failures and facilitate disaster recovery to another on-premises location.

IT management has started its search for solutions that would satisfy these requirements. As lead system engineer, they've asked you to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

### Learning objectives

After completing this module, you'll be able to:

- Describe the process of planning for Azure Stack HCI.
- Explain how to select Azure Stack HCI hardware.
- Describe the Azure Stack HCI integration options.
- Explain how to deploy Azure Stack HCI.
- Explain how to verify a deployment of Azure Stack HCI.

## Prerequisites

In order to get the best learning experience from this module, you should have the basic knowledge of:

- Azure.
- Window Server hyper-converged Storage Spaces Direct technology.
- Windows Server converged networking.