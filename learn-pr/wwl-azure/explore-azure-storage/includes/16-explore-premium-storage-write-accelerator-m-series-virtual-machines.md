



Azure Write Accelerator is a functionality that is available exclusively for Azure M-Series VMs. As the name states, the purpose of the functionality is to improve I/O latency of writes against the Azure Premium Storage. For SAP HANA, Write Accelerator is supposed to be used against the **/hana/log** volume only. Therefore, the **/hana/data** and **/hana/log** are separate volumes with Azure Write Accelerator supporting the **/hana/log** volume only.

> [!IMPORTANT]
> When using Azure Premium Storage, the usage of Azure [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator) or the **/hana/log** volume is mandatory. Write Accelerator is available for premium Storage and M-Series and Mv2-Series VMs only.

The caching recommendations below assume that the following statements are true about the I/O characteristics for SAP HANA:

- There is hardly any read workload against the HANA data files. Exceptions are large-sized I/Os after restart of the HANA instance or when data is loaded into HANA. Another case of larger read I/Os against data files can be HANA database backups. As a result, read caching mostly does not make sense, since in most cases all data file volumes need to be read completely.
- Writing against the data files is experienced in bursts based on HANA savepoints and HANA crash recovery. Writing savepoints is asynchronous and are not holding up any user transactions. Writing data during crash recovery is performance-critical in order to get the system to respond fast again. However, crash recovery should be rather exceptional situations
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
> For production scenarios, check whether a certain VM type is supported for SAP HANA by SAP in the [SAP documentation for IAAS](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas).

The recommended configurations for production scenarios look like:

### Configuration for SAP **/hana/data** volume

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **RAM**
  :::column-end:::
  :::column:::
    **Max. VM I/O throughput**
  :::column-end:::
  :::column:::
    **/hana/data**
  :::column-end:::
  :::column:::
    **Provisioned throughput**
  :::column-end:::
  :::column:::
    **Maximum burst throughput**
  :::column-end:::
  :::column:::
    **IOPS**
  :::column-end:::
  :::column:::
    **Burst IOPS**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ts
  :::column-end:::
  :::column:::
    192 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    4 x P6
  :::column-end:::
  :::column:::
    200 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    960
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ls
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    4 x P6
  :::column-end:::
  :::column:::
    200 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    960
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ls
  :::column-end:::
  :::column:::
    512 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    4 x P10
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    2,000
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32dms\_v2, M32ms\_v2
  :::column-end:::
  :::column:::
    875 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    4 x P15
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    4,400
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64s, M64ds\_v2, M64s\_v2
  :::column-end:::
  :::column:::
    1,024 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    4 x P15
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    4,400
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64dms\_v2, M64ms\_v2
  :::column-end:::
  :::column:::
    1,792 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    4 x P20
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    9,200
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128s, M128ds\_v2, M128s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P20
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    9,200
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ds\_v2, M192s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P20
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    680 MBps
  :::column-end:::
  :::column:::
    9,200
  :::column-end:::
  :::column:::
    14,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128dms\_v2, M128ms\_v2
  :::column-end:::
  :::column:::
    3,892 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P30
  :::column-end:::
  :::column:::
    800 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    20,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ims, M192idms\_v2
  :::column-end:::
  :::column:::
    4,096 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P30
  :::column-end:::
  :::column:::
    800 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    20,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208s\_v2
  :::column-end:::
  :::column:::
    2,850 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    4 x P30
  :::column-end:::
  :::column:::
    800 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    20,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    4 x P40
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    30,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416s\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P40
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    30,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2
  :::column-end:::
  :::column:::
    11,400 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    4 x P50
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
  :::column:::
    30,000
  :::column-end:::
  :::column:::
    no bursting
  :::column-end:::
:::row-end:::

### For the **/hana/log** volume. the configuration would look like

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **RAM**
  :::column-end:::
  :::column:::
    **Max. VM I/O throughput**
  :::column-end:::
  :::column:::
    **/hana/log volume**
  :::column-end:::
  :::column:::
    **Provisioned throughput**
  :::column-end:::
  :::column:::
    **Maximum burst throughput**
  :::column-end:::
  :::column:::
    **IOPS**
  :::column-end:::
  :::column:::
    **Burst IOPS**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ts
  :::column-end:::
  :::column:::
    192 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    3 x P10
  :::column-end:::
  :::column:::
    300 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    1,500
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ls
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    3 x P10
  :::column-end:::
  :::column:::
    300 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    1,500
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ls
  :::column-end:::
  :::column:::
    512 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    3 x P10
  :::column-end:::
  :::column:::
    300 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    1,500
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32dms\_v2, M32ms\_v2
  :::column-end:::
  :::column:::
    875 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64s, M64ds\_v2, M64s\_v2
  :::column-end:::
  :::column:::
    1,024 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64dms\_v2, M64ms\_v2
  :::column-end:::
  :::column:::
    1,792 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128s, M128ds\_v2, M128s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ids\_v2, M192is\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128dms\_v2, M128ms\_v2
  :::column-end:::
  :::column:::
    3,892 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192idms\_v2, M192ims\_v2
  :::column-end:::
  :::column:::
    4,096 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208s\_v2
  :::column-end:::
  :::column:::
    2,850 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416s\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2
  :::column-end:::
  :::column:::
    11,400 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    3 x P15
  :::column-end:::
  :::column:::
    375 MBps
  :::column-end:::
  :::column:::
    510 MBps
  :::column-end:::
  :::column:::
    3,300
  :::column-end:::
  :::column:::
    10,500
  :::column-end:::
:::row-end:::

### For the other volumes, the configuration would look like

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **RAM**
  :::column-end:::
  :::column:::
    **Max. VM I/O throughput**
  :::column-end:::
  :::column:::
    **/hana/shared**
  :::column-end:::
  :::column:::
    **/root volume**
  :::column-end:::
  :::column:::
    **/usr/sap**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ts
  :::column-end:::
  :::column:::
    192 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    1 x P15
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ls
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    1 x P15
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ls
  :::column-end:::
  :::column:::
    512 GiB
  :::column-end:::
  :::column:::
    1000 MBps
  :::column-end:::
  :::column:::
    1 x P20
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32dms\_v2, M32ms\_v2
  :::column-end:::
  :::column:::
    875 GiB
  :::column-end:::
  :::column:::
    500 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64s, M64ds\_v2, M64s\_v2
  :::column-end:::
  :::column:::
    1,024 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64dms\_v2, M64ms\_v2
  :::column-end:::
  :::column:::
    1,792 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128s, M128ds\_v2, M128s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ds\_v2, M192s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128dms\_v2, M128ms\_v2
  :::column-end:::
  :::column:::
    3,892 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192idms\_v2, M192ims\_v2
  :::column-end:::
  :::column:::
    4,096 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208s\_v2
  :::column-end:::
  :::column:::
    2,850 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416s\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2
  :::column-end:::
  :::column:::
    11,400 GiB
  :::column-end:::
  :::column:::
    2,000 MBps
  :::column-end:::
  :::column:::
    1 x P30
  :::column-end:::
  :::column:::
    1 x P10
  :::column-end:::
  :::column:::
    1 x P6
  :::column-end:::
:::row-end:::

M416xx\_v2 VM types are not yet made available by Microsoft to the public. Check whether the storage throughput for the different suggested volumes meets the workload that you want to run. If the workload requires higher volumes for **/hana/data** and **/hana/log**, you need to increase the number of Azure Premium Storage VHDs. Sizing a volume with more VHDs than listed increases the IOPS and I/O throughput within the limits of the Azure virtual machine type.

Azure Write Accelerator only works in conjunction with [Azure managed disks](https://azure.microsoft.com/services/managed-disks/). So at least the Azure Premium Storage disks forming the **/hana/log** volume need to be deployed as managed disks.

There are limits of Azure Premium Storage VHDs per VM that can be supported by Azure Write Accelerator. The current limits are:

- 16 VHDs for an M128xx and M416xx VM
- 8 VHDs for an M64xx and M208xx VM
- 4 VHDs for an M32xx VM

More detailed instructions on how to enable Azure Write Accelerator can be found in the article [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator).

Details and restrictions for Azure Write Accelerator can be found in the same documentation.

> [!TIP]
> You need to use Write Accelerator for disks forming the **/hana/log** volume.

## Cost conscious Azure Storage configuration

The following table shows a configuration of VM types that customers also use to host SAP HANA on Azure VMs. There might be some VM types that might not meet all minimum storage criteria for SAP HANA or are not officially supported with SAP HANA by SAP. But so far those VMs seemed to perform fine for non-production scenarios. The **/hana/data** and **/hana/log** are combined to one volume. As a result the usage of Azure Write Accelerator can become a limitation in terms of IOPS.

- For SAP supported scenarios, check whether a certain VM type is supported for SAP HANA by SAP in the [SAP documentation for IAAS](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/#/solutions?filters=iaas).
- A change from former recommendations for a cost conscious solution, is to move from [Azure Standard HDD disks](/azure/virtual-machines/windows/disks-types) to better performing and more reliable [Azure Standard SSD disks](/azure/virtual-machines/windows/disks-types).

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **RAM**
  :::column-end:::
  :::column:::
    **Max. VM I/O throughput**
  :::column-end:::
  :::column:::
    **/hana/data and /hana/log
striped with LVM or MDADM**
  :::column-end:::
  :::column:::
    **/hana/shared**
  :::column-end:::
  :::column:::
    **/root volume**
  :::column-end:::
  :::column:::
    **/usr/sap**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DS14v2
  :::column-end:::
  :::column:::
    112 GiB
  :::column-end:::
  :::column:::
    768 MB/s
  :::column-end:::
  :::column:::
    4 x P6
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E16v3
  :::column-end:::
  :::column:::
    128 GiB
  :::column-end:::
  :::column:::
    384 MB/s
  :::column-end:::
  :::column:::
    4 x P6
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    VM type not HANA certified
Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ts
  :::column-end:::
  :::column:::
    192 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    3 x P10
  :::column-end:::
  :::column:::
    1 x E15
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E20ds\_v4
  :::column-end:::
  :::column:::
    160 GiB
  :::column-end:::
  :::column:::
    480 MB/s
  :::column-end:::
  :::column:::
    4 x P6
  :::column-end:::
  :::column:::
    1 x E15
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E32v3
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    768 MB/s
  :::column-end:::
  :::column:::
    4 x P10
  :::column-end:::
  :::column:::
    1 x E15
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    VM type not HANA certified
Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E32ds\_v4
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    768 MBps
  :::column-end:::
  :::column:::
    4 x P10
  :::column-end:::
  :::column:::
    1 x E15
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ls
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    4 x P10
  :::column-end:::
  :::column:::
    1 x E15
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E48ds\_v4
  :::column-end:::
  :::column:::
    384 GiB
  :::column-end:::
  :::column:::
    1,152 MBps
  :::column-end:::
  :::column:::
    6 x P10
  :::column-end:::
  :::column:::
    1 x E20
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E64v3
  :::column-end:::
  :::column:::
    432 GiB
  :::column-end:::
  :::column:::
    1,200 MB/s
  :::column-end:::
  :::column:::
    6 x P10
  :::column-end:::
  :::column:::
    1 x E20
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E64ds\_v4
  :::column-end:::
  :::column:::
    504 GiB
  :::column-end:::
  :::column:::
    1200 MB/s
  :::column-end:::
  :::column:::
    7 x P10
  :::column-end:::
  :::column:::
    1 x E20
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Will not achieve less than 1 ms storage latency<sup>1</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ls
  :::column-end:::
  :::column:::
    512 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    7 x P10
  :::column-end:::
  :::column:::
    1 x E20
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32dms\_v2, M32ms\_v2
  :::column-end:::
  :::column:::
    875 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    6 x P15
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 5,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64s, M64ds\_v2, M64s\_v2
  :::column-end:::
  :::column:::
    1,024 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    7 x P15
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64dms\_v2, M64ms\_v2
  :::column-end:::
  :::column:::
    1,792 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    6 x P20
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128s, M128ds\_v2, M128s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    6 x P20
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ds\_v2, M192s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    6 x P20
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128dms\_v2, M128ms\_v2
  :::column-end:::
  :::column:::
    3,800 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    5 x P30
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192dms\_v2, M192ms\_v2
  :::column-end:::
  :::column:::
    4,096 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    5 x P30
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208s\_v2
  :::column-end:::
  :::column:::
    2,850 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    4 x P30
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    4 x P40
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 10,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416s\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    4 x P40
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2
  :::column-end:::
  :::column:::
    11400 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    7 x P40
  :::column-end:::
  :::column:::
    1 x E30
  :::column-end:::
  :::column:::
    1 x E10
  :::column-end:::
  :::column:::
    1 x E6
  :::column-end:::
  :::column:::
    Using Write Accelerator for combined data and log volume will limit IOPS rate to 20,000<sup>2</sup>
  :::column-end:::
:::row-end:::

<sup>1</sup>[Azure Write Accelerator](/azure/virtual-machines/how-to-enable-write-accelerator) can't be used with the Ev4 and Ev4 VM families. As a result of using Azure premium storage, the I/O latency will not be less than 1 ms.

<sup>2</sup> The VM family supports [Azure Write Accelerator](/azure/virtual-machines/how-to-enable-write-accelerator), but there is a potential that the IOPS limit of Write accelerator could limit the disk configurations IOPS capabilities.

M416xx\_v2 VM types are not yet made available by Microsoft to the public. The disks recommended for the smaller VM types with 3 x P20 oversize the volumes regarding the space recommendations according to the SAP TDI Storage Whitepaper. However, the choice as displayed in the table was made to provide sufficient disk throughput for SAP HANA. If you need changes to the **/hana/backup** volume, which was sized for keeping backups that represent twice the memory volume, feel free to adjust.

Check whether the storage throughput for the different suggested volumes meets the workload that you want to run. If the workload requires higher volumes for **/hana/data** and **/hana/log**, you need to increase the number of Azure Premium Storage VHDs. Sizing a volume with more VHDs than listed increases the IOPS and I/O throughput within the limits of the Azure virtual machine type.

- The configurations above would NOT benefit from [Azure virtual machine single VM SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_6/) since it does use a mixture of Azure Premium Storage and Azure Standard Storage. However, the selection was chosen in order to optimize costs. You would need to choose Premium Storage for all the disks above that listed as Azure Standard Storage to make the VM configuration compliant with the Azure single VM SLA.
- The disk configuration recommendations stated are targeting minimum requirements SAP expresses towards their infrastructure providers. In real customer deployments and workload scenarios, situations were encountered where these recommendations still did not provide sufficient capabilities. These could be situations where a customer required a faster reload of the data after a HANA restart or where backup configurations required higher bandwidth to the storage. Other cases included **/hana/log** where 5000 IOPS were not sufficient for the specific workload. So take these recommendations as a starting point and adapt based on the requirements of the workload.
