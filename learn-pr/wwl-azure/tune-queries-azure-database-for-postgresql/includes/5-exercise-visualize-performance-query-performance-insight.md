> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module. If you don't have an Azure subscription, you can set up a free trial account at [Build in the cloud with an Azure free account](https://azure.microsoft.com/free/).

## Create the exercise environment

### Deploy PostgreSQL server

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com).

1. Select **Create a resource**.

    :::image type="content" source="../media/create-resource.png" alt-text="Screenshot of the Create a resource icon.":::
1. In **Search services and marketplace** type **PostgreSQL** and select **Azure Database for PostgreSQL**.
1. Select **Create**.
1. In **Single server**, select **Create**.
1. Select **No - Create Single Server**.
1. Select the relevant **Subscription**, **Resource group**, and **Location** for your environment.
1. Type a valid **Server name**.
1. In **Version**, select **11**.
1. In **Compute + storage**, select **Configure server**.
1. Select **Basic** and select **OK**.
    :::image type="content" source="../media/5-create-single-server.png" alt-text="Screenshot of settings to create PostgreSQL server." lightbox="../media/5-create-single-server.png":::
1. In **Admin username** type **demo**.
1. In **Password** type **Pa$$w0rd**.
1. In **Confirm password** type **Pa$$w0rd**.
1. Select **Review + create**.
1. Select **Create**.
1. Wait until the deployment is complete.
1. When the deployment is complete, select **Go to resource**.
1. Select **Connection security**.
1. Select **Add current client IP address**.
    :::image type="content" source="../media/5-add-client-ip.png" alt-text="Screenshot of Add client I P." lightbox="../media/5-add-client-ip.png":::
1. In **Allow access to Azure services**, select **Yes**.
1. Select **Save**.

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
1. In **Server name**, type the value that you specified when you deployed the server followed by **.postgres.database.azure.com**.
1. In **User name**, type **demo@** followed by your server name.
1. In **Password**, type **Pa$$w0rd**.
1. Select **Remember password**.
1. Start pgAdmin and enter the password that you specified during installation.
1. Right-click **Servers**, select **Register**, and select **Server**.
    :::image type="content" source="../media/pgadmin-register.png" alt-text="Screenshot of server registration menu in p g Admin.":::
1. In **Name**, type **PostgreSQL Exercise 10** and select the **Connection** tab.
1. In **Host name/address**, type the value that you specified when you deployed the server.
1. In **Username**, type **demo@** followed by your server name.
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
1. You can disregard any errors that occur because those objects are not required for these modules.

## Task 1: Turn on query capture mode

1. Navigate to the Azure portal and sign in.
1. Select your Azure Database for PostgreSQL server for this exercise.
1. In **Settings**, select **Server parameters**.
1. Navigate to the **pg_qs.query_capture_mode** setting.
1. Select **TOP**.

    :::image type="content" source="../media/3-settings-turn-query-store-on.png" alt-text="Screenshot of settings to turn Query Store on." lightbox="../media/3-settings-turn-query-store-on.png":::
1. Navigate to **p g m s_wait_sampling.query_capture_mode**, select **ALL**, and select **Save**.
    :::image type="content" source="../media/3-query-capture-mode.png" alt-text="Screenshot of settings to turn p g m s_wait_sampling.query_capture_mode on." lightbox="../media/3-query-capture-mode.png":::
1. Select **Save** and wait for the server parameters to update.

## View pg_stat data

1. Start Azure Data Studio.
1. Select **Connect**.

    :::image type="content" source="../media/5-connect.png" alt-text="Screenshot showing Connect icon." lightbox="../media/5-connect.png":::
1. Select your PostgreSQL server and select **Connect**.
1. Type each of the following query and select **Run**.
    ```sql
    SELECT * FROM pg_stat_activity;
    ```
1. Review the metrics that are available.
1. Leave Azure Data Studio open for the next task.

## Task 2: Examine query statistics

> [!NOTE]
> For a newly created database, there might be limited statistics, if any. If you wait for 30 minutes there will be statistics from background processes.

1. Select the **azure_sys** database.

    :::image type="content" source="../media/5-database-selector.png" alt-text="Screenshot of the database selector." lightbox="../media/5-database-selector.png":::
1. Type each of the following queries and select **Run**.
    ```sql
    SELECT * FROM query_store.query_texts_view;
    ```
    ```sql
    SELECT * FROM query_store.qs_view;
    ```
    ```sql
    SELECT * FROM query_store.runtime_stats_view;
    ```
    ```sql
    SELECT * FROM query_store.pgms_wait_sampling_view;
    ```
1. Review the metrics that are available.
1. Navigate to the Azure portal and sign in.
1. Select your Azure Database for PostgreSQL server for this exercise.
1. Select **Query Performance Insight** and review the metrics that are available.

## Task 3: Delete the PostgreSQL server

When you have completed all of the exercises, you can delete the Azure Database for PostgreSQL with the following steps:

1. In Azure Data Studio, on your Azure Database for PostgreSQL page, select **Overview**.
1. Select **Delete**.
1. Select **Skip feedback**.
1. Type the server name.
1. Select **Delete**.