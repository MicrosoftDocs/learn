Now that you can monitor SQL Server performance counters by using Azure Data Studio, you want to use it to identify and correct query plans choice regressions.

You want to evaluate using the query store to identify query plan regressions and obtain recommended scripts to correct them. Also, you want to evaluate the possibility of using automatic tuning to correct those problems.

## Start Azure Data Studio

If you logged out of the VM, start this exercise by logging on and starting Azure Data Studio:

1. Sign into the VM with your Microsoft account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with the username **Administrator** and the password **Pa$$w0rdLinux**.
1. Close the **Server Manager** window.
1. At the top-left of the desktop, click **Applications**, click **System Tools**, and then click **Terminal**.
1. Type **azuredatastudio** and then press Enter.

## Initialize the exercise

Now, run a SQL script that sets up the necessary resources for the lab:

1. In **Azure Data Studio**, on the **File** menu, click **Open File** and then browse to the **Downloads/sqllinuxautotune** folder.
1. Click **initialize.sql** and then click **Open**. This script ensures that the query store is empty and that auto tuning is disabled.
1. In the top-left of the script window, click **Run** and then in the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**. Azure Data Studio executes the script.

## Start monitoring performance

Before you create and observe a query plan regression problem, you must ensure that Azure Data Studio is collecting performance data. Following these steps:

1. In **Azure Data Studio**, make sure the following scripts are open. They may be open from the previous exercise unit:

    - **batchrequests_perf_collector.sql**
    - **report.sql**
    - **batchrequests.sql**

1. Switch to the **batchrequests_perf_collector.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. Switch to the **report.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**. Wait for about 20 seconds to store some data before the next step.

## View performance

You can now query the temporary table for performance data, as you did in the last exercise. You can consider this data as a baseline of performance before any regression problem arises.

1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. On the right of the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time before any query plan regression problem.

> [!NOTE]
> Do not halt the execution of **batchrequests_perf_collector.sql** or **report.sql**.

## Create a query plan regression problem

Now let's execute a script that creates a query plan regression problem. Follow these steps:

1. In **Azure Data Studio**, on the **File** menu, click **Open File** and then browse to the **Downloads/sqllinuxautotune** folder.
1. Click **regression.sql** and then click **Open**. Examine the contents of the script, which executes the **regression** stored procedure to create a query plan regression problem.
1. In the top-left of the script window, click **Run** and then in the **Connection** window, under **Recent history**, click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. On the right on the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time. You should observe a drop in performance.

> [!NOTE]
> If you do not observe a drop in performance, re-execute **regression.sql** and **batchrequests.sql** until the regression is produced.

## Get recommendations from the Query Store

Because the query store is enabled, SQL Server 2017 gathers information about the regression problem that you have created. To view this information, follow these steps:

1. In **Azure Data Studio**, on the **File** menu, click **Open File** and then browse to the **Downloads/sqllinuxautotune** folder.
1. Click **recommendations.sql** and then click **Open**. Examine the contents of the script, which queries the Query Store to obtain tuning recommendations.
1. In the top-left of the script window, click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. In the **RESULTS** window, notice that:
    - The **reason** column describes the observed problem.
    - The **state_transition_reason** column shows that automatic tuning is not enabled.
    - The **script** column contains a T-SQL script that you could execute to fix the regression problem. This script forces the last known good query plan to be used.
1. Close Azure Data Studio.

## Enable automatic tuning

By executing the recommended script that you obtained from the query store, you can manually fix any regression problems that develop. However, by enabling automatic tuning, you can configure SQL Server to apply such fixes automatically. Follow these steps:

1. In the **Terminal** type **azuredatastudio** and then press Enter.
1. In **Azure Data Studio**, on the **File** menu, click **Open File**.
1. Browse to the **Downloads/sqllinuxautotune** folder.
1. Click **auto_tune.sql** and then click **Open**. Examine the contents of the script, which calls the **auto_tune** stored procedure to enable automatic tuning on the current database.
1. In the top-left of the script window, click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.

## Recreate a query plan regression problem

Now that automatic tuning is enabled, you can test it by recreating the regression problem and observing how performance varies. Follow these steps:

1. In **Azure Data Studio**, switch to the **batchrequests_perf_collector.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. Switch to the **report.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. Wait for about 20 seconds to store some data before the next step. Then switch to the **regression.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. Wait for a further 10 seconds.

## View the results

You can now use Azure Data Studio to view the effects of a query plan regression that occurs when automatic tuning is enabled:

1. Switch to the **batchrequests.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. On the right on the **RESULTS** window, click the lower icon, which displays the **CHART VIEWER** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time. You should observe a drop in performance followed by an increase as SQL Server automatically resolved the regression.
1. Switch to the **recommendations.sql** tab, and then click **Run**.
1. In the **Connection** window, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd**, and then click **Connect**.
1. In the **RESULTS** window, notice that:
    - The **reason** column describes the observed problem.
    - The **state_transition_reason** column shows that the last known good query plan was forced to fix the regression problem.
    - The **script** column contains the T-SQL script that SQL Server executed to fix the regression problem.
