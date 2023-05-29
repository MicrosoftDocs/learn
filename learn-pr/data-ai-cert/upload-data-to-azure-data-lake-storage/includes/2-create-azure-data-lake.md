Before you can upload or transfer data into a data lake, you need to create one. Using the Azure portal, you can provision an Azure Data Lake Storage Gen2 store within minutes.

> [!NOTE]
> If you don't have an Azure account or prefer not to do this exercise in your account, just read through the exercise to understand how to create a Data Lake Storage Gen2 store.

## Create a resource group

Create a new resource group to hold the data lake storage. You use the resource group to administer related services and applications together. A resource group also makes resource clean up easier when you finish this module.

To create a resource group in the Azure portal, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the **Home** page, under **Azure services**, select **Create a resource**.

1. In the search box, enter **Resource group** and press <kbd>Enter</kbd>. The **Resource group** pane appears.

1. Select **Create** to add a new resource group.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting              | Value                                                        |
    | -------------------- | ------------------------------------------------------------ |
    | **Project details**  |                                                              |
    | Subscription         | Subscription you choose to work in.                          |
    | Resource group       | Enter *mslearn-datalake-test*                                |
    | **Resource details** |                                                              |
    | Region               | Select a location for the resource group. Typically, you want a location that's close to you or to the data you work with. |

   :::image type="content" source="../media/2-create-resource-group.png" alt-text="Screenshot showing Azure create a resource group pane.":::

1. Select **Review + create**.

1. After validation passes, select **Create**.

1. After the resource group is created, select **Go to resource group**. Optionally, from the *Notifications* icon in the portal menu (title bar), select **Pin to dashboard** to make it easy to find later.

## Create a Data Lake Storage Gen2 account

You create a Data Lake Storage Gen2 account the same way you create an Azure Blob store, but with one different setting.

1. On the **Resource Group** page, select **Create resources**. The **Create a resource** page appears.

1. In the resource menu, select **Storage**, and then search for **Storage account**, and press <kbd>Enter</kbd>. The **Storage account** pane appears.

1. Select **Create**. The **Create a storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting              | Value                                                        |
    | -------------------- | ------------------------------------------------------------ |
    | **Project details**  |                                                              |
    | Subscription         | Same subscription as the *Data Lake Storage Gen2 account* you created. |
    | Resource group       | From the dropdown list, select *mslearn-datalake-test*       |
    | **Instance details** |                                                              |
    | Storage account name | Enter a unique name for your storage account. The name must be unique across all of Azure. You might have to try a few variations to find a unique name. Try using the prefix *dlakedata* with some numbers. A green check mark indicates you've entered a valid name. |
    | **Region**           | From the dropdown list, select *(US) Central US*.            |

1. Accept the defaults for the remainder of the settings.

   :::image type="content" source="../media/2-create-storage-account-basics.png" alt-text="Screenshot showing the Basics tab for Create a storage account.":::

1. Select **Next : Advanced**.

1. On the **Advanced** tab, select the following value for the setting. Accept default values for all other settings.

    | Setting                       | Value             |
    | ----------------------------- | ----------------- |
    | **Data Lake Storage Gen2**    |                   |
    | Enable hierarchical namespace | *check* (Enabled) |
  
   :::image type="content" source="../media/2-create-storage-account.png" alt-text="Screenshot showing the Advanced tab for Create storage account.":::

1. Select **Review + create** to create the storage account.

1. After the creation details pass validation, select **Create** to start the deployment.

After you receive a message that your deployment is complete, select **Go to resource** to confirm the storage account deployed correctly.