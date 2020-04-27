After you create a virtual machine (VM), you can scale the VM up or down by changing the VM size. Resizing VM might requires deallocating it first. This can happen if the new size is not available on the hardware cluster that is currently hosting the VM. Similarly, when resizing VMs in the same availability set, if the new size for a VM in an availability set is not available on the hardware cluster currently hosting the VM, then all VMs in the availability set will need to be deallocated to resize the VM. You also might need to update the size of other VMs in the availability set after one VM has been resized.

Resizing of Azure VMs can be performed from the Azure portal, via PowerShell, Azure CLI, Azure Resource Manager templates, or programmatically (including REST API).

## Storage

As explained earlier in this course, the size of the virtual machine controls how many data disks you can attach. Attaching disks is an online operation. You can detach a data disk without stopping the Azure VM by using PowerShell or Azure CLI, but you should first make sure that the disk is not being used. For details, refer to 

* **Windows VMs**: [https://docs.microsoft.com/azure/virtual-machines/windows/detach-disk](https://docs.microsoft.com/azure/virtual-machines/windows/detach-disk) 

* **Linux VMs**: [https://docs.microsoft.com/azure/virtual-machines/linux/detach-disk](https://docs.microsoft.com/azure/virtual-machines/linux/detach-disk) 

You also have the option of expanding attached Azure VM disks. For details, refer to

* **Windows VMs**: [https://docs.microsoft.com/azure/virtual-machines/windows/expand-os-disk](https://docs.microsoft.com/azure/virtual-machines/windows/expand-os-disk) 

* **Linux VMs**: [https://docs.microsoft.com/azure/virtual-machines/linux/expand-disks](https://docs.microsoft.com/azure/virtual-machines/linux/expand-disks)

## Scaling SAP HANA on Azure (Large Instances)

To scale up or down, you can choose from many sizes of servers that are available for HANA Large Instances. They are categorized as Type I and Type II and tailored for different workloads. Choose a size that can grow with your workload for the next three years. One-year commitments are also available. S/4HANA and SAP Business Suite on HANA on a single blade can be scaled up to 20 TB with a single HANA Large Instances instance.

A multi-host scale-out deployment is generally used for BW/4HANA deployments as a kind of database partitioning strategy. To scale out, plan the placement of HANA tables prior to installation. From an infrastructure standpoint, multiple hosts are connected to a shared storage volume, enabling quick takeover by standby hosts in case one of the compute worker nodes in the HANA system fails.

For green field scenarios, the SAP Quick Sizer is available to calculate memory requirements for SAP HANA. Memory requirements for HANA increase as data volume grows. Use the current memory consumption as the basis for predicting future consumption and calculate demand for a HANA Large Instances (HLI) sizes.

If you already have SAP deployments, SAP provides reports you can use to check the data used by existing systems and calculate memory requirements for a HANA instance. For example, see the following SAP Notes:

* SAP Note 1793345 - Sizing for SAP Suite on HANA

* SAP Note 1872170 - Suite on HANA and S/4 HANA sizing report

* SAP Note 2121330 - FAQ: SAP BW on HANA Sizing Report

* SAP Note 1736976 - Sizing Report for BW on HANA

* SAP Note 2296290 - New Sizing Report for BW on HANA

## Storage

You can add storage by purchasing additional storage in 1-TB units. This additional storage can be added as additional volume. It also can be used to extend one or more of the existing volumes. It isn't possible to decrease the sizes of the volumes as originally deployed. It also isn't possible to change the names of the volumes or mount names. The storage volumes are attached to the HANA Large Instance units as NFS4 volumes.

## SAP HANA data tiering and extension nodes

SAP supports a data tiering model for SAP BW of different SAP NetWeaver releases and SAP BW/4HANA. With HANA Large Instance, you can use option-1 configuration of SAP HANA extension nodes as explained in SAP BW/4HANA and SAP BW on HANA with SAP HANA extension nodes at [https://www.sap.com/documents/2017/05/ac051285-bc7c-0010-82c7-eda71af511fa.html#](https://www.sap.com/documents/2017/05/ac051285-bc7c-0010-82c7-eda71af511fa.html) . Option-2 configurations can be set up with the following HANA Large Instance SKUs: S72m, S192, S192m, S384, and S384m.

When you look at the documentation, the advantage might not be visible immediately. But when you look at the SAP sizing guidelines, you can see an advantage by using option-1 and option-2 SAP HANA extension nodes. Here are examples:

* SAP HANA sizing guidelines usually require double the amount of data volume as memory. When you run your SAP HANA instance with the hot data, you have only 50 percent or less of the memory filled with data. The remainder of the memory is ideally held for SAP HANA doing its work.

* That means in a HANA Large Instance S192 unit with 2 TB of memory, running an SAP BW database, you only have 1 TB as data volume.

* If you use an additional SAP HANA extension node of option-1, also a S192 HANA Large Instance SKU, it gives you an additional 2-TB capacity for data volume. In the option-2 configuration, you get an additional 4 TB for warm data volume. Compared to the hot node, the full memory capacity of the "warm" extension node can be used for data storing for option-1. Double the memory can be used for data volume in option-2 SAP HANA extension node configuration.

* You end up with a capacity of 3 TB for your data and a hot-to-warm ratio of 1:2 for option-1. You have 5 TB of data and a 1:4 ratio with the option-2 extension node configuration.


The higher the data volume compared to the memory, the higher the chances are that the warm data you are asking for is stored on disk storage.

