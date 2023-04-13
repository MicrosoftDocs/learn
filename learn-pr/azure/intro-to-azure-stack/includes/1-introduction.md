The public cloud offers a wide range of benefits to customers. Benefits that include a cost-effective, consumption-based pricing model, vertical and horizontal scalability, elasticity, global presence, reliability, and security. While these benefits drive the increasing pace of cloud adoption, on-premises computing still represents a significant portion of the overall Information Technology landscape. Hosting resources in an on-premises datacenter is sometimes mandatory because of technical, regulatory, or compliance requirements. There's also a psychological aspect that hinders migrations to cloud, because it constitutes a significant departure from the traditional operating model that many customers are comfortable with. In addition, there are also scenarios in which a highly optimized on-premises infrastructure might be more cost-effective than a public cloud.

This module introduces you to the Azure Stack portfolio and describes the basic architecture, core capabilities, and primary use cases of its products. You also learn about the differences and similarities between Azure Stack HCI, Azure Stack Hub, Azure Stack Edge, and Azure.

## Scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It currently operates almost entirely on-premises. Most of its compute environment runs on either the Windows Server operating system or on one of several Linux distributions. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure infrastructure as a service (IaaS) and platform as a service (PaaS) services. However, several highly regulated workloads have to remain in the on-premises datacenter in New York.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a two-tier Online Transaction Processing (OLTP) application of Contoso’s loan-origination department. The application's PHP-based front-end tier runs on a pair of clustered Linux Ubuntu 18.04 servers, while its back-end tier consists of MySQL databases. The second workload is a yet-to-be implemented, isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso’s investment banking department. This workload is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso has another workload that remains on-premises but presents operational challenges. They have a research application that applies Machine Learning to process and analyze customer data and then uploads it to Azure storage for long-term archival. The current process relies on legacy code to scrub data to minimize the potential for exposing personal data. Unfortunately, the accuracy and efficiency of the code doesn't meet regulatory requirements.

Contoso’s Chief Information Officer (CIO) realizes that modernizing these workloads requires more hardware investment. But, before they commit the necessary funding, they want to verify that the extra expense can help the IT organization deliver a modern technological solution and accelerate the datacenter-consolidation initiative. The new implementation shouldn't just promote a consistent management approach that uses existing IT skills, but should also, whenever possible, promote a transition to the managed services model. That approach should include integration with the cloud services from which Contoso is already benefiting, such as Azure Monitor. It’s also critical that the new solution provides multiple levels of availability and resiliency. it should protect from localized failures and facilitate disaster recovery.

IT management has started its search for a solution that would satisfy these requirements. Your role, as the lead system engineer, is to assist with identifying the most viable candidate. To choose the optimal Microsoft-provided platform for your workloads, you need to understand the options available to you, their capabilities, and the corresponding intended usage scenarios. With increasing integration, the differences between public clouds, private clouds, and traditional on-premises operational models are less pronounced, which makes your task more challenging.

## Learning objectives

After completing this module, you'll be able to:

- Describe the Azure Stack portfolio.
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack Hub.
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack HCI.
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack Edge.

## Prerequisites

In order to get the best learning experience from this module, you should have the basic knowledge of, and experience with:

- Azure
- Window Server software-defined storage
- Windows Server software-defined networking
- IoT technologies
