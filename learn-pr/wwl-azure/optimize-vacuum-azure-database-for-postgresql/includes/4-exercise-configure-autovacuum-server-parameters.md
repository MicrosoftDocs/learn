> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Before you start

1. You have installed and started Azure Database for PostgreSQL flexible server.
1. You have installed Azure Data Studio.
1. Download the lab scripts from [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
1. Open Azure Data Studio and connect to your Azure Database for PostgreSQL flexible server.
1. If you haven't yet created the zoodb, select **File**, **Open file** and navigate to the folder where you saved the scripts. Select **Lab2_ZooDb.sql** and **Open**. Run the script.

## Practice EXPLAIN ANALYZE

1. In the Azure portal, navigate to your Azure Database for PostgreSQL flexible server. Check the server is started. If necessary, start the server.
1. Open Azure Data Studio.
1. Either navigate to the folder with your exercise script files, or download the **Lab9_vacuum.sql** from [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
1. Select File, **Open File**, and select **Lab9_vacuum.sql**.Connect to your Azure Database for PostgreSQL flexible server.
1. Highlight and run the section **Check zoodb database is selected**. If necessary, make zoodb the current database using the drop-down list.
1. Highlight and run the section **Display dead tuples**. This query displays the number of dead and live tuples in the database. Make a note of the number of dead tuples.
1. Highlight and run the section **Change weight** several times. This query updates the weight column for all the animals.
1. Run the section under **Display dead tuples** again. Make a note of the number of dead tuples after the updates have been done.
1. Run the section under **Manually run VACUUM** to run the vacuum process.
1. Run the section under **Display dead tuples** again. Make a note of the number of dead tuples after the vacuum process has been run.

## Configure autovacuum server parameters

1. In the Azure portal, navigate to your Azure Database for PostgreSQL flexible server.
1. Under **Settings**, select **Server parameters**.
1. In the search bar, type **vacuum**. Find the following parameters, and change the values as follows:
    1. autovacuum = ON (it should be ON by default)
    1. autovacuum_vacuum_scale_factor = 0.1
    1. autovacuum_vacuum_threshold = 50

    This is like running the autovacuum process when 10% of a table has rows marked for deletion, or 50 rows updated or deleted in any one table.

1. Select **Save**. The server is restarted.

In the Azure portal, STOP your PostgreSQL server to avoid being charged when you aren't using it.