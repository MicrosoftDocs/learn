## Lab exercise 1 - Host a website in Azure blob storage

To get started with hosting a website in Azure blob storage perform the following steps:

1. Sign in to the [Azure portal](https://portal.azure.com).

2. Navigate to **All services** -> Enter **Storage account** in the filter box.

3. Click on **Storage accounts**.

![Navigate to storage account in the console][storage-account]

4. Enter a name for your storage account, in our examples we use `serverless34`

    This name must be globally unique; it is used as part of the URL used to access the objects in the storage account.

5. Select **Resource Manager** as the deployment model.

    Tiered storage can only be used with Resource Manager storage accounts; Resource Manager is the recommended deployment model for new resources.

6. In the **Account Kind** dropdown list, select **General-purpose v2**.

    When you select GPv2, the performance tier is set to Standard. Tiered storage is not available with the Premium performance tier.

7. Select the right storage tier for your needs: Set the **Access tier** to either **Cool** or **Hot**. The default is **Hot**.

8. Select the subscription in which you want to create the new storage account.

9. Specify a new resource group and enter a name for the new resource group for this set of tutorials: *ServerlessWebApp*.

10. Select the region for your storage account.

11. Click **Create** to create the storage account.

## Create a container

1. Open your storage account
2. Click on **Add**.
3. Give it a name.
4. Select **Create**.

## Install the application

1. Download the sample website from **Artifact location**
2. Upload it into your storage container
3. Retrieve the URL
4. Browse to it in your favorite web browser

<!-- Images -->
[storage-account]: ../media/lab-1-storage-account.png