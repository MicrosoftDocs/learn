You've upgraded several CRM databases to SQL Server 2019, and you're using a staging area to identify any performance issues before you deploy to the production platform. You're using the Microsoft Database Experimentation Assistant (DEA) to help with this task.

In this exercise, you'll configure a new capture using DEA. You'll run a workload on a SQL Server 2008R2 database, then replay this capture against a SQL Server 2019 database.

## Back up the source database

The first step is to create a backup of your source database. Follow these steps:

1. On the **Start** menu, type **ssms**, then select **Microsoft SQL Server Management Studio 18**.
1. In the **Connect to Server** window, leave **Authentication** selection as **Windows Authentication**. Select **Connect**.
1. In **Object Explorer**, select **Databases** to expand the tree.
1. Right-click **AdventureWorks2008R2**, select **Tasks**, and then select **Back Up...**.
1. In the **Back Up Database - AdventureWorks2008R2** window, under **Back up to:**, select **Remove...**.
1. Select **Add...**, and in the **Select Backup Destination** window, in the **File name** field, type **C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\AWBackup.bak**.
1. Select **OK** in the window.
1. Select **OK** to start the backup.
1. When you see the message, **The backup of database 'AdventureWorks2008R2' completed successfully.**, select **OK**.

## Create a new capture with DEA

Now use DEA to create a baseline capture of database events.

1. In **SQL Server Management Studio**, select **File**, **Open**, then **File**. Go to **Windows (C:)**, and then select **create-workload-on-adventureworks.sql**. Select **Open**, to open the workload file.
1. Select **Start**, type **Database Experimentation Assistant**, and then select **Database Experimentation Assistant**.
1. When DEA has opened, select the **Capture traces** camera icon on the left. Select **+ New Capture**.
1. In the **Capture name** field, type `AdventureWorksTrace`. Leave the **Format** set to **XEvents**, and **Duration (minutes)** set to **5**.
1. In the **Capture Location** field, type **C:\\capture**.
1. Tick the **Yes, I have manually taken the backup of the target databases(s)** box.
1. Leave the **Server Type** selection as **SqlServer**, and in the **Server name** field, type `localhost`.
1. Check the **Authentication Type** is **Windows**, and in the **Database name (optional)** field, type `AdventureWorks2008R2`.
1. Clear the **Encrypt connection** box.
1. The **Start** button should now be enabled. If you can't resize the window to see the button, press **Enter** to start the capture. You'll see the capture details page, and the countdown timer.
1. Return to **SQL Server Management Studio**, and the workload file. Select **Execute** and leave to run. If the timer in the **Database Experimentation Assistant** stops before the workload script has completed, select **Cancel Executing Query**.
1. Close the query window without saving.
1. When the timer runs out in the **Database Experimentation Assistant**, you'll see the message **This capture trace is ready for replay**.
1. Leave the **Database Experimentation Assistant** window open.

## Create the Target 1 database

The next step is to restore your database backup as "Target 1", with SQL Server 2008 compatibility level.

1. In **SQL Server Management Studio**, in **Object Explorer**, right-select **Databases**, and select **Restore Database...**.
1. When the **Restore Database** window appears, select **Device**, and then select the browse **...** button.
1. In the **Select backup devices** window, select **Add**.
1. In the **Locate Backup File** window, go to **C:\\Program Files\\Microsoft SQL Server\\MSSQL15.MSSQLSERVER\\MSSQL\\Backup\\**, and select **AWBackup.bak**. Select **OK**.
1. You're now returned to the **Select backup devices** window. Select **OK**.
1. In the **Restore Database** window, you should now see a status of **Ready** in the top-left corner.
1. Under **Destination**, in the **Database** field, type `Target_1`.
1. From the **Select a page** tab, select **Files**. Select **Relocate all files to folder**. 
1. Select the **...** button next to the **AdventureWorks2008R2_Data** row, then in the **Locate Database Files - SQL2019Server** window, type **Target_1.mdf** in the **File name** field. Select **OK**.
1. Select **OK**.
1. When you see the message **Database 'Target_1' restored successfully.**, select **OK** to return to Management Studio.
1. In **Object Explorer**, under **Databases**, right-select **Target_1**, and select **Properties**.
1. In the **Database Properties - Target_1**, from the **Select a page** tab, select **Options**.
1. Notice the **Compatibility level**. This level should be set to **SQL Server 2008 (100)**. Select **Cancel** to close the window.

## Create the Target 2 database

Next, restore your database backup again, this time as "Target 2", with SQL Server 2019 compatibility level.

1. In **Object Explorer**, right-select **Databases**, and select **Restore Database...**.
1. When the **Restore Database** window appears, select **Device**, and then select the browse **...** button.
1. In the **Select backup devices** window, select **Add**.
1. In the **Locate Backup File** window, go to **C:\\Program Files\\Microsoft SQL Server\\MSSQL15.MSSQLSERVER\\MSSQL\\Backup\\**, and select **AWBackup.bak**. Select **OK**.
1. You're now returned to the **Select backup devices** window. Select **OK**.
1. In the **Restore Database** window, you should now see a status of **Ready** in the top-left corner.
1. Under **Destination**, in the **Database** field, type `Target_2`.
1. From the **Select a page** tab, select **Files**. Select **Relocate all files to folder**, then select **OK**.
1. Select the **...** button next to the **AdventureWorks2008R2_Data** row, then in the **Locate Database Files - SQL2019Server** window, type **Target_2.mdf** in the **File name** field. Select **OK**.
1. Select **OK**.
1. When you see the message **Database 'Target_2' restored successfully**, select **OK** to return to Management Studio.
1. In **Object Explorer**, under **Databases**, right-select **Target_2**, and select **Properties**.
1. In the **Database Properties - Target_2**, from the **Select a page** tab, select **Options**. In the **Compatibility level** select list, choose **SQL Server 2019 (150)**. Select **OK**.

## Run the trace on Target 1 and Target 2 databases

Now run the trace files from your DEA capture against both the Target 1 and Target 2 databases.

1. Return to **Database Experimentation Assistant**.
1. On the AdventureWorksTrace page, select the documents icon on the right of the **Capture Trace** field to copy the trace location.
1. On the left, select the **Replay traces** arrow button. Select **+ New Replay**.
1. In the **Full path to source file** field, paste the path to the trace. It should end in **.xel**.
1. In the **Replay name** field, type `ReplayTarget1`.
1. Select **XEvents** from the **Source Trace Format** select list, and leave **Location** selected as **Local**.
1. Set the **Replay Trace Location** to **C:\\replay**, and select **Yes, I have manually restored the database(s)** to agree.
1. Leave the **Server Type** as **SqlServer**, and enter `localhost` in the **Server name** field. The **Authenticate Type** should be selected as **Windows**.
1. In the **Database name** field, type `Target_1`. Clear **Encrypt connection**, and select **Start**. This action takes you to the **Replay** window, where you'll see the progress of the replay.
1. When the replay has completed, you'll see the message, **This replay trace is ready for analysis**.
1. On the same screen, in the top-right, select **Clone**.
1. In the **Replay name** field, type `ReplayTarget2`.
1. Select **Yes, I have manually restored the database(s)** to agree.
1. In the **Database name** field, type `Target_2`. Clear **Encrypt connection**, and select **Start**. This action takes you to the **Replay** window, where you'll see the progress of the replay as before.
1. When the replay has completed, you'll see the message, **This replay trace is ready for analysis**.
1. Select **XEvents** from the **Source Trace Format** select list, and leave **Location** selected as **Local**.
1. Click to agree, **Yes, I have manually restored the database(s).**
1. In the **Database name (optional)** field, type `Target_2`. Unclick **Encrypt connection**, and click **Start**. This takes you to the Replay window, where you will see the progress of the replay as before.
1. When the replay has completed, you will see the message **This replay trace is ready for analysis**.
