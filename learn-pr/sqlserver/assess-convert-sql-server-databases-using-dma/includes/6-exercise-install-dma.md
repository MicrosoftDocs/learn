In your law firm, you need to upgrade several CRM databases used by different teams to SQL Server 2019. These databases include versions from SQL Server 2008R2 through to SQL Server 2016. You've chosen the **Microsoft Data Migration Assistant (DMA)** to help with these upgrades. 

In this exercise, you'll install the Data Migration Assistant.

> [!NOTE]
> Before beginning this exercise, you must complete the **Prepare for the exercises** steps in the unit **Decide if the Data Migration Assistant (DMA) is right for your task**.

## Download the RDP connection file from Azure

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.
1. In the portal menu, select **Virtual Machines**.
1. In the list, select **SQL2019Server**.
1. On the **Overview** page, at the top, select **Connect**.
1. In the drop-down menu, select **RDP**.
1. Select **Download RDP File**, then open it after it's downloaded.

## Connect to the SQL Server

1. In the **Remote Desktop Connection** dialog box, select **Connect**.
1. In the **Windows Security** dialog box, select **More choices**, and then select  **Use a different account**.
1. Sign in with the username **azureadmin**, and the admin password you used when you created the original virtual machine.
    > [!NOTE]
    > You can use the **echo $PASSWORD** command in the Cloud Shell to show you the password.
1. In the **Remote Desktop Connection** dialog box, select **Yes** to continue.
1. You should be logged on to the VM.
1. In the **Server Manager** window, on the left, select **Local Server**.
1. Select **On** next to **IE Enhanced Security Configuration**.
1. In the **Internet Explorer Enhanced Security Configuration** window, select **Off** for both Administrators and Users.
1. Select **OK**.

## Download and restore your company's database

1. On the task bar, select **Internet Explorer**.
1. In the address bar type  
https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-oltp.bak, then press Enter.
1. On the pop-up menu, select **Save As**, select the **Windows (C:)** drive on the left, and then select **Save**.
1. On the Start menu, type **cmd**, and select **Command Prompt**.
1. Execute this command to restore the downloaded backup.

    ```dos
    SqlCmd -E -S SQL2019Server –Q "RESTORE DATABASE [AdventureWorks2008R2] FROM  DISK = N'C:\adventure-works-2008r2-oltp.bak' WITH  FILE = 1,  MOVE N'AdventureWorks2008R2_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008r2.mdf',  MOVE N'AdventureWorks2008R2_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008R2_log.LDF'"
    ```

## Download the Data Migration Assistant

1. Go to the [https://github.com/MicrosoftDocs/mslearn-assess-convert-sql-server-databases-using-dma-samples/blob/master/DataMigrationAssistant.msi](https://github.com/MicrosoftDocs/mslearn-assess-convert-sql-server-databases-using-dma-samples/blob/master/DataMigrationAssistant.msi), then select **Download**.
1. On the pop-up menu, select **Save**.

## Install the Data Migration Assistant

Continue by using the installer to set up the Data Migration Assistant.

1. Using **File Explorer**, go to **C:\\Users\\azureadmin\\Downloads**.
1. Double-click **DataMigrationAssistant.exe**.
1. In the **Microsoft Data Migration Assistant Setup** window, on the **Welcome to the Microsoft Data Migration Assistant Setup Wizard** page, select **Next**.
1. On the **End-User License Agreement** page, read the terms shown. If you agree to these terms, select the **I accept the terms in the License Agreement** check box, and then select **Next**.
1. On the **Privacy Statement** page, select **Read Microsoft privacy statement online**. Read through this statement, and then close Internet Explorer.
1. In the **Microsoft Data Migration Assistant Setup** window, select **Install**.
1. On the **Completed the Microsoft Data Migration Assistant Setup Wizard** page, when the installation has finished, select the **Launch Microsoft Data Migration Assistant** check box, and then select **Finish**. The **Data Migration Assistant** launches.

> [!WARNING]
> Do not deactivate the sandbox. This sandbox will continue to be used in the next unit.
