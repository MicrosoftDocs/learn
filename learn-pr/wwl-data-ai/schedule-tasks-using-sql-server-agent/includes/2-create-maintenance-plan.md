Typical activities you can schedule for regular SQL Server maintenance include:

- Database and transaction log backups
- Database consistency checks
- Index maintenance
- Statistics updates

It's crucial to understand the importance of backups, as well as index and statistics maintenance, for all your databases. Database consistency checks, also known as [CHECKDB](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql?azure-portal=true) (using the command `DBCC CHECKDB`), are equally important because they are the only way to check an entire database for corruption. Depending on the size of your databases and your uptime requirements, you might perform all these activities nightly. However, in production systems, maintenance operations are often spread out over the week, as both index maintenance and consistency checks are very I/O intensive and typically done during weekend hours. 

Many DBAs stagger backups of large databases, performing one full backup a week and using differential and transaction log backups to manage recovery to a specific point in time. SQL Server offers a built-in way to manage all these tasks using Maintenance Plans. Maintenance Plans create a workflow of tasks to support your databases and are created as Integration Services packages, allowing you to schedule your maintenance activities. Additionally, many DBAs use open-source scripts for database maintenance to gain more flexibility and control over maintenance activities.

## Best practices for maintenance plans

Maintenance plans not only help you perform database maintenance but also offer options to prune data from the `msdb` database, which serves as the data store for the SQL Server Agent. Also, maintenance plans allow you to specify the removal of older database backups from disk. Removing old backup files reduces the size of your backup volume and helps manage the size of the `msdb` database.

Ensure that your backup retention period is longer than your consistency check window. For example, if you run a consistency check weekly, you should retain sufficient backup history to recover from potential corruption detected during consistency checks. Note that the backup operation does not detect corruption in a database, so it is possible to have corruption within a backup file. Maintenance plan activities are scheduled as SQL Server Agent jobs for execution.

## Create a maintenance plan

You can create a maintenance plan using SQL Server Management Studio, as shown below. In the example, multiple maintenance tasks are combined into one maintenance plan. However, the best practice is to create a separate maintenance plan for each type of task, and possibly even for specific databases on your server. For instance, you might create one maintenance plan to back up system databases and another to back up user databases. Additionally, you could have a separate maintenance plan for handling the backup of a particularly large user database. The image below and the following examples demonstrate how to create a maintenance plan using the Maintenance Plan Wizard.

:::image type="content" source="../media/module-66-automation-final-04.png" alt-text="Screenshot showing the Maintenance Plan Wizard screen.":::

The image shows the first screen of the Maintenance Plan Wizard in SQL Server Management Studio (SSMS). You need to specify a name for your maintenance plan and a run-as account. Most maintenance tasks will run as the SQL Server Agent service account, but for security purposes, some tasks may need to run as a different account. For example, if you need to back up to a file share accessible only by a specific account, you would use a proxy user, which is a component of the SQL Server Agent.

## What is a proxy account?

A proxy account is an account with stored credentials that the SQL Server Agent can use to execute specific job steps as a designated user. The login information for this user is stored as a credential in the SQL Server instance. Proxy accounts are typically used when specific job steps require very granular security rights.

Suppose you have a SQL Server Agent job that needs to back up a database to a network file share. If the SQL Server Agent service account does not have access to the file share, you can create a proxy account with the necessary permissions. This proxy account can then be used to run the backup step, ensuring it has the required access rights.

## Job schedules

Job schedules are part of the job system in the `msdb` system database. SQL Server Agent jobs and schedules have a many-to-many relationship, meaning each job can have multiple schedules, and each schedule can be assigned to multiple jobs. However, the Maintenance Plan Wizard does not allow the creation of independent schedules. Instead, it creates a specific schedule for each maintenance plan.

The following example shows the schedule for a weekly execution, but you also have the option to create a schedule with hourly or daily recurrence. 

:::image type="content" source="../media/module-66-automation-final-05.png" alt-text="Screenshot showing the job schedule in SQL Agent.":::

The next step is to select the maintenance tasks to add to the plan. The following example shows the operations available to be performed by your maintenance plan.

:::image type="content" source="../media/module-66-automation-final-06.png" alt-text="Maintenance Plan Tasks Addition Screen":::

**Check database integrity** - This task runs the `DBCC CHECKDB` command to validate the logical and physical consistency of each database page. You should perform this task regularly and align it with your backup retention window. Ensure you complete a consistency check before discarding any prior backups to prevent carrying over corruption.

**Shrink database** - This task reduces the size of a database or transaction log file by moving data into free space on pages. Once enough space is freed, it can be returned to the file system. It is recommended not to include this action in regular maintenance as it causes severe index fragmentation, harming database performance. The operation is also very I/O and CPU intensive, which can significantly impact system performance.

**Reorganize/Rebuild index** - This task checks the level of fragmentation in a database’s indexes and either rebuilds or reorganizes the index based on the user-defined fragmentation level. Rebuilding an index also updates its statistics.

**Update statistics** - This task updates the column and index statistics used by SQL Server to build query execution plans. Accurate statistics are crucial for the query optimizer to make the best decisions. You can choose which tables and indexes to scan and the percentage or number of rows to scan. The default sampling rate is usually sufficient, but you may need more detailed statistics for specific tables.

**Cleanup history** - This task deletes the history of backup and restore operations from the `msdb` database, as well as the history of SQL Server Agent jobs. It helps manage the size of the `msdb` database.

**Execute SQL Server Agent job** - This task runs a user-defined SQL Server Agent job.

**Backup Database (Full/Differential/Log)** - This task backs up databases on a SQL Server instance. A full backup captures the entire database and serves as the starting point for a restore. Differential backups capture the pages that have changed since the last full backup, providing an incremental restore point. Transaction log backups capture the active pages in your transaction log, allowing you to define your recovery point objective. Note that transaction log backups cannot be performed on databases in SIMPLE recovery mode.

For example, If you take a full backup on Sunday and a differential backup each weeknight, to restore your database to noon on Thursday, you would restore Sunday’s full backup, Wednesday’s differential backup, and the transaction log backups from Wednesday’s differential to Thursday at noon.

**Maintenance Cleanup Tasks** - This task removes old files related to maintenance plans, including text reports and backup files. It only removes backups in the specified folders, so any subfolders must be explicitly listed or they will be skipped.

Each task can be scoped to user databases, system databases, or a custom selection of databases, and each has specific configuration options.

:::image type="content" source="../media/module-66-automation-final-07.png" alt-text="Complete Maintenance Plan in SSMS":::

Upon creation, the plan will appear as a job in the SQL Server Agent. If you added a schedule either during the creation process or after, that job will be executed and the maintenance tasks will be performed.

## Multiserver environment

In a [multiserver environment](/ssms/agent/create-a-multiserver-environment?azure-portal=true), SQL Server Agent allows you to designate one server as a master server that can execute jobs on other servers, known as target servers. The master server stores a master copy of the jobs and distributes them to the target servers. Target servers periodically connect to the master server to update their job schedules. This setup enables you to define a job once and deploy it across your enterprise. For example, you can configure database maintenance tasks on the master server and push them out to a group of target servers, ensuring consistent deployment.