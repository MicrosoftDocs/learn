There are still many customers that aren't ready to transition to the hybrid operational model. They prefer to rely on traditional tools and methods to deploy and manage Windows or Linux servers running in on-premises datacenters. There are also some workloads that are better suited for the traditional on-premises operational model. The planned deployment of an isolated VDI farm for users in Contoso’s investment banking department is an example of such a workload. Azure Stack HCI can help with implementing these types of scenarios in an optimal manner. In this unit, you learn what Azure Stack HCI is and in which cases it delivers the most significant benefits.

## What is Azure Stack HCI?

Azure Stack HCI allows you to deploy Windows and Linux-based virtualized and containerized workloads on a hyperconverged infrastructure (HCI) cluster in your own datacenter, or in a datacenter managed by a service provider. From the hardware standpoint, each Azure Stack HCI cluster consists of between 1 and 16 physical, validated servers running a specialized operating system purposely defined for hyperconverged infrastructure.

> [!NOTE]
> In the simplest terms, you can think of Azure Stack HCI as pre-built, pre-configured, highly-optimized hyperconverged clusters that you can use to deploy Windows and Linux Hyper-V VMs.

> [!NOTE]
> In the context of software-defined technologies, the term *hyper-convergence* designates a system architecture that combines compute, storage, and networking resources by relying on software-based and hardware-based virtualization. Physical servers and their hardware components form a pool of resources, which you can arbitrarily allocate to individual server workloads.

> [!NOTE]
> As with Azure Stack Hub, Azure Stack HCI clusters are available as *integrated systems* from a range of hardware vendors, with configuration validated and certified by Microsoft.

The clustered servers share common configuration and resources by using the Windows Server Failover Clustering feature. Its shared resources include:

- Hyper-V&ndash;based compute resources.
- Storage Spaces Direct&ndash;based virtualized storage.
- Optional Software-Defined Networking (SDN)&ndash;based virtualized networking using the Network Controller Windows Server role.

:::image type="content" source="../media/4-azure_stack_hci.png" alt-text="Diagram showing the Azure Stack HCI solution. The solution consists of validated partner hardware hosting Windows Server 2019 Datacenter edition with Hyper-V, Storage Spaces Direct, and SDN. The solution is managed via the Windows Admin Center UI. To simplify its management and maintenance, you can connect remotely to, and use Azure services." border="false":::

Unlike with Azure Stack Hub, which allows only a restricted set of administrative tasks via well-defined, constrained interfaces, Azure Stack HCI gives you full, direct access to the underlying hardware and the operating system running on cluster nodes. You can manage Azure Stack HCI operations the same way as any other Windows Server-based cluster, using such tools as Windows PowerShell and Server Manager. Also, to optimize your experience, it's recommended to use Windows Admin Center.

Azure Stack HCI also offers disaster recovery capabilities that build on its support for stretched clustering. By deploying a stretched Azure Stack HCI cluster, you can synchronously replicate its workloads across two separate on-premises locations and automatically failover between them. Azure Stack HCI also runs Platform-as-a-Service (PaaS) services on-premises with Azure Arc.

On the other hand, Azure Stack HCI doesn't support implementation of the Azure-based deployment methodologies that rely on Azure Resource Manager, which is available on Azure Stack Hub. In addition, Azure Stack HCI doesn't inherently enforce or provide multitenancy.

## Common use cases of Azure Stack HCI

Azure Stack HCI delivers the most significant benefits in cases that involve:

|Use case|Description|
|---|---|
|Branch office and edge|For branch office and edge workloads, you can minimize infrastructure costs by deploying two-node clusters with inexpensive witness options, such as Cloud Witness or a USB drive–based file share witness. Another factor that contributes to the lower cost of two-node clusters is support for switchless networking, which relies on crossover cables between cluster nodes instead of more expensive high-speed switches.|
|VDI|Azure Stack HCI clusters are well suited for large-scale VDI deployments with RDS or equivalent third-party offerings as the virtual desktop broker. Azure Stack HCI provides more benefits by including centralized storage and enhanced security, which simplifies protecting user data and minimizes the risk of accidental or intentional data leaks.|
|Highly performant SQL Server|Azure Stack HCI provides an extra layer of resiliency to highly available, mission-critical Always On availability groups-based deployments of SQL Server. This approach also offers extra benefits associated with the single-vendor approach, including simplified support and performance optimizations built into the underlying platform.|
|Trusted enterprise virtualization|Azure Stack HCI satisfies the trusted enterprise virtualization requirements through its built-in support for Virtualization-based Security (VBS). VBS relies on Hyper-V to implement the mechanism referred to as *virtual secure mode*, which forms a dedicated, isolated memory region within its guest Virtual Machines (VMs). By using programming techniques, it's possible to perform designated, security-sensitive operations in this dedicated memory region while blocking access to it from the host OS. This configuration considerably limits potential vulnerability to kernel-based exploits.|
|Scale-out storage|Storage Spaces Direct is one of the core technologies of Azure Stack HCI. Its primary benefits include high availability, performance, and scalability that uses locally attached drives. Using Storage Spaces Direct results in significant cost reductions compared with competing offers based on storage area network (SAN) or network-attached storage (NAS) technologies. These benefits result from an innovative design and a wide range of enhancements such as persistent read/write cache drives, mirror-accelerated parity, nested resiliency, and deduplication.|
|Azure Kubernetes Service (AKS)|You can use the Azure Stack HCI to host container-based deployments, which increases workload density and resource usage efficiency. Azure Stack HCI also further enhances the agility and resiliency inherent to Azure Kubernetes deployments. Azure Stack HCI manages automatic failover of VMs serving as Kubernetes cluster nodes, if there's a localized failure of the underlying physical components. This configuration supplements the high availability built into Kubernetes, which automatically restarts failed containers on the same or another VM.|
|Disaster recovery for virtualized workloads|An Azure Stack HCI stretched cluster provides automatic failover of virtualized workloads to a secondary site following a primary site failure. Synchronous replication ensures crash consistency of virtual machine disks.|

Choose the best response for each of the following questions, and then select **Check your answers**.
