Customers might already have a significant presence in Azure or might be planning on modernizing their Azure-based workloads by leveraging capabilities of both infrastructure-as-a-service (IaaS) and platform-as-a-service (PaaS) services. For example, Contoso will likely benefit from converting its two-tier Online Transaction Processing (OLTP) application used by the Contoso’s loan-origination department to a PaaS-based implementation. Both PHP-based front-end tier and MySQL databases are viable candidates for such conversion. In these types of scenarios, Azure Stack Hub can help with implementing a consistent management and programming model for on-premises workloads, resulting in reduced operational complexity and cost savings. In this unit you'll learn what is Azure Stack Hub and when to use it.

## What is Azure Stack Hub?

Azure Stack Hub allows you to deploy a subset of IaaS and PaaS services available in the Azure public cloud into your own datacenter or in a datacenter managed by a service provider. These services include virtual machines, App Service web apps, API apps, and functions, SQL and MySQL databases, containers, Event Hubs, IoT Hubs, Service Fabric clusters and Kubernetes clusters.

> [!NOTE]
> In the simplest terms, you can think of Azure Stack Hub as Azure for on-premises environments.

From the hardware standpoint, each Azure Stack Hub instance is an *integrated system* consisting of a pre-built rack of between 4 and 16 physical servers. Each system has a set of well-defined interfaces that expose only the functionality required to manage its operations and implement its workloads, but do not provide direct access to the operating system running on the physical servers. You can interact with these interfaces by using the management and programming tools equivalent to those applicable to Azure, including the matching web-based portal, Azure PowerShell and Azure Command-Line Interface (CLI) scripting tools, and software development kits (SDKs).

> [!NOTE]
> Integrated systems are available from a range of hardware vendors, with configuration validated and certified by Microsoft.

:::image type="content" source="../media/3-azure_stack_hub.png" alt-text="Azure Stack Hub offers support for IaaS and PaaS Azure services, including VMs, database, storage, App Services, and other Azure services. The services are separated from underlying infrastructure, which includes the Hardware Lifecycle Host (HLH), Top of Rack (ToR), and baseboard management controller (BMC) switches. The primary personas that interact with Azure Stack Hub are users, operators, and managed service providers." border="false":::

The use of equivalent set of tools makes it possible to design, develop, deploy, and manage services and applications in hybrid scenarios in the same, consistent manner, regardless of their location. This helps minimize administrative and development overhead. You also have the option of implementing Azure Stack Hub in fully disconnected scenarios, without direct connectivity to Azure.

> [!NOTE]
> Azure Stack Hub supports the Azure Resource Manager deployment model.

Azure Stack Hub allows you to benefit from the latest advancements in cloud-based containerization, microservices, and serverless technologies. This simplifies the process of modernizing existing apps or developing new ones. Hybrid compatibility promotes consistent DevOps processes across Azure cloud and Azure Stack Hub, helping to accelerate app release cadency.

Azure Stack Hub services support *multitenancy*. This means that as the host (or provider) of Azure Stack Hub, you can simultaneously offer the same types of resources to multiple groups of users, while providing each group with exclusive access to their respective resources with full logical isolation between them. Service providers can leverage this capability to deliver Azure Stack Hub services to multiple customers. Large organizations can use Azure Stack Hub to host workloads for multiple departments, while maintaining separation between them.

## What Azure Stack Hub is not?

While it's important to understand what Azure Stack Hub is, it's also helpful to realize what Azure Stack Hub is not, which is:

- A replacement for virtualization technology. Azure Stack Hub isn't designed to replace an existing on-premises private cloud. Instead, it's designed to introduce the public cloud operating model in your datacenter.
- A customizable infrastructure. Azure Stack Hub relies on preconfigured systems that are in a constant known state, without support for customizing hardware.
- A solution that eliminates the need for infrastructure updates. Azure Stack Hub requires that you update its infrastructure components on a regular basis. However, you can perform the updates without having to take offline workloads running on that infrastructure.
- A solution that eliminates the responsibility for the underlying infrastructure. Microsoft hosts and manages the Azure cloud physical and virtualization infrastructure. You rely on availability Service Level Agreements (SLAs) that Microsoft provides to evaluate platform and service resiliency. With Azure Stack Hub, you host and manage the infrastructure. Therefore, it's your responsibility to implement and maintain its resiliency and availability.

## Common use cases of Azure Stack Hub

Azure Stack Hub delivers the most significant benefits in cases that involve:

|Use case|Description|
|---|---|
|Latency- and bandwidth-sensitive workloads|Azure Stack Hub helps address latency and connectivity constraints that preclude the use of Azure for workload hosting.|
|Disconnected workloads|By leveraging the ability of Azure Stack Hub in the disconnected mode, you can introduce cloud capabilities to such environments as factory floors, cruise ships, or mine shafts.|
|Workloads that are subject to residency requirements|Azure Stack Hub allows you to provision IaaS and PaaS workloads that are subject to compliance or regulatory restrictions, in the areas such as audit, financial reporting, foreign exchange trading, online gaming, or expense reporting.|

Choose the best response for each of the following questions, and then select **Check your answers**.
