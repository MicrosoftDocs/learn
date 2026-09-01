In this exercise, you deploy the first SAP HANA host, add hosts to a multiple-host SAP HANA system, and manage volumes in an application volume group for SAP HANA.

### Task 1 - Deploy the first application volume group

1. From your NetApp account, select Application volume groups, then +Add Group.

    :::image type="content" source="../media/exercise-application-volume-group-list.png" alt-text="Screenshot of Application volume groups page in Azure NetApp Files showing a list of existing SAP HANA volume groups." border="true" lightbox="../media/exercise-application-volume-group-list.png":::

2. In Deployment Type, select SAP HANA then Next.

    :::image type="content" source="../media/exercise-application-volume-group-deployment-type.png" alt-text="Screenshot of Create a volume group wizard showing Deployment Type dropdown with SAP HANA selected." border="true" lightbox="../media/exercise-application-volume-group-deployment-type.png":::

3. In the SAP HANA tab, provide HANA-specific information:

    - SAP ID (SID)
    - Group name
    - SAP node memory
    - Capacity overhead (%)
    - Single-host or Multiple host

    :::image type="content" source="../media/exercise-application-volume-group-sap-hana-tab.png" alt-text="Screenshot of Create a volume group wizard SAP HANA tab showing single-host configuration with fields." border="true" lightbox="../media/exercise-application-volume-group-sap-hana-tab.png":::

4. Select Next: Volume Group.

5. In the Volume group tab, provide information for creating the volume group:

    - Proximity placement group (PPG)
    - Capacity pool
    - Virtual network
    - Subnet

    :::image type="content" source="../media/exercise-application-volume-group-volume-group-tab.png" alt-text="Screenshot of Create a volume group wizard Volume group tab showing PPG, capacity pool, virtual network, and subnet configuration." border="true" lightbox="../media/exercise-application-volume-group-volume-group-tab.png":::

6. Select Next: Tags.

7. In the Tags section of the Volume Group tab, you can add tags as needed for the volumes.

    :::image type="content" source="../media/exercise-application-volume-group-tags-tab.png" alt-text="Screenshot of Create a volume group wizard showing the Tags section with Name and Value pair fields for resource tagging." border="true" lightbox="../media/exercise-application-volume-group-tags-tab.png":::

8. Select Next: Protocol.

9. In the Protocol section of the Volume Group tab, you can modify the Export Policy, which should be common to all volumes. You cannot change the protocol (NFS v4.1) for the volumes in this view; you can change this later in the workflow.

    :::image type="content" source="../media/exercise-application-volume-group-protocol-tab.png" alt-text="Screenshot of Create a volume group wizard Protocol section showing NFS export policy with allowed clients and read/write access settings." border="true" lightbox="../media/exercise-application-volume-group-protocol-tab.png":::

10. Select Next: Volumes.

11. The Volumes tab summarizes the volumes that are being created with proposed volume name, quota, and throughput.

    :::image type="content" source="../media/exercise-application-volume-group-volumes-tab.png" alt-text="Screenshot of Create a volume group wizard Volumes tab listing five volumes with their quotas and throughput values." border="true" lightbox="../media/exercise-application-volume-group-volumes-tab.png":::

12. In the Volumes tab, you can select each volume to view or change the volume details.

    When you select a volume, you can change the following values in the Basics tab:

    - Volume Name
    - Quota
    - Throughput

    :::image type="content" source="../media/exercise-application-volume-group-volume-basics-data.png" alt-text="Screenshot of Create a volume group wizard showing volume Basics tab with fields for volume name, quota, throughput, virtual network, and subnet." border="true" lightbox="../media/exercise-application-volume-group-volume-basics-data.png":::

13. Select Next: Protocols to review the protocol settings.

14. In the Protocols tab of a volume, you can modify File path (the export name where the volume can be mounted) and Export policy as needed.

    You cannot change the protocol for the data and log volumes.

    Select the Tags tab if you want to specify tags for a volume. Or select Volumes to return to the Volumes overview page.

    :::image type="content" source="../media/exercise-application-volume-group-volume-protocol.png" alt-text="Screenshot of Create a volume group wizard Protocol tab for a volume showing file path, NFSv4.1 protocol, and export policy rule." border="true" lightbox="../media/exercise-application-volume-group-volume-protocol.png":::

15. The Volumes page displays volume details.

    :::image type="content" source="../media/exercise-application-volume-group-volumes-updated.png" alt-text="Screenshot of Create a volume group wizard Volumes tab showing updated throughput values for the five volumes." border="true" lightbox="../media/exercise-application-volume-group-volumes-updated.png":::

16. Select Volumes to return to the Volume overview page. Select Next: Review + create.

    :::image type="content" source="../media/exercise-application-volume-group-volume-basics-backup.png" alt-text="Screenshot of Create a volume group wizard showing volume Basics tab for the data-backup volume with quota and throughput fields." border="true" lightbox="../media/exercise-application-volume-group-volume-basics-backup.png":::

17. The Review + Create tab lists all the volumes and their creation method. Select Create Volume Group to start the volume group creation.

    :::image type="content" source="../media/exercise-application-volume-group-review-create.png" alt-text="Screenshot of Create a volume group wizard Review and Create tab showing all volumes with their quota, throughput, and protocol settings." border="true" lightbox="../media/exercise-application-volume-group-review-create.png":::

18. The Volume Groups deployment workflow starts. You can monitor the progress. This process can take a few minutes to complete.

    :::image type="content" source="../media/exercise-application-volume-group-deployment-progress.png" alt-text="Screenshot of Azure portal deployment overview showing the CreateVolumeGroup deployment in progress with one resource being created." border="true" lightbox="../media/exercise-application-volume-group-deployment-progress.png":::

### Task 2 - Add application volume group for a SAP HANA system

In this task, you add hosts to an existing multiple-host SAP HANA system using application volume group for SAP HANA.

1. From your NetApp account, select Application volume groups, and select +Add Group. In Deployment Type, select SAP HANA then Next.

2. In the SAP HANA tab for adding a volume group, specify the following information:

    - SAP ID (SID)
    - Group name
    - SAP node memory
    - Capacity overhead (%)
    - Multiple-host
    - First host ID
    - Host count

    :::image type="content" source="../media/application-volume-group-multiple-host-creation-form.png" alt-text="Screenshot of Create a volume group wizard SAP HANA tab showing multiple-host configuration with First Host ID 2 and Host count 3." border="true" lightbox="../media/application-volume-group-multiple-host-creation-form.png":::

3. Select Next: Volume Group.

4. In the Volume group tab, provide identical input as you did when you created the first HANA host.

5. Select Next and continue through the Protocol and Tags sections, providing the same input as the first HANA host in the previous task.

    :::image type="content" source="../media/exercise-application-volume-group-multiple-host-volumes.png" alt-text="Screenshot of Create a volume group wizard Volumes tab for multiple-host setup showing two volumes: data and log with their quotas and throughput." border="true" lightbox="../media/exercise-application-volume-group-multiple-host-volumes.png":::

6. Select Next: Review + Create.

7. In the Review + Create tab, the {HostId} placeholder is replaced with the individual numbers for each of the volume groups that will be created.

    :::image type="content" source="../media/exercise-application-volume-group-multiple-host-review.png" alt-text="Screenshot of Create a volume group wizard Review and Create tab showing volume group 1 of 3 with HostId placeholder replaced by host number 00002." border="true" lightbox="../media/exercise-application-volume-group-multiple-host-review.png":::

8. After you navigate through the volume groups, select Create All Groups to create all the volumes for the HANA hosts you're adding.

    :::image type="content" source="../media/exercise-application-volume-group-create-all-groups.png" alt-text="Screenshot of Create a volume group wizard Review and Create tab showing the last volume group 3 of 3 with Create All Groups button." border="true" lightbox="../media/exercise-application-volume-group-create-all-groups.png":::

The **Create Volume Group** page shows the added volume groups with the "Creating" status.

### Task 3 - Manage volumes in an application volume group for SAP HANA

In this task, you manage a volume from its volume group. You can resize, delete, or change throughput for the volume.

1. From your NetApp account, select Application volume groups. Click a volume group to display the volumes in the group.

2. Select the volume you want to resize, delete, or change throughput. The volume overview is displayed.

3. To resize the volume, select Resize and specify the quota in GiB.

    :::image type="content" source="../media/exercise-application-volume-group-update-quota.png" alt-text="Screenshot of Update volume quota dialog showing available quota and quota input field in GiB." border="true" lightbox="../media/exercise-application-volume-group-update-quota.png":::

4. To change the throughput for the volume, select Change throughput and specify the intended throughput in MiB/s.

    :::image type="content" source="../media/exercise-application-volume-group-change-throughput.png" alt-text="Screenshot of Change throughput dialog showing available throughput and throughput input field in MiB/s." border="true" lightbox="../media/exercise-application-volume-group-change-throughput.png":::

5. To delete the volume in the volume group, select Delete. If you are prompted, type the volume name to confirm the deletion.

    :::image type="content" source="../media/exercise-application-volume-group-delete-volume.png" alt-text="Screenshot of Delete volume confirmation dialog requiring the user to type the volume name to confirm permanent deletion." border="true" lightbox="../media/exercise-application-volume-group-delete-volume.png":::
