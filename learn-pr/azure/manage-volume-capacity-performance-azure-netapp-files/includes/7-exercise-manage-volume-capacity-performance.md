In this exercise, you resize a capacity pool or volume, change the service level of a volume, and manage default and individual user and group quotas for a volume. You also learn how to manage Azure NetApp Files storage with cool access.

### Task 1 - Resize a capacity pool

In this task, you resize a capacity pool for Azure NetApp Files.

1. From the NetApp account view, go to **Capacity pools** under **Storage service**, and select the capacity pool that you want to resize.
2. Select **NetAppLearnCP2** from the list.
3. Right-click the capacity pool name or select the ellipsis at the end of the capacity pool row to display the context menu, and then select **Resize**.

    :::image type="content" source="../media/exercise-pool-menu-resize.png" alt-text="Screenshot of Azure NetApp Files Capacity pools list with context menu open and Resize selected for NetAppLearnCP2." lightbox="../media/exercise-pool-menu-resize.png" border="true":::

4. In the **Resize pool** window, specify the new pool size under **Size (TiB)**.
5. Select **OK**.
6. Verify the updated capacity pool size from the list of capacity pools.

    :::image type="content" source="../media/exercise-pool-resized-list.png" alt-text="Screenshot of Azure NetApp Files Capacity pools list showing resized capacity value for NetAppLearnCP2." lightbox="../media/exercise-pool-resized-list.png" border="true":::

### Task 2 - Resize a volume

In this task, you change the size of an Azure NetApp Files volume. You can change the size of the volume as necessary. A volume's capacity consumption counts against its pool's provisioned capacity.

1. From the NetApp account view, go to **Volumes** under **Storage service**, and select the volume that you want to resize.
2. Right-click the volume name or select the ellipsis at the end of the volume row to display the context menu, and then select **Resize**.

    :::image type="content" source="../media/exercise-volume-menu-resize.png" alt-text="Screenshot of Azure NetApp Files Volumes list with context menu showing Resize action." lightbox="../media/exercise-volume-menu-resize.png" border="true":::

3. In the **Update volume quota** window, specify the new quota for the volume under **Quota (GiB)**.

    :::image type="content" source="../media/exercise-volume-quota-dialog.png" alt-text="Screenshot of Azure portal Update volume quota dialog with quota value entered." lightbox="../media/exercise-volume-quota-dialog.png" border="true":::

4. Select **OK**.
5. Verify the updated volume quota from the list of volumes.

    :::image type="content" source="../media/exercise-volume-resized-list.png" alt-text="Screenshot of Azure NetApp Files Volumes list showing updated quota for the selected volume." lightbox="../media/exercise-volume-resized-list.png" border="true":::

### Task 3 - Move a volume to another capacity pool

In this task, you change the service level of an existing volume. To change the service level of a volume, move the volume to another capacity pool in the same NetApp account that uses the service level you want.

1. On the **Volumes** page, right-click the volume whose service level you want to change.
2. Select **Change pool**.

    :::image type="content" source="../media/exercise-change-pool-menu.png" alt-text="Screenshot of Azure NetApp Files volume context menu with Change pool selected." lightbox="../media/exercise-change-pool-menu.png" border="true":::

3. In the **Change pool** window, select the capacity pool you want to move the volume to.

    :::image type="content" source="../media/exercise-change-pool-dialog.png" alt-text="Screenshot of Change pool dialog showing target capacity pool selection." lightbox="../media/exercise-change-pool-dialog.png" border="true":::

4. Select **OK**.

### Task 4 - Create new quota rules

In this task, you create a new quota rule for an Azure NetApp Files volume.

1. In the Azure portal, navigate to and select the volume for which you want to create a quota rule.
2. Select **User and group quotas** in the navigation pane.
3. In the **User and group quotas** window, select **+ Add** to create a quota rule for a volume.
4. In the **New quota** window, provide information for the following fields, then select **Create**:
   - Name: Quota1
   - Quota type: Individual user quota
   - Quota target: 429
   - Quota limit: 20

    :::image type="content" source="../media/exercise-new-quota-form.png" alt-text="Screenshot of New quota form with name, quota type, target, and limit fields populated." lightbox="../media/exercise-new-quota-form.png" border="true":::

5. Verify the newly created quota under **User and group quotas**.

    :::image type="content" source="../media/exercise-quota-rule-list.png" alt-text="Screenshot of User and group quotas list showing newly created Quota1 rule." lightbox="../media/exercise-quota-rule-list.png" border="true":::

### Task 5 - Edit or delete quota rules

In this task, you edit an existing quota rule and delete a quota rule of a volume.

1. In the Azure NetApp Files portal, navigate to and select the volume whose quota rule you want to edit or delete.
2. Select **User and group quotas** in the navigation pane.
3. Select the ellipsis at the end of the quota rule row for **Quota1**, then select **Edit** or **Delete** as appropriate.

    :::image type="content" source="../media/exercise-quota-rule-menu.png" alt-text="Screenshot of quota rule row context menu showing Edit and Delete options." lightbox="../media/exercise-quota-rule-menu.png" border="true":::

4. If you're editing a quota rule, update **Quota limit** in the **Edit User quota rule** window, then select **OK**.

    :::image type="content" source="../media/exercise-edit-quota-dialog.png" alt-text="Screenshot of Edit User quota rule dialog with updated Quota limit value." lightbox="../media/exercise-edit-quota-dialog.png" border="true":::

5. If you're deleting a quota rule, confirm the deletion by selecting **Yes**.

    :::image type="content" source="../media/exercise-delete-quota-confirm.png" alt-text="Screenshot of delete confirmation dialog for quota rule Quota1 with Yes and No options." lightbox="../media/exercise-delete-quota-confirm.png" border="true":::

6. Verify that the quota rule is deleted from the list.

### Task 6 - Manage Azure NetApp Files storage with cool access

In this task, you enable cool access in Azure NetApp Files, configure a capacity pool with cool access, and configure a volume with cool access.

#### Enable cool access

Azure NetApp Files storage with cool access is generally available. Before using cool access for the first time, register for the feature with the Standard service level.

1. Register the feature:

   `Register-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFCoolAccess`

2. Check status of the feature registration:

   `Get-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFCoolAccess`

#### Enable cool access on an existing capacity pool

Here you enable cool access support on an existing capacity pool. This action allows you to add or modify volumes in the pool to use cool access.

1. Navigate to **Capacity pools** under **Storage service**.
2. Right-click the capacity pool for which you want to enable cool access.
3. Select **Enable Cool Access**.

    :::image type="content" source="../media/exercise-enable-cool-access-menu.png" alt-text="Screenshot of Azure NetApp Files Capacity pools context menu with Enable Cool Access selected." lightbox="../media/exercise-enable-cool-access-menu.png" border="true":::

4. Select **Yes** to proceed with the action.

    :::image type="content" source="../media/exercise-enable-cool-access-confirm.png" alt-text="Screenshot of confirmation dialog to permanently enable cool access on selected capacity pool." lightbox="../media/exercise-enable-cool-access-confirm.png" border="true":::

#### Enable cool access on a new volume

1. Select **Volumes** from **Capacity pools**, and then select **+ Add volume** to create a new NFS, SMB, or dual-protocol volume.
2. In the **Basics** tab of **Create a volume**, set the following options:
   - Enable Cool Access: Checked
   - Coolness Period: The default value is 31 days. (The supported values are between 2 and 183 days.)
   - Cool Access Retrieval Policy: Default, OnRead, or Never

    :::image type="content" source="../media/exercise-create-volume-cool-access.png" alt-text="Screenshot of Create a volume Basics tab with cool access settings enabled." lightbox="../media/exercise-create-volume-cool-access.png" border="true":::

#### Enable cool access on an existing volume

In a cool-access-enabled capacity pool, you can enable an existing volume to support cool access.

1. Right-click the volume for which you want to enable cool access, and select **Edit**.

    :::image type="content" source="../media/exercise-edit-volume-menu.png" alt-text="Screenshot of Azure NetApp Files volume context menu with Edit selected." lightbox="../media/exercise-edit-volume-menu.png" border="true":::

2. In the **Edit** window, set the following options:
   - Enable Cool Access: Checked
   - Coolness Period: 31
   - Cool Access Retrieval Policy: Default

    :::image type="content" source="../media/exercise-edit-volume-cool-access.png" alt-text="Screenshot of Edit dialog showing cool access enabled with coolness period and retrieval policy values." lightbox="../media/exercise-edit-volume-cool-access.png" border="true":::

3. Select **OK**.
