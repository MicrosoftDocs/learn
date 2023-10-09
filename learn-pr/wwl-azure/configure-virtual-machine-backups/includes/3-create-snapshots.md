
An Azure Backup job creates a snapshot for your virtual machine in two phases:

- Phase 1: Take a snapshot of the virtual machine data

- Phase 2: Transfer the snapshot to an Azure Recovery Services vault

The following diagram highlights this process.

:::image type="content" source="../media/virtual-machine-snapshot-aeddf5a2.png" alt-text="Illustration that shows the Azure Backup job process for a virtual machine as described in the text." border="false":::

After the Azure Backup job completes, you can use recovery points for the snapshot to restore your virtual machine or specific files.

### Things to know about snapshots and recovery points

Let's take a closer look at the characteristics of snapshots and recovery points in Azure Backup.

- By default, Azure Backup keeps snapshots for two days to reduce backup and restore times. The local retention reduces the time required to transform and copy data back from an Azure Recovery Services vault.

- You can set the default snapshot retention value from one and five days.

- Incremental snapshots are stored as Azure page blobs (Azure Disks). 

- Recovery points for a virtual machine snapshot are available only after both phases of the Azure Backup job are complete.

- Recovery points are listed for the virtual machine snapshot in the Azure portal and are labeled with a _recovery point type_.

- After a snapshot is first taken, the recovery points are identified with the **snapshot** recovery point type.

- After the snapshot is transferred to an Azure Recovery Services vault, the recovery point type changes to **snapshot and vault**.

### Things to consider when using snapshots and recovery points

Here are some important benefits and considerations about using snapshots and recovery points.

- **Consider recovery after Phase 1**. Use the snapshot captured in Phase 1 of the Azure Backup job to restore your virtual machine from the snapshot. Phase 2 transfers the snapshot to the Recovery Services vault, so recovery points can be created. You don't have to wait for Phase 2 to complete before attempting a full restore from the snapshot.

- **Consider disk type, sizing, pricing**. Back up Standard SSD disks, Standard HDD disks, and Premium SSD disks. Use disk sizes up to 32 TB. For Premium Azure storage accounts, snapshots taken for instant recovery points count towards the 10-TB limit of allocated space.

   > [!Note]
   > Azure Backup doesn't recommend resizing disks.

- **Consider snapshot retention and cost savings**. Configure how long Azure Backup retains your snapshots based on your restore needs. Depending on your requirements, you might set the snapshot retention value to a minimum of one day. This setting can help reduce costs for snapshot retention, if you don't perform restores frequently.