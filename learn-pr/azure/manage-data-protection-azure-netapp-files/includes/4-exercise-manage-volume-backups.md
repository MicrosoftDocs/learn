In this section, you configure policy-based backups and manual backups. You'll also learn to manage backup vaults, manage backup policies, search backups, restore a backup, and delete backups.

### Task 1 - Configure policy-based backups for Azure NetApp Files

Azure NetApp Files backup supports policy-based (scheduled) backups and manual (on-demand) backups at the volume level. You can use both types of backups in the same volume.

To enable a policy-based (scheduled) backup:

1. Sign in to the Azure portal and navigate to **Azure NetApp Files**.
2. Select your Azure NetApp Files account.
3. Select **Backups**.
4. Select **Backup Policies**.
5. Select **Add**.
6. In the **Backup Policy** page, specify the backup policy name. Enter the number of backups that you want to keep for daily, weekly, and monthly backups. Select **Save**.

    The minimum value for **Daily Backups to Keep** is 2.

    :::image type="content" source="../media/backup-policy-numbers.png" alt-text="Screenshot of the Backup Policy page showing the number of backups to keep for daily, weekly, and monthly backups." border="true" lightbox="../media/backup-policy-numbers.png":::

To configure backups for a volume:

1. Navigate to **Volumes** then select the volume for which you want to configure backups.
2. From the selected volume, select **Backup** under Storage service from the left menu.
3. Then select **Configure**.
4. In the Configure Backups page, select the backup vault from the **Backup vaults** drop-down. For information about creating a backup vault, see [Create a backup vault](https://learn.microsoft.com/azure/azure-netapp-files/backup-vault-manage).
5. In the **Backup Policy** drop-down menu, assign the backup policy to use for the volume. Select **OK**.

    The Vault information is prepopulated.

    :::image type="content" source="../media/configure-backups.png" alt-text="Screenshot of the Configure Backups page showing the backup vault and backup policy settings." border="true" lightbox="../media/configure-backups.png":::

### Task 2 - Configure manual backups for Azure NetApp Files

Azure NetApp Files backup supports *policy-based* (scheduled) backups and *manual* (on-demand) backups at the volume level. You can use both types of backups in the same volume.

1. Sign in to the Azure portal and navigate to **Azure NetApp Files**.
2. Select your Azure NetApp Files account.
3. Go to **Volumes** under Storage services and select the specific volume for which you want to configure backups.
4. From the selected volume, select **Backup** under Storage service from the left menu.
5. Then select **Configure**.
6. In the Configure Backup page, select the backup vault from the dropdown menu.

    :::image type="content" source="../media/backup-configure-vault-select.png" alt-text="Screenshot of the Configure Backups page showing the Backup vault dropdown menu." border="true" lightbox="../media/backup-configure-vault-select.png":::

7. Select **OK**.

### Task 3 - Create a manual backup for a volume

1. Go to **Volumes** and select the volume for which you want to create a manual backup.
2. Select **Add Backup**.
3. In the New Backup window that appears:
    - Specify a backup name in the **Name** field.
    - If you want to use an existing snapshot for the backup, select the **Use Existing Snapshot** option.

    :::image type="content" source="../media/backup-add-manual.png" alt-text="Screenshot of the New Backup window with the Name field and Use Existing Snapshot option." border="true" lightbox="../media/backup-add-manual.png":::

4. Select **Create**.

### Task 4 - Create a backup vault

Backup vaults store the backups for your Azure NetApp Files subscription.

Although it's possible to create multiple backup vaults in your Azure NetApp Files account, it's recommended you have only one backup vault.

1. In your Azure NetApp Files account, navigate to the **Backup Vaults** menu under Data protection.
2. Select **+ Add Backup Vault**. Assign a name to your backup vault then select **Create**.

    :::image type="content" source="../media/backup-vault-create.png" alt-text="Screenshot of the Backup Vault page showing add backup vault option and a name field for the new backup vault." border="true" lightbox="../media/backup-vault-create.png":::

### Task 5 - Migrate backups to a backup vault

If you have existing backups, you must migrate them to a backup vault before you can restore from a backup.

1. Navigate to **Backups**.
2. From the banner above the backups, select **Assign Backup Vault**.
3. Select the volumes for migrating backups. Then, select **Assign to Backup Vault**.

    :::image type="content" source="../media/backup-vault-migrate.png" alt-text="Screenshot of the Assign Backup Vault page showing volume selection for migration." border="true" lightbox="../media/backup-vault-migrate.png":::

4. Navigate to the Backup Vault menu to view and manage your backups.

### Task 6 - Delete a backup vault

1. Navigate to the **Backup Vault** menu.
2. Identify the backup vault you want to delete and select the three dots **...** next to the backup's name. Select **Delete**.

    :::image type="content" source="../media/backup-vault-delete.png" alt-text="Screenshot of the Backup Vault menu showing the three-dot action menu with the Delete option." border="true" lightbox="../media/backup-vault-delete.png":::

### Task 7 - Modify a backup policy

To modify the backup policy settings:

1. Navigate to **Backups**.
2. Select **Backup Policies** then select the three dots (...) to the right of a backup policy. Select **Edit**.

    :::image type="content" source="../media/backup-policy-edit-menu.png" alt-text="Screenshot of the Backup Policies page showing the action menu with the Edit option." border="true" lightbox="../media/backup-policy-edit-menu.png":::

3. In the Modify Backup Policy window, update the number of backups you want to keep for daily, weekly, and monthly backups. Enter the backup policy name to confirm the action. Select **Save**.

    :::image type="content" source="../media/backup-policy-modify.png" alt-text="Screenshot of the Modify Backup Policy window showing the backup retention settings." border="true" lightbox="../media/backup-policy-modify.png":::

### Task 8 - Search backups of Azure NetApp Files volumes

1. Select **Backups**.
2. In the **Search Backups** field, enter the backup name that you want to search for.

    A partial search is supported; you don't have to specify the entire backup name. The search filters the backups based on the search string.

    :::image type="content" source="../media/backup-search.png" alt-text="Screenshot of the Backups page showing the Search Backups field with filtered results." border="true" lightbox="../media/backup-search.png":::

### Task 9 - Search backups at volume level

1. Select **Volumes**.
2. If you have migrated to a backup vault, navigate to **Backup Vault**. Select the backup vault. If you haven't yet migrated to a backup vault, navigate to **Backups**.

    The **Type** column shows whether the backup is generated by a **Scheduled** (policy-based) or a **manual** backup.

3. In the **Search Backups** field, enter the backup name that you want to search for.

    :::image type="content" source="../media/backup-search-volume.png" alt-text="Screenshot of the Backup Vault page showing the Search Backups field filtered at the volume level." border="true" lightbox="../media/backup-search-volume.png":::

### Task 10 - Restore a backup to a new volume

Restoring a backup creates a new volume with the same protocol type.

1. Select **Backup Vault**. Navigate to **Backups**.
2. From the backup list, select the backup to restore. Select the three dots (...) to the right of the backup, then select **Restore to new volume** from the Action menu.

    :::image type="content" source="../media/backup-restore-menu.png" alt-text="Screenshot of the Backups list showing the action menu with the Restore to new volume option." border="true" lightbox="../media/backup-restore-menu.png":::

3. In the Create a Volume page that appears, provide information for the fields in the page as applicable, and select **Review + Create** to begin restoring the backup to a new volume.

    - The **Protocol** field is prepopulated from the original volume and can't be changed.
    - The Quota value must be at least 20% greater than the size of the backup from which the restore is triggered. Once the restore is complete, the volume can be resized depending on the size used.
    - The Capacity pool that the backup is restored into must have sufficient unused capacity to host the new restored volume. Otherwise, the restore operation fails.

    :::image type="content" source="../media/backup-restore-create-volume.png" alt-text="Screenshot of the Create a Volume page for restoring a backup to a new volume." border="true" lightbox="../media/backup-restore-create-volume.png":::

### Task 11 - Delete backups of a volume

You can delete individual backups that you no longer need to keep for a volume. Deleting backups deletes the associated objects in your Azure Storage account, resulting in space saving.

1. Select **Volumes**.
2. Navigate to **Backups**.
3. From the backup list, select the backup to delete. Select the three dots (...) to the right of the backup then **Delete** from the Action menu.

    :::image type="content" source="../media/backup-delete-menu.png" alt-text="Screenshot of the Backups list showing the action menu with the Delete option." border="true" lightbox="../media/backup-delete-menu.png":::
