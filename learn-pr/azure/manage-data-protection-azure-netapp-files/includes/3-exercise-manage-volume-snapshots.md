In this exercise section, you create a snapshot, manage snapshot policies, restore a snapshot to a new volume, restore a single file by using a client, or revert an existing volume by using a snapshot. You also learn to delete a snapshot using Azure portal.

### Task 1 - Create an on-demand snapshot for a volume

In this task, you use the Azure portal to create a snapshot of an Azure NetApp Files volume.

1. From the Azure NetApp Files portal, go to the **Volumes** under Storage service.
    :::image type="content" source="../media/snapshot-volumes-list.png" alt-text="Screenshot of Azure NetApp Files portal showing Volumes list under Storage service." border="true" lightbox="../media/snapshot-volumes-list.png":::

2. Select the volume that you want to create a snapshot for and select **Snapshots** from the left menu.

    :::image type="content" source="../media/snapshot-list-menu.png" alt-text="Screenshot of Azure portal showing Snapshots option to be selected for the volume." border="true" lightbox="../media/snapshot-list-menu.png":::

3. Select **+ Add snapshot** to create an on-demand snapshot for a volume.

    :::image type="content" source="../media/snapshot-add.png" alt-text="Screenshot of the Add snapshot button on the Snapshots page." border="true" lightbox="../media/snapshot-add.png":::

4. In the New Snapshot window, provide a name for the new snapshot that you're creating.

    :::image type="content" source="../media/snapshot-new-name.png" alt-text="Screenshot of the New Snapshot window with a name field for the snapshot." border="true" lightbox="../media/snapshot-new-name.png":::

5. Select **OK**.

### Task 2 - Manage snapshot policies in Azure NetApp Files

In this task, you use the Azure portal to manage snapshot policies in Azure NetApp Files volume.

A snapshot policy enables you to specify the snapshot creation frequency in hourly, daily, weekly, or monthly cycles. You also need to specify the maximum number of snapshots to retain for the volume.

1. From the Azure NetApp Files NetApp Account view, select **Snapshot policy** under Data protection.

    :::image type="content" source="../media/snapshot-policy-menu.png" alt-text="Screenshot of the Azure NetApp Files NetApp Account view showing Snapshot policies under Data protection." border="true" lightbox="../media/snapshot-policy-menu.png":::

2. Select **+ Add snapshot policy**.

    :::image type="content" source="../media/snapshot-policy-add.png" alt-text="Screenshot of the Snapshot policy page showing the Add snapshot policy button." border="true" lightbox="../media/snapshot-policy-add.png":::

3. In the Snapshot Policy window, set Policy State to **Enabled**.

4. Select the **Hourly**, **Daily**, **Weekly**, or **Monthly** tab to create hourly, daily, weekly, or monthly snapshot policies. Specify the **Number of snapshots to keep**.

    The following example shows hourly snapshot policy configuration.

    :::image type="content" source="../media/snapshot-policy-hourly.png" alt-text="Screenshot of the Snapshot Policy configuration window showing the hourly policy settings with number of snapshots to keep." border="true" lightbox="../media/snapshot-policy-hourly.png":::

5. Select **Save**.

### Task 3 - Apply a snapshot policy to a volume

If you want a volume to use a snapshot policy that you created, you need to apply the policy to the volume.

1. Go to the **Volumes** page under Storage services, right-click the volume that you want to apply a snapshot policy to and select **Edit**.

    :::image type="content" source="../media/snapshot-apply-policy-edit.png" alt-text="Screenshot of the Volumes page showing the right-click context menu with the Edit option." border="true" lightbox="../media/snapshot-apply-policy-edit.png":::

2. In the Edit window, under Snapshot policy, select a policy to use for the volume. Select **OK** to apply the policy.

    :::image type="content" source="../media/snapshot-apply-policy-select.png" alt-text="Screenshot of the Edit volume window showing the Snapshot policy dropdown with a policy selected." border="true" lightbox="../media/snapshot-apply-policy-select.png":::

### Task 4 - Modify a snapshot policy

You can modify an existing snapshot policy to change the policy state, snapshot frequency (hourly, daily, weekly, or monthly), or number of snapshots to keep.

1. From the Azure NetApp Files NetApp Account view, select **Snapshot policy** under Data protection.

2. Right-click the snapshot policy you want to modify, then select **Edit**.

    :::image type="content" source="../media/snapshot-policy-edit-menu.png" alt-text="Screenshot of the Snapshot policy page showing the right-click context menu with the Edit option." border="true" lightbox="../media/snapshot-policy-edit-menu.png":::

3. Make the changes in the Snapshot Policy window that appears, then select **Save**.

4. You'll receive a prompt asking you to confirm that you want to update the Snapshot Policy. Select **Yes** to confirm your choice.

### Task 5 - Delete a snapshot policy

You can delete a snapshot policy that you no longer want to keep.

1. From the Azure NetApp Files NetApp Account view, select **Snapshot policy** under Data protection.

2. Right-click the snapshot policy you want to delete, then select **Delete**.

    :::image type="content" source="../media/snapshot-policy-delete-menu.png" alt-text="Screenshot of the Snapshot policy page showing the right-click context menu with the Delete option." border="true" lightbox="../media/snapshot-policy-delete-menu.png":::

3. Select **Yes** to confirm that you want to delete the snapshot policy.

    :::image type="content" source="../media/snapshot-policy-delete-confirm.png" alt-text="Screenshot of the delete snapshot policy confirmation dialog." border="true" lightbox="../media/snapshot-policy-delete-confirm.png":::

### Task 6 - Edit the hide snapshot path option of Azure NetApp Files

1. To view the Hide snapshot path option setting of a volume, select the volume. The **Hide snapshot path** field shows whether the option is enabled.

2. To edit the Hide snapshot path option, select **Edit** on the volume page and modify the **Hide snapshot path** option as needed.

### Task 7 - Restore a snapshot to a new volume using Azure NetApp Files

1. Select **Snapshots** from the Volume page to display the snapshot list.

2. Right-click the snapshot to restore and select **Restore to new volume** from the menu option.

    :::image type="content" source="../media/snapshot-restore-new-volume-menu.png" alt-text="Screenshot of the Snapshots list showing the right-click context menu with the Restore to new volume option." border="true" lightbox="../media/snapshot-restore-new-volume-menu.png":::

3. In the Create a Volume page, provide information for the new volume.

    :::image type="content" source="../media/snapshot-restore-create-volume.png" alt-text="Screenshot of the Create a Volume page for restoring a snapshot to a new volume." border="true" lightbox="../media/snapshot-restore-create-volume.png":::

4. Select **Review + create**. Select **Create**.

### Task 8 - Restore individual files using single-file snapshot restore

1. Select the volume that has the snapshot to use for restoring files.

2. Select **Snapshots** from the left menu under Storage service, to display the list of volume snapshots.

    :::image type="content" source="../media/snapshot-list-menu.png" alt-text="Screenshot of the Snapshots list for a volume showing available snapshots for single-file restore." border="true" lightbox="../media/snapshot-list-menu.png":::

3. Right-click the snapshot that you want to use for restoring files, then select **Restore Files** from the menu.

    :::image type="content" source="../media/snapshot-single-file-restore-menu.png" alt-text="Screenshot of the Snapshots list showing the right-click context menu with the Restore Files option." border="true" lightbox="../media/snapshot-single-file-restore-menu.png":::

4. In the Restore Files window that appears, provide the following information:

    - In the **File Paths** field, specify the file or files to restore by using their full paths.
    - In the **Destination Path** field, provide the location in the volume where the specified files are to be restored to.
    - Select **Restore** to initiate the restore operation.

    :::image type="content" source="../media/snapshot-single-file-restore-paths.png" alt-text="Screenshot of the Restore Files window showing File Paths and Destination Path fields." border="true" lightbox="../media/snapshot-single-file-restore-paths.png":::

### Task 9 - Revert a volume using snapshot revert with Azure NetApp Files

1. Go to the **Snapshots** menu of a volume. Right-click the snapshot you want to use for the revert operation. Select **Revert volume**.

    :::image type="content" source="../media/snapshot-revert-volume-menu.png" alt-text="Screenshot of the Snapshots menu showing the right-click context menu with the Restore to new volume,Revert volume, and Delete options." border="true" lightbox="../media/snapshot-revert-volume-menu.png":::

2. In the Revert Volume to Snapshot window, enter the name of the volume then select **Revert**.

    :::image type="content" source="../media/snapshot-revert-volume-confirm.png" alt-text="Screenshot of the Revert volume to snapshot confirmation window with volume name input field." border="true" lightbox="../media/snapshot-revert-volume-confirm.png":::

3. The volume is now restored to the point in time of the selected snapshot.

### Task 10 - Delete snapshots using Azure NetApp Files

1. Go to the **Snapshots** menu of a volume. Select the three dots at the end of the row of the snapshot you want to delete. Select **Delete**.

    :::image type="content" source="../media/snapshot-revert-volume-menu.png" alt-text="Screenshot of the Snapshots menu showing the right-click context menu with the Restore to new volume, Revert volume, and Delete options." border="true" lightbox="../media/snapshot-revert-volume-menu.png":::

2. In the Delete Snapshot window, confirm that you want to delete the snapshot by selecting **Yes**.

    :::image type="content" source="../media/snapshot-delete-confirm.png" alt-text="Screenshot of the Delete snapshot confirmation dialog." border="true" lightbox="../media/snapshot-delete-confirm.png":::
