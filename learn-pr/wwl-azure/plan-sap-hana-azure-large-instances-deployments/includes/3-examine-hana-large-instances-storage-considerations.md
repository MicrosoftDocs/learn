Storage layout is implemented according to the recommendation of the TDI for SAP HANA. HANA Large Instances come with a specific storage configuration for the standard TDI specifications. You can add storage to existing instances in 1 TB units. This additional storage can be added as additional volume. It also can be used to extend one or more of the existing volumes. It isn't possible to decrease the sizes of the volumes as originally deployed. It also isn't possible to change the names of the volumes or mount names.

To support the requirements of mission-critical environments including fast recovery, NFS is used and not direct attached storage. The NFS storage server for HANA Large Instances is hosted in a multi-tenant environment, where tenants are segregated and secured using compute, network, and storage isolation. The storage volumes are attached to the HANA Large Instance units as NFS4 volumes.

To support high availability at the primary site, use different storage layouts. For example, in a multi-host scale-out, the storage is shared. Another high availability option is application-based replication such as HSR. For DR, however, a snapshot-based storage replication is used.

The HANA Large Instance SKUs of the Type I class come with four times the memory volume as storage volume. This is not the case for the Type II class of HANA Large Instance units. The following table lists the rough capacity for the different volumes provisioned with the different HANA Large Instance units.

:::row:::
  :::column:::
    **HANA Large Instance SKU**
  :::column-end:::
  :::column:::
    **hana/data**
  :::column-end:::
  :::column:::
    **hana/log**
  :::column-end:::
  :::column:::
    **hana/shared**
  :::column-end:::
  :::column:::
    **hana/logbackups**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S72
  :::column-end:::
  :::column:::
    1,280 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    768 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S72m
  :::column-end:::
  :::column:::
    3,328 GB
  :::column-end:::
  :::column:::
    768 GB
  :::column-end:::
  :::column:::
    1,280 GB
  :::column-end:::
  :::column:::
    768 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S96
  :::column-end:::
  :::column:::
    1,280 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    768 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S192
  :::column-end:::
  :::column:::
    4,608 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S192m
  :::column-end:::
  :::column:::
    11,520 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
  :::column:::
    1,792 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S192xm
  :::column-end:::
  :::column:::
    11,520 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
  :::column:::
    1,792 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S384
  :::column-end:::
  :::column:::
    11,520 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
  :::column:::
    1,792 GB
  :::column-end:::
  :::column:::
    1,536 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S384m
  :::column-end:::
  :::column:::
    12,000 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    2,040 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S384xm
  :::column-end:::
  :::column:::
    16,000 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    2,040 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S384xxm
  :::column-end:::
  :::column:::
    20,000 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S576m
  :::column-end:::
  :::column:::
    20,000 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S576xm
  :::column-end:::
  :::column:::
    31,744 GB
  :::column-end:::
  :::column:::
    4,096 GB
  :::column-end:::
  :::column:::
    2,048 GB
  :::column-end:::
  :::column:::
    4,096 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S768m
  :::column-end:::
  :::column:::
    28,000 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    3,100 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S768xm
  :::column-end:::
  :::column:::
    40,960 GB
  :::column-end:::
  :::column:::
    6,144 GB
  :::column-end:::
  :::column:::
    4,096 GB
  :::column-end:::
  :::column:::
    6,144 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S960m
  :::column-end:::
  :::column:::
    36,000 GB
  :::column-end:::
  :::column:::
    4,100 GB
  :::column-end:::
  :::column:::
    2,050 GB
  :::column-end:::
  :::column:::
    4,100 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896m
  :::column-end:::
  :::column:::
    33,792 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::


More recent SKUs of HANA Large Instances are delivered with storage configurations looking like:

:::row:::
  :::column:::
    **HANA Large Instance SKU**
  :::column-end:::
  :::column:::
    **hana/data**
  :::column-end:::
  :::column:::
    **hana/log**
  :::column-end:::
  :::column:::
    **hana/shared**
  :::column-end:::
  :::column:::
    **hana/logbackups**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224
  :::column-end:::
  :::column:::
    4,224 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224oo
  :::column-end:::
  :::column:::
    6,336 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224m
  :::column-end:::
  :::column:::
    8,448 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224om
  :::column-end:::
  :::column:::
    8,448 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224ooo
  :::column-end:::
  :::column:::
    10,560 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S224oom
  :::column-end:::
  :::column:::
    12,672 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448
  :::column-end:::
  :::column:::
    8,448 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448oo
  :::column-end:::
  :::column:::
    12,672 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448m
  :::column-end:::
  :::column:::
    16,896 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448om
  :::column-end:::
  :::column:::
    16,896 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448ooo
  :::column-end:::
  :::column:::
    21,120 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S448oom
  :::column-end:::
  :::column:::
    25,344 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672
  :::column-end:::
  :::column:::
    12,672 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672oo
  :::column-end:::
  :::column:::
    19,008 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672m
  :::column-end:::
  :::column:::
    25,344 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672om
  :::column-end:::
  :::column:::
    25,344 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672ooo
  :::column-end:::
  :::column:::
    31,680 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S672oom
  :::column-end:::
  :::column:::
    38,016 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896
  :::column-end:::
  :::column:::
    16,896 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896oo
  :::column-end:::
  :::column:::
    25,344 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896om
  :::column-end:::
  :::column:::
    33,792 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896ooo
  :::column-end:::
  :::column:::
    42,240 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    S896oom
  :::column-end:::
  :::column:::
    50,688 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
  :::column:::
    1,024 GB
  :::column-end:::
  :::column:::
    512 GB
  :::column-end:::
:::row-end:::


It's possible to host more than one active SAP HANA instance on HANA Large Instance units. To provide the capabilities of storage snapshots and disaster recovery, such a configuration requires a volume set per instance. Currently, HANA Large Instance units can be subdivided as follows:

 -  S72, S72m, S96, S144, S192: In increments of 256 GB, with 256 GB the smallest starting unit. Different increments such as 256 GB and 512 GB can be combined to the maximum of the memory of the unit.
 -  S144m and S192m: In increments of 256 GB, with 512 GB the smallest unit. Different increments such as 512 GB and 768 GB can be combined to the maximum of the memory of the unit.
 -  Type II class: In increments of 512 GB, with the smallest starting unit of 2 TB. Different increments such as 512 GB, 1 TB, and 1.5 TB can be combined to the maximum of the memory of the unit.

The storage used in HANA Large Instances has a file size limitation of 16 TB. Unlike in file size limitations in the EXT3 file systems, HANA is not aware implicitly of the storage limitation enforced by the HANA Large Instances storage. As a result, HANA will not automatically create a new data file when the file size limit of 16 TB is reached. As HANA attempts to grow the file beyond 16 TB, HANA will report errors and the index server will crash at the end. To prevent HANA trying to grow data files beyond the 16 TB file size limit of HANA Large Instance storage, you need to set the following parameters in the global.ini configuration file of HANA:

 -  datavolume\_striping = true
 -  datavolume\_striping\_size\_gb = 15000

For additional information, refer to [SAP Note \#2400005](https://launchpad.support.sap.com/#/notes/2400005) and [SAP Note \#2631285](https://launchpad.support.sap.com/#/notes/2631285).
