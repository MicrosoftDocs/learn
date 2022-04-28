The storage infrastructure underlying SAP HANA on Azure (Large Instances) supports storage snapshots of volumes. Both backup and restoration of volumes are supported, with the following considerations:

 -  Instead of full database backups, storage volume snapshots are taken on a frequent basis.
 -  When a snapshot is triggered over **/hana/data** and **/hana/shared**, which includes **/usr/sap**, volumes, the snapshot technology initiates an SAP HANA snapshot before it runs the storage snapshot. This SAP HANA snapshot is the setup point for eventual log restorations after recovery of the storage snapshot. For a HANA snapshot to be successful, you need an active HANA instance. In an HSR scenario, a storage snapshot isn't supported on a current secondary node where a HANA snapshot can’t be performed.
 -  After the storage snapshot runs successfully, the SAP HANA snapshot is deleted.
 -  Transaction log backups are taken frequently and stored in the **/hana/logbackups** volume or in Azure. You can trigger the **/hana/logbackups** volume that contains the transaction log backups to take a snapshot separately. In that case, you don't need to run a HANA snapshot.
 -  If you must restore a database to a certain point in time, for a production outage, request that Microsoft Azure Support or SAP HANA on Azure restore to a certain storage snapshot. An example is a planned restoration of a sandbox system to its original state.
 -  The SAP HANA snapshot that's included in the storage snapshot is an offset point for applying transaction log backups that ran and were stored after the storage snapshot was taken.
 -  These transaction log backups are taken to restore the database back to a certain point in time.

You can perform storage snapshots that target three classes of volumes:

 -  A combined snapshot over **/hana/data** and **/hana/shared**, which includes **/usr/sap**. This snapshot requires the creation of an SAP HANA snapshot as preparation for the storage snapshot. The SAP HANA snapshot ensures that the database is in a consistent state from a storage point of view. For the restore process, that's a point to set up on.
 -  A separate snapshot over **/hana/logbackups**.
 -  An operating system partition.
