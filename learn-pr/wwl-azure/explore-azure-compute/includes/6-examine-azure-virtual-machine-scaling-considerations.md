SAP application servers and the Central Services clusters can scale up/down or scale out by adding more instances. The AnyDB database can scale up/down but doesn't scale out. The SAP database container for AnyDB doesn't support sharding.

Microsoft offers the M-Series virtual machine that's certified for an SAP HANA scale-out configuration. The virtual machine type M128s got certified for a scale-out of up to 16 nodes. Of the 16-node scale-out certification:

- One node is the leading node
- A maximum of 15 nodes are worker nodes

The minimum OS releases for deploying scale-out configurations in Azure Virtual Machines are:

- **SUSE Linux 12 SP3**
- **Red Hat Linux 7.4**

Azure Virtual Machine scale-out deployments don't support a standby node with NFS shares implemented by third-party solutions. This is because none of these solutions are currently able to fulfill the storage latency criteria for SAP HANA with their solutions deployed on Azure. This means that **/hana/data** and **/hana/log** volumes can't be shared, which prevents the usage of an SAP HANA standby node in a scale-out configuration.

The basic configuration of a SUSE Linux virtual machine node for SAP HANA scale-out has the following characteristics:

- For **/hana/shared**, you build out a highly available NFS cluster based on SUSE Linux 12 SP3. This cluster hosts the **/hana/shared** NFS share(s) of your scale-out configuration and SAP NetWeaver or BW/4HANA Central Services.
- All other disk volumes aren't shared among the different nodes and aren't based on NFS.

Sizing the volumes for the nodes is the same as for scale-up, except **/hana/shared**. For the M128s virtual machine SKU, the suggested sizes and types look like:

| Configuration              | Suggestion |
|----------------------------|------------|
| **VM SKU**                 | M128s      |
| **RAM**                    | 2,000 GiB   |
| **Max. VM I/O Throughput** | 2,000 MB/s  |
| **/hana/data**             | 3 x P30    |
| **/hana/log**              | 2 x P20    |
| **/root** volume           | 1 x P6     |
| **/usr/sap**               | 1 x P6     |
| **hana/backup**            | 2 x P40    |

Make sure that the storage throughput for HANA-specific volumes meets the requirements of the workload that you want to run. If the workload requires higher volumes for **/hana/data** and **/hana/log**, you need to increase the number of Azure Premium Storage disks. Adding disks increases the IOPS and I/O throughput within the limits imposed by the Azure Virtual Machine size. In addition, ensure to enable Azure Write Accelerator on the disks that form the **/hana/log** volume.

SAP provides a formula that defines the size of the **/hana/shared** volume for scale-out as the multiple of the memory size of a single worker node for each four worker nodes. Assuming you take the SAP HANA scale-out certified M128s Azure Virtual Machine with roughly 2-TB memory, the SAP recommendations can be summarized as follows:

- 2-TB size of the **/hana/shared** volume for up to four worker nodes
- 4-TB size of the **/hana/shared** volume for between five and eight worker nodes
- 6-TB size of the **/hana/shared** volume for between 9 and 11 worker nodes
- 8-TB size of the **/hana/shared** volume for between 12 and 15 worker nodes

From the networking standpoint, SAP highly recommends a separation of the client/application facing traffic from the communications between the HANA nodes. This goal can be achieved by having two different vNICs attached to the virtual machine. Both vNICs are in different subnets and have different IP addresses. You then control the flow of traffic with NSGs and user-defined routes.

Azure doesn't offer the ability to enforce quality of service and quotas on specific vNICs. As a result, the separation of client/application facing, and intra-node communication doesn't provide a mechanism to prioritize one traffic stream over the other. Instead, the separation constitutes a measure of security in shielding the intra-node communications of the scale-out configurations. To optimize network performance, you should also consider:

- Since traffic to **/hana/shared** is moderate, route it through the vNIC that's assigned to the client network in the minimum configuration.
- Eventually, for the traffic to **/hana/shared**, create a third subnet in the virtual network hosting the SAP HANA scale-out configuration and assign a third vNIC that's hosted in that subnet. Use the third vNIC and associated IP address for the traffic to the NFS share. You then can apply separate access and routing rules.

If you want to share the highly available NFS cluster between SAP HANA configurations, move all those HANA configurations into the same virtual network.
