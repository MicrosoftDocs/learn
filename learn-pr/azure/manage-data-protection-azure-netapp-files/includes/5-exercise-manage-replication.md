In this exercise, you learn how to set up cross-region replication by creating replication peering. You also learn to monitor replication status, manage disaster recovery, delete volume replications.

Setting up replication peering enables you to asynchronously replicate data from an Azure NetApp Files volume (source) to another Azure NetApp Files volume (destination). The source volume and the destination volume must be deployed in separate regions. The service level for the destination capacity pool can match that of the source capacity pool, or you can select a different service level.

### Task 1 - Locate the source volume Resource ID

In this task, you obtain the resource ID of the source volume that you want to replicate.

1. Go to the source volume, and select **Properties** under Settings to display the source volume resource ID.

    :::image type="content" source="../media/replication-source-resource-id.png" alt-text="Screenshot of the volume Properties page showing the Resource ID field for the source volume." border="true" lightbox="../media/replication-source-resource-id.png":::

2. Copy the resource ID to the clipboard. You'll need it later.

### Task 2 - Create the data replication volume (the destination volume)

In this task, you create a destination volume where you want the data from the source volume to be replicated to.

1. Before you can create a destination volume, you need to have a **NetApp account** and a **capacity pool** in the destination region.
2. Delegate a subnet in the region to be used for replication by following the steps in [Delegate a subnet to Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-delegate-subnet).
3. Create the data replication volume by selecting **Volumes** under Storage Service in the destination NetApp account. Then select the **+ Add data replication** button.

    :::image type="content" source="../media/replication-add-volume.png" alt-text="Screenshot of the Volumes page in the destination NetApp account showing the Add data replication button." border="true" lightbox="../media/replication-add-volume.png":::

4. In the Create a Volume page that appears, complete the following fields under the **Basics** tab:

    - Volume name
    - Capacity pool
    - Volume quota
    - Virtual network
    - Subnet

5. Under the **Protocol** tab, select the same protocol as the source volume.

    For the NFS protocol, ensure that the export policy rules satisfy the requirements of any hosts in the remote network that will access the export.

6. Under the **Tags** tab, create key/value pairs as necessary.
7. Under the **Replication** tab, paste in the source volume resource ID that you obtained in Task 1 - Locate the source volume resource ID, and then select the desired replication schedule.

    There are three options for the replication schedule: every 10 minutes, hourly, and daily.

    :::image type="content" source="../media/replication-tab-schedule.png" alt-text="Screenshot of the Replication tab in the Create a Volume wizard showing the source volume resource ID field and replication schedule options." border="true" lightbox="../media/replication-tab-schedule.png":::

8. Select **Review + Create**, then select **Create** to create the data replication volume.

### Task 3 - Authorize replication from the source volume

To authorize the replication, you need to obtain the resource ID of the replication destination volume and paste it to the Authorize field of the replication source volume.

1. In the Azure portal, navigate to Azure NetApp Files.
2. Go to the destination NetApp account and destination capacity pool where the replication destination volume is located.
3. Select the replication destination volume, go to **Properties** under Settings, and locate the **Resource ID** of the destination volume. Copy the destination volume resource ID to the clipboard.

    :::image type="content" source="../media/replication-destination-resource-id.png" alt-text="Screenshot of the destination volume Properties page showing the Resource ID field." border="true" lightbox="../media/replication-destination-resource-id.png":::

4. In Azure NetApp Files, go to the replication source account and source capacity pool.
5. Locate the replication source volume and select it. Navigate to **Replication** under Storage Service then select **Authorize**.

    :::image type="content" source="../media/replication-authorize.png" alt-text="Screenshot of the source volume Replication page showing the Authorize option." border="true" lightbox="../media/replication-authorize.png":::

6. In the Authorize field, paste the destination replication volume resource ID that you obtained in Step 3, then select **OK**.

### Task 4 - Display health and monitor status of replication relationship

In this task, you view replication status on the source volume or the destination volume. You can also set alert rules in Azure Monitor to help you monitor the replication status.

**Display replication status**

1. From either the source volume or the destination volume, select **Replication** under Storage Service for either volume.

    The following information about replication status and health is displayed:

    - **End point type** - Identifies whether the volume is the source or destination of replication.
    - **Health** - Displays the health status of the replication relationship.
    - **Mirror state** - Shows one of the following values:
        - Uninitialized: This is the initial and default state when a peering relationship is created. The state remains uninitialized until the initialization completes successfully.
        - Mirrored: The destination volume has been initialized and is ready to receive mirroring updates.
        - Broken: This is the state after you break the peering relationship. The destination volume is 'RW' and snapshots are present.
    - **Relationship status** - Shows one of the following values:
        - Idle: No transfer operation is in progress and future transfers aren't disabled.
        - Transferring: A transfer operation is in progress and future transfers aren't disabled.
    - **Replication schedule** - Shows how frequently incremental mirroring updates will be performed when the initialization (baseline copy) is complete.
    - **Total progress** - Shows the total number of cumulative bytes transferred over the lifetime of the relationship. This amount is the actual bytes transferred, and it might differ from the logical space that the source and destination volumes report.

    :::image type="content" source="../media/replication-status-health.png" alt-text="Screenshot of the volume Replication page showing replication status fields including end point type, health, mirror state, and relationship status." border="true" lightbox="../media/replication-status-health.png":::

### Task 5 - Set alert rules to monitor replication

Create alert rules in Azure Monitor to help you monitor the status of cross-region replication:

1. In Azure Monitor, select **Alerts**.
2. From the **Alerts** window, select the **Create** dropdown then **Alert rule**.
3. From the **Scope** tab of the **Create an Alert Rule** page, choose **Select scope**. The **Select a Resource** page appears.
4. From the **Browse** tab, enter "Volumes" in the **Search to filter items...** field.
5. Select the target volume you'd like to monitor and select **Apply**.
6. From the **Condition** tab, use the **Signal name** dropdown to select **See all signals**. Identify the **Volume replication lag time** signal then select **Apply**.
7. Confirm **Greater than** is selected for the **Operator** field.
8. For the **Threshold** value field, enter the number of seconds equal to your replication schedule plus 20%. For example:
    - If your replication schedule is 10 minutes, enter 720 (10 minutes \* 60 seconds \* 1.2).
    - If your replication schedule is hourly, enter 4,320 (60 minutes \* 60 seconds \* 1.2).
    - If your replication schedule is daily, enter 103,680 (24 hours \* 60 minutes \* 60 seconds \* 1.2).
9. Select **Review + create**. The alert rule is ready for use.

    :::image type="content" source="../media/replication-alert-rule.png" alt-text="Screenshot of the Create an alert rule page showing the condition configuration for volume replication lag time." border="true" lightbox="../media/replication-alert-rule.png":::

### Task 6 - Manage disaster recovery using Azure NetApp Files

In this task, when an ongoing replication prepares you for a disaster recovery event, you'll fail over to the destination volume, enabling the client to read and write to the destination volume. And after disaster recovery, you can perform a resync operation to fail back to the source volume. You then reestablish the source-to-destination replication and remount the source volume for the client to access.

**Fail over to destination volume**

Failover is a manual process. When you need to activate the destination volume (for example, when you want to fail over to the destination region), you need to break replication peering then mount the destination volume.

1. To break replication peering, select the destination volume. Select **Replication** under Storage Service.
2. Check the following fields before continuing:

    - Ensure that Mirror State shows **Mirrored**. Don't attempt to break replication peering if Mirror State shows Uninitialized.

    - Ensure that Relationship Status shows **Idle**. Don't attempt to break replication peering if Relationship Status shows Transferring.

3. Select **Break Peering**.
4. Type **Yes** when prompted and then select **Break**.

    :::image type="content" source="../media/replication-break-peering.png" alt-text="Screenshot of the Break Peering confirmation dialog with the Yes confirmation input field." border="true" lightbox="../media/replication-break-peering.png":::

5. Mount the destination volume by following the steps in Mount or unmount a volume for Windows or Linux virtual machines.

    This step enables a client to access the destination volume.

**Resync volumes after disaster recovery**

After disaster recovery, you can reactivate the source volume by performing a reverse resync operation. The reverse resync operation reverses the replication process and synchronizes data from the destination volume to the source volume.

1. To reverse resync replication, select the source volume. Select **Replication** under Storage Service. Then select **Reverse Resync**.
2. Type **Yes** when prompted then select **OK**.

    :::image type="content" source="../media/replication-reverse-resync.png" alt-text="Screenshot of the Reverse Resync confirmation dialog for restoring the source volume after disaster recovery." border="true" lightbox="../media/replication-reverse-resync.png":::

3. Monitor the source volume health status by following steps in Task 4 - Display health status of replication relationship.

**Reestablish source-to-destination replication**

After the resync operation from destination to source is complete, you need to break replication peering again to reestablish source-to-destination replication. You should also remount the source volume so that the client can access it.

1. Break the replication peering:

    1. Select the destination volume. Select **Replication** under Storage Service.
    1. Check the following fields before continuing:
        1. Ensure that Mirror State shows Mirrored. Don't attempt to break replication peering if Mirror State shows uninitialized.
        1. Ensure that Relationship Status shows Idle. Don't attempt to break replication peering if Relationship Status shows transferring.

    1. Select **Break Peering**.

    1. Type **Yes** when prompted then select **Break**.

2. Resync the source volume with the destination volume:

    1. Select the **destination** volume. Select **Replication** under Storage Service. Then select **Reverse Resync**.

    1. Type **Yes** when prompted then select **OK**.

3. Remount the source volume by following the steps in [Mount a volume for Windows or Linux virtual machines](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-mount-unmount-volumes-for-virtual-machines).

    This step enables a client to access the source volume.

### Task 7 - Delete volume replications or volumes

In this task, you delete volume replications and also delete the source or destination volume.

Here, you terminate the replication connection between the source and the destination volumes by deleting volume replication and also delete source or destination volumes.

1. Ensure that the replication peering has been broken before you delete volume replication. To break the replication peering:

    1. Select the **destination** volume. Select **Replication** under Storage Service.
    1. Check the following fields before continuing:

        1. Ensure that Mirror State shows **Mirrored**. Don't attempt to break replication peering if Mirror State shows **Uninitialized**.
        1. Ensure that Relationship Status shows **Idle**. Don't attempt to break replication peering if Relationship Status shows **Transferring**.

    1. Select **Break Peering**.

    1. Type **Yes** when prompted then select **Break**.

    :::image type="content" source="../media/replication-break-peering-delete.png" alt-text="Screenshot of the Break Peering dialog before deleting the volume replication." border="true" lightbox="../media/replication-break-peering-delete.png":::

2. To delete volume replication, select **Replication** from the source or the destination volume.
3. Click **Delete**.
4. Confirm deletion by typing **Yes** and selecting **Delete**.

    :::image type="content" source="../media/replication-delete.png" alt-text="Screenshot of the Delete replication confirmation dialog with the Yes confirmation input field." border="true" lightbox="../media/replication-delete.png":::

5. After deleting the volume replication, delete the destination or source volume as needed by right clicking the volume name and select **Delete**.

    :::image type="content" source="../media/replication-volume-delete.png" alt-text="Screenshot of the Volumes list showing the right-click context menu with the Delete option for removing a volume." border="true" lightbox="../media/replication-volume-delete.png":::

### Task 8 - Create a volume with an availability zone

You can deploy new volumes in the logical availability zone of your choice. You can also populate existing volumes with availability zone information.

1. Select **Volumes** from your capacity pool. Then select **+ Add volume** to create a volume.
2. In the Create a Volume page, under the Basic tab, select the **Availability Zone** pulldown to specify an availability zone where Azure NetApp Files resources are present.

    :::image type="content" source="../media/availability-zone-create-volume.png" alt-text="Screenshot of the Create a Volume Basic tab showing the Availability Zone dropdown with available zones listed." border="true" lightbox="../media/availability-zone-create-volume.png":::

3. Follow the UI to create the volume. The Review + Create page shows the selected availability zone you specified.

    :::image type="content" source="../media/availability-zone-review-create.png" alt-text="Screenshot of the Review + Create page showing the selected availability zone configuration." border="true" lightbox="../media/availability-zone-review-create.png":::

4. Navigate to **Properties** to confirm your availability zone configuration.

    :::image type="content" source="../media/availability-zone-properties.png" alt-text="Screenshot of the volume Properties page showing the availability zone configuration." border="true" lightbox="../media/availability-zone-properties.png":::

### Task 9 - Create the source volume with an availability zone

1. Select **Volumes** from your capacity pool. Then select **+ Add volume** to create a volume.
2. In the Create a Volume page, under the Basic tab, select the **Availability Zone** pulldown menu to specify an availability zone where Azure NetApp Files resources are present.

    :::image type="content" source="../media/availability-zone-source-create.png" alt-text="Screenshot of the Create a Volume Basic tab showing the Availability Zone dropdown for the source volume." border="true" lightbox="../media/availability-zone-source-create.png":::

3. Follow the steps indicated in the interface to create the volume. The **Review + Create** page shows the selected availability zone you specified.

    :::image type="content" source="../media/availability-zone-source-review-create.png" alt-text="Screenshot of the Review + Create page for the source volume showing the selected availability zone." border="true" lightbox="../media/availability-zone-source-review-create.png":::

4. After you create the volume, the **Volume Overview** page includes availability zone information for the volume.

    :::image type="content" source="../media/availability-zone-volume-overview.png" alt-text="Screenshot of the Volume Overview page showing the availability zone information for the newly created volume." border="true" lightbox="../media/availability-zone-volume-overview.png":::
