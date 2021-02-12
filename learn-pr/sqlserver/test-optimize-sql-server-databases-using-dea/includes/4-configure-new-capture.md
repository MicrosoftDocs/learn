Running the Database Experimentation Assistant (DEA) involves capturing events on an existing SQL Server database. These events are then replayed on the current and future versions of the database to identify any performance changes.

Now you've installed the DEA, you're ready to use it to analyze database loads in SQL Server by capturing a baseline.

In this unit, you'll see how to capture events, replay them, and capture the traces on a new version of the database.

## Configure a new capture in DEA

The DEA needs several pieces of information: the source database on which to run the capture, and two targets. These targets are used to create the baseline and make comparisons. The first target will be the backup of the database in its current form. The second target will have the single change applied to it. 

DEA captures the events on the source and then, when you run the capture against the two targets, it creates a comparison with the first target as the baseline. Ideally, the target servers should have the same or similar hardware to make the test as accurate as possible. Then, if there's a performance difference, it's the result of the change in SQL Server, not a hardware difference.

The source database backup should be taken just before you run the capture. You want to ensure that events are rerun against the database that's in as similar state to the source as possible. If you've a read-only database, such as a reporting database that needs a new index, the timing of the backup might be less critical if data is only reloaded periodically; for example, every day at midnight. However, it's best to ensure your backup is taken as close as possible to when you run the capture. In the example of the reporting database, back up the database and run the capture on the same set of data.

After taking a backup of your source database, you should restore it on the instance where you'll run the replay, to ensure the backup is valid. Then you're ready to create a new capture. Each capture requires a name and a location to store the capture file. If you run the capture on an Azure SQL Database or Azure SQL Managed Instance, you'll need the SAS URI for the Azure Blob storage account. 

You choose whether to save the file in trace or XEvents format, and select a duration from 5 minutes through to 180 minutes. DEA needs the query to have at least 30 executions on the target server, so run the capture for as long as it takes to create a large enough sample. The capture can be run on SQL Server, Azure SQL Database, or Azure SQL Managed Instance. You can connect using Windows or SQL Server authentication. Optionally, you can provide a database name to restrict the capture to a single database. If you leave the name blank, events across all databases on the instance are captured.

How long you run the capture for, and the time you choose, depends on the database load on a typical business day. Running the capture adds minimal impact to the performance of the database. As a guideline, you can expect, about 3% memory overhead. Run DEA at a time when it captures an adequate representation of the workload, so you get the best results from the replay.  

## Run a replay on a target database

When your capture is complete, you replay the events on the target servers. The target servers must be configured to run with **Distributed Replay (DReplay)** traces on. It's recommended that you restart the SQL Server service to obtain a consistent evaluation. The source database for **Target 1** should be restored with no change applied. You can then restore the same backup for **Target 2**, and make the change. For example, you might upgrade the database, or add a new columnstore index. After you replay the trace on both targets, DEA generates the analysis report.

## Key steps for configuring a new capture

Before you start, back up the source database using a tool such as **SQL Server Management Studio**.

### Create a new capture with DEA

1. In **Database Experimentation Assistant**, create a **New Capture**.
1. Give the capture file a name, set the capture format to **XEvents**, and set a **Duration (minutes)**.
1. Specify where to save the capture, set the **Server Type** to **SqlServer**, and in the **Server name** field, enter the name of the source server.
1. Set the **Authentication Type**, and provide a database name.
1. You can now start the capture. Clear the **Encrypt connection** box.
1. Use **SQL Server Management Studio**, or another tool, to run a workload on the database while the capture is in progress.
1. When the timer runs out in the **Database Experimentation Assistant**, you'll see the message **This capture trace is ready for replay**.

### Create the target databases

1. Use a tool such as **SQL Server Management Studio** to restore the original source database, as **Target_1**.
1. View the database properties to verify that the **Compatibility level** is currently set to a pre-SQL Server 2019 level, such as **SQL Server 2008 (100)**.
1. Use a tool such as **SQL Server Management Studio** to restore the original source database again, this time as **Target_2**.
1. Set the database properties to **SQL Server 2019 (150)**.

### Run the trace on the target databases

1. In the **Database Experimentation Assistant**, create a **New Replay**.
1. Enter the path to source trace files, provide a name for the replay, select **XEvents** as the source trace format, and specify a replay trace location.
1. Set the **Server Type** as **SqlServer**, and in the **Server name** field, enter the name of the source server.
1. Set the **Authentication Type**, and provide a database name.
1. You can now start the replay. When the replay completes, you'll see the message **This replay trace is ready for analysis**.
1. Select **Clone**, provide a name for this replay, select **XEvents** as the source trace format, and specify a replay trace location.
1. Provide a database name, and start this replay. When the replay completes, you'll see the message **This replay trace is ready for analysis** again.

The DEA uses Distributed Replay technology to create an A/B testing solution for applying a single change to SQL Server. An A/B test measures only one change, so you'll see the effect of applying the change. Using the DEA to test a change before it goes into production can highlight potentially adverse performance results that could negatively affect the business. The DEA might not be the right tool for an emergency fix or smaller alterations. But it's useful for planned changes such as upgrading your databases or testing a new feature.