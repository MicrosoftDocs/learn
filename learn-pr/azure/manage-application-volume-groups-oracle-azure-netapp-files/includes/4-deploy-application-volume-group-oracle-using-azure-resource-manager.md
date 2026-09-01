Here you learn how to use an Azure Resource Manager (ARM) template to deploy Azure NetApp Files application volume group for Oracle.

### Steps

1. Log in to the [Azure portal](https://portal.azure.com).

    :::image type="content" source="../media/portal-login.png" alt-text="Screenshot of Azure portal sign-in page." border="true" lightbox="../media/portal-login.png":::

2. Search for service **Deploy a custom template**.

    :::image type="content" source="../media/search-deploy-template.png" alt-text="Screenshot of Search for Deploy a custom template in Azure portal." border="true" lightbox="../media/search-deploy-template.png":::

3. Type **oracle** in the **Quickstart template** search dropdown.

    :::image type="content" source="../media/quickstart-search-oracle.png" alt-text="Screenshot of Azure portal showing the quickstart template search filtered by oracle." border="true" lightbox="../media/quickstart-search-oracle.png":::

4. Select template **quickstarts/microsoft.netapp/anf-oracle/anf-oracle-storage** from the dropdown menu.

    :::image type="content" source="../media/select-oracle-template.png" alt-text="Screenshot of Azure portal showing the selection of the anf-oracle-storage quickstart template." border="true" lightbox="../media/select-oracle-template.png":::

5. Click **Select template** to deploy.
6. Select **Subscription**, **Resource Group**, and **Availability Zone** from the dropdown menu. **Proximity Placement Group Name** and **Proximity Placement Group Resource Group** must be blank if the **Availability Zone** option is selected.

    :::image type="content" source="../media/azure-resource-manager-template-settings.png" alt-text="Screenshot of Azure portal showing Azure Resource Manager templatedeployment settings for subscription, resource group, and availability zone." border="true" lightbox="../media/azure-resource-manager-template-settings.png":::

7. Enter values for **Number of Oracle Data Volumes**, **Oracle Throughput**, **Capacity Pool**, **ANF NetApp Account**, and **Virtual Network**.

    :::image type="content" source="../media/azure-resource-manager-oracle-volume-settings.png" alt-text="Screenshot of Azure portal showing Azure Resource Manager template parameter fields for Oracle volume group deployment." border="true" lightbox="../media/azure-resource-manager-oracle-volume-settings.png":::

8. Select **Review + Create** to continue.

    :::image type="content" source="../media/azure-resource-manager-review-create.png" alt-text="Screenshot of Azure portal showing the review plus create page for Oracle Azure Resource Manager deployment." border="true" lightbox="../media/azure-resource-manager-review-create.png":::

9. The **Create** button is enabled if there are no validation errors. Select **Create** to continue.

    :::image type="content" source="../media/azure-resource-manager-create-volume-group.png" alt-text="Screenshot of Azure portal showing the Create button enabled after successful validation." border="true" lightbox="../media/azure-resource-manager-create-volume-group.png":::

10. The overview page denotes "Your deployment is in progress" then "Your deployment is complete."
11. You can display a summary for the volume group. You can also display the volumes in the volume group under the NetApp account.
