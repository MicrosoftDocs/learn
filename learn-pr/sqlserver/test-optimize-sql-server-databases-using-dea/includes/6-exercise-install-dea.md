It's easy to install the **Database Experimentation Assistant (DEA)**, and it can then be rerun at any time. 

You're upgrading several CRM databases to SQL Server 2019. These databases include versions from SQL Server 2008 R2 through to SQL Server 2016. The databases are critical to your organization's business, so you must identify any potential performance issues, before the upgraded databases go live into production. You've chosen to use the DEA to help with this task. First, you need to install DEA.

In this exercise, you'll install the DEA on the virtual machine you created earlier.
> [!NOTE]
> Before beginning this exercise, you must complete the **Prepare for the exercises** steps in the unit **Decide if DEA is right for your task**.

## Download the RDP connection file from Azure

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.
1. In the portal menu, select **Virtual Machines**.
1. In the list, select **SQL2019Server**.
1. On the **Overview** page, at the top, select **Connect**.
1. In the drop-down, select **RDP**.
1. Select **Download RDP File** then, when it's downloaded, open the file.

## Connect to the SQL Server

1. In the **Remote Desktop Connection** dialog box, select **Connect**.
1. In the **Windows Security** dialog box, select **More choices**, and then select   **Use a different account**.
1. Sign in with the username **azureadmin**, and the admin password you used when you created the original virtual machine.
    > [!NOTE]
    > You can use the **echo $PASSWORD** command in the Cloud Shell to show you the password.
1. In the **Remote Desktop Connection** dialog box, select **Yes** to continue.
1. You should be logged on to the VM.
1. In the **Server Manager** window on the left, select **Local Server**.
1. Select **On** next to **IE Enhanced Security Configuration**.
1. In the **Internet Explorer Enhanced Security Configuration** window, select **Off** for both Administrators and Users.
1. Select **OK**.

## Download and restore your company's databases and workloads

1. On the taskbar, select **Internet Explorer**.
1. Go to 
[https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-oltp.bak](https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-oltp.bak).
1. On the pop-up, select **Save As**, select the **Windows (C:)** drive on the left, and then select **Save**.
1. Go to [https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/create-workload-on-adventureworks.sql](https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/create-workload-on-adventureworks.sql). On the menu, right-click the **Raw** button, and select **Save target as...**
1. In the **Save As** window, select **Save**.
1. On the Start menu, type **cmd**, and select **Command Prompt**.
1. Execute this command to restore the downloaded backup:

    ```dos
    SqlCmd -E -S SQL2019Server –Q "RESTORE DATABASE [AdventureWorks2008R2] FROM  DISK = N'C:\adventure-works-2008r2-oltp.bak' WITH  FILE = 1,  MOVE N'AdventureWorks2008R2_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008r2.mdf',  MOVE N'AdventureWorks2008R2_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008R2_log.LDF'"
    ```

## Download the latest sqlpackage.exe component required for the DEA

1. On the taskbar, select **Internet Explorer**.
1. Go to [https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/DacFramework.msi](https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/DacFramework.msi).
1. Select **Download**.
1. In the pop-up, select **Run**.
1. On the **Microsoft SQL Server Data-Tier Application Framework (x64)** window, select **Next**.
1. Read the end-user license agreement, if you agree, select **I accept the terms in the License Agreement**. Then select **Next**.
1. Select **Install**, then select **Finish**.

## Install the Database Experimentation Assistant

1. Go to [https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/DatabaseExperimentationAssistantV2.6.exe]https://github.com/MicrosoftDocs/mslearn-test-optimize-sql-server-databases-using-dea/blob/master/DatabaseExperimentationAssistantV2.6.exe).
1. Select **Download**.
1. In the pop-up, select **Run**.
1. On the screen, you'll see **Microsoft Software License Terms**. Read the terms and, if you agree, select **I agree to the license terms and conditions**. Then select **Install**.
1. When the **Setup Options** screen appears, select **OK**.
1. When you see the message **Installation Successfully Completed**, select **Close**.
1. Select **Start**, type **Database Experimentation Assistant**, and then select it to open the application.
1. Using **File Explorer**, create a new folder on the **C:** drive, **C:\\capture**.
1. Using **File Explorer**, create a new folder on the **C:** drive, **C:\\replay**.