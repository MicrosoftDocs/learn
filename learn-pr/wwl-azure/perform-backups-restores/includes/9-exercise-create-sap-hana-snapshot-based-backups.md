SAP HANA supports storage snapshots (this is restricted to single-container systems). SAP HANA MCS with more than one tenant does not support this kind of SAP HANA database snapshot.

The process works as follows:

1.  Prepare for a storage snapshot by initiating the SAP HANA snapshot.
2.  Run the storage snapshot (Azure blob snapshot, for example).
3.  Confirm the SAP HANA snapshot.

The snapshot then also appears in the backup catalog in SAP HANA Studio. On disk, the snapshot shows up in the SAP HANA data directory. It's necessary to ensure that the file system consistency is also guaranteed before running the storage snapshot while SAP HANA is in the snapshot preparation mode.

Once the storage snapshot is done, it's critical to confirm the SAP HANA snapshot. There is a corresponding SQL statement to run: BACKUP DATA CLOSE SNAPSHOT (see [BACKUP DATA CLOSE SNAPSHOT Statement (Backup and Recovery)](https://help.sap.com/viewer/4fe29514fd584807ac9f2a04f6754767/2.0.04/en-US/c39739966f7f4bd5818769ad4ce6a7f8.html)).

> [!IMPORTANT]
> Make sure to confirm the HANA snapshot. Due to "Copy-on-Write," SAP HANA might require additional disk space in snapshot-prepare mode, and it's not possible to start new backups until the SAP HANA snapshot is confirmed.

## HANA VM backup via Azure Backup service

The backup agent of the Azure Backup service is not available for Linux VMs. Moreover, Linux does not have similar functionality as Windows has it with VSS. To make use of Azure backup on the file/directory level, one would need to copy SAP HANA backup files to a Windows VM and then use the backup agent. Otherwise, only a full Linux VM backup is possible via the Azure Backup service.

The Azure Backup service offers an option to back up and restore a VM. There are, however, two important considerations:

 -  For Linux virtual machines, only file-consistent backups are possible, since Linux does not have an equivalent platform to VSS.
 -  Applications need to implement their own integrity validation mechanism for the restored data.

Therefore, one has to make sure SAP HANA is in a consistent state on disk when the backup starts. More specifically, it's recommended to confirm or abandon a storage snapshot as soon as possible after it has been created. While the storage snapshot is being prepared or created, the snapshot-relevant data is frozen. While the snapshot-relevant data remains frozen, changes can still be made in the database. Such changes will not cause the frozen snapshot-relevant data to be changed. Instead, the changes are written to positions in the data area that are separate from the storage snapshot. Changes are also written to the log. However, the longer the snapshot-relevant data is kept frozen, the more the data volume can grow.

Azure Backup takes care of the file system consistency via Azure VM extensions. These extensions aren't available standalone and work only in combination with Azure Backup service. Nevertheless, it's still a requirement to provide scripts to create and delete an SAP HANA snapshot to guarantee app consistency.

Azure Backup, in this case, has four major phases:

1.  **Execute prepare script** \- script needs to create an SAP HANA snapshot
2.  **Take snapshot**
3.  **Execute post-snapshot script** \- script needs to delete the SAP HANA snapshot created by the prepare script
4.  **Transfer data to vault**

For details on where to copy these scripts and details on how Azure Backup works exactly, check the following articles:

 -  Plan your VM backup infrastructure in Azure: [An overview of Azure VM backup](/azure/backup/backup-azure-vms-introduction)
 -  Application-consistent backup of Azure Linux VMs: [Application-consistent backup of Azure Linux VMs](/azure/backup/backup-azure-linux-app-consistent)

At the time of authoring, Microsoft has not published prepare-scripts and post-snapshot scripts for SAP HANA. You as the customer or system integrator would need to create those scripts and configure the procedure based on the documentation referenced above.

## Restore from application consistent backup against a VM

Azure Backup provides the capability to restore Azure virtual machines (VMs) and disks from Azure VM backups, also known as recovery points. This section describes how to recover files and folders from an Azure VM backup. Restoring files and folders is possible only for Azure VMs deployed using the Resource Manager model and protected by a Recovery Services vault.

## Mount the volume and copy files

1.  Sign in to the Azure portal and in the left pane, select **Virtual machines**. From the list of virtual machines, select the virtual machine to open that virtual machine's menu.
2.  On the virtual machine's menu, select Backup to open the **Backup** dashboard.
3.  On the Backup menu, select **File Recovery**.
4.  From the **Select recovery point** drop-down menu, select the recovery point that contains the files you want. By default, the latest recovery point is already selected.
5.  To download the software used to copy files from the recovery point, select **Download Executable** (for Windows Azure VM) or **Download Script** (for Linux Azure VM, a python script is generated).
6.  The executable or script is password protected and requires a password. In the **File Recovery** menu, select the **copy** button to load the password into memory.
7.  From the download location (usually the Downloads folder), right-select the executable or script and run it with Administrator credentials. When prompted, type the password or paste the password from memory, and press **Enter**. Once the valid password is entered, the script connects to the recovery point. If you run the script on a computer with restricted access, ensure there's access to:
    
     -  download.microsoft.com
     -  Recovery Service URLs (geo-name refers to the region where the recovery service vault resides)
        
         -  `https://pod01-rec2.geo-name.backup.windowsazure.com` (For Azure public geos)
         -  `https://pod01-rec2.geo-name.backup.windowsazure.cn` (For Azure China 21Vianet)
         -  `https://pod01-rec2.geo-name.backup.windowsazure.us` (For Azure US Government)
         -  `https://pod01-rec2.geo-name.backup.windowsazure.de` (For Azure Germany)
     -  outbound port 3260
8.  Identify the mounted volumes:
    
     -  **Windows**: When you run the executable, the operating system mounts the new volumes and assigns drive letters. You can use Windows Explorer or File Explorer to browse those drives. The drive letters assigned to the volumes may not be the same letters as the original virtual machine, however, the volume name is preserved. Browse through all volumes mentioned in the script output until you find your files/folder.
     -  **Linux**: In Linux, the volumes of the recovery point are mounted to the folder where the script is run. The attached disks, volumes, and the corresponding mount paths are shown accordingly. These mount paths are visible to users having root level access. Browse through the volumes mentioned in the script output.
9.  Identify and copy files to the local file system
10. After identifying the files and copying them to a local storage location, remove (or unmount) the additional drives. To unmount the drives, on the **File Recovery** menu in the Azure portal, select **Unmount Disks**.

## HANA license key and VM restore via Azure Backup service

The Azure Backup service allows creating a new VM during restore. One can choose between creating a VM during restore, restoring the disks, or restoring disk content (as described in the previous section). After restoring the disks, it's still necessary to create a new VM on top of it. Whenever a new VM gets created on Azure the unique VM ID changes.

As the result of the restore via Azure Backup service, Azure VM unique ID changes. The SAP hardware key, which is used for SAP licensing, is using this unique VM ID. As a consequence, a new SAP license has to be installed after a VM restore.

## SAP HANA VM backup via manual disk snapshot

Instead of using the Azure Backup service, one could configure an individual backup solution by creating blob snapshots of Azure VHDs manually via PowerShell. This offers more flexibility but does not resolve the issues described earlier:

 -  You still must make sure that SAP HANA is in a consistent state by creating an SAP HANA snapshot.
 -  The OS disk cannot be overwritten even if the VM is deallocated because of an error stating that a lease exists. It only works after deleting the VM, which would lead to a new unique VM ID and the need to install a new SAP license.

It is possible to restore only the data disks of an Azure VM (avoiding the problem of getting a new unique VM ID and, therefore, invalidated the SAP license) by using the following procedure:

1.  Verify that SAP HANA was in a consistent state by SAP HANA snapshot feature.
2.  Perform file system freeze.
3.  Take blob snapshots from data disks.
4.  Perform file system unfreeze.
5.  Confirm SAP HANA snapshot.
6.  Shut down the VM and detach data disks.
7.  Attach new disks based on blob snapshots.
8.  Set HANA back to the HANA snapshot.