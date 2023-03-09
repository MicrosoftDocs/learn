Now we'll discuss some scenarios that illustrate when it's appropriate to migrate an on-premises file-based workload to run in the cloud using Azure NetApp Files as shared file storage. Using the energy company as an example, we'll investigate the possible migration of three workloads: your web content, your Microsoft Virtual Desktop deployment, and the HPC applications of your research and development team. Here are the criteria that will help you decide whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud:

- Ease of migration
- Workload scale
- Flexibility
- Storage technology

## Decision criteria

Azure NetApp Files can manage enterprise-scale, file-based workloads that need little or no reconfiguration and require some deployment flexibility. The use cases where Azure NetApp Files might not be the correct choice typically involve small, static, workloads that require block-based or object-based storage. Let's review these decision criteria in more detail.

| **Criteria** | **Analysis**|
| --- | --- |
| Ease of migration | Do you need to "lift and shift" your workload? That is, is it a requirement that you transition your workload into the Azure cloud without having to change the components, configuration, or code of your application? A lift-and-shift migration minimizes the risk that your workload will have problems when it starts running in the cloud. It also minimizes the costs, effort, and time required to perform the migration. |
| Workload scale | What is the overall scale of the workload? Azure NetApp Files works best with enterprise-scale workloads that require the highest performance and availability. Examples include massive database deployments, large-scale VDI, and high-performance computing applications. Azure NetApp Files can easily support relatively small-scale and low-performance workloads. However, using an enterprise-level virtual NAS such as Azure NetApp Files in these cases is almost always an economically non-viable solution. |
| Flexibility | Does your workload need some flexibility in terms of service level, capacity, and other types of scalability? Azure NetApp Files enables you to change a volume's service level between Standard, Premium, and Ultra. You can do this with no service disruption by moving the volume to a capacity pool with the level you want. You can also increase or decrease the size of a capacity pool or volume at any time to match current demand. If you have a manual QoS capacity pool, Azure NetApp Files also enables you to change a volume's throughput as needed by your workload. If your workload consists mostly of static content with relatively constant demand, then the flexibility of Azure NetApp Files is not a consideration. |
| Storage technology | Do you require object-based or block-based storage? Azure NetApp Files can support any Portable Operating System Interface for UNIX (POSIX)-compliant workload that requires shared file storage. However, some workloads have a strict dependency or requirement for storage that is both block-based and direct-attached. Azure NetApp Files provides a virtual NAS, which makes it unsuitable for that workload type. However, while historically many workloads have used direct-attached, block-based storage, it's usually not a strict dependency or requirement. In such cases, Azure NetApp Files might provide better performance and scalability because the service is less rate-limited than block-based infrastructure.  |

> [!IMPORTANT]
> Before performing any migration to Azure, you should consider setting up a proof-of-concept application that enables you to assess the Azure NetApp Files performance levels. This test app should be configured with a realistic workload so that you can determine whether Azure NetApp Files provides the IOPS, throughput, and latency levels required by the workload you want to migrate.

## Apply the criteria

Azure NetApp Files is the correct choice for shared network storage when file-based, enterprise-scale, elastic workloads need to be "lifted-and-shifted" into Azure. However, these criteria don't apply equally to all uses. Let's examine how these criteria apply to our scenario's use cases.

### Should the web team use Azure NetApp Files?

A web content deployment is often a good candidate for migration to the cloud because the on-premises deployment likely runs in a Linux environment with POSIX-compliant permissions. As such, the deployment can be lifted-and-shifted into Azure with the web content and code stored in an Azure NetApp Files volume. The website of our energy company consists of a large number of pages that describe the company's technologies, products, research, papers, and customer stories. The static nature of the content and the relatively constant level of demand are arguments against using Azure NetApp Files. However, the massive scale of the company's web content is sufficient to justify an Azure NetApp Files instance. In this case, the company should probably go with a capacity pool that uses the Standard tier, which provides more than enough throughput and IOPS for their web presence.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-web.png" alt-text="Diagram depicting a typical setup for running a web server in an Azure virtual network with Azure NetApp Files as the shared storage for the server." lightbox="../media/4-when-to-use-azure-netapp-files-web.png":::

### Should the Azure Virtual Desktop team use Azure NetApp Files?

Azure NetApp Files can provide up to 450,000 IOPS and sub-millisecond latency, which means it can provide storage for large-scale Azure Virtual Desktop (AVD) deployments. By taking advantage of the Azure NetApp Files features that enable you to change the throughput and choose a different service tier for your volumes on demand without service disruptions, you can quickly and easily optimize the scale of your AVD deployment to control costs. Also, by creating frequent manual or automatic volume snapshots, you can roll back individual FSLogix user profile containers when needed and even revert entire volumes.

Our fictional energy company has several thousand employees within its AVD deployment, with each user given a virtual personal desktop. This large-scale deployment can be lifted-and-shifted into Azure and optimized for throughput as needed. For optimum performance, the company should probably go with a capacity pool that uses the Premium tier, which provides 64 MiB/s throughput and 450,000 IOPS.

The following image depicts one possible architecture the company could use for a personal desktop-based AVD deployment. Users are mapped to specific desktop pods, where a *pod* is a spoke virtual network with a pool of virtual machines and an Azure NetApp File designated subnet that uses a volume from the overall Azure NetApp Files capacity pool. Each pool has just under 1,000 virtual machines—one for each user. Azure NetApp Files can easily handle that many personal desktops per single-session host pool VNet. If more personal desktops are needed, it's easy to add more pods.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-wvd.png" alt-text="Diagram depicting a typical setup for running several pools of Azure Virtual Desktops in an Azure virtual network with Azure NetApp Files providing shared storage for each virtual desktop pool." lightbox="../media/4-when-to-use-azure-netapp-files-wvd.png":::

### Should the research and development team use Azure NetApp Files?

The energy company's research and development (R&D) team is responsible for a variety of innovative work, including the following tasks:

- Inventing new wind-powered and solar-powered products.
- Optimizing the company's existing renewable energy products.
- Creating renewable energy technologies that can be licensed to other companies.
- Advancing the science behind the company's renewable energy products.
- Investigating other possible sources of renewable energy.

Most of these tasks require compute-intensive and data-intensive operations such as computer-aided design, 3D modeling, and detailed simulations. As such, they require very high IOPS, low latency, and high availability. These tasks often create extreme usage swings, where usage is very high during, say, a complex simulation, then down to almost nothing when the simulation ends. R&D team members require mixed SMB/NFS protocol access with POSIX compliance. All of these considerations work in favor of migrating the R&D team's applications to Azure and using Azure NetApp Files as the shared-storage service. In this case, the company would require a capacity pool that uses the Ultra tier with its 128 Mib/s throughout and 450,000 IOPS.

The following image depicts a possible setup for running a high-performance computing application in an Azure virtual network with Azure NetApp Files as the shared storage for the application. An R&D team member accesses the front end through a Windows or Linux virtual machine. The HPC application runs in the Compute subnet, which consists of a scale set of Linux virtual machines. The shared storage for the scale set comes from a designated subnet containing an Azure NetApp Files instance.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-hpc.png" alt-text="Diagram depicting a typical setup for running a high-performance computing application in an Azure virtual network with Azure NetApp Files as the shared storage for the application." lightbox="../media/4-when-to-use-azure-netapp-files-hpc.png":::
