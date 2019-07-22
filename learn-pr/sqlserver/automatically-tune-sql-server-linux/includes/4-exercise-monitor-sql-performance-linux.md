When you run SQL Server 2017 on a Linux server, you cannot use Windows Performance Monitor to gather and display performance counters because Performance Monitor is not supported on Linux.

Suppose you are a database administrator for a global novelty goods importer called Wide World Importers. You have migrated your customer-facing product database to a Linux server. Recently, some users have complained of slow performance.

You want to use Azure Data Studio to display SQL Server performance counters and how they vary over time.

## Start the lab

Start by logging into the database server:

<!--YAML added to connect to https://labondemand.com/AuthenticatedLaunch/46511?providerId=4 -->
1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with theusername **Administrator** and the password **Pa$$w0rdLinux**.
1. Close the Server Manager window.
1. At the top-left of the desktop, click **Applications**, click **System Tools**, and then click **Settings**.
1. Click **Network** and then click the **+** button adjacent to **Wired**.
1. In **Name**, type **Ethernet** and then in **MAC Address** box, select the **eth0** address.
1. Click **Add**, and then close **Settings**.

## Install Azure Data Studio

SQL Server 2017 is already installed on your Red Hat Enterprise Linux (RHEL) server however, you would like a Graphical User Interface (GUI) to administer it and display performance information. Install Azure Data Studio, which has already been downloaded to your computer.

1. At the top-left of the desktop, click **Applications**, click **System Tools**, and then click **Terminal**.
1. To stop the built-in package updater **packagekit**, which would block your install happening until it had finished its updates, type the following command, and then press Enter:

    ```bash
    systemctl stop packagekit
    ```

1. When prompted for the Administrator password, type **Pa$$w0rdLinux**, and press Enter.
1. To check your version of Azure Data Studio, first switch to the **Downloads** folder, by typing the following command, and then pressing Enter:

    ```bash
    cd Downloads
    ```

1. To check your version of Azure Data Studio, list the files in the **Downloads** folder, by typing the following command, and then pressing Enter:

    ```bash
    ls
    ```

1. To install Azure Data Studio, type the following command, replacing `<version>` with the file version number of the **.rpm** file in the Downloads directory, and then press Enter:

    ```bash
    sudo yum install azuredatastudio-linux-<version>.rpm
    ```

## Create stored procedures

Four stored procedures are used in this module. In this section, you will create those procedures.

1. To start Azure Data Studio type the following command in a terminal, and then press Enter:

    ```bash
    azuredatastudio
    ```

1. If you are asked to enable preview features, click **Yes** and if you are asked to allow Microsoft to collect usage data, close the dialog. In the **Connection** pane, click **Cancel**.
1. On the **File** menu, click **Open File** and then browse to the **Downloads/sqllinuxautotune** folder.
1. Click **setup.sql** and then click **Open**. Examine the contents of the script, which creates four stored procedures.
1. In the top-left of the script window, click **Run** and then in the **Connection** pane, in the **Connection type** drop-down list, select **Microsoft SQL Server**.
1. In the **Server** textbox, type **localhost** and in the **Authentication type** drop-down list, select **SQL Login**.
1. In the **User name** textbox, type **sa**, in the **Password** textbox, type **Pa$$w0rd** and then click **Connect**. Azure Data Studio connects to the server and executes the T-SQL script.

## Create a global temporary table to store the counter

You will create a global temporary table that stores the values of the **Batch Requests/sec** counter. Follow these steps:

1. In Azure Data Studio, on the **File** menu, click **Open File**.
1. Browse to the **Downloads/sqllinuxautotune** folder.
1. Click **batchrequests_perf_collector.sql** and then click **Open**. Examine the contents of the script, which creates a global temporary table that stores the way a performance counter varies over time. The script continues to populate that table with measurements of the **Batch Requests/sec** counter.
1. In the top-left of the script window, click **Run**.
1. In the **Connection** pane, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd** and then click **Connect**.

## Simulate load on the SQL Server

In order to store some meaningful measurements of the **Batch Requests/sec** counter, follow these steps:

1. On the **File** menu, click **Open File**.
1. Click **report.sql** and then click **Open**. Examine the contents of the script, which calls a stored procedure to simulate load on the SQL Server.
1. In the top-left of the script window, click **Run**.
1. In the **Connection** pane, under **Recent history** click **localhost**.
1. In the **Password** textbox, type **Pa$$w0rd** and then click **Connect**. Wait for about 20 seconds to store some data before the next step.

## Query for and display the counter

The final step is to execute a query against the temporary table that returns relevant values. You'll use a timeSeries chart to display these values in a graph:

1. On the **File** menu, click **Open File**.
1. Click **batchrequests.sql** and then click **Open**. Examine the contents of the script, which queries the global temporary table of performance data created by the **batchrequests_perf_collector.sql** script.
1. In the top-left of the script window, click **Run**.
1. In the **Connection** pane, under **Recent history** click **localhost**, in the **Password** textbox, type **Pa$$w0rd** and then click **Connect**.
1. On the right of the **RESULTS** window, click the lower icon, which displays the **CHART** window.
1. In the **Chart Type** drop-down list, select **timeSeries**. Azure Data Studio displays a graph that shows how the **Batch Requests/Sec** counter has varied over time.
1. Close **Azure Data Studio**.