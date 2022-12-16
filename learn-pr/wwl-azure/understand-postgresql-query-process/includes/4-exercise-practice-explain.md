> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Before you start

1. You have installed and started Azure Database for PostgreSQL flexible server.
1. You have installed Azure Data Studio.
1. Download the lab scripts from [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
1. Open Azure Data Studio and connect to your Azure Database for PostgreSQL flexible server.
1. If you haven't yet created the zoodb, select **File**, **Open file** and navigate to the folder where you saved the scripts. Select **Lab2_ZooDb.sql** and **Open**. Run the script.

## Practice EXPLAIN ANALYZE

1. In the [Azure portal](https://portal.azure.com), navigate to your Azure Database for PostgreSQL flexible server. Check the server is started or restart it if necessary.
1. Open Azure Data Studio and connect to your Azure Database for PostgreSQL flexible server.
1. Select **File**, **Open File**, and navigate to the folder where you saved the scripts. Open **RepopulateZoo.sql**. Reconnect to the server if necessary.
1. Select **Run** to execute the query. This repopulates the zoodb database.
1. Select File, **Open File**, and select **Lab3_explain.sql**.
1. In the section **1. Investigate EXPLAIN ANALYZE** highlight and run Statement A and Statement B separately. Which statement updated the database, and why? How many milliseconds did it take to plan Statement A? What was the execution time for Statement B?

## Practice EXPLAIN

1. In the section **2. Investigate EXPLAIN** highlight and run that statement. What sort key was used, and why?
1. In Section **3. Investigate EXPLAIN options** highlight and run each statement separately. Compare the query plan statistics for each option.
