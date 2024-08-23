SAP HANA workloads require high performance and low latency. When planning to use  Azure NetApp Files application volume groups for SAP HANA, you should understand proximity placement groups and the requirements of your SAP HANA workload. Developing this understanding enables your application volume group to meet the requirements of your SAP HANA workload. 

## Architecture

Application servers and storage resources are connected through network switches in the Azure infrastructure. With application volume groups, Azure NetApp Files creates key SAP HANA resources – data and log volumes – on separate storage endpoints for each to get direct access with low latency. (If you're using replication technology for backup, these volumes are placed on a different resource.) These features deliver the NFS client performance necessary to optimize your SAP HANA workload by specific optimized placement of your resources.

## Virtual machine pinning

Azure NetApp Files application volume group leverages proximity placement groups (PPGs) in availability sets to ensure performance. PPGs enforce that the data, log, and shared volumes are created in the close proximity to the SAP HANA VMs so they can meet the performance and low latency requirements of the SAP HANA workload.

A PPG resides in an availability set (AvSet). An availability set is a logical grouping of VMs that allows Azure to understand how your application is built to provide for redundancy and availability. Before requesting pinning, you must create an AvSet then start a virtual machine in it.

When using a PPG without a pinned availability set, the PPG would lose its anchor if the virtual machines in the PPG aren't running. When the virtual machines are restarted, they might then be started in a different location. This action can result in a latency increase because the volumes created with the application volume group aren't moved.

## Planning

To use application volumes groups, you must have an understanding of your SAP HANA system, including the system type (single or multi-host), whether you want to use system replication, and the expected capacity requirements.

Once you gather this information and create an empty AvSet, you can request the AvSet pinning.

The request form requires the following information:

- Azure Region
- AvSet
- Azure VM type you plan to use
- Anticipated Azure NetApp Files capacity pool requirement
- SAP HANA system type (single or multi-host)