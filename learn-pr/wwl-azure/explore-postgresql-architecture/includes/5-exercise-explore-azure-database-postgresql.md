In this exercise, you'll create an Azure Database for PostgreSQL flexible server and configure the backup retention period.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you don't have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Create a Resource Group

> [!NOTE]
> You can use an existing resource group but creating a separate resource group will make it easier to delete everything after you have finished all the exercises.

1. In a web browser, navigate to the [Azure portal](https://portal.azure.com). Sign in using an Owner or Contributor account.
2. Under Azure services, select **Resource Groups**, then select **+ Create**.
3. Check that the correct subscription is displayed, then enter the Resource group name as **PostgreSQL_Flexi**. Select a **Region**.
4. Select **Review + create**. Then select **Create**.

## Create an Azure Database for PostgreSQL flexible server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for PostgreSQL**, select **Create**.
1. Under **How do you plan to use the service?** Under **Flexible server**, select **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - **PostgreSQL_Flexi**.
    1. Server name - **postgresql-fx99** (Server name must be globally unique, so replace 99 with random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 13.
    1. Workload type - **Development**.
    1. Compute + storage - **Burstable**. Select **Configure server** and examine the configuration options. Don't make any changes and close the blade.
    1. Availability zone - No preference.
    1. High availability - leave unchecked.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses)
    1. Under Firewall rules, select **+ Add current client IP address**, to add your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings including how long it will take to create the server, then select **Create** to create your Azure Database for PostgreSQL flexible server. When the deployment is complete, select **Go to resource** ready for the next step.

## Examine server parameters

1. Under **Settings** select **Server parameters**.
1. In the **Search to filter items ...** box, enter **connections**. Server parameters related to connections are displayed. Note the value for **max_connections**. Don't make any changes.
1. From the left menu, select **Overview** to exit from **Server parameters**.

## Change backup retention period

1. Navigate to the **Overview** blade, under **Settings**, select **Compute + storage**. This section displays your current Compute tier, and the option to upgrade it. It also displays the amount of storage you've provisioned, and the option to increase storage.
1. Under **backups**, the backup retention period in days is displayed. Using the slider bar, change the backup retention period to 14 days. Select **Save** to retain your changes.
1. When you've completed this exercise, **STOP** the server. You'll not be charged while the server is in a stopped state.

## Optional exercise - configure a high availability server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for PostgreSQL**, select **Create**.
1. Under **How do you plan to use the service?** Under **Flexible server**, select **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - **PostgreSQL_Flexi**.
    1. Server name - **postgresql-fx99** (Server name must be globally unique, so replace 99 with random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 13.
    1. Workload type - **Production (Small / Medium)**
    1. Compute + storage - **General purpose**.
    1. Availability zone - 1. You can leave this at "No preference" and Azure will automatically choose availability zones for your primary and secondary servers. Alternatively, specify an availability zone to co-locate with your application.
    1. Enable high availability - check this. Note the estimated costs when this option is selected.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses)
    1. Under Firewall rules, select **+ Add current client IP address**, to add your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Review your settings including how long it will take to create the server, then select **Create** to create your Azure Database for PostgreSQL flexible server. When the deployment is complete, select **Go to resource** ready for the next step.

### Inspect the new server

- Under **Settings**, select **High availability**. High availability is enabled, and the primary availability zone is 1. The standby availability zone has been automatically allocated.

### Force a failover

1. On the **High availability** blade, from the top menu select **Forced Failover**. A message is displayed, select **OK**.
1. The failover process starts. A message is displayed when the failover operation has completed successfully.
1. On the **High availability** blade, you can see that the primary zone is now 2, and the standby availability zone is 1. You may need to refresh your browser to see the latest information.
1. When you've completed this exercise, delete the server.

> [!IMPORTANT]
> The server for this lab exercise will incur charges. Delete the server once you've completed the exercise. 
