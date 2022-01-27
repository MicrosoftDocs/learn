Write Accelerator is a disk capability for M-Series Azure VMs with Premium storage-based Azure managed disks. Its purpose is to improve the I/O latency of writes. Write Accelerator is ideally suited where log file updates are required to persist to disk in a highly performant manner for modern databases.

Write Accelerator should be used for the volumes that contain the transaction log or redo logs of a DBMS. It is not recommended to use Write Accelerator for the data volumes of a DBMS as the feature has been optimized to be used against log disks.

When using Write Accelerator for Azure VM disks, these restrictions apply:

 -  **The disk caching must be set to 'None' or 'Read Only'**. All other caching modes are not supported.
 -  **Snapshots are not currently supported for Write Accelerator-enabled disks**. During backup, the Azure Backup service automatically excludes Write Accelerator-enabled disks attached to the VM.
 -  **Only smaller I/O sizes (&lt;=512 KiB) are taking the accelerated path**. In workload situations where data is getting bulk loaded or where the transaction log buffers of the different DBMS are filled to a larger degree before getting persisted to the storage, chances are that the I/O written to disk is not taking the accelerated path.

In addition, it is important to note that there are limits on the number of Azure Premium Storage VHDs per VM that can be supported by Write Accelerator. At the time of authoring, the limits are:

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **Number of Write Accelerator disks**
  :::column-end:::
  :::column:::
    **Write Accelerator Disk IOPS per VM**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2, M416s\_v2
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    20000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2, M208s\_v2
  :::column-end:::
  :::column:::
    8
  :::column-end:::
  :::column:::
    10000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128s
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    20000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64ls, M64s
  :::column-end:::
  :::column:::
    8
  :::column-end:::
  :::column:::
    10000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ms, M32ls, M32ts, M32s
  :::column-end:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    5000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M16ms, M16s
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    2500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M8ms, M8s
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    1250
  :::column-end:::
:::row-end:::


The IOPS limits are per VM and not per disk. All Write Accelerator enabled disks share the same IOPS limit per VM. For more information regarding this topic, see [Enable Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator).

## Optional demo:

 -  [Demonstration: Back up Azure file shares](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-back-up-azure-file-shares.md)
