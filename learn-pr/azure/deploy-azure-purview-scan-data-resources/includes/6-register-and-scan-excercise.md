## 1. Grant the Azure Purview Managed Identity Access

To scan a source, Azure Purview requires a set of **credentials**. For Azure Data Lake Storage Gen2, Azure Purview supports the following [authentication methods](https://docs.microsoft.com/en-gb/azure/purview/register-scan-adls-gen2#setting-up-authentication-for-a-scan).

* Managed Identity (recommended)
* Service Principal
* Account Key

In this module we will walk through how to grant the Azure Purview Managed Identity the necessary access to successfully configure and run a scan.

1. Navigate to your Azure Data Lake Storage Gen2 account (e.g. `pvlab{randomId}adls`) and select **Access Control (IAM)** from the left navigation menu.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.06-storage-access.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Add role assignments**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.07-storage-addrole.png" alt-text="Alt text that describes the content of the image.":::

1. Filter the list of roles by searching for `Storage Blob Data Reader`, click the row to select the role, and then click **Next**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.08-access-role.png" alt-text="Alt text that describes the content of the image.":::

1. Under **Assign access to**, select **Managed identity**, click **+ Select members**, select **Purview account** from the **Managed Identity** drop-down menu, select the managed identity for your Azure Purview account (e.g. `pvlab-{randomId}-pv`), click **Select**. Finally, click **Review + assign**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.09-access-members.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Review + assign** once more to perform the role assignment.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.10-access-assign.png" alt-text="Alt text that describes the content of the image.":::

1. To confirm the role has been assigned, navigate to the **Role assignments** tab and filter the **Scope** to `This resource`. You should be able to see that the Azure Purview managed identity has been granted the **Storage Blob Data Reader** role.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.11-role-assignment.png" alt-text="Alt text that describes the content of the image.":::

## 2. Upload Data to Azure Data Lake Storage Gen2 Account

Before proceeding with the following steps, you will need to:

* Download and install [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/).
* Open Azure Storage Explorer.
* Sign in to Azure via **View > Account Management > Add an account...**.

1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. Note: This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

1. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking the file and selecting **Extract All...**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.10-explorer-unzip.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Extract**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.11-explorer-extract.png" alt-text="Alt text that describes the content of the image.":::

1. Open Azure Storage Explorer, click on the Toggle Explorer icon, expand the Azure Subscription to find your Azure Storage Account. Right-click on Blob Containers and select **Create Blob Container**. Name the container **raw**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.12-explorer-container.png" alt-text="Alt text that describes the content of the image.":::

1. With the container name selected, click on the **Upload** button and select **Upload Folder...**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.13-explorer-upload.png" alt-text="Alt text that describes the content of the image.":::

1. Click on the **ellipsis** to select a folder.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.14-explorer-browse.png" alt-text="Alt text that describes the content of the image.":::

1. Navigate to the extracted **BingCoronavirusQuerySet** folder (e.g. Downloads\BingCoronavirusQuerySet) and click **Select Folder**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.15-explorer-folder.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Upload**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.16-explorer-data.png" alt-text="Alt text that describes the content of the image.":::

1. Monitor the **Activities** until the transfer is complete.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.17-explorer-transfer.png" alt-text="Alt text that describes the content of the image.":::

## 3. Create a Collection


[Collections](https://docs.microsoft.com/en-us/azure/purview/how-to-create-and-manage-collections) in Azure Purview can be used to organize data sources, scans, and assets in a hierarchical model based on how your organization plans to use Azure Purview. The collection hierarchy also forms the security boundary for your metadata to ensure users don't have access to data they don't need (e.g. sensitive metadata). 

For more information, check out [Collection Architectures and Best Practices](https://docs.microsoft.com/en-us/azure/purview/concept-best-practices-collections).

1. Open Purview Studio, navigate to **Data Map** > **Collections**, and click  **Add a collection**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.18-sources-collection.png" alt-text="Alt text that describes the content of the image.":::

1. Provide the collection a **Name** (e.g. Contoso) and click **Create**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.76-collection-create.png" alt-text="Alt text that describes the content of the image.":::

## 4. Register a Source (ADLS Gen2)

1. Open Purview Studio, navigate to **Data Map** > **Sources**, and click on **Register**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.20-sources-register.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Azure Data Lake Storage Gen2** and click **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.21-sources-adls.png" alt-text="Alt text that describes the content of the image.":::

1. Select the **Azure subscription**, **Storage account name**, **Collection**, and click **Register**.

    At this point, we have simply registered a data source. Assets are not written to the catalog until after a scan has finished running.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.22-sources-properties.png" alt-text="Alt text that describes the content of the image.":::


## 5. Scan a Source with the Azure Purview Managed Identity

1. Open Purview Studio, navigate to **Data Map** > **Sources**, and within the Azure Data Lake Storage Gen2 tile, click the **New Scan** button.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.23-scan-new.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Test connection** to ensure the Azure Purview managed identity has the appropriate level of access to read the Azure Data Lake Storage Gen2 account. If successful, click **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.24-scan-test.png" alt-text="Alt text that describes the content of the image.":::

1. Expand the hierarchy to see which assets will be within the scans scope, and click **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.25-scan-scope.png" alt-text="Alt text that describes the content of the image.":::

1. Select the system default scan rule set and click **Continue**.
    
    [Scan Rule Sets](https://docs.microsoft.com/en-us/azure/purview/create-a-scan-rule-set) determine which **File Types** and **Classification Rules** are in scope. If you want to include a custom file type or custom classification rule as part of a scan, a custom scan rule set will need to be created.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.26-scan-ruleset.png" alt-text="Alt text that describes the content of the image.":::

1. Select **Once** and click **Continue**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.27-scan-trigger.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Save and Run**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.28-scan-run.png" alt-text="Alt text that describes the content of the image.":::

1. To monitor the progress of the scan run, click **View Details**.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.29-sources-details.png" alt-text="Alt text that describes the content of the image.":::

1. Click **Refresh** to periodically update the status of the scan. Note: It will take approximately 5 to 10 minutes to complete.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.30-sources-refresh.png" alt-text="Alt text that describes the content of the image.":::

## 6. View Assets

1. Navigate to **Purview Studio** > **Data catalog**, and perform a wildcard search by typing the asterisk character (`*`) into the search box and hitting the Enter key to submit the query.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.80-wildcard-search.png" alt-text="Alt text that describes the content of the image.":::

1. You should be able to see a list of assets within the search results, which is a result of the scan.

    :::image type="content" source="../media/6-register-and-scan-exercise/02.72-search-wildcard.png" alt-text="Alt text that describes the content of the image.":::
