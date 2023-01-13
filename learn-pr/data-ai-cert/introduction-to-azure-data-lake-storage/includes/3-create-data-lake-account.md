Azure Data Lake Storage Gen2 is easy to set up. It requires a **StorageV2 (General Purpose V2)** Azure Storage account with the Hierarchical namespace enabled. Let's walk through an example of setting up a Data Lake Storage account in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Create a resource** and in the textbox that states *Search services and marketplace*, search for and select **Storage account**.

1. On the **Storage account** page, select **Create**.

   :::image type="content" source="../media/3-azure-portal.png" alt-text="Screenshot of the Azure portal showing the Create a resource, Storage account in highlights.":::

1. On the **Create a storage account** page, select the **Basics** tab. In the **Project details** section, ensure that your subscription is selected, and select or enter the appropriate resource group. In the **Instance details** section, define a **Storage account name**. Set the **Region** to **Central US**. In the **Performance** radio button list, select **Standard**, and set the **Redundancy** to **Locally-redundant storage (LRS)**.

   :::image type="content" source="../media/3-create-storage-account-basics.png" alt-text="Screenshot of Basics Settings for Creating Storage Account.":::

1. Select the **Advanced** tab. In the **Data Lake Storage Gen2** section, select the checkbox for  **Enable hierarchical namespace**.

   :::image type="content" source="../media/3-create-storage-account-advanced.png" alt-text="Screenshot of Advanced Settings for Creating Storage Account.":::

1. Select **Review** and then **Create**.

This new Azure Storage account is now set up to host data for an Azure Data Lake. After the account has deployed, select **Go to resource**. You'll find options related to **Data Lake Storage** on the Overview page.