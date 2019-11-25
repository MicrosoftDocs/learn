Running the Database Experimentation Assistant involves capturing events on an existing SQL Server database. These events can then be replayed on the current, and future versions, of the database to identify any performance changes.

Now that you've installed the DEA, you're ready to use it to analyze database loads in SQL Server by capturing a baseline.

In this unit, you'll see how to capture events, replay those events, and capture the traces on a new version of the database.

## Configure a new capture in DEA

The Database Experimentation Assistant needs several pieces of information; the source database on which to run the capture, and two targets. The two targets are used to create the baseline and make comparisons. The first target will be the backup of the database in its current form; the second target will have the single change applied to it. DEA will capture the events on the source and then, when you run the capture against the two targets, DEA can create a comparison with the first target being the baseline. Ideally, the target servers should have the same or similar hardware to make the test as accurate as possible. This ensures if there's a performance difference, it's the result of the change in SQL Server and not a hardware difference.

The backup of the source database should be taken just before you run the capture, as you want to ensure that events are rerun against the database that is in as similar state to the source as possible. If you have a read-only database, such as a reporting database that needs a new index, the timing of the backup may be less critical if data is only reloaded periodically (for example, every day at midnight). However, it's best practice to ensure your backup is taken as close as possible to when you run the capture, so in the example of the reporting database, backup the database and run the capture on the same set of data.

After taking a backup of your source database, you should restore it on the instance where you'll run the replay, to ensure the backup is valid. Then you're ready to create a new capture. Each capture requires a name and a location to store the capture file. If you run the capture on an Azure SQL Database or Azure SQL Managed Instance, you'll need the SAS URI for the Azure blob storage account. You can choose whether to save the file in trace or XEvents format, and select a duration from 5 minutes through to 180 minutes. Keep in mind that DEA needs the query to have at least 30 executions on the target server, so run the capture long enough to create a large enough sample. The capture can be run on SQL Server, Azure SQL Database, or Azure SQL Managed Instance, and you can connect using Windows or SQL Server authentication. Optionally, you can provide a database name to restrict the capture to a single database, or if left blank, events across all databases on the instance are captured.

How long you decide to run the capture for, and the time of day you choose, will depend on the load on the database throughout a typical business day. Running the capture adds minimal impact to the performance of the database, and you can expect, as a guideline, about 3% memory overhead. DEA needs to be run at a time when it can capture an adequate representation of the workload, so that you get the best results from the replay.  

## Run a replay on a target database

When your capture is complete, you can then replay the events on the target servers. The target servers must be configured to run with **Distributed Replay (DReplay)** traces on. It's recommended that you restart the SQL Server service to obtain a consistent evaluation. The source database for **Target 1** should be restored with no change applied. You can then restore the same backup for **Target 2**, and make the change; for example, upgrade the database, or add a new columnstore index. After you replay the trace on both targets, DEA can then generate the analysis report.

## Key steps for configuring a new capture

Before you start, back up the source database using a tool such as **SQL Server Management Studio**.

### Create a new capture with DEA

1. In **Database Experimentation Assistant**, create a **New Capture**.
1. Give the capture file a name, set the capture format to **XEvents**, and set a **Duration (minutes)**.
1. Specify where to save the capture, set the **Server Type** to **SqlServer**, and in the **Server name** field, enter the name of the source server.
1. Set the **Authentication Type**, and provide a database name.
1. You can now start the capture. Uncheck the **Encrypt connection** box.
1. Use **SQL Server Management Studio**, or other tool, to run a workload on the database while the capture is in progress.
1. When the timer runs out in the **Database Experimentation Assistant**, you'll see the message **This capture trace is ready for replay**.

### Create the target databases

1. Use a tool such as **SQL Server Management Studio** to restore the original source database, as **Target_1**.
1. View the database properties to verify that the **Compatibility level** is currently set to a pre-SQL Server 2017 level, such as **SQL Server 2008 (100)**.
1. Use a tool such as **SQL Server Management Studio** to restore the original source database again, this time as **Target_2**.
1. Set the database properties to **SQL Server 2017 (140)**.

### Run the trace on the target databases

1. In the **Database Experimentation Assistant**, create a **New Replay**.
1. Enter the path to source trace files, provide a name for the replay, select **XEvents** as the source trace format, and specify a replay trace location.
1. Set the **Server Type** as **SqlServer**, and in the **Server name** field, enter the name of the source server.
1. Set the **Authentication Type**, and provide a database name.
1. You can now start the replay. When the replay has completed, you'll see the message **This replay trace is ready for analysis**.
1. Select **Clone**, provide a name for this replay, select **XEvents** as the source trace format, and specify a replay trace location.
1. Provide a database name, and start this replay. When this replay has completed, you'll again see the message **This replay trace is ready for analysis**.

## Summary

The Database Experimentation Assistant leverages Distributed Replay technology to create an A/B testing solution for applying a single change to SQL Server. An A/B test measures only one change, enabling you see the effect of applying the change. Using the DEA to test a change before it goes into production can highlight potentially adverse performance results, that could negatively impact the business. While it may not be the right tool for an emergency fix or smaller alterations, it is useful for planned changes such as upgrading your databases or testing a new feature.
