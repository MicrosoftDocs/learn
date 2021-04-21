In your law firm,you need to upgrade several CRM databases to SQL Server 2019. These databases include versions from SQL Server 2008R2 through to SQL Server 2016. To save time, you want to migrate multiple databases in parallel, and migrate database logins. You'll use the **Microsoft Data Migration Assistant (DMA)** to help with these upgrades.

In this exercise, you'll upgrade a database from SQL Server 2008 R2, to SQL Server 2019. After the database has been migrated, you'll export the results as a CSV report.

## Migrate a database

To use the DMA to migrate the database, follow these steps:

1. On the taskbar, select **File Explorer**.
1. On the left, select  **Windows (C:)**, right-select in the main pane, select **New**, and then select **Folder**.
1. Rename the new folder **temp**.
1. On the taskbar, select **Data Migration Assistant**.
1. On the left, select **+**.
1. In the **New** flyout, under **Project type**, select **Migration** and then, in the **Project name** box, type **AdventureWorks 2008-2019**.
1. Leave the **Source server type** as **SQL Server**, in the **Target server type** list, select **SQL Server**, and then select **Create**.
1. On the **Specify source & target** tab, under **Source server details**, in the **Server name** box, type **localhost**.
1. In the **Authentication type** list, ensure **Windows Authentication** is selected, and that **Encrypt connection** is clear.
1. Under **Target server details**, in the **Server name** box, type **localhost**.
1. In the **Authentication type** list, ensure **Windows Authentication** is selected, and that **Encrypt connection** is clear, and then select **Next**.
1. On the **Add databases** tab, under **Source server**, ensure only **AdventureWorks2008R2** is selected.
1. In the **Shared location accessible by source and target servers for backup operation** box, type **C:\\temp**, and then select **Next**.

    > [!NOTE]
    > Note that migrating a database on the same server, to the same location, causes an error.

1. In the **Provide target database name** box, type **`AWMigrate2019`**.
1. In the **Restore options** section, change the **Data** path for **Restore as on target server** to:

    ```cmd
    C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AWMigrate2019.mdf
    ```

1. Change the **Log** path for **Restore as on target server** to:

    ```cmd
    C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AWMigrate2019_log.LDF
    ```

1. Select **Next**, on the **Select logins** tab, ensure no logins are selected, and then select **Start Migration**.

## Export the results

Next, export the results to a CSV text file:

1. When the migration completes, on the **View results** tab, select **Export report**.
1. In the **Save migration report** dialog box, change the location to the **Desktop**.
1. In the **File name** box, type **`AdventureWorks 2008-2019 Upgrade`**.
1. In the **Save as type** list, select **CSV Files (*.csv)**, and then select **Save**.
1. Minimize the **Data Migration Assistant** window.
1. On the **Desktop**, double-click the **AdventureWorks 2008-2019 Upgrade.csv** file.
1. In Notepad, scroll through the results of the export. Notice that the report includes a list of databases you chose to migrate. Close Notepad.

## Check the current compatibility level

Before you make the upgrade, find out the original compatibility level for the database:

1. Select **Start**, type **`SSMS`**, and then press Enter.
1. In the **Connect to Server** dialog box, select **Connect**.
1. In Object Explorer, expand **Databases**. You should now see the migrated **AWMigrate2019** database. Right-click **AWMigrate2019**, and then select **Properties**.
1. In the **Database Properties - AWMigrate2019** window, under **Select a page**, select **Options**.
1. The **Compatibility level** should be set to **SQL Server 2008 (100)**, and then select **Cancel**.

## Update the compatibility level

Now you can upgrade the compatibility level for the Adventure Works database:

1. In Object Explorer, right-click **AWMigrate2019**, and then select **New Query**.
1. In the query window, type the following code, and then select **Execute**:

    ```sql
    ALTER DATABASE AWMigrate2019
    SET COMPATIBILITY_LEVEL = 150
    ```

1. In Object Explorer, right-click **AWMigrate2019**, and then select **Properties**.
1. In the **Database Properties - AWMigrate2019** window, under **Select a page**, select **Options**.
1. The **Compatibility level** should now be set to **SQL Server 2019 (150)**. Select **Cancel**.
1. Close SSMS, without saving any changes.
