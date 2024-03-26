SAP HANA on Azure VMs can be backed up by using the following two methods:

- HANA backup to the file system in an Azure Linux VM
- HANA backup based on storage snapshots using either the Azure storage blob snapshot feature manually or Azure VM Level Backup

SAP doesn't provide recommendations regarding the choice between the two methods. SAP lists the pros and cons, so one can determine which to use depending on the situation and available storage technology.

Azure blob snapshot doesn't guarantee file system consistency. This lack of guarantee needs to be accounted for when taking storage snapshots. File system and application consistency are complex issues when taking storage snapshots. The easiest way to avoid problems would be to shut down SAP HANA, or maybe even the whole virtual machine. A shutdown might be doable with a demo or prototype, or even a development system, but isn't an option for a production system.

File system consistency is available when using the SAP HANA snapshot feature if there's only a single virtual disk involved. But even with a single disk, there are extra considerations outlined in [SAP Note \#2039883](https://me.sap.com/notes/2039883). For example, with the XFS file system, it's necessary, to run xfs\_freeze before starting a storage snapshot to guarantee consistency.

The subject of consistency becomes even more challenging in a case where a single file system spans multiple disks/volumes. As per the same SAP Note: "the storage system has to guarantee I/O consistency while creating a storage snapshot per SAP HANA data volume, that is, creating a snapshot of an SAP HANA service-specific data volume must be an atomic operation."

Assuming there's an XFS file system spanning four Azure virtual disks, the following steps provide a consistent snapshot that represents the HANA data area:

1. Prepare the HANA snapshot.
2. Freeze the file system (for example, use xfs\_freeze).
3. Create all necessary blob snapshots on Azure.
4. Unfreeze the file system.
5. Confirm the HANA snapshot.

> [!NOTE]
> For safety it's recommended that you use the procedure above in all cases, no matter which file system.

> [!IMPORTANT]
> It's critical to confirm the HANA snapshot. Due to the "Copy-on-Write," SAP HANA might not require extra disk space while in this snapshot-prepare mode. In addition, it's not possible to start new backups until the SAP HANA snapshot is confirmed.

When working with snapshots, it's important to understand the billing implications.
