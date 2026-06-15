In this exercise, you create a dual-protocol volume for Azure NetApp Files.

1. In the Azure portal, go to your NetApp account. From the navigation pane, select **Volumes**.

    :::image type="content" source="../media/exercise-azure-netapp-files-navigation-volumes.png" alt-text="Screenshot of the Azure NetApp Files account left-side navigation menu with the Volumes option highlighted under Storage service." border="true" lightbox="../media/exercise-azure-netapp-files-navigation-volumes.png":::

2. Select **+ Add volume** to create a volume.

    :::image type="content" source="../media/exercise-azure-netapp-files-add-volume-button.png" alt-text="Screenshot of the Azure NetApp Files Volumes blade showing the Add volume button highlighted in the toolbar." border="true" lightbox="../media/exercise-azure-netapp-files-add-volume-button.png":::

3. In the **Create a Volume** window, select **Create**, and provide information for the following fields under the **Basics** tab:

   - **Volume name**: NetAppLearnVol3
   - **Capacity pool**: NetAppLearnCP1
   - **Quota**: 100 GiB
   - **Large Volume**: No
   - **Throughput (MiB/S)**: Default

    :::image type="content" source="../media/exercise-create-volume-basics.png" alt-text="Screenshot of the Create a volume page in the Azure portal. It is showing the Basics tab with volume name NetAppLearnVol3, capacity pool NetAppLearnCP1, and quota 100 GiB." border="true" lightbox="../media/exercise-create-volume-basics.png":::

4. Select the **Protocol** tab, then complete the following actions:

   - **Protocol type**: **Dual-protocol**
   - **Volume path**: Enter a path for the volume
   - **Versions**: Select NFS and SMB versions
   - **Security style**: Select a security style
   - **Kerberos**: **Disabled** by default
   - Configure an export policy, if required

    :::image type="content" source="../media/dual-protocol-volume-settings.png" alt-text="Screenshot of the Create a volume page in Azure portal. It is showing the Protocol tab with Dual-protocol selected, NFSv4.1 and SMB versions, NTFS security style, and an export policy section." border="true" lightbox="../media/dual-protocol-volume-settings.png":::

5. Select **Review + Create** to review the volume details. Select **Create** to create the volume.
6. Verify that the volume you created appears in the **Volumes** page.
