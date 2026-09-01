### Task 1 - Deploy application volume group for Oracle

In this task, you deploy all required volumes for your Oracle database using Azure NetApp Files application volume group for Oracle.

1. From your NetApp account, select **Application volume groups**, and click **+Add Group**.

    :::image type="content" source="../media/app-volume-groups-add-group.png" alt-text="Screenshot showing Add Group option in Application volume groups." border="true" lightbox="../media/app-volume-groups-add-group.png":::

2. In Deployment Type, select **ORACLE** then **Next**.
3. In the **ORACLE** tab, provide Oracle-specific information:
   - Unique System ID (SID)
   - Group name / Group description
   - Number of Oracle data volumes (1-8)
   - Oracle database size in (TiB)
   - Additional capacity for snapshots (%)
   - Oracle database storage throughput (MiB/s)

    :::image type="content" source="../media/oracle-deployment-type.png" alt-text="Screenshot of Create a volume group page showing Oracle deployment type and Oracle-specific parameters." border="true" lightbox="../media/oracle-deployment-type.png":::

4. Click **Next: Volume Group**.
5. In the Volume group tab, provide information for creating the volume group:
   - Availability options
   - Availability Zone
   - Network features
   - Capacity pool
   - Virtual network
   - Subnet

    :::image type="content" source="../media/volume-group-configuration.png" alt-text="Screenshot of Volume group configuration details for Oracle application volume group." border="true" lightbox="../media/volume-group-configuration.png":::

6. Select **Next: Tags**.
7. In the Tags section of the Volume Group tab, you can add tags as needed for the volumes.
8. Select **Next: Protocol**.
9. In the **Protocols** section of the Volume Group tab, you can select the NFS version, modify the Export Policy, and select LDAP-enabled volumes. These settings need to be common to all volumes.
10. Select **Next: Volumes**. The **Volumes** tab summarizes the volumes that are being created with proposed volume name, quota, and throughput.

    :::image type="content" source="../media/volumes-summary.png" alt-text="Screenshot of Create a volume group page showing summary of proposed Oracle volumes in the Volumes tab." border="true" lightbox="../media/volumes-summary.png":::

11. In the **Volumes** tab, you can select each volume to view or change the volume details.

    When you select a volume, you can change the following values in the **Volume-Detail-Basics** tab:

    - **Volume Name:** It's recommended that you retain the suggested naming conventions.
    - **Quota:** The size of the volume.
    - **Throughput:** You can edit the proposed throughput requirements for the selected volume.

12. Select **Next: Protocol** to review the protocol settings.

    :::image type="content" source="../media/volume-detail-protocol.png" alt-text="Screenshot of Volume detail protocol settings for a selected volume." border="true" lightbox="../media/volume-detail-protocol.png":::

13. In the **Volume Details - Protocol** tab of a volume, the defaults are based on the volume group input you provided previously. Select **Next: Tags** to review the tags settings.
14. In the **Volume Details - Tags** tab of a volume, the defaults are based on the volume group input you provided previously. You can adjust volume specific tags here.
15. Select **Volumes** to return to the Volumes tab.

    :::image type="content" source="../media/volume-detail-tags.png" alt-text="Screenshot showing volume detail tags settings for a selected volume." border="true" lightbox="../media/volume-detail-tags.png":::

16. Select **Next: Review + Create** after completing the changes of volumes.
17. The **Review + Create** tab lists all the volumes that will be created. The process also validates the creation. Select **Create Volume Group** to start the volume group creation.

    :::image type="content" source="../media/create-volume-group.png" alt-text="Screenshot of Create a volume group page showing Create Volume Group button in the review page." border="true" lightbox="../media/create-volume-group.png":::

18. The **Volume Groups** deployment workflow starts, and the progress is displayed. This process can take a few minutes to complete.

    :::image type="content" source="../media/volume-group-deployment-progress.png" alt-text="Screenshot showing Volume group deployment progress status." border="true" lightbox="../media/volume-group-deployment-progress.png":::

### Task 2 - Manage volumes in an application volume group for Oracle

In this task, you can manage a volume from its volume group. You can resize, delete, or change throughput for the volume.

1. From your NetApp account, select **Application volume groups**. Select a volume group to display the volumes in the group.
2. Select the volume you want to resize, delete, or change throughput. The volume overview is displayed.
3. From **Volume Overview**, you can select:
   - **Edit** - You can change individual volume properties:
     - Protocol type
     - Hide snapshot path
     - Snapshot policy
     - Unix permissions
   - **Change Throughput** - You can adapt the throughput of the volume.

### Task 3 - Deploy application volume group for Oracle using Azure Resource Manager

In this task, you use an Azure Resource Manager (ARM) template to deploy Azure NetApp Files application volume group for Oracle.

1. Log in to the [Azure portal](https://portal.azure.com).

    :::image type="content" source="../media/portal-login.png" alt-text="Screenshot of Azure portal sign-in page." border="true" lightbox="../media/portal-login.png":::

2. Search for service **Deploy a custom template**.

    :::image type="content" source="../media/search-deploy-template.png" alt-text="Screenshot of Search for Deploy a custom template in Azure portal." border="true" lightbox="../media/search-deploy-template.png":::

3. Type **oracle** in the **Quickstart template** search dropdown.

    :::image type="content" source="../media/quickstart-search-oracle.png" alt-text="Screenshot of Azure portal showing the quickstart template search filtered by oracle." border="true" lightbox="../media/quickstart-search-oracle.png":::

4. Select template **quickstart/microsoft.netapp/anf-oracle/anf-oracle-storage** from the dropdown menu.

    :::image type="content" source="../media/select-oracle-template.png" alt-text="Screenshot of Azure portal showing the selection of the anf-oracle-storage quickstart template." border="true" lightbox="../media/select-oracle-template.png":::

5. Choose **Select template** to deploy.
6. Select **Subscription**, **Resource Group**, and **Availability Zone** from the dropdown menu. **Proximity Placement Group Name** and **Proximity Placement Group Resource Name** must be blank if the **Availability Zone** option is selected.

    :::image type="content" source="../media/azure-resource-manager-template-settings.png" alt-text="Screenshot of Azure portal showing Azure Resource Manager templatedeployment settings for subscription, resource group, and availability zone." border="true" lightbox="../media/azure-resource-manager-template-settings.png":::

7. Enter values for **Number of Oracle Data Volumes**, **Oracle Throughput**, **Capacity Pool**, **NetApp Account**, and **Virtual Network**.

    :::image type="content" source="../media/azure-resource-manager-oracle-volume-settings.png" alt-text="Screenshot of Azure portal showing Azure Resource Manager template parameter fields for Oracle volume group deployment." border="true" lightbox="../media/azure-resource-manager-oracle-volume-settings.png":::

8. Click **Review + Create** to continue.

    :::image type="content" source="../media/azure-resource-manager-review-create.png" alt-text="Screenshot of Azure portal showing the review plus create page for Oracle Azure Resource Manager deployment." border="true" lightbox="../media/azure-resource-manager-review-create.png":::

9. The **Create** button is enabled if there are no validation errors. Click **Create** to continue.

    :::image type="content" source="../media/azure-resource-manager-create-volume-group.png" alt-text="Screenshot of Azure portal showing the Create button enabled after successful validation." border="true" lightbox="../media/azure-resource-manager-create-volume-group.png":::

10. The overview page denotes "Your deployment is in progress" then "Your deployment is complete."
11. You can display a summary for the volume group. You can also display the volumes in the volume group under the NetApp account.
