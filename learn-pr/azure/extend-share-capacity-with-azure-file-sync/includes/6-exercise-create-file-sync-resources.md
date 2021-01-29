Now that you know your server is compatible with Azure File Sync, you're ready to set up your Azure resources. In this exercise, you'll create the four components that you need to connect your company's file server.

The following video shows how to create the Azure resources you'll need. Use the steps in this exercise to continue following along in your Azure subscription.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4LBmt]

## Create the storage account

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true). 
1. Search for **Storage accounts** by using the Azure portal search box.
1. In **Storage accounts**, select **Add**.
1. Use the following values for the storage account:
   
   |Box |Value  |
   |---------|---------|
   |Resource group | **learn-file-sync-rg**        |
   |Storage account name   | **extendcadfiles**      |

   Accept the defaults for the rest of the values.
1. Select **Review + create** and then select **Create**.

## Create the file share

1. Wait for the storage account to be created.
1. When you get the notification, select **Go to resource**.
1. On the **Overview** page, select **File shares**.
1. Select **File share**.
1. Enter these values:

   |Box  |Value  |
   |---------|---------|
   |Name    |**cadfileshare**    |
   |Quota    |      **1**   |

 
1. Select **Create**.

## Create the Storage Sync Service

1. In the upper-left corner of the portal, select **Create a resource**.
1. In the search box, enter **Azure File Sync**, and then select **Azure File Sync**.
1. Select **Create**.
1. Enter these values:

   |Box |Value  |
   |---------|---------|
   |Resource group | **learn-file-sync-rg**        |
   |Storage Sync Service name  | **CADSyncService** |

1. Select **Review + Create** and then select **Create** to deploy the Storage Sync Service.

## Create a sync group

1. Wait for the Storage Sync Service to be created.
1. When you get the notification, select **Go to resource**.
1. In the **Storage Sync Service Overview** pane, select **Sync group**.
1. Enter these values:

   |Box |Value  |
   |---------|---------|
   |Sync group name | **CADFiles** |
   |Storage account | **extendcadfiles** |
   |Azure File Share|**cadfileshare**|

1. Select **create**.
