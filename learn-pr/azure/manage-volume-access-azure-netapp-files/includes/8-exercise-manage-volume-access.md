In this exercise, you configure export policies, configure Unix permissions, change ownership mode for NFS or dual-protocol volumes. You'll also set network features for an Azure NetApp Files volume.

### Task 1 - Configure export policy

In this task, you use the Azure portal to configure export policy for NFS or dual-protocol volumes.

1. On the Volumes page, select the volume NetAppLearnVol1, or a volume that you have previously created, to configure the export policy.

2. From the left pane, under Storage service select Export policy.

    :::image type="content" source="../media/volume-export-policy.png" alt-text="Screenshot of Azure portal volume overview with Export policy highlighted." border="true" lightbox="../media/volume-export-policy.png":::

3. Enter the IPV4 address for the client in Allowed Clients.

4. Select Read & Write as the access type.

5. Specify whether the root account can access the volume. By default, Root Access is set to On.

6. Modify the change ownership mode as needed to set the ownership management capabilities of files and directories. Set it to Restricted in this example.

    :::image type="content" source="../media/export-policy-configured.png" alt-text="Screenshot of Azure portal showing export policy rule configured with client IP and access settings." border="true" lightbox="../media/export-policy-configured.png":::

7. Click Save. Select Yes to confirm updating export policy.

8. You Successfully updated the export policy of the volume.

### Task 2 - Configure Unix permissions and change ownership mode

In this task, you use the Azure portal to set Unix permissions and change ownership mode for NFS or dual-protocol volumes.

You can specify the Unix permissions and change ownership mode (Chown Mode) settings under the **Protocol** tab when you create an NFS volume or create a dual-protocol volume.

For existing NFS or dual-protocol volumes, follow the below steps.

1. To modify Unix permissions, under Volumes, right-click the volume NetAppLearnVol1, and select Edit.

2. In the Edit window, scroll down to find Unix Permissions option.

3. By default, it's set to 0770. Here change it to 0777.

    :::image type="content" source="../media/exercise-unix-permissions-edit.png" alt-text="Screenshot of Edit dialog showing Unix Permissions set to 0777." border="true" lightbox="../media/exercise-unix-permissions-edit.png":::

4. Click OK.

5. To modify the change ownership mode, Select the volume NetAppLearnVol1.

6. From the left pane, under Storage service select Export policy.

7. Select the Chown Mode setting and chose the required ownership mode from the dropdown.

    :::image type="content" source="../media/exercise-chown-mode-dropdown.png" alt-text="Screenshot of export policy showing Chown Mode dropdown options." border="true" lightbox="../media/exercise-chown-mode-dropdown.png":::

### Task 3 - Configure network features

In this task, you use the Azure portal to set network features for Azure NetApp Files volume.

#### Set network features option during volume creation

1. During the process of creating a new NFS, SMB, or dual-protocol volume, you can set the Network Features option to Basic or Standard under the Basic tab of the Create a Volume screen.

2. Example of a volume creation for a region that supports the Standard network features capabilities:

    :::image type="content" source="../media/create-volume-standard-region.png" alt-text="Screenshot of Create a Volume page showing network features in supported region." border="true" lightbox="../media/create-volume-standard-region.png":::

3. Example of a volume creation for a region that doesn't support the Standard network features capabilities:

    :::image type="content" source="../media/create-volume-basic-region.png" alt-text="Screenshot of Create a Volume page showing network features in unsupported region." border="true" lightbox="../media/create-volume-basic-region.png":::

4. Before completing the volume creation process, you can display the specified network features setting in the Review + Create tab of the Create a Volume screen. Select Create to complete the volume creation.

    :::image type="content" source="../media/review-create-standard.png" alt-text="Screenshot of Create a Volume page with Review + Create tab selected and showing Standard network features." border="true" lightbox="../media/review-create-standard.png":::

#### Edit network features option for existing volumes

You can edit the network features option of existing volumes from Basic to Standard network features.

1. Go to Volumes under Storage Service from Azure NetApp Files portal.

2. Select the volume for which you want to change the network features option.

3. Select Change network features.

    :::image type="content" source="../media/volume-change-network-features.png" alt-text="Screenshot of Volume page showing Change network features option." border="true" lightbox="../media/volume-change-network-features.png":::

4. The Edit network features window displays the volumes that are in the same network sibling set as the volume you're editing.

    :::image type="content" source="../media/exercise-edit-network-features.png" alt-text="Screenshot of Edit network features dialog showing sibling volumes." border="true" lightbox="../media/exercise-edit-network-features.png":::

5. Click Save.

6. Click Yes to Confirm the Edit Operation.

    :::image type="content" source="../media/confirm-edit-operation.png" alt-text="Screenshot of Confirm Edit Operation dialog with warning about disruption." border="true" lightbox="../media/confirm-edit-operation.png":::

7. Verify the Network feature of the volume is set to Standard.

    :::image type="content" source="../media/volume-standard-network.png" alt-text="Screenshot of Volume overview showing Standard network features." border="true" lightbox="../media/volume-standard-network.png":::
