Azure Data Lake Storage Gen2 is easy to set up. It requires a **StorageV2 (General Purpose V2)** Azure Storage account with the Hierarchical namespace enabled. Let's walk through an example of setting up an Data Lake Storage account in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true)
1. Select **Create a resource** and navigate to **Storage**.
1. In **Featured**, select **Storage account - blob, file, table, queue** as shown in the following screenshot.

    ![Screenshot of the Azure portal showing the Create a resource, Storage account in highlights.](../media/3-azure-portal.png)

1. Next, in the **Create storage account** window, under the **Basics** tab, define a **storage account name**. Set the **location** to **Central US**.

1. In the **Account kind** drop-down list, select **StorageV2 (general-purpose v2)** to create a Data Lake Storage Gen2 data store.

    ![Screenshot of Basics Settings for Creating Storage Account.](../media/3-create-storage-account-basics.png)

1. Select the **Advanced** tab. Next to the option of **Hierarchical namespace**, make sure that the **Data lake storage gen2(preview)** option is set to **Enabled** as shown below.

    ![Screenshot of Advanced Settings for Creating Storage Account.](../media/3-create-storage-account-advanced.png)

This new Azure Storage account is now set up to host data for an Azure Data Lake. After the account has deployed, you will find options related to Azure Data Lake in the Overview page.