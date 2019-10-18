Suppose you need to upgrade CRM databases to SQL Server 2017, and these databases include versions from SQL Server 2008R2 through to SQL Server 2016. To save time, you want to migrate multiple databases in parallel, and also migrate database logins. You have, therefore, chosen to use the **Microsoft Data Migration Assistant (DMA)** to help with these upgrades.

In this exercise, you will upgrade a database from SQL Server 2008 R2, to SQL Server 2017. After the database has been migrated, you will export the results to CSV.

## Start the DMA

If you logged out of the VM, start by logging on and accessing the DMA:

1. Sign into the VM with your Microsoft account.
1. Click **Commands**, click **CTRL+ALT+DEL**, and then login with the **Administrator** password **`Pa55w.rd`**.
1. Close the Server Manager window.
1. On the **Desktop**, double-click **Microsoft Data Migration Assistant**.
1. If the **A new version is available** dialog box appears, click **Cancel**.

## Migrate a database

Next, use the DMA to migrate the database. Follow these steps:

1. On the taskbar, click File Explorer.
1. On the left, click **Local Disk (C:)**, then right click in the main pane and select **New**, then select **Folder**.
1. Rename the new folder, **temp**.
1. On the taskbar, select **Data Migration Assistant**.
1. On the left, click **+**.
1. In the **New** fly-out, under **Project type**, click **Migration** and then in the **Project name** box, type **`AdventureWorks 2008-2017`**.
1. Leave the **Source server type** as **SQL Server**, in the **Target server type** list, click **SQL Server**, and then click **Create**.
1. On the **Specify source & target** tab, under **Source server details**, in the **Server name** box, type **`localhost`**.
1. In the **Authentication type** list, ensure **Windows Authentication** is selected, and that **Encrypt connection** is clear.
1. Under **Target server details**, in the **Server name** box, type **`localhost`**.
1. In the **Authentication type** list, ensure **Windows Authentication** is selected, and that **Encrypt connection** is clear, and then click **Next**.
1. On the **Add databases** tab, under **Source server**, ensure only **AdventureWorks** is selected.
1. In the **Shared location accessible by source and target servers for backup operation** box, type **`C:\temp`**, and then click **Next**.

    >[!ALERT] Note that migrating a database on the same server and to the same location causes an error.

1. In the **Provide target database name** box, type **`AWMigrate2017`**.
1. In the **Restore options** section, change the **Data** path for **Restore as on target server** to:

    ```cmd
    C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AWMigrate2017.mdf
    ```

1. Change the **Log** path for **Restore as on target server** to:

    ```cmd
    C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AWMigrate2017_log.LDF
    ```

1. Click **Next**, on the **Select logins** tab, ensure no logins are selected, and then click **Start Migration**.

## Export the results

Next, export the results to a CSV text file:

1. When the migration completes, on the **View results** tab, click **Export report**.
1. In the **Save migration report** dialog box, change the location to the **Desktop**.
1. In the **File name** box, type **`AdventureWorks 2008-2017 Upgrade`**.
1. In the **Save as type** list, click **CSV Files (*.csv)**, and then click **Save**.
1. Minimize the **Data Migration Assistant** window.
1. On the **Desktop**, double-click the **AdventureWorks 2008-2017 Upgrade.csv** file.
1. In Notepad, scroll through the results of the export. Notice that the report includes a list of databases you chose not to migrate. Close Notepad.

## Check the current compatibility level

Before you make the upgrade, find out the original compatibility level for the database:

1. Click Start, type **`SSMS`**, and then press Enter.
1. In the **Connect to Server** dialog box, in the **Server name** box, type **`localhost`**, leave the **Authentication** selection as **Windows Authentication**, and then click **Connect**.
1. In Object Explorer, expand **Databases**, you should now see the migrated **AWMigrate2017** database. Right-click **AWMigrate2017**, and then click **Properties**.
1. In the **Database Properties - AWMigrate2017** window, under **Select a page**, click **Options**.
1. The **Compatibility level** should be set to **SQL Server 2008 (100)**, and then click **Cancel**.

## Update the compatibility level

Now you can upgrade the compatibility level for the Adventure Works database:

1. In Object Explorer, right-click **AWMigrate2017**, and then click **New Query**.
1. In the query window, type the following code, and then click **Execute**:

    ```sql
    ALTER DATABASE AWMigrate2017
    SET COMPATIBILITY_LEVEL = 140
    ```

1. In Object Explorer, right-click **AWMigrate2017**, and then click **Properties**.
1. In the **Database Properties - AWMigrate2017** window, under **Select a page**, click **Options**.
1. The **Compatibility level** should now be set to **SQL Server 2017 (140)**, and then click **Cancel**.
1. Close SSMS, without saving any changes.

## Summary

Here, you ran the Microsoft Data Migration Assistant to migrate a database from SQL Server 2008 to SQL Server 2017. You migrated all the qualified logins with the database, enabling users to begin using the database as soon as their connections are updated. When the database finished migrating, you exported the results and viewed the output in Excel. Then you changed the compatibility level of the database to SQL Server 2017 using SQL Server Management Studio.
