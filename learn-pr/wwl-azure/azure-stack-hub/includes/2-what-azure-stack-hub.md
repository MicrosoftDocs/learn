Azure Stack Hub is an extension of Azure that provides a way to run apps in an on-premises environment and deliver Azure services in your datacenter. With a consistent cloud platform, organizations can confidently make technology decisions based on business requirements, rather than business decisions based on technology limitations.

## Why use Azure Stack Hub?

Azure provides a rich platform for developers to build modern apps. However, some cloud-based apps face obstacles like latency, intermittent connectivity, and regulations. Azure and Azure Stack Hub unlock new hybrid cloud use cases for both customer-facing and internal line-of-business apps:

 -  **Edge and disconnected solutions**. Address latency and connectivity requirements by processing data locally in Azure Stack Hub and then aggregating it in Azure for further analytics, with common app logic across both. You can even deploy Azure Stack Hub disconnected from the internet without connectivity to Azure. Think of factory floors, cruise ships, and mine shafts as examples.
 -  **Cloud apps that meet varied regulations**. Develop and deploy apps in Azure with full flexibility to deploy on-premises with Azure Stack Hub to meet regulatory or policy requirements. No code changes are needed. App examples include global audit, financial reporting, foreign exchange trading, online gaming, and expense reporting.
 -  **Cloud app model on-premises**. Use Azure services, containers, serverless, and microservice architectures to update and extend existing apps or build new ones. Use consistent DevOps processes across Azure in the cloud and Azure Stack Hub on-premises to speed up app modernization for core mission-critical apps.

Azure Stack Hub allows you to deploy a subset of IaaS and PaaS services available in the Azure public cloud into your own datacenter or in a datacenter managed by a service provider. These services include virtual machines, App Service web apps, API apps, and functions, SQL and MySQL databases, containers, Event Hubs, IoT Hubs, Service Fabric clusters, and Kubernetes clusters.

## Azure Stack Hub architecture

Azure Stack Hub integrated systems are comprised in racks of 4-16 servers built by trusted hardware partners and delivered straight to your datacenter. After delivery, a solution provider will work with you to deploy the integrated system and ensure the Azure Stack Hub solution meets your business requirements. You can prepare your datacenter by ensuring all required power and cooling, border connectivity, and other required datacenter integration requirements are in place.

Azure Stack Hub is built on industry standard hardware and is managed using the same tools you already use for managing Azure subscriptions. As a result, you can apply consistent DevOps processes whether you're connected to Azure or not.

The Azure Stack Hub architecture lets you provide Azure services at the edge for remote locations or intermittent connectivity, disconnected from the internet. You can create hybrid solutions that process data locally in Azure Stack Hub and then aggregate it in Azure for other processing and analytics. Finally, because Azure Stack Hub is installed on-premises, you can meet specific regulatory or policy requirements with the flexibility of deploying cloud apps on-premises without changing any code. Integrated systems are available from a range of hardware vendors, with configuration validated and certified by Microsoft.

:::image type="content" source="../media/azure-stack-hub-architecture-overview-update-5f960ad2.png" alt-text="Diagram shows Azure Stack Hub elements.":::


The use of equivalent set of tools makes it possible to design, develop, deploy, and manage services and applications in hybrid scenarios in the same, consistent manner, regardless of their location. The tools minimize administrative and development overhead. You also have the option of implementing Azure Stack Hub in fully disconnected scenarios, without direct connectivity to Azure.

Azure Stack Hub allows you to benefit from the latest advancements in cloud-based containerization, microservices, and serverless technologies. These features simplify the process of modernizing existing apps or developing new ones. Hybrid compatibility promotes consistent DevOps processes across Azure cloud and Azure Stack Hub, helping to accelerate app release cadency.

Azure Stack Hub services support multitenancy. As the host (or provider) of Azure Stack Hub, you can simultaneously offer the same types of resources to multiple groups of users, while providing each group with exclusive access to their respective resources with full logical isolation between them. Service providers can use this capability to deliver Azure Stack Hub services to multiple customers. Large organizations can use Azure Stack Hub to host workloads for multiple departments, while maintaining separation between them.

## What Azure Stack Hub is not?

While it's important to understand what Azure Stack Hub is, it's also helpful to realize what Azure Stack Hub is not, which is:

 -  A replacement for virtualization technology. Azure Stack Hub isn't designed to replace an existing on-premises private cloud. Instead, it's designed to introduce the public cloud-operating model in your datacenter.
 -  A customizable infrastructure. Azure Stack Hub relies on preconfigured systems that are in a constant known state, without support for customizing hardware.
 -  A solution that eliminates the need for infrastructure updates. Azure Stack Hub requires that you update its infrastructure components regularly. However, you can perform the updates without having to take offline workloads running on that infrastructure.
 -  A solution that eliminates the responsibility for the underlying infrastructure. Microsoft hosts and manages the Azure cloud physical and virtualization infrastructure. You rely on availability Service Level Agreements (SLAs) that Microsoft provides to evaluate platform and service resiliency. With Azure Stack Hub, you host and manage the infrastructure. Therefore, it's your responsibility to implement and maintain its resiliency and availability.
