Storage layout is implemented according to the recommendation of the TDI for SAP HANA. HANA Large Instances come with a specific storage configuration for the standard TDI specifications. You can add storage to existing instances in 1-TB units. This additional storage can be added as additional volume. It also can be used to extend one or more of the existing volumes. It isn't possible to decrease the sizes of the volumes as originally deployed. It also isn't possible to change the names of the volumes or mount names. 

To support the requirements of mission-critical environments including fast recovery, NFS is used and not direct attached storage. The NFS storage server for HANA Large Instances is hosted in a multi-tenant environment, where tenants are segregated and secured using compute, network, and storage isolation. The storage volumes are attached to the HANA Large Instance units as NFS4 volumes.

To support high availability at the primary site, use different storage layouts. For example, in a multi-host scale-out, the storage is shared. Another high availability option is application-based replication such as HSR. For DR, however, a snapshot-based storage replication is used.

The HANA Large Instance of the Type I class comes with four times the memory volume as storage volume. This is not the case for the Type II class of HANA Large Instance units. The following table lists the rough capacity for the different volumes provisioned with the different HANA Large Instance units.

| HANA Large Instance SKU | hana/data | hana/log | hana/shared | hana/logbackups |
| --- | --- | --- | --- | --- |
| S72 | 1,280 GB | 512 GB | 768 GB | 512 GB |
| S72m | 3,328 GB | 768 GB | 1,280 GB | 768 GB |
| S96 | 1,280 GB | 512 GB | 768 GB | 512 GB |
| S192 | 4,608 GB | 1,024 GB | 1,536 GB | 1,024 GB |
| S192m | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S192xm | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S384 | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S384m | 12,000 GB | 2,050 GB | 2,050 GB | 2,040 GB |
| S384xm | 16,000 GB | 2,050 GB | 2,050 GB | 2,040 GB |
| S384xxm | 20,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S576m | 20,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S576xm | 31,744 GB | 4,096 GB | 2,048 GB | 4,096 GB |
| S768m | 28,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S768xm | 40,960 GB | 6,144 GB | 4,096 GB | 6,144 GB |
| S960m | 36,000 GB | 4,100 GB | 2,050 GB | 4,100 GB |

It's possible to host more than one active SAP HANA instance on HANA Large Instance units. To provide the capabilities of storage snapshots and disaster recovery, such a configuration requires a volume set per instance. Currently, HANA Large Instance units can be subdivided as follows:

* **S72, S72m, S96, S144, S192:** In increments of 256 GB, with 256 GB the smallest starting unit. Different increments such as 256 GB and 512 GB can be combined to the maximum of the memory of the unit.

* **S144m and S192m:** In increments of 256 GB, with 512 GB the smallest unit. Different increments such as 512 GB and 768 GB can be combined to the maximum of the memory of the unit.

* **Type II class:** In increments of 512 GB, with the smallest starting unit of 2 TB. Different increments such as 512 GB, 1 TB, and 1.5 TB can be combined to the maximum of the memory of the unit.

 