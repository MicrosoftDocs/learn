Now let's look at some scenarios that illustrate when it's appropriate to migrate an on-premises file-based workload to run in the cloud using Azure NetApp Files as shared file storage. Here are the criteria that help you decide whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud: 

- Ease of deployment or migration
- Workload scale
- Flexibility
- Storage technology

## Decision criteria

Azure NetApp Files can manage enterprise-scale, file-based workloads that need little or no reconfiguration and require some deployment flexibility. The use cases where Azure NetApp Files might not be the correct choice typically involve small, static, workloads that require block-based or object-based storage. Let's review these decision criteria in more detail.

| **Criteria** | **Analysis**|
| --- | --- |
| Ease of deployment or migration | Do you need to "lift and shift" your workload? That is, is it a requirement that you transition your workload into the Azure cloud without having to change the components, configuration, or code of your application? A lift-and-shift migration minimizes the risk that your workload has problems when it starts running in the cloud. It also minimizes the costs, effort, and time required to perform new new deployments and migration. |
| Workload scale | What is the overall scale of the workload? Azure NetApp Files works best with enterprise-scale workloads that require the highest performance and availability. Examples include massive database deployments, large-scale VDI, and high-performance computing applications. Azure NetApp Files can easily support relatively small-scale and low-performance workloads. |
| Flexibility | Does your workload need flexibility in terms of performance, capacity, and scalability? Azure NetApp Files enables you to change a volume's service level between Standard, Premium, and Ultra, with no service disruption by moving the volume to a capacity pool with the service level you want. You can also increase or decrease the size of a capacity pool or volume at any time to match current demand. If you have set your capacity pool to manual QoS, Azure NetApp Files also enables you to independently change a volume's throughput as needed by your workload. |
| Storage technology | Do you need block-based or file-based storage? Azure NetApp Files works for any POSIX-compatible workload that can use shared file storage. However, some workloads have a strict dependency or requirement for storage that is both block-based and direct-attached. Azure NetApp Files provides a virtual NAS, which makes it unsuitable for that workload type. However, while historically many workloads have used direct-attached, block-based storage, it's not a strict dependency or requirement. In such cases, Azure NetApp Files might provide better performance and scalability because Azure virtual machines are less network rate-limited than block-based (SSD) infrastructure, and Azure Network Files volumes are network connected. |

## Apply the criteria

Azure NetApp Files is the correct choice for shared network storage when file-based, enterprise-scale, elastic workloads need to be "lifted-and-shifted" into Azure. However, these criteria don't apply equally to all uses. Let's examine how these criteria apply to our scenario's use cases.

### Should an Oracle Database team use Azure NetApp Files?

The most demanding Oracle Database workloads require high I/O capacity and low-latency access to storage. The solution provides shared file access with the network file system (NFS) protocol. The architecture uses Azure NetApp Files, a shared file-storage service. Azure NetApp Files offers benefits:

- Disk I/O limits on access rates that apply at the virtual machine (VM) level don't affect Azure NetApp Files. As a result, you can use smaller VM SKUs than you would with disk storage, without degrading performance. This approach can significantly reduce costs.
- Azure NetApp Files offers flexibility. You can enlarge or shrink deployments on demand to keep your configuration cost effective.

As a simple-to-consume Azure native service, Azure NetApp Files runs within the Azure datacenter environment. You can provision, consume, and scale Azure NetApp Files just like other Azure storage options. Azure NetApp Files uses a bare-metal fleet of all-flash storage. Besides using shared and highly scalable storage, Azure NetApp Files provides latencies of less than 1 millisecond. These factors make this service well-suited for using the NFS protocol to run Oracle Database workloads over networks. 

The following diagram depicts a possible architecture. The components interact as follows:

- Oracle Database runs on Azure VMs within the Oracle subnet.
- In the Azure NetApp Files subnet, Azure NetApp Files provides NFS access to the data and log files.
- The connection protocol Oracle Direct NFS (dNFS) improves performance and throughput.

:::image type="content" source="../media/4-oracle-deployment.png" alt-text="Diagram depicting an Oracle Database deployment on Azure NetApp Files." lightbox="../media/4-oracle-deployment.png":::

### Should an Azure Virtual Desktop (AVD) team use Azure NetApp Files?

Azure NetApp Files can provide up to 450,000 IOPS and submillisecond latency, which means it can provide storage for large-scale Azure Virtual Desktop (AVD) deployments. By taking advantage of Azure NetApp Files features, you can quickly and easily optimize the scale of your AVD deployment to control costs. Azure NetApp Files lets you change the throughput and choose a different service tier for your volumes on demand without service disruptions. Also, by creating frequent manual or automatic volume snapshots, you can roll back individual FSLogix user profile containers when needed and even revert entire volumes.

Consider a scenario where several employees are working within the AVD deployment, with each user operating a virtual personal desktop. This large-scale deployment can be lifted-and-shifted into Azure and optimized for throughput as needed.

The following diagram depicts one possible architecture the company could use for a personal desktop based AVD deployment. Users are mapped to specific desktop pods. A pod is a spoke virtual network with a pool of virtual machines and an Azure NetApp File designated subnet that uses a volume from the overall Azure NetApp Files capacity pool. Each pool has just under 1,000 virtual machines--one for each user. Azure NetApp Files can easily handle that many personal desktops per single-session host pool VNet. If more personal desktops are needed, it's easy to add more pods.

:::image type="content" source="../media/4-windows-virtual-desktop-architecture.png" alt-text="Diagram depicting a typical setup for running several pools of Azure Virtual Desktops in an Azure virtual network. The setup uses Azure NetApp Files providing shared storage for each virtual desktop pool." lightbox="../media/4-when-to-use-azure-netapp-files-wvd.png":::

### Should a research and development team use Azure NetApp Files?

Most R&D teams have applications that require compute-intensive and data-intensive operations such as computer-aided design, 3D modeling, and detailed simulations. As such, they require high IOPS, low latency, and high availability. These tasks often create extreme usage swings, where usage is high during, say, a complex simulation, then down to almost nothing when the simulation ends. R&D team members require mixed SMB/NFS protocol access with POSIX compliance. All of these considerations work in favor of migrating the R&D team's applications to Azure and using Azure NetApp Files as the shared-storage service.

The following image depicts a possible setup for running a high-performance computing application in an Azure virtual network. The setup uses Azure NetApp Files as the shared storage for the application. An R&D team member accesses the front end through a Windows or Linux virtual machine. The HPC application runs in the Compute subnet, which consists of a scale set of Linux virtual machines. The shared storage for the scale set comes from a designated subnet containing an Azure NetApp Files volume.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-hpc.png" alt-text="Diagram depicting a typical setup for running a high-performance computing application in an Azure virtual network." lightbox="../media/4-when-to-use-azure-netapp-files-hpc.png":::
