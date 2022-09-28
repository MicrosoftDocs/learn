In this exercise, you will create an Azure Database for MySQL flexible server and configure it.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

## Create a Resource Group

> [!NOTE]
> You can use an existing resource group but following these steps makes it easy to delete things after you have finished the exercise.

1. In a web browser, navigate to the [Azure portal](https://portal.azure.com). Sign in using an Owner or Contributor account.
1. Under Azure services, select **Resource Groups**, then select **+ Create**.
1. Check that the correct subscription is displayed, then enter the Resource group name as **MyFlex_nnn**. Replace **nnn** with a random number. Select a **Region**.
1. Select **Review + create**. Then select **Create**.

## Create an Azure Database for MySQL flexible server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for MySQL**, select **Create**.
1. Under **Choose a deployment option to create a MySQL server**, select the **Resource type** dropdown box to view the options. Select **Flexible server (Recommended)**. Select **Create**.
    
    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the Azure Database for MySQL Flexible server (recommended) page.](../media/mysql-deployment-option.png)](../media/mysql-deployment-option.png#lightbox)
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - MyFlex_nnn.
    1. Server name - mysql-fxnnn (replace nnn with random numbers).
    1. Region - select the same region as the resource group.
    1. MySQL version - select 8.0.
    1. Workload type - for development or hobby projects.
    1. Compute + storage - **Burstable**. Select **Configure server** and examine the configuration options. Do not make any changes and close the blade.
    1. Availability zone - No preference.
    1. High availability - leave unchecked.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Next: Networking >**
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses)
    1. Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings including how long it will take to create the server, then select **Create** to create your Azure Database for MySQL flexible server. When the deployment is complete, select **Go to resource** ready for the next step.
    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the Azure Database for MySQL flexible server deployment is in progress page.](../media/deployment.png)](../media/deployment.png#lightbox)

## Inspect the server and increase the backup retention period

1. Navigate to the **Overview** blade, under **Settings**, select **Compute + storage**. This blade displays your current Compute tier, and the option to upgrade it. It also displays the amount of storage you have provisioned, and the option to increase storage.
1. Under backups, the backup retention period in days is displayed. Use the slider bar to change the backup retention period to 1. days. Select **Save** to retain your changes.
1. Under **Settings**, select **Databases**. The four system databases used by MySQL are displayed. When you create database, it will be listed here.

## Examine server parameters

1. Under **Settings**, select **Server parameters**.
1. Use the search bar to search for and examine the following parameters. Examine the options by selecting each drop list, but do not change these parameters.
   - character_set_server
   - collation_server
   - default_storage_engine
   - blackhole

> [!NOTE]
> You cannot change the blackhole parameter. Read the message at the top of the page about modifiable and non-modifiable server parameters.

When you have completed this exercise, Select **STOP** to stop the server. This will prevent charges being incurred while you are not using it. The server will be used in the next module.

## Optional exercise - Create an Azure Database for MySQL with high availability

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for MySQL**, select **Create**.
1. Under **Choose a deployment option to create a MySQL server**, select the **Resource type** dropdown box to view the options. Select **Flexible server (Recommended)**. Select **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. **Subscription** - your subscription.
    1. **Resource group** - MyFlex_nnn.
    1. **Server name** - mysql-fxnnn (replace nnn with random numbers).
    1. **Region** - select the same region as the resource group.
    1. **MySQL version** - select 8.0.
    1. **Workload type** - For small or medium size databases.
    1. **Compute + storage** - General Purpose. Select **Configure server** and examine the configuration options. Do not make any changes and close the blade.
    1. **Availability zone** - 1. (If you can leave this as No preference, Azure will automatically choose an availability zone for your primary and secondary servers. You must specify the availability zone if you have a preference.)
    1. **High availability** - checked. Note the estimated costs when this option is selected.
    1. **High availability mode** - select Zone redundant.
    1. In **admin username** enter **demo**.
    1. In **password** enter **Pa$$w0rd**.
    1. Select **Next: Networking >**
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses)
    1. Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings including how long it will take to create the server, then select **Create** to create your Azure Database for MySQL flexible server. When the deployment is complete, select **Go to resource** ready for the next step.

## Inspect the server

1. Navigate to your new Azure Database for MySQL flexible server and select the **Overview** page. Notice that the availability zone is 1. which is what you specified for the primary server.
1. From the left menu, under **Settings**, select **High availability**. Notice that that primary availability zone is 1 (as on the Overview page), and the standby availability zone is 3.
    
    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the Azure Database for MySQL high availability primary zone and standby zone page.](../media/high-availability.png)](../media/high-availability.png#lightbox)

## Force a failover

1. If necessary, from the left menu, under **Settings**, select **High availability**.
1. Select **Forced failover**. Notice the estimated time for the failover operation to complete.
1. Select **OK**. The failover process is initiated. When the failover is complete, a notification is displayed.
    
    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the Azure Database for MySQL forced failover page.](../media/forced-failover.png)](../media/forced-failover.png#lightbox)

    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the Azure Database for MySQL forced failover notification page.](../media/notifications.png)](../media/notifications.png#lightbox)
1. Navigate to the **High availability** blade again. You may need to refresh your browser window to see the latest information. The primary zone is now 3 and the standby availability zone is 1.
1. From the top menu, select **Delete** to delete the server. A notification is displayed. Select **Yes** to delete the server.

> [!IMPORTANT]
> Be sure to delete the server when you have completed this exercise. If you do not delete the server, you will incur charges. This server will not be used in future exercise.
