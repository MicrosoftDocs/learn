> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module. If you don't have an Azure subscription, you can set up a free trial account at [Build in the cloud with an Azure free account](https://azure.microsoft.com/free/).

## Create the exercise environment

### Deploy PostgreSQL server

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com).

1. Select **Create a resource**.
    
    :::image type="content" source="../media/create-resource.png" alt-text="Create a resource icon.":::

1. In **Search services and marketplace** type **PostgreSQL** and select **Azure Database for PostgreSQL Flexible Server**.
1. Select **Create**.
1. Select the relevant **Subscription**, **Resource group**, and **Region** for your environment.
1. Type a valid **Server name**.
1. In **PostgreSQL version**, select **13**.
1. In **Workload type**, select **Development**.
    
    :::image type="content" source="../media/create-flexible-server.png" alt-text="Screenshot of settings to create PostgreSQL server.":::

1. In **Admin username** type **demo**.
1. In **Password** type **Pa$$w0rd**.
1. In **Confirm password** type **Pa$$w0rd**.
1. Select **Next: Networking >**.
1. In **Firewall rules**, select **Allow public access from any Azure service within Azure to this server**.
1. Select **Add current client IP address**.
    
    :::image type="content" source="../media/firewall-rules.png" alt-text="Screenshot of firewall rules.":::

1. Select **Review + create**.
1. Select **Create**.
1. Wait until the deployment is complete.

### Restore AdventureWorks database

1. Clone the PostgreSQL samples database repository at [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
    1. For example, you could use the following code from a command prompt:
    ```dos
    git clone https://github.com/MicrosoftLearning/mslearn-postgres c:\postgresql-samples-databases
    ```
1. Download and install pgAdmin 4 from [Download](https://www.pgadmin.org/download/)
1. Download and install Azure Data Studio from [Download and install Azure Data Studio](/sql/azure-data-studio/download-azure-data-studio).
1. Start Azure Data Studio.
1. Select the **View** menu and select **Extensions**.
1. In **Search Extensions in Marketplace**, type **PostgreSQL** and select **Install**.
    
    :::image type="content" source="../media/postgresql-extension.png" alt-text="Screenshot of PostgreSQL extension install button.":::

1. Select **Connections**.
    
    :::image type="content" source="../media/connections.png" alt-text="Screenshot of Connections button.":::

1. Select **Servers** and select **New connection**.
    
    :::image type="content" source="../media/create-connection.png" alt-text="Screenshot of Create a connection button.":::

1. In **Connection type**, select **PostgreSQL**.
1. In **Server name**, type the value that you specified when you deployed the server.
1. In **User name**, type **demo**.
1. In **Password**, type **Pa$$w0rd**.
1. Select **Remember password**.
1. Start pgAdmin and enter the password that you specified during installation.
1. Right-click **Servers**, select **Register**, and select **Server**.

    :::image type="content" source="../media/pgadmin-register.png" alt-text="Screenshot of server registration menu in pgAdmin.":::

1. In **Name**, type **PostgreSQL Exercise 8** and select the **Connection** tab.
1. In **Host name/address**, type the value that you specified when you deployed the server.
1. In **Username**, type **demo**.
1. In **Password**, type **Pa$$w0rd**.
1. Select **Save password**.
1. Select **Save**.
1. Expand **PostgreSQL Exercise**, right-click **Databases**, select **Create**, and select **Database**.
    
    :::image type="content" source="../media/create-database.png" alt-text="Screenshot showing Create Database menu item.":::

1. In **Database**, type **adventureworks** and select **Save**.
1. Right-click **adventureworks** and select **Restore**.
1. In **Filename**, type the path that you specified in the git clone statement plus **\AdventureWorksPG.gz**.
1. In **Number of jobs**, type **1**.
1. In **Role name**, select **demo**.
1. Select **Restore**.
    
    :::image type="content" source="../media/restore.png" alt-text="Screenshot of Restore dialog box.":::

1. Wait until the restore process completes.
1. You can disregard any errors that occur because those objects aren't required for these modules.

## Task 1: Investigate default locking behavior

1. Start **Azure Data Studio**.
1. In **SERVERS**, select **New connection**.
    
    :::image type="content" source="../media/5-servers.png" alt-text="Screenshot highlighting the New connection button." lightbox="../media/5-servers.png":::

1. In **Connection type**, select **PostgreSQL**.
1. In **Server name** type the server name of your Azure Database for PostgreSQL server. This can be copied from the Azure portal.
1. In **User name**, type **demo**.
1. In **Password**, type **Pa$$w0rd**.
1. Select **Remember password**.
1. Select **Connect**.
    
    :::image type="content" source="../media/5-connection.png" alt-text="Screenshot of the Connection dialog box." lightbox="../media/5-connection.png":::

1. Expand **Databases**, right-click **adventureworks** and select **New Query**.
    
    :::image type="content" source="../media/5-new-query.png" alt-text="Screenshot of adventureworks highlighting New Query context menu item." lightbox="../media/5-new-query.png":::
    
1. Repeat the previous step to create another query tab. You should now have a query tab with a name beginning **SQL_Query_1** and another query tab with a name beginning **SQL_Query_2**.
1. Select the **SQLQuery_1** tab, type the following query and select **Run**.

    ```sql
    SELECT * FROM production.workorder;
    ```
1. Notice that the **stockedqty** value for the first row is **15**.
1. Select the **SQLQuery_2** tab, type the following query and select **Run**.

    ```sql
    BEGIN TRANSACTION;
    UPDATE production.workorder
        SET stockedqty=stockedqty+1
    ```

1. Notice that the second query begins a transaction, but doesn't commit the transaction.
1. Return to **SQLQuery_1** and run the query again.
1. Notice that the **stockedqty** value for the first row is still **15**. The query is using a snapshot of the data and isn't seeing the updates from the other transaction.
1. Select the **SQLQuery_2** tab, delete the existing query, type the following query and select **Run**.

    ```sql
    ROLLBACK TRANSACTION;
    ```

## Task 2: Apply table locks to a transaction

1. Select the **SQLQuery_2** tab, type the following query and select **Run**.

    ```sql
    BEGIN TRANSACTION;
    LOCK TABLE production.workorder IN ACCESS EXCLUSIVE MODE;
    UPDATE production.workorder
        SET stockedqty=stockedqty+1
    ```

1. Notice that the second query begins a transaction, but doesn't commit the transaction.
1. Return to **SQLQuery_1** and run the query again.
1. Notice that the transaction is blocked and won't complete, however long you wait.
1. Select the **SQLQuery_2** tab, delete the existing query, type the following query and select **Run**.

    ```sql
    ROLLBACK TRANSACTION;
    ```
1. Return to **SQLQuery_1**, wait for a few seconds and notice that the query has completed was the block was removed.

In this exercise, we've seen the default locking behavior. We then applied locks explicitly and saw that although some locks provide very high levels of protection, these locks can also have performance implications.
