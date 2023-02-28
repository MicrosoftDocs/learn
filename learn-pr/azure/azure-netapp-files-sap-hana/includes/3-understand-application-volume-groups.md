SAP HANA workloads require high performance. When planning to use application volume groups for SAP HANA with Azure NetApp Files, you should understand proximity placement groups and the requirements of your SAP HANA workload. Developing this understanding enables your application volume group can meet to requirements of your SAPA HANA workload. 

## Architecture

Your Azure NetApp Files and SAP HANA system run in clusters connected to network switches. With application volume groups, Azure NetApp Files creates key SAP HANA resources – data and log volumes – on different resources and uses separate IP addresses for each to get direct access with low latency. (If you're using replication technology for backup, these volumes are placed on a different resource.) These features deliver the NFS client performance necessary to optimize your SAP HANA workload, however they require specific placement of your resources.

The following diagram illustrates an application volume group deployment, showing the placement of different resources:

:::image type="content" source="../media/3-azure-netapp-files-sap-hana-diagram.png" alt-text="Diagram depicting Azure NetApp Files application groups for SAP HANA." lightbox="../media/3-azure-netapp-files-sap-hana-diagram.png":::


## Proximity placement groups

Azure NetApp Files leverages proximity placement groups (PPGs) in availability groups to ensure performance. PPGs enforce that the data, log, and shared volumes are created in the close proximity to the SAP HANA VMs so they can meet the performance and low latency required of the SAP HANA workload.

A PPG resides in an availability set (AvSet). An availability set is a logical grouping of VMs that allows Azure to understand how your application is built to provide for redundancy and availability. You must create an empty AvSet before requesting a PPG.

When using a PPG without a pinned availability set, a PPG would lose its anchor if all the virtual machines in that PPG are stopped. When the virtual machines are restarted, they might be started in a different location, which can result in a latency increase because the volumes created with the application volume group won't be moved.

## Planning

To use application volumes groups, you must have an understanding of your SAP HANA system, including the system type (single or multi-host), whether you want to use system replication, and what your expected capacity limits are.

Once you've gathered this information and created an empty AvSet, you can request the PPG. 

The request form requires you provide the following information:

- Azure Region
- AvSet
- Azure VM type you plan to use
- Anticipated Azure NetApp Files capacity pool requirement
- SAP HANA system type (single or multi-host)
