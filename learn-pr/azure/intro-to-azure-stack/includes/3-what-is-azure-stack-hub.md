Customers might already have a significant presence in Azure or might be planning on modernizing their Azure-based workloads by leveraging capabilities of both infrastructure-as-a-service (IaaS) and platform-as-a-service (PaaS) services. In such scenarios, Azure Stack Hub can help with implementing a consistent management and programming model for on-premises workloads, resulting in reduced operational complexity and cost savings.

## What is Azure Stack Hub?

Azure Stack Hub provides a range of services that closely parallel those available in the Azure cloud. That parallelism applies both to IaaS capabilities such as VMs, networking, and storage, as well as to PaaS capabilities such as web apps, functions, SQL databases, and containers.

:::image type="content" source="../media/3-azure_stack_hub.png" alt-text="Azure Stack Hub offers support for IaaS and PaaS Azure services, including VMs, database, storage, App Services, and other Azure services. The services are separated from underlying infrastructure, which includes HLH as well as Top of Rack (ToR) and baseboard management controller (BMC) switches. The primary personas that interact with Azure Stack Hub are users, operators, and managed service providers." border="false":::

## What are Azure Stack Hub core features?

Azure Stack Hub allows you to deploy and manage Azure IaaS-based and PaaS-based solutions either in your own datacenter or in a datacenter managed by your service provider. You can make the most of consistency between Azure Stack Hub and Azure to use capabilities offered by the latter, including a wide range of ready-to-use Azure Marketplace solutions. This consistency extends to the management and programming tools, with the matching web-based portal, Azure PowerShell and Azure Command-Line Interface (CLI) scripting tools, and software development kits (SDKs).

> [!NOTE]
> In the simplest terms, you can think of Azure Stack Hub as Azure for on-premises environments.

You can design, develop, deploy, and manage services and applications in hybrid scenarios in the same manner, regardless of their location. This helps minimize administrative and development overhead. In addition, despite the public cloud characteristics of Azure Stack Hub, you can operate it in a disconnected manner, without direct connectivity to Azure.

Azure Stack Hub services support *multitenancy*. This means that as the host (or provider) of Azure Stack Hub, you can simultaneously offer the same types of resources to multiple groups of users, while providing each group with exclusive access to their respective resources with full logical isolation between them. Service providers can leverage this capability to deliver Azure Stack Hub services to multiple customers. Large organizations can use Azure Stack Hub to serve multiple departments while maintaining separation between them.

Azure Stack Hub allows you to benefit from the latest advancements in Azure-based technologies for containers and microservices, in addition to serverless technologies. This simplifies the process of modernizing existing apps or developing new ones. Hybrid compatibility promotes consistent DevOps processes across Azure cloud and Azure Stack Hub, helping to accelerate app modernization initiatives.

From the hardware standpoint, an Azure Stack Hub instance takes the form of an *integrated system* consisting of a pre-built rack of between 4 and 16 physical servers.

> [!NOTE]
> Integrated systems are available from a range of hardware vendors, with configuration validated and certified by Microsoft.

## What Azure Stack Hub is not?

While it's important to understand what Azure Stack Hub is, it's also helpful to realize what Azure Stack Hub is not. In particular, Azure Stack Hub is not:

- A replacement for virtualization technology. Azure Stack Hub isn't designed to replace an existing on-premises private cloud. Instead, it's designed to introduce the public cloud operating model in your datacenter.
- A customizable infrastructure. Azure Stack Hub relies on preconfigured systems that are in a constant known state, without support for customizing hardware.
- A solution that eliminates the need for infrastructure updates. Azure Stack Hub requires that you update its infrastructure components on a regular basis. However, you can perform the updates without having to take offline workloads running on that infrastructure.
- A solution that eliminates the responsibility for the underlying infrastructure. Microsoft hosts and manages the Azure cloud physical and virtualization infrastructure. You rely on availability Service Level Agreements (SLAs) that Microsoft provides to evaluate platform and service resiliency. With Azure Stack Hub, you host and manage the infrastructure. Therefore, it's your responsibility to implement and maintain its resiliency and availability.

## Common use cases of Azure Stack Hub

Azure Stack Hub delivers the most significant benefits in cases that involve:

- Apps and services operating on the edge of on-premises networks in hybrid scenarios. Azure Stack Hub helps address latency and connectivity constraints by processing data locally, aggregating it, and then transferring to Azure for further analysis.
- Apps and services operating in disconnected scenarios. By leveraging the ability of Azure Stack Hub in the disconnected mode, you can introduce cloud capabilities to such environments as factory floors, cruise ships, or mine shafts.
- Apps and services that are subjects to compliance or regulatory restrictions, in the areas such as audit, financial reporting, foreign exchange trading, online gaming, or expense reporting. Note that with Azure Stack Hub, you have the ability to develop and deploy apps and services to both Azure and Azure Stack Hub in the same, consistent manner.