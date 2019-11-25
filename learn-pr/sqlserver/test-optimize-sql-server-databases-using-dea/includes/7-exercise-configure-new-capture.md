You have upgraded several CRM databases to SQL Server 2017, and you're using a staging area to so that you can identify any performance issues, before you deploy to your production platform. You're using the Microsoft Database Experimentation Assistant (DEA) to help with this task.

In this exercise, you'll configure a new capture using DEA, running a workload on a SQL Server 2008R2 database, and then replaying this capture against a SQL Server 2017 database.

## Start the lab

Start by logging into the database server:

1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, and then click **CTRL+ALT+DEL**, and login with the Administrator password: **Pa55w.rd**

## Back up the source database

The first step is to create a backup of your source database. Follow these steps:

1. On the **Taskbar**, click **SQL Server Management Studio**.
1. In the **Connect to Server** window, leave **Authentication** selection as **Windows Authentication**. Click **Connect**.
1. In **Object Explorer**, click **Databases** to expand the tree.
1. Right-click **AdventureWorks**, select **Tasks**, and click **Back Up...**.
1. In the window **Back Up Database - AdventureWorks**, click **OK** to start the backup. 
1. When you see the message, **The backup of database 'AdventureWorks' completed successfully.**, click **OK**.

## Create a new capture with DEA

Now use DEA to create a baseline capture of database events.

1. In **SQL Server Management Studio**, click **File**, **Open**, then **File**. Navigate to the folder **Downloads**, and select **create-workload-on-adventureworks.sql**. Click **Open**, to open the workload file.
1. Click **Start**, and then type **Database Experimentation Assistant**.
1. When DEA has opened, click on the camera icon, **Capture traces**. Click **+ New Capture**.
1. In the **Capture name** field, type `AdventureWorksTrace`. Leave the **Format** set to **XEvents**, and **Duration (minutes)** set to **5**.
1. Type `c:\capture` in the **Capture Location** field.
1. Tick the box **Yes, I have manually taken the backup of the target databases(s)**.
1. Leave the **Server Type** selection as **SqlServer**, and in the **Server name** field, type `localhost`.
1. Check the **Authentication Type** is **Windows**, and in the **Database name (optional)** field, type `AdventureWorks`.
1. Uncheck the **Encrypt connection** box.
1. The **Start** button should now be enabled. Click the button to start the capture, if you can't resize the window to see the button press **Enter**. You'll see the capture details page, and the countdown timer.
1. Return to **SQL Server Management Studio**, and the workload file. Click **Execute**. Leave this to run. If the timer in the **Database Experimentation Assistant** stops before the workload script has completed, click **Cancel Executing Query**.
1. When the timer runs out in the **Database Experimentation Assistant**, you'll see the message **This capture trace is ready for replay**.
1. Leave the **Database Experimentation Assistant** window open.

## Create the Target 1 database

The next step is to restore your database backup as "Target 1", and with SQL Server 2008 compatibility level.

1. In **SQL Server Management Studio**, in **Object Explorer**, right-click **Databases**, and select **Restore Database...***.
1. When the **Restore Database** window appears, click **Device**, and then click the browse **...** button.
1. In the **Select backup devices** window, click **Add**.
1. In the **Locate Backup File** window, navigate to **C:\\Program Files\\Microsoft SQL Server\\MSSQL14.MSSQLSERVER\\MSSQL\\Backup\\**, and select **AdventureWorks.bak**. Click **OK**.
1. This returns to the **Select backup devices** window. Click **OK**.
1. In the **Restore Database** window, you should now see a status of **Ready** in the top left-hand corner.
1. Under **Destination**, in the **Database** field, type `Target_1`.
1. From the **Select a page** tab, click **Files**. Click **Relocate all files to folder**. Click **OK**.
1. When you see the message **Database 'Target_2' restored successfully.**, click **OK** to return to Management Studio.
1. In **Object Explorer**, under **Databases**, right-click **Target_1**, and select **Properties**.
1. In the **Database Properties - Target_1**, from the **Select a page** tab, click **Options**.
1. Notice the **Compatibility level**. This should be set to **SQL Server 2008 (100)**. Click **Cancel** to close the window.

## Create the Target 2 database

Next, restore your database backup again, this time as "Target 2", and with SQL Server 2017 compatibility level.

1. In **Object Explorer**, right-click **Databases**, and select **Restore Database...**.
1. When the **Restore Database** window appears, click **Device**, and then click the browse **...** button.
1. In the **Select backup devices** window, click **Add**.
1. In the **Locate Backup File** window, navigate to **C:\\Program Files\\Microsoft SQL Server\\MSSQL14.MSSQLSERVER\\MSSQL\\Backup\\**, and select **AdventureWorks.bak**. Click **OK**.
1. This returns to the **Select backup devices** window. Click **OK**.
1. In the **Restore Database** window, you should now see a status of **Ready** in the top left-hand corner.
1. Under **Destination**, in the **Database** field, type `Target_2`.
1. From the **Select a page** tab, click **Files**. Click **Relocate all files to folder**. Click **OK**.
1. When you see the message **Database 'Target_2' restored successfully**, click **OK** to return to Management Studio.
1. In **Object Explorer**, under **Databases**, right-click **Target_2**, and select **Properties**.
1. In the **Database Properties - Target_2**, from the **Select a page** tab, click **Options**. In the **Compatability level** select list, choose **SQL Server 2017 (140)**. Click **OK**

## Run the trace on Target 1 and Target 2 databases

Now run the trace files from your DEA capture against both the Target 1 and Target 2 databases.

1. Return to **Database Experimentation Assistant**, and
1. On the AdventureWorksTrace page, click the documents icon on the right of the **Capture Trace** field to copy the trace location.
1. On the left click **Replay traces**. Click **+ New Replay**.
1. In the **Full path to source file** field, paste the path to the trace, it should end in **.xel**.
1. In the **Replay name** field, type `ReplayTarget1`.
1. Select **XEvents** from the **Source Trace Format** select list, and leave **Location** selected as **Local**.
1. Set the **Replay Trace Location** to `C:\replay`, and click to agree, **Yes, I have manually restored the database(s).**
1. Leave the **Server Type** as **SqlServer**, and enter `localhost` in the **Server name** field. The **Authenticate Type** should be selected as **Windows**.
1. In the **Database name (optional)** field, type `Target_1`. Unclick **Encrypt connection**, and click **Start**. This takes you to the Replay window, where you'll see the progress of the replay.
1. When the replay has completed, you'll see the message **This replay trace is ready for analysis**.
1. On the same screen in the top right, click **Clone**.
1. In the **Replay name** field, type `ReplayTarget2`.
1. Select **XEvents** from the **Source Trace Format** select list, and leave **Location** selected as **Local**.
1. Click to agree, **Yes, I have manually restored the database(s).**
1. In the **Database name (optional)** field, type `Target_2`. Unclick **Encrypt connection**, and click **Start**. This takes you to the Replay window, where you will see the progress of the replay as before.
1. When the replay has completed, you will see the message **This replay trace is ready for analysis**.

## Summary

Here, you backed up the source database and ran a capture using the Database Experimentation Assistant. Then you restored the backup to a new database that you named Target_1, and left the compatibility level at SQL Server 2008 (100). You restored the same database to a new database named Target_2, and changed the compatibility level to SQL Server 2017 (140). Then you used DEA to run the capture from the source database on the Target_1 and Target_2 databases.