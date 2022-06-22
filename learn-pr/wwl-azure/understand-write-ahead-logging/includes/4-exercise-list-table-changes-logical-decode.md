In this exercise you'll configure logical replication, which is native to PostgreSQL. You will create two servers, which act as publisher and subscriber. Data in the zoodb will be replicated between them.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you don't have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Create resource group

1. Sign in to the Azure portal. Your user account must be an Owner or Contributor for the Azure subscription.
1. Select **Resource groups** and then select **+ Create**.
1. Select your subscription.
1. In Resource group, enter **PostgreSQL_Replication**.
1. Select a region close to your location.
1. Select **Review + create**.
1. Select **Create**.

## Create a publisher server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for PostgreSQL**, select **Create**.
1. Under **How do you plan to use the service?** Under **Flexible server**, select **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - select **PostgreSQL_Replication**.
    1. Server name - **postgresql-pub99** (Name must be globally unique, so replace 99 with random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 13.
    1. Workload type - **Development**.
    1. Compute + storage - **Burstable**. Select **Configure server** and examine the configuration options. Don't make any changes and close the section.
    1. Availability zone - 1. If availability zones aren't supported, leave as No preference.
    1. High availability - leave unchecked.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses).
    1. **Allow public access from any Azure service within Azure to this server** - checked. This must be checked, so that the publisher and subscriber databases can communicate with each other.
    1. Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Then select **Create**.
    :::image type="content" source="../media/flexible-server-networking.png" alt-text="Screenshot showing the Flexible server Networking page." lightbox="../media/flexible-server-networking.png":::

## Create a subscriber server

1. Under Azure services, select **+ Create a resource**. Under **Categories**, select **Databases**. Under **Azure Database for PostgreSQL**, select **Create**.
1. Under **How do you plan to use the service?** Under **Flexible server**, select **Create**.
1. On the Flexible server **Basics** tab, enter each field as follows:
    1. Subscription - your subscription.
    1. Resource group - select **PostgreSQL_Replication**.
    1. Server name - **postgresql-sub99** (Name must be globally unique, so replace 99 with random numbers).
    1. Region - select the same region as the resource group.
    1. PostgreSQL version - select 13.
    1. Workload type - **Development**.
    1. Compute + storage - **Burstable**. Select **Configure server** and examine the configuration options. Don't make any changes and close the section.
    1. Availability zone - 2. If availability zones aren't supported, leave as No preference.
    1. High availability - leave unchecked.
    1. In **admin username**, enter **demo**.
    1. In **password**, enter **Pa$$w0rd**.
    1. Select **Next: Networking >**.
1. On the Flexible server **Networking** tab, enter each field as follows:
    1. Connectivity method: (o) Public access (allowed IP addresses)
    1. **Allow public access from any Azure service within Azure to this server** - checked. This must be checked, so that the publisher and subscriber databases can communicate with each other.
    1. Under Firewall rules, select **+ Add current client IP address**. This adds your current IP address as a firewall rule. You can optionally name this firewall rule to something meaningful.
1. Select **Review + create**. Then select **Create**.

## Set up replication

For both the publisher and subscriber servers:

1. In the Azure portal, navigate to the server and under Settings select **Server parameters**.
1. Using the search bar, find each parameter and make the following changes:
    1. wal_level = LOGICAL
    1. max_worker_processes = 24
1. Select **Save**. Then select **Save and Restart**.

## Set up the publisher

1. Open Azure Data Studio and connect to the publisher server. (Copy the server name from the Overview section.)
1. Open the script **Lab6_Replication.sql** and connect to the server.
1. Highlight and run the section **Grant the admin user replication permission**.
1. Highlight and run the section **Create zoodb database**.
1. Select zoodb as the current database using the dropdown list on the toolbar. Verify that zoodb is the current database by running the **SELECT** statement.
1. Highlight and run the section **Create tables and foreign key constraints in zoodb**.
1. Highlight and run the section **Populate the tables in zoodb**.
1. Highlight and run the section **Create a publication**. When you run the SELECT statement it will not list anything, because the replication isn't yet active.

## Set up the subscriber

1. Open a second instance of Azure Data Studio.
1. Open the script **Lab6_Replication.sql** and connect to the subscriber server. (Copy the server name from the Overview section.)
1. Highlight and run the section **Grant the admin user replication permission**.
1. Highlight and run the section **Create zoodb database**.
1. Select zoodb as the current database using the dropdown list on the toolbar. Verify that zoodb is the current database by running the **SELECT** statement.
1. Highlight and run the section **Create tables and foreign key constraints in zoodb**.
1. Scroll down to the section **Create a subscription**.
    1. Edit the **CREATE SUBSCRIPTION** statement so that it has the correct publisher server name. Highlight and run the statement.
    1. Highlight and run the **SELECT** statement. This shows the subscription "sub" that you've created.
1. Under the section **Display the tables**, highlight and run each **SELECT** statement. The tables have been populated by replication from the publisher.

## Make changes to the publisher database

- In the first instance of Azure Data Studio (publisher), under **Insert more animals** highlight and run the **INSERT** statement.

## View the changes in the subscriber database

- In the second instance of Azure Data Studio (subscriber), under **Display the animal tables** highlight and run the **SELECT** statement.

You've now created two Azure Database for PostgreSQL flexible servers and configured one as a publisher, and the other as a subscriber. In the publisher database you created and populated the zoo database. In the subscriber database, you created an empty database, which was then populated by streaming replication.

> [!IMPORTANT]
> Once you've finished the exercise, delete both servers. You'll be charged for the servers unless you either STOP or DELETE them.
