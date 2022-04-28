## Grant the Microsoft Purview managed identity access

To scan a source, Microsoft Purview requires a set of **credentials**. For Azure Data Lake Storage Gen2, Microsoft Purview supports the following [authentication methods](https://docs.microsoft.com/en-gb/azure/purview/register-scan-adls-gen2#setting-up-authentication-for-a-scan).

* Managed Identity (recommended)
* Service Principal
* Account Key

In this module we will walk through how to grant the Microsoft Purview managed identity the necessary access to successfully configure and run a scan.

1. Navigate to your Azure Data Lake Storage Gen2 account and select **Access Control (IAM)** from the left navigation menu.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.06-storage-access.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Add role assignments**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.07-storage-addrole.png" alt-text="Alt text that describes the content of the image.":::

1. Filter the list of roles by searching for `Storage Blob Data Reader`, select the row to select the role, and then select **Next**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.08-access-role.png" alt-text="Alt text that describes the content of the image.":::

1. Under **Assign access to**, select **Managed identity**, select **+ Select members**, select **Purview account** from the **Managed Identity** drop-down menu, select the managed identity for your Microsoft Purview account, select **Select**. Finally, select **Review + assign**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.09-access-members.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Review + assign** once more to perform the role assignment.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.10-access-assign.png" alt-text="Alt text that describes the content of the image.":::

1. To confirm the role has been assigned, navigate to the **Role assignments** tab and filter the **Scope** to `This resource`. You should be able to see that the Microsoft Purview managed identity has been granted the **Storage Blob Data Reader** role.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.11-role-assignment.png" alt-text="Alt text that describes the content of the image.":::

## Register the source

1. Open Purview Studio, navigate to **Data Map** > **Sources**, and select**Register**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.20-sources-register.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Azure Data Lake Storage Gen2** and select **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.21-sources-adls.png" alt-text="Alt text that describes the content of the image.":::

1. Select the **Azure subscription**, **Storage account name**, **Collection**, and select **Register**.

    At this point, we have simply registered a data source. Assets are not written to the catalog until after a scan has finished running.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.22-sources-properties.png" alt-text="Alt text that describes the content of the image.":::

## Scan source with the Microsoft Purview managed identity

1. Open Purview Studio, navigate to **Data Map** > **Sources**, and within the Azure Data Lake Storage Gen2 tile, select the **New Scan** button.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.23-scan-new.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Test connection** to ensure the Microsoft Purview managed identity has the appropriate level of access to read the Azure Data Lake Storage Gen2 account. If successful, select **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.24-scan-test.png" alt-text="Alt text that describes the content of the image.":::

1. Expand the hierarchy to see which assets will be within the scans scope, and select **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.25-scan-scope.png" alt-text="Alt text that describes the content of the image.":::

1. Select the system default scan rule set and select **Continue**.

    [Scan Rule Sets](https://docs.microsoft.com/en-us/azure/purview/create-a-scan-rule-set) determine which **File Types** and **Classification Rules** are in scope. If you want to include a custom file type or custom classification rule as part of a scan, a custom scan rule set will need to be created.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.26-scan-ruleset.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Once** and select **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.27-scan-trigger.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Save and Run**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.28-scan-run.png" alt-text="Alt text that describes the content of the image.":::

1. To monitor the progress of the scan run, select **View Details**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.29-sources-details.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Refresh** to periodically update the status of the scan.

    >[!Note]
    > It will take 5 to 10 minutes to complete.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.30-sources-refresh.png" alt-text="Alt text that describes the content of the image.":::

## View Assets

1. Navigate to **Purview Studio** > **Data catalog**, and perform a wildcard search by typing the asterisk character (`*`) into the search box and hitting the Enter key to submit the query.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.80-wildcard-search.png" alt-text="Alt text that describes the content of the image.":::

1. You should be able to see a list of assets within the search results, which is a result of the scan.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.72-search-wildcard.png" alt-text="Alt text that describes the content of the image.":::
