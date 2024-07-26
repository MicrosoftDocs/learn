Azure NetApp Files (ANF) provides native Network File System (NFS) shares that can be used for **/hana/shared**, **/hana/data**, and **/hana/log** volumes. Using ANF-based NFS shares for the **/hana/data** and **/hana/log** volumes requires the usage of the v4.1 NFS protocol. The NFS protocol v3 isn't supported for the usage of **/hana/data** and **/hana/log** volumes when basing the shares on ANF.

> [!IMPORTANT]
> The NFS v3 protocol implemented on Azure NetApp Files is **not** supported to be used for **/hana/data** and **/hana/log**. The usage of the NFS 4.1 is mandatory for **/hana/data** and **/hana/log** volumes from a functional point of view. Whereas for the **/hana/shared** volume the NFS v3 or the NFS v4.1 protocol can be used from a functional point of view.

:::image border="false" type="content" source="../media/highly-available-nfs-share-overview-558f42ac.png" alt-text="Diagram showing an overview of a highly available N F S share.":::

## Important considerations

When considering Azure NetApp Files for the SAP Netweaver and SAP HANA, be aware of the following important considerations:

- The minimum capacity pool is 4 TiB.
- The minimum volume size is 100 GiB.
- Azure NetApp Files and all virtual machines, where Azure NetApp Files volumes are mounted, must be in the same Azure Virtual Network or in [peered virtual networks](/azure/virtual-network/virtual-network-peering-overview) in the same region.
- It's important to have the virtual machines deployed in close proximity to the Azure NetApp storage for low latency.
- The selected virtual network must have a subnet, delegated to Azure NetApp Files.
- Make sure the latency from the database server to the ANF volume is measured and below 1 millisecond.
- The throughput of an Azure NetApp volume is a function of the volume quota and Service level, as documented in [Service level for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-service-levels). When sizing the SAP HANA Azure NetApp volumes, make sure the resulting throughput meets the SAP HANA system requirements.
- Try to "consolidate" volumes to achieve more performance in a larger volume, for example, use one volume for **/sapmnt**, **/usr/sap/trans**, … if possible.
- Azure NetApp Files offers [export policy](/azure/azure-netapp-files/azure-netapp-files-configure-export-policy): you can control the allowed clients, the access type (Read &amp; Write, Read Only, etc.).
- Azure NetApp Files feature isn't zone aware yet. Currently Azure NetApp Files feature isn't deployed in all Availability zones in an Azure region. Be aware of the potential latency implications in some Azure regions.
- The User ID for **sidadm** and the Group ID for `sapsys` on the virtual machines must match the configuration in Azure NetApp Files.

> [!IMPORTANT]
> For SAP HANA workloads, low latency is critical. Work with your Microsoft representative to ensure that the virtual machines and the Azure NetApp Files volumes are deployed in close proximity. If there's a mismatch between User ID for **sidadm** and the Group ID for **sapsys** between the virtual machine and the Azure NetApp configuration, the permissions for files on Azure NetApp volumes, mounted to the virtual machine, would be displayed as **nobody**. Make sure to specify the correct User ID for **sidadm** and the Group ID for **sapsys**, when [on-boarding a new system](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRxjSlHBUxkJBjmARn57skvdUQlJaV0ZBOE1PUkhOVk40WjZZQVJXRzI2RC4u) to Azure NetApp Files.

## Deployment with zonal proximity

To get a zonal proximity of your NFS volumes and VMs, you can follow the instructions as described in [Manage availability zone volume placement for Azure NetApp Files](/azure-netapp-files/manage-availability-zone-volume-placement). With this method, the VMs and the NFS volumes are going to be in the same Azure Availability Zone. In most of the Azure regions, this type of proximity should be sufficient to achieve less than 1-millisecond latency for the smaller redo log writes for SAP HANA. This method doesn't require any interactive work with Microsoft to place and pin VMs into specific datacenter. As a result, you're flexible with change VM sizes and families within all the VM types and families offered in the Availability Zone you deployed. So, that you can react flexible on changing conditions or move faster to more cost efficient VM sizes or families. We recommend this method for nonproduction systems and production systems that can work with redo log latencies that are closer to 1 millisecond. **The functionality is currently in public preview**.

## Deployment through Azure NetApp Files application volume group for SAP HANA (AVG)

To deploy ANF volumes with proximity to your VM, a new functionality called Azure NetApp Files application volume group for SAP HANA (AVG) got developed. There's a series of articles that document the functionality. Best is to start with the article [Understand Azure NetApp Files application volume group for SAP HANA](/azure/azure-netapp-files/application-volume-group-introduction). As you read the articles, it becomes clear that the usage of AVGs involves the usage of Azure proximity placement groups as well. Proximity placement groups are used by the new functionality to tie into with the volumes that are getting created. To ensure that over the lifetime of the SAP HANA system, the VMs aren't going to be moved away from the ANF volumes, we recommend using a combination of Avset/ PPG for each of the zones you deploy into.
The order of deployment would look like:

- Using the [form](https://aka.ms/HANAPINNING) you need to request a pinning of the empty AvSet to a compute HW to ensure that VMs aren't going to move
- Assign a PPG to the Availability Set and start a VM assigned to this Availability Set
- Use Azure NetApp Files application volume group for SAP HANA functionality to deploy your SAP HANA volumes

The proximity placement group configuration to use AVGs in an optimal way would look like:

:::image border="false" type="content" source="../media/azure-netapp-files-volume-group-hana-proximity-placement-group-architecture.png" alt-text="Screenshot of A N F application volume group and P P G architecture.":::

The diagram shows that you're going to use an Azure proximity placement group for the DBMS layer. So, that it can get used together with AVGs. It's best to just include only the VMs that run the SAP HANA instances in the proximity placement group. The proximity placement group is necessary, even if only one VM with a single SAP HANA instance is used, for the AVG to identify the closest proximity of the ANF hardware. And to allocate the NFS volume on ANF as close as possible to one or more VMs that are using the NFS volumes.

This method generates the most optimal results as it relates to low latency. Not only by getting the NFS volumes and VMs as close together as possible. But considerations of placing the data and redo log volumes across different controllers on the NetApp backend are taken into account as well. Though, the disadvantage is that your VM deployment is pinned down to one datacenter. With that you're losing flexibilities in changing VM types and families. As a result, you should limit this method to the systems that absolutely require such low storage latency. For all other systems, you should attempt the deployment with a traditional zonal deployment of the VM and ANF. In most cases, this is sufficient in terms of low latency. This also ensures an easy maintenance and administration of the VM and ANF.  

## Availability

ANF system updates and upgrades are applied without impacting the customer environment. The defined [SLA is 99.99%](https://azure.microsoft.com/support/legal/sla/netapp/).

## Volumes and IP addresses and capacity pools

With ANF, it's important to understand how the underlying infrastructure is built. A capacity pool is only a construct, which provides a capacity and performance budget and unit of billing, based on capacity pool service level. A capacity pool has no physical relationship to the underlying infrastructure. When you create a volume on the service, a storage endpoint is created. A single IP address is assigned to this storage endpoint to provide data access to the volume. If you create several volumes, all the volumes are distributed across the underlying bare metal fleet, tied to this storage endpoint. ANF has a logic that automatically distributes customer workloads once the volumes or/and capacity of the configured storage reaches an internal predefined level. You might notice such cases because a new storage endpoint, with a new IP address, gets created automatically to access the volumes. The ANF service doesn't provide customer control over this distribution logic.
