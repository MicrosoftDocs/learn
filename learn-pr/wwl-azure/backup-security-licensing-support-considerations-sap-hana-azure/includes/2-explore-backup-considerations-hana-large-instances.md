Based on your business requirements, choose from several options available for backup and recovery.

:::row:::
  :::column:::
    **Backup option**
  :::column-end:::
  :::column:::
    **Pros**
  :::column-end:::
  :::column:::
    **Cons**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA backup
  :::column-end:::
  :::column:::
    Native to SAP. Built-in consistency check.
  :::column-end:::
  :::column:::
    Long backup and recovery times. Storage space consumption.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA snapshot
  :::column-end:::
  :::column:::
    Native to SAP. Rapid backup and restore.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage snapshot
  :::column-end:::
  :::column:::
    Included with HANA Large Instances. Optimized DR for HANA Large Instances. Boot volume backup support.
  :::column-end:::
  :::column:::
    Maximum 254 snapshots per volume.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Log backup
  :::column-end:::
  :::column:::
    Required for point in time recovery.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::


SAP HANA on Azure (Large Instances) offers the following backup and restore options:

 -  **Do it yourself (DIY)**. After you make sure that there's enough disk space, perform full database and log backups by using one of the following disk backup methods. You can back up (using native tools such as SAP HANA Cockpit) either directly to volumes attached to the HANA Large Instance units or to NFS shares that are set up in an Azure virtual machine (VM). In the latter case, customers set up a Linux VM in Azure, attach Azure Storage to the VM, and share the storage through a configured NFS server in that VM. If you perform the backup against volumes that directly attach to HANA Large Instance units, copy the backups to an Azure storage account. Do this after you set up an Azure VM that exports NFS shares that are based on Azure Storage. You can also use either an Azure Backup vault or Azure cold storage. Another option is to use a third-party data protection tool to store the backups after they're copied to an Azure storage account. The DIY backup option also might be necessary for data that you need to store for longer periods of time for compliance and auditing purposes. In all cases, the backups are copied into NFS shares represented through a VM and Azure Storage.
 -  **Infrastructure backup and restore functionality**. You also can use the backup and restore functionality that the underlying infrastructure of SAP HANA on Azure (Large Instances) provides. This option fulfills the need for backups and fast restores. The rest of this section addresses the backup and restore functionality that's offered with HANA Large Instances. This section also covers the relationship that backup and restore have to the disaster recovery functionality offered by HANA Large Instances.

The snapshot technology that's used by the underlying infrastructure of HANA Large Instances has a dependency on SAP HANA snapshots. At this point, SAP HANA snapshots don't work in conjunction with multiple tenants of SAP HANA multitenant database containers. If only one tenant is deployed, SAP HANA snapshots do work, and you can use this method.
