Typical activities that you can schedule for regular SQL Server maintenance include:

- Database and transaction log backups
- Database Consistency Checks
- Index maintenance
- Statistics updates

You should be aware of the importance of backups, as well as index and statistics maintenance, for all your databases. Database consistency checks, also known as CHECKDB (for the command DBCC CHECKDB) are of equal importance, as it is the only way to check an entire database for corruption. Depending on the size of your databases and your uptime requirements, you may perform all of these activities nightly. More commonly in production systems, the maintenance operations are spread out over the course of week, as both index maintenance and consistency checks are very I/O intensive operations and they are typically done during weekend hours. Similarly, many DBAs stagger backups of large databases, and only do one full backup a week. Differential and transaction log backups can then be used to manage recovery to a specific point in time. SQL Server offers a built-in way to manage all of these tasks using Maintenance Plans. Maintenance plans create a workflow of the tasks to support your databases. Maintenance plans are created as Integration Services packages, which allow you to schedule your maintenance activities. Many DBAs also use open-source scripts to perform database maintenance, to allow for more flexibility and control of maintenance activities.

## Best practices for maintenance plans

In addition to allowing you to performance database maintenance, maintenance plans provide options to allow you to prune data from the `msdb` database, which acts as the data store for the SQL Server Agent. Maintenance plans also allow you to specify that older database backups should be removed from disk. Removing old backup files helps your SQL Server by reducing the size of your backup volume and helps manage the size of the `msdb` database. Ensure that your backup retention period is longer than your consistency check window. This means if you run a consistency check weekly, you should retain eight days of backups. (Note: The backup operation will not detect corruption in a database, so it is possible to have corruption within a backup file). Maintenance plan activities are scheduled as SQL Server Agent jobs for execution.

## Creating a maintenance plan

You can create a maintenance plan using SQL Server Management Studio as shown below. Note that in the example below, multiple maintenance tasks are combined in one maintenance plan. The best practice would be to create a maintenance plan for each type of task—and possibly even for a specific database on your server. For example, you might create a maintenance plan to back up system databases and another maintenance plan to back up user databases. You could also have another maintenance plan for special handling of the backup of one very large user database. The image below and the following examples show the creation a maintenance plan using the maintenance plan wizard.

:::image type="content" source="../media/module-66-automation-final-04.png" alt-text="Maintenance Plan Wizard":::

The image above shows the first screen of the maintenance plan wizard from SQL Server Management Studio (SSMS). There are a couple of things you should note — you need to specify a name for your maintenance plan, and you need to specify a run-as account. Typically, most maintenance operations will run as the SQL Server Agent service account, but you may need to have a task run as a different account for security purposes. For example, if you need to back up to a file share that only a specific account has access to, you would need to run that specific plan as a different user. This concept is known a proxy user and is another component of the SQL Server Agent.

## What is a proxy account?

A proxy account is an account with stored credentials that can be used by the SQL Server Agent to execute steps of a job as a specific user. The login information for this user as stored as a credential in the SQL Server instance. Proxy accounts are typically used when very granular security rights are needed for specific steps of a SQL agent job.

## Job schedules

Job schedules are a component of the job system in the `msdb` system database. SQL Server Agent jobs and schedules have a many-to-many relationship. Each job can contain multiple schedules, and the same schedule can be assigned to multiple jobs. The maintenance plan wizard, however, does not allow creation of independent schedules. It creates a specific schedule for each maintenance plan, as shown below:

:::image type="content" source="../media/module-66-automation-final-05.png" alt-text="Job Schedule Creation in Maintenance Plan Wizard":::

The above schedule is for a weekly execution, but you also have the option to create a schedule with hourly or daily recurrence. The next step in this process is to add maintenance tasks to the plan.

:::image type="content" source="../media/module-66-automation-final-06.png" alt-text="Maintenance Plan Tasks Addition Screen":::

The image above shows the maintenance tasks addition screen. This is where you choose the operations to be performed by your maintenance plan. The options are:

**Check Database integrity** - This task executes the DBCC CHECKDB command, which validates the contents of each database page to ensure its logical and physical consistency. This task should be performed on a regular basis (daily or weekly), and it should align to your backup retention window. To ensure corruption is not carried over to your backups, make sure you are successfully completing a consistency check before discarding any prior backups.

**Shrink Database** -  This task reduces the size of database or transaction log file by moving data into free space on pages. When enough space is consumed, the free space can be returned to the file system.

> [!NOTE]
> It is recommended that you never execute this action as part of any regular maintenance as it leads to severe index fragmentation which can harm database performance. The operation itself is also very I/O and CPU intensive and can severely impact your system performance.

**Reorganize/Rebuild Index** - This task will check the level of fragmentation in a database’s indexes, and may either rebuild or reorganize the index based on the user-defined level of fragmentation. Note that rebuilding an index updates the statistics on the index.

**Update Statistics** - This task updates the column and index statistics that are used by SQL Server to build query execution plans. It is important that the statistics accurately reflect the data stored in tables so that the query optimizer can make the best decisions in building execution plans. This task allows you to choose which tables and indexes are scanned, and the percentage or number of rows scanned. The default sampling rate is acceptable for most objects, though you may wish to capture more detailed statistics for specific tables.

**Cleanup History** - This task deletes history of backup and restore operations from the `msdb` database as well the history of SQL Server agent jobs. This task is used to manage the size of the `msdb` database.

**Execute SQL Server Agent Job** - This task is used to execute a user-defined SQL Server Agent job.

**Backup Database (Full/Differential/Log)** - This task is used to back up databases on a SQL Server instance. A full backup backs up the entire database, and serves as the starting point for a restore (you need a full backup in order to completely restore a database). Differential backups backup the pages in the database that have changed since the last full backup, and are typically used to provide an incremental restore point. Transaction log backups backup the active pages in your transaction log, and allow you to define your recovery point objective. Transaction log backups cannot be performed on databases in SIMPLE recovery mode.

Here’s an example of the use of different kinds of backups: If you took a full backup on Sunday, and a differential each week night, and you wanted to restore to your database to noon on Thursday, you would only need to restore Sunday’s full backup and Wednesday’s differential, followed by the transaction log backups from the point of Wednesday’s differential backup until Thursday at noon. 

**Maintenance Cleanup Tasks** - This task removes old files related to maintenance plans, including text reports from maintenance plan execution, and backup files. It only removes backups on files in the folders specified, so any subfolders must be specifically listed or they will be skipped.

Each task has a scope of user databases, system databases, or a custom selection of databases. Additionally, each task has its own specific configuration options.

Once you finish creating the Maintenance Plan, you will be presented with the details of the entire plan. You can get back to this view in SQL Server Management Studio by expanding the Management node, then expanding the Maintenance Plans node, right-clicking on this Maintenance Plan and selecting Modify.

:::image type="content" source="../media/module-66-automation-final-07.png" alt-text="Complete Maintenance Plan in SSMS":::

Upon creation, the plan will appear as a job in the SQL Server Agent. If you added a schedule either during the creation process or after, that job will be executed and the maintenance tasks will be performed.

## Multi-server automation

In a multi-server environment, the SQL Server Agent provides the option of designating one server as a master server that can execute jobs on other servers, designated as target servers. The master server stores a master copy of the jobs and distributes the jobs to the target servers. Target servers connect to the master server periodically to update their schedule of jobs. This allows you to define one job and deploy it across your enterprise. A good example of this would be configuring database maintenance across your environment. You could create a set of maintenance plan tasks once and allow them to be pushed out to group of target servers, to ensure consistent deployment.
