Write Accelerator is a disk capability for M-Series Azure Virtual Machines with Premium storage-based Azure managed disks. Its purpose is to improve the I/O latency of writes. Write Accelerator is ideally suited where log file updates are required to persist to disk in a highly performant manner for modern databases.

Write Accelerator should be used for the volumes that contain the transaction log or redo logs of a DBMS. It isn't recommended to use Write Accelerator for the data volumes of a DBMS as the feature has been optimized to be used against log disks.

When using Write Accelerator for Azure Virtual Machine disks, these restrictions apply:

- **The disk caching must be set to 'None' or 'Read Only'**. All other caching modes aren't supported.
- **Azure Disk Backup does support backup of Write Accelerator-enabled disks. However, during restore the disk will be restored as a normal disk.** Write Accelerater cache can be enabled on the restored disk after mounting it to a virtual machine.
- **Only smaller I/O sizes (&lt;=512 KiB) are taking the accelerated path**. In workload situations where data is getting bulk loaded or where the transaction log buffers of the different DBMS are filled to a larger degree before getting persisted to the storage, chances are that the I/O written to disk isn't taking the accelerated path.

In addition, it's important to note that there are limits on the number of Azure Premium Storage VHDs per virtual machine that can be supported by Write Accelerator. At the time of authoring, the limits are:

| VM SKU | Number of Write Accelerator disks | Write Accelerator Disk IOPS per virtual machine |
|-|-|-|
| M416ms\_v2, M416s\_v2 | 16 | 20000 |
| M208ms\_v2, M208s\_v2 | 8 | 10000 |
| M192ids\_v2, M192idms\_v2, M192is\_v2, M192ims\_v2 | 16 | 20000 |
| M128ms, M128s, M128ds\_v2, M128dms\_v2, M128s\_v2, M128ms\_v2 | 16 | 20000 |
| M64ms, M64ls, M64s, M64ds\_v2, M64dms\_v2, M64s\_v2, M64ms\_v2 | 8 | 10000 |
| M32ms, M32ls, M32ts, M32s, M32dms\_v2, M32ms\_v2 | 4 | 5000 |
| M16ms, M16s | 2 | 2500 |
| M8ms, M8s | 1 | 1250 |

The IOPS limits are per virtual machine and not per disk. All Write Accelerator enabled disks share the same IOPS limit per virtual machine. For more information regarding this topic, see [Enable Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator).

## Optional demo

- [Demonstration: Back up Azure file shares](https://go.microsoft.com/fwlink/?linkid=2260470&clcid=0x409)
