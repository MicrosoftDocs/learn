In this exercise, you will create SMB volumes for Azure NetApp Files.

### Task 1: Create an SMB volume for Azure NetApp Files

In this task, you use the Azure portal to create an SMB volume and verify it.

1. In the Azure portal, go to your NetApp account. From the navigation pane, select Volumes.

    :::image type="content" source="../media/volumes.png" alt-text="This is a screenshot of the Azure Portal left-hand navigation menu for an Azure NetApp Files account." border="true" lightbox="../media/volumes.png":::

2. Select **+ Add volume** to create a volume.

    :::image type="content" source="../media/add-volume.png" alt-text="Screenshot of the Azure NetApp Files portal showing the Volumes blade with the Add volume button highlighted." border="true" lightbox="../media/add-volume.png":::

3. In the Create a Volume window, select **Create**, and provide information for the following fields under the Basics tab:

    - Volume name: NetAppLearnVol2
    - Capacity pool: NetAppLearnCP1
    - Quota: 100 GiB
    - Large Volume: No
    - Throughput (MiB/S): Default

    :::image type="content" source="../media/create-volume-basics.png" alt-text="Screenshot of the Create a volume page in the Azure portal for Azure NetApp Files. It displays the Basics tab with the volume details filled in." border="true" lightbox="../media/create-volume-basics.png":::

4. Select **Protocol** tab then complete the following actions:

    - Protocol type: SMB
    - Active Directory: Added by default
    - Share name: NetAppLearnCP1
    - Enable Access Based Enumeration
    - Enable SMB3 Protocol Encryption
    - Enable Continuous Availability
    - Enable Non Browsable Share

    :::image type="content" source="../media/create-volume-protocol.png" alt-text="Screenshot of the Protocol tab of an Azure NetApp Files volume creation wizard in the Azure portal. It displays the Protocol tab with the SMB settings filled in." border="true" lightbox="../media/create-volume-protocol.png":::

5. Select **Review + Create** tab to review the volume details. Select **Create** to create the volume.
6. Verify that the volume you created appears in the Volumes page.

    :::image type="content" source="../media/volumes-page.png" alt-text="Screenshot of the Volumes page in the Azure NetApp Files portal. It displays the list of volumes, including the newly created volume." border="true" lightbox="../media/volumes-page.png":::

### Task 2: Enable Continuous Availability feature

In this task, you use the Azure portal to enable the SMB Continuous Availability (CA) feature.

1. Select the SMB volume that you want to have SMB CA enabled. Then select **Edit**.
2. On the Edit window that appears, select the **Enable Continuous Availability** checkbox.

    :::image type="content" source="../media/enable-continuous-availability.png" alt-text="Screenshot of a UI checkbox labeled Enable Continuous Availability with an info icon next to the label." border="true" lightbox="../media/enable-continuous-availability.png":::

3. Snapshot that shows the Enable Continuous Availability option.
4. Reboot the Windows systems connecting to the existing SMB share.
