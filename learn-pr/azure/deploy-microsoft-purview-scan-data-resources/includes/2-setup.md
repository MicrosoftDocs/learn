
## Prerequisites

In order to follow the hands-on exercises in this module, you'll need the following:

- An [Azure account](https://azure.microsoft.com/free/) with an active subscription. If you don't have one, you can follow the link to create a free one.
- Owner permissions within a Resource Group to create resources and manage role assignments. If you just created your Azure account, you'll have owner permissions already. If you didn't create your subscription, check with your Azure administrator to confirm [you have owner permissions within a resource group](/azure/role-based-access-control/quickstart-assign-role-user-portal).
- An Azure Data Lake Store Gen2 or Azure Storage account. If you don't have one, [follow the steps below to create one](#create-a-storage-account).
- Some data in your ADLS Gen2 or Azure Storage account. If you don't have any data, you can follow [the steps below to add data to your storage account](#add-data-to-your-storage-account).

## Create a storage account

> [!NOTE]
> If you already have an ADLS Gen2 or Azure Storage account in your subscription that you would like to use, you can skip this section.

To provide data for Microsoft Purview to classify, we'll set up an ADLS Gen 2 account with some sample data. Follow the steps below to create the resource.

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.
1. Select **Create a resource**.

    :::image type="content" source="../media/create-storage-account/create-a-resource.png" alt-text="Screenshot of Azure portal with the Create a Resource button selected in the Azure services menu at the top of the window.":::

1. Search for and select **Storage account**.
1. Select the **Storage account** plan, and select **Create**.

    :::image type="content" source="../media/create-storage-account/select-storage-account.png" alt-text="Screenshot of Azure Marketplace, with storage account in the search bar, and the create menu selected under Storage account.":::

1. Select an existing resource group, or create a new one.
1. Create a unique storage account name.
1. Select **Standard** performance.
1. Select **Locally-redundant storage**.

    :::image type="content" source="../media/create-storage-account/basics-options.png" alt-text="Screenshot of the Create a storage account window basics tab with subscription, resource group, storage account name, performance, and redundancy options highlighted.":::

1. Select **Next: Advanced**.
1. Select **Enable hierarchical namespace**.

    :::image type="content" source="../media/create-storage-account/advanced-options.png" alt-text="Screenshot of  the Create a storage account window advanced tab with the Enable hierarchical namespace option highlighted and selected.":::

1. Select **Review + create**.
1. After validation succeeds, select **Create**.

    :::image type="content" source="../media/create-storage-account/select-create.png" alt-text="Screenshot of  the Create a storage account window review + create tab, with validation showing as passed and the create button highlighted.":::

## Add data to your storage account

> [!NOTE]
> If your storage account already has data you would like to scan, you can skip this section.

1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. 
    > [!NOTE]
    > This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

1. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking or holding on the file and selecting **Extract All...**

    :::image type="content" source="../media/explorer-unzip.png" alt-text="Screenshot of the BingCoronavirusQuerySet zip file with the menu open and Extract All highlighted.":::

1. Select **Extract**.

    :::image type="content" source="../media/explorer-extract.png" alt-text="Screenshot of the extract menu with the Extract button highlighted.":::

1. In the [Azure portal](https://portal.azure.com), locate your storage account, and in the left menu select **Storage browser**.

    :::image type="content" source="../media/add-data/select-storage-browser.png" alt-text="Screenshot of A D L S Gen 2 storage account with Storage browser selected from the left side menu.":::

1. Select **Upload** from the top menu.

    :::image type="content" source="../media/add-data/select-upload.png" alt-text="Screenshot of A D L S Gen 2 storage browser, with the upload button selected in the menu at the top.":::

1. In the new menu either browse for files, or drag all your files from the query set we extracted earlier. Create a new container, named **raw**.

    :::image type="content" source="../media/add-data/upload-files.png" alt-text="Screenshot of A D L S Gen 2 storage browser upload menu, with **browse for files** highlighted, the container dropdown menu highlighted with a container named raw, and the upload button in the middle of the page highlighted.":::

1. Select **Upload**, and at the bottom of the screen you'll see the upload status of each file as it is added.

1. Once all your files are uploaded, you can exit the upload menu and select our new **raw** container.

1. In the **raw** container, you should see all the files you uploaded.

    :::image type="content" source="../media/add-data/all-files.png" alt-text="Screenshot of A D L S Gen 2 storage browser with the new raw container opened, and all the uploaded files listed below.":::