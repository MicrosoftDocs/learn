In this exercise, you'll create an Azure Database for PostgreSQL flexible server and configure the backup retention period.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you don't have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Create a Resource Group

> [!NOTE]
> You can use an existing resource group but creating a separate resource group will make it easier to delete everything after you have finished all the exercises.
>
> In this exercise we will manually setup an Azure Database for PostgreSQL flexible server.
> In later exercises we will use [Bicep](azure/azure-resource-manager/bicep/overview) to deploy our resources.

1. In a web browser, navigate to the [Azure portal](https://portal.azure.com). Sign in using an Owner or Contributor account.
2. Under Azure services, select **Resource Groups**, then select **+ Create**.
3. Check that the correct subscription is displayed, then enter the Resource group name as **rg-PostgreSQL_Flexi**. Select a **Region**.
4. Select **Review + create**. Then select **Create**.

## Create an Azure Database for PostgreSQL flexible server

1. Under Azure services, select **+ Create a resource**. 
    1. In **Search the Market Place**, type **azure database for postgresql flexible server**, choose **Azure Database for PostgreSQL Flexible Server** and click **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - **rg-PostgreSQL_Flexi**.
    1. Server name - **psql-postgresql-fx9999** (Server name must be globally unique, so replace 9999 with four random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 16.
    1. Workload type - **Development**.
    1. Compute + storage - **Burstable, B1ms**. Select **Configure server** and examine the configuration options. Don't make any changes and close the blade in the right hand corner.
    1. Availability zone - No preference.
    1. High availability - leave unchecked.
    1. Authentication Method - leave as **PostgreSQL authentication only**
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd_01**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses) and Private endpoint
    1. Public access, select **Allow public access to this resource through the internet using a public IP address**
    1. Under Firewall rules, select **+ Add current client IP address**, to add your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings, then select **Create** to create your Azure Database for PostgreSQL Flexible server. When the deployment is complete, select **Go to resource** ready for the next step.

## Examine server parameters

1. Under **Settings** select **Server parameters**.
1. In the **Search to filter items ...** box, enter **connections**. Server parameters related to connections are displayed. Note the value for **max_connections**. Don't make any changes.
1. From the left menu, select **Overview** to exit from **Server parameters**.

## Change backup retention period

1. Navigate to the **Overview** blade, under **Settings**, select **Compute + storage**. This section displays your current Compute tier, and the option to upgrade it. It also displays the amount of storage you've provisioned, and the option to increase storage.
1. Under **backups**, the backup retention period in days is displayed. Using the slider bar, change the backup retention period to 14 days. Select **Save** to retain your changes.
1. When you've completed this exercise, navigate to the **Overview** blade, and click **STOP** which will stop the server.
    1. You'll not be charged while the server is in a stopped state, but be aware that within seven days the server will be restarted if you have not deleted it.

## Optional exercise - configure a high availability server

1. Under Azure services, select **+ Create a resource**.
    1. In **Search the Market Place**, type **azure database for postgresql flexible server**, choose **Azure Database for PostgreSQL Flexible Server** and click **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - **rg-PostgreSQL_Flexi**.
    1. Server name - **psql-postgresql-fx8888** (Server name must be globally unique, so replace 8888 with random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 16.
    1. Workload type - **Production (Small / Medium)**
    1. Compute + storage - leave as **General purpose**.
    1. Availability zone - You can leave this at "No preference" and Azure will automatically choose availability zones for your primary and secondary servers. Alternatively, specify an availability zone to co-locate with your application.
    1. Enable high availability - check this. Note the estimated costs when this option is selected.
    1. High availability mode - choose **Zone redundant - a standby server is always available within another zone in the same region as the primary server**
    1. Authentication Method - leave as **PostgreSQL authentication only**
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd_01**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses) and Private endpoint
    1. Public access, select **Allow public access to this resource through the internet using a public IP address**
    1. Under Firewall rules, select **+ Add current client IP address**, to add your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings, then select **Create** to create your Azure Database for PostgreSQL flexible server. When the deployment is complete, select **Go to resource** ready for the next step.

### Inspect the new server

1. Under **Settings**, select **High availability**. High availability is enabled, and the primary availability zone should be zone 1.
    1. The standby availability zone has been automatically allocated and will be different to the primary availability zone and typically is zone 2.

### Force a failover

1. On the **High availability** blade, from the top menu select **Forced Failover**. A message is displayed, select **OK**.
1. The failover process starts. A message is displayed when the failover operation has completed successfully.
1. On the **High availability** blade, you can see that the primary zone is now 2, and the standby availability zone is 1. You may need to refresh your browser to see the latest information.
1. When you've completed this exercise, delete the server.

> [!IMPORTANT]
> The server for this lab exercise will incur charges. Delete the resource group **rg-PostgreSQL_Flexi** once you've completed the exercise.
> This will remove the server and any other resources that you have deployed in this lab exercise.
