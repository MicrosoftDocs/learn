Azure Write Accelerator is a functionality that's available exclusively for Azure M-Series virtual machines. As the name states, the purpose of the functionality is to improve I/O latency of writes against the Azure Premium Storage. For SAP HANA, Write Accelerator is supposed to be used against the **/hana/log** volume only. Therefore, the **/hana/data** and **/hana/log** are separate volumes with Azure Write Accelerator supporting the **/hana/log** volume only.

> [!IMPORTANT]
> When using Azure Premium Storage, the usage of Azure [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator) or the **/hana/log** volume is mandatory. Write Accelerator is available for premium Storage and M-Series and Mv2-Series virtual machines only.

The caching recommendations below assume that the following statements are true about the I/O characteristics for SAP HANA:

- There is hardly any read workload against the HANA data files. Exceptions are large-sized I/Os after restart of the HANA instance or when data is loaded into HANA. Another case of larger read I/Os against data files can be HANA database backups. As a result, read caching mostly doesn't make sense, since in most cases all data file volumes need to be read completely.
- Writing against the data files is experienced in bursts based on HANA savepoints and HANA crash recovery. Writing savepoints is asynchronous and aren't holding up any user transactions. Writing data during crash recovery is performance-critical in order to get the system to respond fast again. However, crash recovery should be rather exceptional situations
- There are hardly any reads from the HANA redo files. Exceptions are large I/Os when performing transaction log backups, crash recovery, or in the restart phase of a HANA instance.
- Main load against the SAP HANA redo log file is writes. Dependent on the nature of the workload, you can have I/Os as small as 4 KB or in other cases I/O sizes of 1 MB or more. Write latency against the SAP HANA redo log is performance-critical.
- All writes need to be persisted on disk in a reliable fashion.

As a result of these observed I/O patterns by SAP HANA, the caching for the different volumes using Azure Premium Storage should be set like:

- **/hana/data** \- no caching
- **/hana/log** \- no caching - exception for M- and Mv2-Series where Write Accelerator should be enabled without read caching.
- **/hana/shared** \- read caching

## Production recommended storage solution

> [!IMPORTANT]
> SAP HANA certification for Azure M-Series virtual machines is exclusively with Azure Write Accelerator for the **/hana/log** volume. As a result, production scenario SAP HANA deployments on Azure M-Series virtual machines are expected to be configured with Azure Write Accelerator for the **/hana/log** volume.

> [!NOTE]
> For production scenarios, check whether a certain virtual machine type is supported for SAP HANA by SAP in the [SAP documentation for IAAS](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=v:deCertified;iaas;ve:24).

The recommended configurations for production scenarios look like:

### Configuration for SAP **/hana/data** volume

| VM SKU | RAM | Max. VM I/O throughput | /hana/data | Provisioned throughput | Maximum burst throughput | IOPS | Burst IOPS |
|-|-|-|-|-|-|-|-|
| M32ts | 192 GiB | 500 MBps | 4 x P6 | 200 MBps | 680 MBps | 960 | 14,000 |
| M32ls | 256 GiB | 500 MBps | 4 x P6 | 200 MBps | 680 MBps | 960 | 14,000 |
| M64ls | 512 GiB | 1,000 MBps | 4 x P10 | 400 MBps | 680 MBps | 2,000 | 14,000 |
| M32dms\_v2, M32ms\_v2 | 875 GiB | 500 MBps | 4 x P15 | 500 MBps | 680 MBps | 4,400 | 14,000 |
| M64s, M64ds\_v2, M64s\_v2 | 1,024 GiB | 1,000 MBps | 4 x P15 | 500 MBps | 680 MBps | 4,400 | 14,000 |
| M64ms, M64dms\_v2, M64ms\_v2 | 1,792 GiB | 1,000 MBps | 4 x P20 | 600 MBps | 680 MBps | 9,200 | 14,000 |
| M128s, M128ds\_v2, M128s\_v2 | 2,048 GiB | 2,000 MBps | 4 x P20 | 600 MBps | 680 MBps | 9,200 | 14,000 |
| M192ds\_v2, M192s\_v2 | 2,048 GiB | 2,000 MBps | 4 x P20 | 600 MBps | 680 MBps | 9,200 | 14,000 |
| M128ms, M128dms\_v2, M128ms\_v2 | 3,892 GiB | 2,000 MBps | 4 x P30 | 800 MBps | no bursting | 20,000 | no bursting |
| M192ims, M192idms\_v2 | 4,096 GiB | 2,000 MBps | 4 x P30 | 800 MBps | no bursting | 20,000 | no bursting |
| M208s\_v2 | 2,850 GiB | 1,000 MBps | 4 x P30 | 800 MBps | no bursting | 20,000 | no bursting |
| M208ms\_v2 | 5,700 GiB | 1,000 MBps | 4 x P40 | 1,000 MBps | no bursting | 30,000 | no bursting |
| M416s\_v2 | 5,700 GiB | 2,000 MBps | 4 x P40 | 1,000 MBps | no bursting | 30,000 | no bursting |
| M416ms\_v2 | 11,400 GiB | 2,000 MBps | 4 x P50 | 1,000 MBps | no bursting | 30,000 | no bursting |

### Configuration for the **/hana/log** volume

| VM SKU | RAM | Max. VM I/O throughput | /hana/log volume | Provisioned throughput | Maximum burst throughput | IOPS | Burst IOPS |
|-|-|-|-|-|-|-|-|
| M32ts | 192 GiB | 500 MBps | 3 x P10 | 300 MBps | 510 MBps | 1,500 | 10,500 |
| M32ls | 256 GiB | 500 MBps | 3 x P10 | 300 MBps | 510 MBps | 1,500 | 10,500 |
| M64ls | 512 GiB | 1,000 MBps | 3 x P10 | 300 MBps | 510 MBps | 1,500 | 10,500 |
| M32dms\_v2, M32ms\_v2 | 875 GiB | 500 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M64s, M64ds\_v2, M64s\_v2 | 1,024 GiB | 1,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M64ms, M64dms\_v2, M64ms\_v2 | 1,792 GiB | 1,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M128s, M128ds\_v2, M128s\_v2 | 2,048 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M192ids\_v2, M192is\_v2 | 2,048 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M128ms, M128dms\_v2, M128ms\_v2 | 3,892 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M192idms\_v2, M192ims\_v2 | 4,096 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M208s\_v2 | 2,850 GiB | 1,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M208ms\_v2 | 5,700 GiB | 1,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M416s\_v2 | 5,700 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |
| M416ms\_v2 | 11,400 GiB | 2,000 MBps | 3 x P15 | 375 MBps | 510 MBps | 3,300 | 10,500 |

### Configuration for the other volumes

| VM SKU | RAM | Max. VM I/O throughput | /hana/shared | /root volume | /usr/sap |
|-|-|-|-|-|-|
| M32ts | 192 GiB | 500 MBps | 1 x P15 | 1 x P6 | 1 x P6 |
| M32ls | 256 GiB | 500 MBps | 1 x P15 | 1 x P6 | 1 x P6 |
| M64ls | 512 GiB | 1000 MBps | 1 x P20 | 1 x P6 | 1 x P6 |
| M32dms\_v2, M32ms\_v2 | 875 GiB | 500 MBps | 1 x P30 | 1 x P6 | 1 x P6 |
| M64s, M64ds\_v2, M64s\_v2 | 1,024 GiB | 1,000 MBps | 1 x P30 | 1 x P6 | 1 x P6 |
| M64ms, M64dms\_v2, M64ms\_v2 | 1,792 GiB | 1,000 MBps | 1 x P30 | 1 x P6 | 1 x P6 |
| M128s, M128ds\_v2, M128s\_v2 | 2,048 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M192ds\_v2, M192s\_v2 | 2,048 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M128ms, M128dms\_v2, M128ms\_v2 | 3,892 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M192idms\_v2, M192ims\_v2 | 4,096 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M208s\_v2 | 2,850 GiB | 1,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M208ms\_v2 | 5,700 GiB | 1,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M416s\_v2 | 5,700 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |
| M416ms\_v2 | 11,400 GiB | 2,000 MBps | 1 x P30 | 1 x P10 | 1 x P6 |

M416xx\_v2 virtual machine types aren't yet made available by Microsoft to the public. Check whether the storage throughput for the different suggested volumes meets the workload that you want to run. If the workload requires higher volumes for **/hana/data** and **/hana/log**, you need to increase the number of Azure Premium Storage VHDs. Sizing a volume with more VHDs than listed increases the IOPS and I/O throughput within the limits of the Azure Virtual Machine type.

Azure Write Accelerator only works in conjunction with [Azure managed disks](https://azure.microsoft.com/services/managed-disks/). So at least the Azure Premium Storage disks forming the **/hana/log** volume need to be deployed as managed disks.

There are limits of Azure Premium Storage VHDs per virtual machine that can be supported by Azure Write Accelerator. The current limits are:

- 16 VHDs for an M128xx and M416xx virtual machine
- 8 VHDs for an M64xx and M208xx virtual machine
- 4 VHDs for an M32xx virtual machine

More detailed instructions on how to enable Azure Write Accelerator can be found in the article [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator).

Details and restrictions for Azure Write Accelerator can be found in the same documentation.

> [!TIP]
> You need to use Write Accelerator for disks forming the **/hana/log** volume.

## Cost conscious Azure Storage configuration

The following table shows a configuration of virtual machine types that customers also use to host SAP HANA on Azure Virtual Machines. There might be some virtual machine types that might not meet all minimum storage criteria for SAP HANA or aren't officially supported with SAP HANA by SAP. But so far those virtual machines seemed to perform fine for non-production scenarios. The **/hana/data** and **/hana/log** are combined to one volume. As a result the usage of Azure Write Accelerator can become a limitation in terms of IOPS.

- For SAP supported scenarios, check whether a certain virtual machine type is supported for SAP HANA by SAP in the [SAP documentation for IAAS](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=v:deCertified;iaas;ve:24).
- A change from former recommendations for a cost conscious solution, is to move from [Azure Standard HDD disks](/azure/virtual-machines/windows/disks-types) to better performing and more reliable [Azure Standard SSD disks](/azure/virtual-machines/windows/disks-types).

| VM SKU | RAM | Max. VM I/O throughput | /hana/data and /hana/log striped with LVM or MDADM | /hana/shared | /root volume | /usr/sap | Comments |
|-|-|-|-|-|-|-|-|
| DS14v2 | 112 GiB | 768 MB/s | 4 x P6 | 1 x E10 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| E16v3 | 128 GiB | 384 MB/s | 4 x P6 | 1 x E10 | 1 x E6 | 1 x E6 | Virtual machine type not HANA certified<sup>1</sup> |
| M32ts | 192 GiB | 500 MB/s | 3 x P10 | 1 x E15 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup> |
| E20ds\_v4 | 160 GiB | 480 MB/s | 4 x P6 | 1 x E15 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| E32v3 | 256 GiB | 768 MB/s | 4 x P10 | 1 x E15 | 1 x E6 | 1 x E6 | Virtual machine type not HANA certified<sup>1</sup> |
| E32ds\_v4 | 256 GiB | 768 MBps | 4 x P10 | 1 x E15 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| M32ls | 256 GiB | 500 MB/s | 4 x P10 | 1 x E15 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup> |
| E48ds\_v4 | 384 GiB | 1,152 MBps | 6 x P10 | 1 x E20 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| E64v3 | 432 GiB | 1,200 MB/s | 6 x P10 | 1 x E20 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| E64ds\_v4 | 504 GiB | 1200 MB/s | 7 x P10 | 1 x E20 | 1 x E6 | 1 x E6 | Will not achieve less than 1 ms storage latency<sup>1</sup> |
| M64ls | 512 GiB | 1,000 MB/s | 7 x P10 | 1 x E20 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup> |
| M32dms\_v2, M32ms\_v2 | 875 GiB | 500 MB/s | 6 x P15 | 1 x E30 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup> |
| M64s, M64ds\_v2, M64s\_v2 | 1,024 GiB | 1,000 MB/s | 7 x P15 | 1 x E30 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup> |
| M64ms, M64dms\_v2, M64ms\_v2 | 1,792 GiB | 1,000 MB/s | 6 x P20 | 1 x E30 | 1 x E6 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup> |
| M128s, M128ds\_v2, M128s\_v2 | 2,048 GiB | 2,000 MB/s | 6 x P20 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |
| M192ds\_v2, M192s\_v2 | 2,048 GiB | 2,000 MB/s | 6 x P20 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |
| M128ms, M128dms\_v2, M128ms\_v2 | 3,800 GiB | 2,000 MB/s | 5 x P30 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |
| M192dms\_v2, M192ms\_v2 | 4,096 GiB | 2,000 MB/s | 5 x P30 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |
| M208s\_v2 | 2,850 GiB | 1,000 MB/s | 4 x P30 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup> |
| M208ms\_v2 | 5,700 GiB | 1,000 MB/s | 4 x P40 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup> |
| M416s\_v2 | 5,700 GiB | 2,000 MB/s | 4 x P40 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |
| M416ms\_v2 | 11400 GiB | 2,000 MB/s | 7 x P40 | 1 x E30 | 1 x E10 | 1 x E6 | Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup> |

<sup>1</sup>[Azure Write Accelerator](/azure/virtual-machines/how-to-enable-write-accelerator) can't be used with the Ev4 and Ev4 virtual machine families. As a result of using Azure premium storage, the I/O latency will not be less than 1 ms.

<sup>2</sup> The virtual machine family supports [Azure Write Accelerator](/azure/virtual-machines/how-to-enable-write-accelerator), but there's a potential that the IOPS limit of Write accelerator could limit the disk configurations IOPS capabilities.

M416xx\_v2 virtual machine types aren't yet made available by Microsoft to the public. The disks recommended for the smaller virtual machine types with 3 x P20 oversize the volumes regarding the space recommendations according to the SAP TDI Storage Whitepaper. However, the choice as displayed in the table was made to provide sufficient disk throughput for SAP HANA. If you need changes to the **/hana/backup** volume, which was sized for keeping backups that represent twice the memory volume, feel free to adjust.

Check whether the storage throughput for the different suggested volumes meets the workload that you want to run. If the workload requires higher volumes for **/hana/data** and **/hana/log**, you need to increase the number of Azure Premium Storage VHDs. Sizing a volume with more VHDs than listed increases the IOPS and I/O throughput within the limits of the Azure Virtual Machine type.

- The configurations above wouldn't benefit from [Azure Virtual Machine single virtual machine SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_6/) since it does use a mixture of Azure Premium Storage and Azure Standard Storage. However, the selection was chosen in order to optimize costs. You would need to choose Premium Storage for all the disks above that listed as Azure Standard Storage to make the virtual machine configuration compliant with the Azure single virtual machine SLA.
- The disk configuration recommendations stated are targeting minimum requirements SAP expresses towards their infrastructure providers. In real customer deployments and workload scenarios, situations were encountered where these recommendations still did not provide sufficient capabilities. These could be situations where a customer required a faster reload of the data after a HANA restart or where backup configurations required higher bandwidth to the storage. Other cases included **/hana/log** where 5000 IOPS were not sufficient for the specific workload. So take these recommendations as a starting point and adapt based on the requirements of the workload.
