Storage snapshots consume storage space that's allocated to the HANA Large Instance units. Consider the following aspects of scheduling storage snapshots and how many storage snapshots to keep.

The specific mechanics of storage snapshots for SAP HANA on Azure (Large Instances) include:

 -  A specific storage snapshot at the point in time when it's taken consumes little storage.
 -  As data content changes and the content in SAP HANA data files change on the storage volume, the snapshot needs to store the original block content and the data changes.
 -  As a result, the storage snapshot increases in size. The longer the snapshot exists, the larger the storage snapshot becomes.
 -  The more changes that are made to the SAP HANA database volume over the lifetime of a storage snapshot, the larger the space consumption of the storage snapshot.

SAP HANA on Azure (Large Instances) comes with fixed volume sizes for the SAP HANA data and log volumes. Performing snapshots of those volumes eats into your volume space. You need to:

 -  Determine when to schedule storage snapshots.
 -  Monitor the space consumption of the storage volumes.
 -  Manage the number of snapshots that you store.

You can disable the storage snapshots when you either import masses of data or perform other significant changes to the HANA database.

The following sections provide information for performing these snapshots and include general recommendations:

 -  Although the hardware can sustain 255 snapshots per volume, you want to stay well below this number. The recommendation is 250 or less.
 -  Before you perform storage snapshots, monitor and keep track of free space.
 -  Lower the number of storage snapshots based on free space. You can lower the number of snapshots that you keep, or you can extend the volumes. You can order additional storage in 1 TB units.
 -  During activities such as moving data into SAP HANA with SAP platform migration tools (R3load) or restoring SAP HANA databases from backups, disable storage snapshots on the **/hana/data** volume.
 -  During larger reorganizations of SAP HANA tables, avoid storage snapshots if possible.

Storage snapshots are a prerequisite to taking advantage of the disaster recovery capabilities of SAP HANA on Azure (Large Instances).
