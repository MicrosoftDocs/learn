Next, let's create an Azure Storage account and Blob Storage container to hold the data we want to import into our data warehouse.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating the Blob storage container and associated storage account.

## Create an Azure Storage account

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

1. Select **Create a resource**.

1. In the left menu pane, select **Storage**, then search for and select **Storage account**. The **Storage account** pane appears.

1. Select **Create**. The **Create storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting       | Value |
    | ----------- | ----------- |
    | **Project details** |
    | Subscription     | Name of the subscription you are using in this exercise. |
    | Resource group        | From the dropdown, select **mslearn-demodw**. |
    | **Instance details** |
    | Storage account name | **demodwstorage** |
    | Region | Select the same location where you placed your database. |

1. Select **Review + create** to validate the account details. The **Create storage account** pane reappears with a *Validation passed* notification.

1. After validation passes, select **Create** to start the deployment process. Deployment can take a few minutes. You can monitor the deployment process by selecting the notifications (bell) icon in the toolbar.

## Create the blob container for the import data

Next, create a blob container that holds the source data.

1. After deployment is complete, select **Go to resource**.

1. In the left menu pane, under **Data storage**, select **Containers**. The **Containers** pane appears.

1. To create a container to store the files, in the top menu bar, select **Container**. The **New container** pane appears.

1. In the **Name** field, enter **data-files**.

1. In the **Public access level** dropdown list, select **Blob (anonymous read access for blobs only)**.

1. Select **Create** to create the container.
