In this module, you'll learn the fundamentals of Azure Arc and how it's used to bring new capabilities to the management and monitoring of your Azure Stack HCI clusters at scale.

## Scenario

Contoso is a medium-size financial-services company with its headquarters in London, England, and offices all around the world. It’s currently operating almost entirely on-premises, with a large portion of its compute environment running on the Windows Server platform, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure infrastructure as a service (IaaS) and platform as a service (PaaS) services. However, many highly regulated workloads must remain in the on-premises datacenters.

Two types of these workloads present a particular challenge because of their performance and resiliency requirements. The first consists of Microsoft SQL Server instances hosting transactional databases for each of the Contoso’s regional loan origination departments. The second type of workload is a set of containerized apps serving securities research department apps running on third-party Kubernetes clusters in each of the regions with a local securities exchange.

Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, they want to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. They also want to make sure that the new implementation will help ensure a consistent management methodology, which not only leverages existing IT skills, but also aligns with the way workloads running in Azure are administered.

Given the hybrid nature of Contoso's environment, the CIO wants to explore technologies that promise to bridge the gap between the administrative model of on-premises and cloud services. As the IT Engineering team lead, you're tasked with exploring and evaluating hybrid capabilities of Azure Stack HCI and Azure Arc to determine whether they can help streamline management and maintenance of the two workloads types that must remain in Contoso's datacenters.

Over the course of this module, you'll review features of Azure Arc and the benefits it brings to customers like Contoso. By the end of this module, you'll be able to describe how these benefits contribute to management and monitoring of Azure Stack HCI at scale.

## Learning objectives

After completing this module, you'll be able to:

- Describe Azure Arc, its components, and use cases.
- Describe the principles of integration of Azure Arc and Azure Stack HCI.
- Describe the benefits of Azure Arc enabled Azure Stack HCI clusters.

## Prerequisites

For the best learning experience from this module, you should have knowledge of:

- Basic concepts of cloud technologies.
- Basic characteristics of services available in Azure.
- Basic concepts of virtualization and containerization.
- Basic architecture and operating principles of Azure Stack HCI.
- The purpose and core capabilities of Azure Resource Manager.
