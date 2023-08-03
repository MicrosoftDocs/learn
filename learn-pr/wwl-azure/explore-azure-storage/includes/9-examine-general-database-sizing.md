



When you plan your disk layout, find the optimal configuration based on the following factors:

- The number of data files
- The number of disks that contain the files
- The IOPS quotas of a single disk
- The data throughput per disk
- The number of additional data disks possible per VM size
- The overall storage throughput a VM can provide
- The latency different Azure Storage types can provide
- VM SLAs

Database performance is dependent on the underlying storage. For new workloads on Azure, the number of IOPS and throughput should come from the sizing estimates. In migrations, the storage performance requirement can be obtained either from the underlying storage platform, whether it has performance monitoring tools available, or from the database itself.

[SAP Note \#1872170](https://aka.ms/az-120-sapnote-1872170) provides an ABAP report to estimate the memory and disk space requirements for the database tables of Business Suite on SAP HANA, S/4HANA systems, and any other ABAP-based systems running on HANA, except for BW. The result of the report should be cross-checked with the sizing method for SAP HANA main memory, described in [SAP Note \#1793345](https://aka.ms/az-120-sapnote-1793345). The report output is only an estimate of memory and disk requirements of HANA. The current version of the report is valid for sizing of SAP HANA 1.0 and 2.0. Database statistics must be up to date in order to provide a reliable sizing result.

For migration, the source database size may differ greatly from the target database size. For instance, if the source is an Oracle DB or SQL DB uncompressed, the target SAP Hana DB should be compressed and much smaller than the source.
