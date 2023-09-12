## Grant the Microsoft Purview managed identity access

To scan a source, Microsoft Purview requires a set of **credentials**. For Azure Data Lake Storage Gen2, Microsoft Purview supports the following [authentication methods](/azure/purview/register-scan-adls-gen2#setting-up-authentication-for-a-scan).

* Managed Identity (recommended)
* Service Principal
* Account Key

In this module, we'll walk through how to grant the Microsoft Purview managed identity the necessary access to successfully configure and run a scan.

1. Navigate to your Azure Data Lake Storage Gen2 account in the [Azure portal](https://portal.azure.com/)) and select **Access Control (IAM)** from the left navigation menu.

    :::image type="content" source="../media/register-and-scan-exercise/storage-access.png" alt-text="Screenshot of a storage account in the Azure portal, with Access Control (IAM) highlighted in the left menu.":::

1. Select **Add role assignments**.

    :::image type="content" source="../media/register-and-scan-exercise/storage-add-role.png" alt-text="Screenshot of Access Control menu in a storage account with the 'Add role assignment' button highlighted.":::

1. Filter the list of roles by searching for `Storage Blob Data Reader`, select the row to select the role, and then select **Next**.

    :::image type="content" source="../media/register-and-scan-exercise/access-role.png" alt-text="Screenshot of the Add role assignment page, with the search box highlighted and filled with Storage blob data reader, and the next button selected.":::

1. Under **Assign access to**, select **Managed identity**, select **+ Select members**, select **Microsoft Purview account** from the **Managed Identity** drop-down menu, select the managed identity for your Microsoft Purview account, select **Select**. Finally, select **Review + assign**.

    :::image type="content" source="../media/register-and-scan-exercise/access-members.png" alt-text="Screenshot of Add role assignment page with the Managed identity radio button selected, and the Select members button highlighted. On the Select managed identities page, the Purview account has been selected, and the Select button is highlighted.":::

1. Select **Review + assign** once more to perform the role assignment.

    :::image type="content" source="../media/register-and-scan-exercise/access-assign.png" alt-text="Screenshot of the Add role assignment review page, with the review + assign button highlighted at the bottom.":::

1. To confirm the role has been assigned, navigate to the **Role assignments** tab and filter the **Scope** to `This resource`. You should be able to see that the Microsoft Purview managed identity has been granted the **Storage Blob Data Reader** role.

    :::image type="content" source="../media/register-and-scan-exercise/role-assignment.png" alt-text="Screenshot of the storage account Access Control IAM page with the Role assignments tab selected, scope set to this resource, and the Microsoft Purview account shown under the storage blob data reader role.":::

## Register the source

1. Open the [Microsoft Purview Governance Portal](https://web.purview.azure.com/) for your account, navigate to **Data Map** > **Sources**, and select **Register**.

    :::image type="content" source="../media/register-and-scan-exercise/sources-register.png" alt-text="Screenshot of the Microsoft Purview governance portal, with the Data map selected in the left menu, then sources, and then register.":::

1. Select **Azure Data Lake Storage Gen2** and select **Continue**.

    :::image type="content" source="../media/register-and-scan-exercise/sources-adls.png" alt-text="Screenshot of the register sources menu with Azure Data Lake Storage Gen2 selected.":::

1. Select the **Azure subscription**, **Storage account name**, **Collection**, and select **Register**.

    :::image type="content" source="../media/register-and-scan-exercise/sources-properties.png" alt-text="Screenshot of the register Azure Data Lake Storage Gen2 menu, with the required fields highlighted: Subscription, storage account name, and collection.":::

## Scan source with the Microsoft Purview managed identity

At this point, we've registered a data source. Assets aren't written to the catalog until after a scan has finished running.

1. Open Purview Governance Portal, navigate to **Data Map** > **Sources**, and within the Azure Data Lake Storage Gen2 tile, select the **New Scan** button.

    :::image type="content" source="../media/register-and-scan-exercise/scan-new.png" alt-text="Screenshot of the Microsoft Purview governance portal with the data map selected in the left menu, then sources. The sources page is open to the map view, and the scan button is highlighted on the tile of the data source we registered in the above steps.":::

1. Select **Test connection** to ensure the Microsoft Purview managed identity has the appropriate level of access to read the Azure Data Lake Storage Gen2 account. When successful, select **Continue**.

    :::image type="content" source="../media/register-and-scan-exercise/scan-test.png" alt-text="Screenshot of the scan menu, with Connect via integration runtime set to the Azure AutoResolveIntegrationRuntime, credential set to Microsoft Purview MSI, and the Test Connection button selected at the bottom.":::

1. Expand the hierarchy to see which assets will be within the scans scope, and select **Continue**.

    :::image type="content" source="../media/register-and-scan-exercise/scan-scope.png" alt-text="Screenshot of the scope your scan page with all files and folders selected.":::

1. Select the system default scan rule set and select **Continue**.

    [Scan Rule Sets](/azure/purview/create-a-scan-rule-set) determine which **File Types** and **Classification Rules** are in scope. If you want to include a custom file type or custom classification rule as part of a scan, a custom scan rule set will need to be created.

    :::image type="content" source="../media/register-and-scan-exercise/scan-rule-set.png" alt-text="Screenshot of the select a scan rule set screen, with the AdlsGen2 system default rule set selected.":::

1. Select **Once** and select **Continue**.

    :::image type="content" source="../media/register-and-scan-exercise/scan-trigger.png" alt-text="Screenshot of the set a scan trigger menu with the Once radio button selected.":::

1. Select **Save and Run**.

    :::image type="content" source="../media/register-and-scan-exercise/scan-run.png" alt-text="Screenshot of the Review your scan page with the Save and Run button highlighted at the bottom of the page.":::

1. To monitor the progress of the scan run, select **View Details** under your data source in the data map.

    :::image type="content" source="../media/register-and-scan-exercise/sources-details.png" alt-text="Screenshot of the Microsoft Purview governance portal with the data map selected in the left menu, then sources. The sources page is open to the map view, and the View Details button is highlighted on the tile of the data source we registered and scanned in the previous steps.":::

1. Select **Refresh** to periodically update the status of the scan and wait until it says completed.

    >[!Note]
    > It will take 5 to 10 minutes to complete.

    :::image type="content" source="../media/register-and-scan-exercise/sources-refresh.png" alt-text="Screenshot of the Microsoft Purview governance portal, with Data Map selected, then sources, showing a screen of the source view details page. The refresh button in the middle of the page is highlighted.":::

    :::image type="content" source="../media/register-and-scan-exercise/complete-sources-refresh.png" alt-text="Screenshot of the Microsoft Purview governance portal, with Data Map selected, then sources, showing a screen of the source view details page, where the status now shows as Complete.":::


## View Assets

1. Navigate to **Purview Governance Portal** > **Data catalog**, and perform a wildcard search by typing the asterisk character (`*`) into the search box and hitting the Enter key to submit the query.

    :::image type="content" source="../media/register-and-scan-exercise/wildcard-search.png" alt-text="Screenshot of the Microsoft Purview governance portal with Data Catalog selected, and the search bar in the middle of the page highlighted.":::

1. You should be able to see a list of assets within the search results, which is a result of the scan.

    :::image type="content" source="../media/register-and-scan-exercise/search-wildcard.png" alt-text="Screenshot of the search results page, with the search bar at the very top of the page highlighted, and a list of scanned assets shown below.":::
