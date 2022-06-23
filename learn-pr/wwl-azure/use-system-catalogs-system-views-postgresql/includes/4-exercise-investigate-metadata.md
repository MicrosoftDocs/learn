> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module. If you don't have an Azure subscription, you can set up a free trial account at [Build in the cloud with an Azure free account](https://azure.microsoft.com/free/).

## Create the exercise environment

### Deploy PostgreSQL server

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com).

1. Select **Create a resource**.

    :::image type="content" source="../media/create-resource.png" alt-text="Screenshot of Create a resource icon.":::
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

## Task 1: View metadata in the Azure portal

1. Navigate to [the Azure portal](https://portal.azure.com) and sign in.
1. Select **All resources**.

    :::image type="content" source="../media/4-all-resources.png" alt-text="Screenshot of All resources icon.":::
1. Select the Azure Database for PostgreSQL flexible server that you created for this exercise.
1. In **Monitoring**, select **Metrics**.

    :::image type="content" source="../media/4-metrics.png" alt-text="Screenshot of Metrics icon.":::
1. Select **Metric** and select **CPU percent**.
    :::image type="content" source="../media/4-processor-percent.png" alt-text="Screenshot showing Metric selection." lightbox="../media/4-processor-percent.png":::
1. Take note that you can view various metrics about your databases.

## Task 2: View data in system catalog tables

1. Switch to Azure Data Studio.
1. In **SERVERS**, select your PostgreSQL server and wait until a connection is made and a green circle is displayed on the server.

    :::image type="content" source="../media/4-connection.png" alt-text="Screenshot of connected server.":::
1. Right-click the server and select **New Query**.
1. Type the following SQL and select **Run**:
    ```sql
    SELECT datname, xact_commit, xact_rollback FROM pg_stat_database;
    ```
1. Take note that you can view commits and rollbacks for each database.

## Task 3: View a complex metadata query using a system view

1. Right-click the server and select **New Query**.
1. Type the following SQL and select **Run**:
    ```sql
    SELECT *
    FROM pg_catalog.pg_stats;
    ```
1. Take note that you can view a large amount of statistics information.
1. By using system views, you can reduce the complexity of the SQL that you need to write. The previous query would need the following code if you weren't using the **pg_stats** view:
    ```sql
    SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    a.attname,
    s.stainherit AS inherited,
    s.stanullfrac AS null_frac,
    s.stawidth AS avg_width,
    s.stadistinct AS n_distinct,
        CASE
            WHEN s.stakind1 = 1 THEN s.stavalues1
            WHEN s.stakind2 = 1 THEN s.stavalues2
            WHEN s.stakind3 = 1 THEN s.stavalues3
            WHEN s.stakind4 = 1 THEN s.stavalues4
            WHEN s.stakind5 = 1 THEN s.stavalues5
            ELSE NULL::anyarray
        END AS most_common_vals,
        CASE
            WHEN s.stakind1 = 1 THEN s.stanumbers1
            WHEN s.stakind2 = 1 THEN s.stanumbers2
            WHEN s.stakind3 = 1 THEN s.stanumbers3
            WHEN s.stakind4 = 1 THEN s.stanumbers4
            WHEN s.stakind5 = 1 THEN s.stanumbers5
            ELSE NULL::real[]
        END AS most_common_freqs,
        CASE
            WHEN s.stakind1 = 2 THEN s.stavalues1
            WHEN s.stakind2 = 2 THEN s.stavalues2
            WHEN s.stakind3 = 2 THEN s.stavalues3
            WHEN s.stakind4 = 2 THEN s.stavalues4
            WHEN s.stakind5 = 2 THEN s.stavalues5
            ELSE NULL::anyarray
        END AS histogram_bounds,
        CASE
            WHEN s.stakind1 = 3 THEN s.stanumbers1[1]
            WHEN s.stakind2 = 3 THEN s.stanumbers2[1]
            WHEN s.stakind3 = 3 THEN s.stanumbers3[1]
            WHEN s.stakind4 = 3 THEN s.stanumbers4[1]
            WHEN s.stakind5 = 3 THEN s.stanumbers5[1]
            ELSE NULL::real
        END AS correlation,
        CASE
            WHEN s.stakind1 = 4 THEN s.stavalues1
            WHEN s.stakind2 = 4 THEN s.stavalues2
            WHEN s.stakind3 = 4 THEN s.stavalues3
            WHEN s.stakind4 = 4 THEN s.stavalues4
            WHEN s.stakind5 = 4 THEN s.stavalues5
            ELSE NULL::anyarray
        END AS most_common_elems,
        CASE
            WHEN s.stakind1 = 4 THEN s.stanumbers1
            WHEN s.stakind2 = 4 THEN s.stanumbers2
            WHEN s.stakind3 = 4 THEN s.stanumbers3
            WHEN s.stakind4 = 4 THEN s.stanumbers4
            WHEN s.stakind5 = 4 THEN s.stanumbers5
            ELSE NULL::real[]
        END AS most_common_elem_freqs,
        CASE
            WHEN s.stakind1 = 5 THEN s.stanumbers1
            WHEN s.stakind2 = 5 THEN s.stanumbers2
            WHEN s.stakind3 = 5 THEN s.stanumbers3
            WHEN s.stakind4 = 5 THEN s.stanumbers4
            WHEN s.stakind5 = 5 THEN s.stanumbers5
            ELSE NULL::real[]
        END AS elem_count_histogram
    FROM pg_statistic s
     JOIN pg_class c ON c.oid = s.starelid
     JOIN pg_attribute a ON c.oid = a.attrelid AND a.attnum = s.staattnum
     LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE NOT a.attisdropped AND has_column_privilege(c.oid, a.attnum, 'select'::text) AND (c.relrowsecurity = false OR NOT row_security_active(c.oid));
    ```

## Task 4: Delete the PostgreSQL server

When you've completed all of the tasks in the exercise, you can stop the PostgreSQL server.

1. In the Azure portal, select your PostgreSQL server and select **Overview**.
1. Select **Stop**.

    :::image type="content" source="../media/4-stop-server.png" alt-text="Screenshot of the Stop icon." lightbox="../media/4-stop-server.png":::
