In this exercise, you will use Data Migration Assistant to assess your existing Social database for any issues and to ensure that it is compatible with Azure SQL Database. A successful assessment is an important step to ensure your company's database can be successfully migrated to Azure.

You start by installing Data Migration Assistant on your SQL Server instance.

## Connect to a VM

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) if you don't already have it open.

1. In the **Resource group** pane, the **admsdemorg** resource group that you deployed appears.

1. In the list of resources in the resource group, select the **admsdemovm** virtual machine. The **admsdemovm** virtual machine pane appears.

1. In the top menu bar, select **Connect**, and from the dropdown list, select **RDP**. The **Connect** pane appears for your VM.

1. On the **RDP** tab, under the **Connect with RDP** section, select **Download RDP File**. Save the IP address to your computer in a location of your choice.

1. Select the RDP file to open it. Select **Connect**, and supply the credentials. Use the **windowsadmin** account and the password that you specified earlier. An RDP connection should open in a separate window.

## Disable Enhanced Security Configuration

On your RDP session, you need to disable Enhanced Security Configuration in Internet Explorer before you can download Data Migration Assistant, otherwise security rules will block the download.

1. By default, Server Manager should be open on your connected RDP session. If you closed it, use the **Start** menu to open it.

1. In the left menu pane, select **Local Server**.

    :::image type="content" source="../media/4-rdp-server-manager.png" alt-text="Screenshot of server manager with IE Enhanced security set to off." loc-scope="azure-database-migration" lightbox="../media/4-rdp-server-manager.png":::

1. Select the **IE Enhanced Security Configuration** setting. The **Internet Explorer Enhanced Security Configuration** dialog box appears.

1. Change the **Administrators** setting to **Off**, and then select **OK**.

## Download, install, and run Data Migration Assistant

> [!NOTE]  
> You may need to install .Net Framework 4.8 before installing Data Migration Assistant. You can do so from https://dotnet.microsoft.com/download/dotnet-framework/net48. You will need to relaunch your RDP session before installing the Data Migration Assistant.

1. From your RDP session, open Internet Explorer, and go to the [Data Migration Assistant download page](https://www.microsoft.com/download/details.aspx?id=53595).

1. Select **Download**, and install the Data Migration Assistant. Accept the defaults through the installation dialog box.

1. To start the assistant, select **Microsoft Data Migration Assistant** to open the application.

1. To begin a new assessment, in the left menu pane, select **+**.

1. For **Project type**, select **Assessment**.

1. For **Project name**, enter *Social Database Assessment*.

1. Accept the default values for the remaining fields, and select **Create**.

    :::image type="content" source="../media/4-02-project-type.png" alt-text="Screenshot of project type." loc-scope="azure-database-migration":::

## Configure the project

1. On the **Select report type** pane, ensure both **Check database compatibility** and **Check feature parity** are checked, and then select **Next**. The **Connect to a server** pane appears.

1. To configure the source database to connect to, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Server name | admsdemovm |
    | Authentication type | Windows Authentication |
    | **Connection properties** |   |
    | Encrypt connection | Check  |
    | Trust server certificate | Check  |
    | | |

    :::image type="content" source="../media/4-04-connect-to-server.png" alt-text="Screenshot of connect to a server." loc-scope="azure-database-migration":::

1. Select **Connect**. The **Add sources** pane appears.

1. Select the **Social** database, and then select **Add**.

1. The assessment now shows the database you've selected. To begin the assessment, select **Start Assessment**.

    :::image type="content" source="../media/4-06-select-sources.png" alt-text="Screenshot of select sources." loc-scope="azure-database-migration" lightbox="../media/4-06-select-sources.png":::

## Review the assessment results and address issues

Allow the assessment to run. When it finishes, the results display in two options in the left pane, *SQL Server feature parity* issues or *Compatibility issues*. Start by looking at the default view, **SQL Server feature parity**.

:::image type="content" source="../media/4-07-review-results.png" alt-text="Screenshot of review results." loc-scope="azure-database-migration" lightbox="../media/4-07-review-results.png":::

In the middle of the page, look for the section **Unsupported features**. The second and third items show **N/A** under the affected objects, meaning that nothing was found in the source system for these two items.

Look more closely at the first row, though, and you'll see the issue, **Service Broker feature is not supported in Azure SQL Database. Azure SQL Database does not support trace flags.** The information for that issue includes instructions about how to solve it. The database that you're migrating doesn't need this feature, so you can disable it without any problems.

In the left pane, select **Compatibility issues**. It shows that there were no compatibility issues with the database. If there had been issues, it would have listed them and you would need to resolve them before you could continue the migration.

:::image type="content" source="../media/4-08-compatibility-issues.png" alt-text="Screenshot showing Compatibility issues." loc-scope="azure-database-migration" lightbox="../media/4-08-compatibility-issues.png":::

1. From your RDP session's taskbar, search for and select **SQL Server Management Studio**, and connect to the **admsdemovm** server with Windows authentication. To connect to the **Social** database, select **Connect**.

1. In the top menu bar, select **New Query**.

1. Enter the following query, and to run it, on the top menu bar, select **Execute**.

    ```sql
    ALTER DATABASE [Social] SET DISABLE_BROKER;
    ```

## Rerun the assessment

1. Switch back to Data Migration Assistant. To have Data Migration Assistant reassess the fixed database, in the upper right taskbar, select **Restart Assessment**.

1. When the assessment finishes, you should still be on the **Compatibility Issues** page, and it should still show that there are no issues.

1. In the left pane, select **SQL Server feature parity**. It should now show that the issue has been resolved.

    :::image type="content" source="../media/4-09-fixed-issues.png" alt-text="Fixed issues." loc-scope="azure-database-migration" lightbox="../media/4-09-fixed-issues.png":::

At this point, you've completed the assessment. To return to the list of completed assessments, on the upper-left side of the page, to the left of **Social Database Assessment**, select the arrow.
