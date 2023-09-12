Azure NetApp Files provides native Network File System (NFS) shares that can be used for **/hana/shared**, **/hana/data**, and **/hana/log** volumes. Using ANF-based NFS shares for the **/hana/data** and **/hana/log** volumes requires the usage of the v4.1 NFS protocol. The NFS protocol v3 is not supported for the usage of **/hana/data** and **/hana/log** volumes when basing the shares on ANF.

> [!IMPORTANT]
> The NFS v3 protocol implemented on Azure NetApp Files is **not** supported to be used for **/hana/data** and **/hana/log**. The usage of the NFS 4.1 is mandatory for **/hana/data** and **/hana/log** volumes from a functional point of view. Whereas for the **/hana/shared** volume the NFS v3 or the NFS v4.1 protocol can be used from a functional point of view.

:::image type="content" source="../media/highly-available-nfs-share-overview-558f42ac.png" alt-text="Overview diagram of highly available N F S share.":::
<br><br>

## Important considerations

When considering Azure NetApp Files for the SAP Netweaver and SAP HANA, be aware of the following important considerations:

- The minimum capacity pool is 4 TiB.
- The minimum volume size is 100 GiB.
- Azure NetApp Files and all virtual machines, where Azure NetApp Files volumes are mounted, must be in the same Azure Virtual Network or in [peered virtual networks](/azure/virtual-network/virtual-network-peering-overview) in the same region.
- It is important to have the virtual machines deployed in close proximity to the Azure NetApp storage for low latency.
- The selected virtual network must have a subnet, delegated to Azure NetApp Files.
- Make sure the latency from the database server to the ANF volume is measured and below 1 millisecond.
- The throughput of an Azure NetApp volume is a function of the volume quota and Service level, as documented in [Service level for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-service-levels). When sizing the HANA Azure NetApp volumes, make sure the resulting throughput meets the HANA system requirements.
- Try to “consolidate” volumes to achieve more performance in a larger volume, for example, use one volume for **/sapmnt**, **/usr/sap/trans**, … if possible.
- Azure NetApp Files offers [export policy](/azure/azure-netapp-files/azure-netapp-files-configure-export-policy): you can control the allowed clients, the access type (Read &amp; Write, Read Only, etc.).
- Azure NetApp Files feature isn't zone aware yet. Currently Azure NetApp Files feature isn't deployed in all Availability zones in an Azure region. Be aware of the potential latency implications in some Azure regions.
- The User ID for **sidadm** and the Group ID for `sapsys` on the virtual machines must match the configuration in Azure NetApp Files.

> [!IMPORTANT]
> For SAP HANA workloads, low latency is critical. Work with your Microsoft representative to ensure that the virtual machines and the Azure NetApp Files volumes are deployed in close proximity. If there is a mismatch between User ID for **sidadm** and the Group ID for **sapsys** between the virtual machine and the Azure NetApp configuration, the permissions for files on Azure NetApp volumes, mounted to the VM, would be displayed as **nobody**. Make sure to specify the correct User ID for **sidadm** and the Group ID for **sapsys**, when [on-boarding a new system](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRxjSlHBUxkJBjmARn57skvdUQlJaV0ZBOE1PUkhOVk40WjZZQVJXRzI2RC4u) to Azure NetApp Files.
