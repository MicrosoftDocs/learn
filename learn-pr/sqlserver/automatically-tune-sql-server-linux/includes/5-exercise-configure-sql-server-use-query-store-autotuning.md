Now that you can monitor SQL Server performance counters by using Azure Data Studio, you want to use it to identify and correct query plans choice regressions.

You need to evaluate using the Query Store to identify query plan regressions and obtain recommended scripts to correct them. Also, you want to evaluate the possibility of using automatic tuning to correct those problems.

## Reconnect to the virtual machine

If you've closed your RDP connection to the Ubuntu SQL Server, reconnect it now:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the left menu, select **Virtual machines**, and then select your Ubuntu virtual machine.
1. In the **Overview** page, select **Connect**, and then select **RDP**.
1. Click **Download RDP File**, and open the file with your RDP client.
1. If you're warned that the publisher can't be identified, click **Connect**. If you're warned that the identity of the remote computer can't be verified, click **Yes**.
1. Log in to the Ubuntu server with the username **ubuntuadmin** and the password that you recorded in the last exercise.
1. In the top-left corner, select **Applications**, point to **Development**, and then select **Azure Data Studio**.

## Initialize the exercise

Now run a SQL script that sets up the necessary resources for the lab:

1. In **Azure Data Studio**, on the **File** menu, click **Open File**, and then browse to the ****~/mslearn-automatically-tune-sql-server-linux/**** folder.
1. Click **initialize.sql**, and then click **Open**. This script ensures that the Query Store is empty and that auto tuning is disabled.
1. In the top-left of the script window, click **Run**. Azure Data Studio executes the script.

## Start monitoring performance

Before you create and observe a query plan regression problem, you must ensure that Azure Data Studio is collecting performance data. Follow these steps:

1. In **Azure Data Studio**, make sure the following scripts are open. They might be open from the previous exercise unit:

    - **batchrequests_perf_collector.sql**
    - **report.sql**
    - **batchrequests.sql**

1. Switch to the **batchrequests_perf_collector.sql** tab, and then click **Run**.
1. Switch to the **report.sql** tab, and then click **Run**. Wait for about 20 seconds to store some data before the next step.

## View performance

You can now query the temporary table for performance data, as you did in the last exercise. You can consider this data as a baseline of performance before any regression problem arises.

1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. On the right of the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time before any query plan regression problem.

> [!NOTE]
> Do not halt the execution of **batchrequests_perf_collector.sql** or **report.sql**.

## Create a query plan regression problem

Now you'll execute a script that creates a query plan regression problem. Follow these steps:

1. In **Azure Data Studio**, on the **File** menu, click **Open File** and then browse to the **~/mslearn-automatically-tune-sql-server-linux/** folder.
1. Click **regression.sql**, and then click **Open**. Examine the contents of the script, which executes the **regression** stored procedure to create a query plan regression problem.
1. In the top-left of the script window, click **Run**.
1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. On the right, on the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time. You should observe a drop in performance.

> [!NOTE]
> If you don't observe a drop in performance, re-execute **regression.sql** and **batchrequests.sql** until the regression is produced.

## Get recommendations from the Query Store

Because the Query Store is enabled, SQL Server 2019 gathers information about the regression problem that you've created. To view this information, follow these steps:

1. In **Azure Data Studio**, on the **File** menu, click **Open File**, and then browse to the **~/mslearn-automatically-tune-sql-server-linux/** folder.
1. Click **recommendations.sql**, and then click **Open**. Examine the contents of the script, which queries the Query Store to obtain tuning recommendations.
1. In the top-left of the script window, click **Run**.
1. In the **RESULTS** window, notice that:
    - The **reason** column describes the observed problem.
    - The **state_transition_reason** column shows that automatic tuning isn't enabled.
    - The **script** column contains a T-SQL script that you could execute to fix the regression problem. This script forces the last known good query plan to be used.

## Enable automatic tuning

By executing the recommended script that you obtained from the Query Store, you can manually fix any regression problems that develop. However, by enabling automatic tuning, you configure SQL Server to apply such fixes automatically. Follow these steps:

1. In **Azure Data Studio**, on the **File** menu, click **Open File**.
1. Browse to the **~/mslearn-automatically-tune-sql-server-linux/** folder.
1. Click **auto_tune.sql**, and then click **Open**. Examine the contents of the script, which calls the **auto_tune** stored procedure to enable automatic tuning on the current database.
1. In the top-left of the script window, click **Run**.

## Recreate a query plan regression problem

Now that automatic tuning is enabled, you can test it by recreating the regression problem and observing how performance varies. Follow these steps:

1. In **Azure Data Studio**, switch to the **batchrequests_perf_collector.sql** tab, and then click **Run**.
1. Switch to the **report.sql** tab, and then click **Run**.
1. Wait for about 20 seconds to store some data before the next step. Switch to the **regression.sql** tab, and then click **Run**.
1. Wait for a further 10 seconds.

## View the results

You can now use Azure Data Studio to view the effects of a query plan regression that occurs when automatic tuning is enabled:

1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. On the right, on the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time. You should observe a drop in performance followed by an increase as SQL Server automatically resolves the regression.
1. Switch to the **recommendations.sql** tab, and then click **Run**.
1. In the **RESULTS** window, notice that:
    - The **reason** column describes the observed problem
    - The **state_transition_reason** column shows that the last known good query plan was forced to fix the regression problem
    - The **script** column contains the T-SQL script that SQL Server executed to fix the regression problem
