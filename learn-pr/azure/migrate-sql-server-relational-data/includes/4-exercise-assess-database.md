In this exercise, you use Data Migration Assistant to assess your existing social database for any issues and ensure it's compatible with Azure SQL Database. This is an important step to ensure that your company's database can be successfully migrated to Azure.

You start by installing Data Migration Assistant on your SQL Server instance.

## Connect to a VM

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) if you don't already have it open. 

1. Select **Resource groups**, and then select the **admsdemorg** resource group that you deployed.

1. In the list of resources in the resource group, select the **admsdemovm** virtual machine (VM).

1. On the toolbar above the VM info, select **Connect**, and from the dropdown, select **RDP**.

1. On the **Connect** window, from the **RDP*** tab, under the **Connect with RDP** section, select **Download RDP File**, Save it to your computer in a location of your choice.

1. Select the RDP file to open it. Select **Connect**, and supply the credentials. Use the **windowsadmin** account, and use the password that you specified for this account.

## Disable Enhanced Security Configuration

Before you can download Data Migration Assistant, you need to disable Enhanced Security Configuration in Internet Explorer, or it will block the download.

1. By default, Server Manager should be open. If you closed it, use the **Start** menu to open it.

1. On the left menu, select **Local Server**.

1. Select the **IE Enhanced Security Configuration** setting.

1. Change the setting to **Off** for **Administrators**, and then select **OK**.

## Download, install, and run Data Migration Assistant

1. Open Internet Explorer, and go to the [Data Migration Assistant download page](https://www.microsoft.com/download/details.aspx?id=53595).

1. Select **Download**, and install the migration assistant. Accept the defaults through the installation dialog box.

1. To start the assistant, on the desktop, select **Microsoft Data Migration Assistant**.

1. To begin a new assessment, on the left menu, select **+**.

1. For **Project type**, select **Assessment**.

1. For **Project name**, enter **Social Database Assessment**.

1. Leave the remaining fields at their default values, and select **Create**.

    :::image type="content" source="../media/4-02-project-type.png" alt-text="Project type." loc-scope="azure-database-migration":::

## Configure the project

1. On the **Select report type** pane, ensure both **Check database compatibility** and **Check feature parity** are selected, and then select **Next**.

1. Configure the source database to connect to. On the **Connect to a server** pane, configure the following settings:

    | | |
    |---------|---------|
    | **Server name** | admsdemovm |
    | **Authentication type** | Windows Authentication |
    | **Encrypt connection** | Selected        |
    | **Trust server certificate** | Selected        |
    | | |

    :::image type="content" source="../media/4-04-connect-to-server.png" alt-text="Connect to a server." loc-scope="azure-database-migration":::

1. Select **Connect**.

1. On the **Add sources** pane, select the **Social** database, and then select **Add**.

1. The assessment now shows the database you've selected. To begin the assessment, select **Start Assessment**.

    :::image type="content" source="../media/4-06-select-sources.png" alt-text="Select sources." loc-scope="azure-database-migration":::

## Review the assessment results and address issues

Allow the analysis to run. When it finishes, it produces results and breaks them into *SQL Server feature parity* issues or *Compatibility issues*. Start by looking at the SQL Server feature parity results, which is the default.

:::image type="content" source="../media/4-07-review-results.png" alt-text="Review results." loc-scope="azure-database-migration":::

In the middle of the page, look for the section **Unsupported features**. The second and third items show **N/A** under the affected objects, meaning that nothing was found in the source system for these two items.

Look more closely at the first row, though, and you'll see the issue, **Service Broker feature is not supported in Azure SQL Database. Azure SQL Database does not support trace flags.** The information for that issue includes instructions about how to solve it. The database that you're migrating doesn't need this feature, so you can disable it without any problems.

Select **Compatibility issues**. It shows that there were no compatibility issues with the database. If there had been issues, it would have listed them and you would need to resolve them before you could continue the migration.

:::image type="content" source="../media/4-08-compatibility-issues.png" alt-text="Compatibility issues." loc-scope="azure-database-migration":::

1. Open SQL Server Management Studio and connect to the **admsdemovm** server with Windows authentication. To connect to the **social** database, select **Connect**.

1. Select **New Query**.

1. Enter the following query, and to run it, select **Execute**.

    ```sql
    ALTER DATABASE [Social] SET DISABLE_BROKER;
    ```

## Rerun the assessment

1. Switch back to Data Migration Assistant. To have Data Migration Assistant reassess the fixed database, select **Restart Assessment**.

1. When the assessment finishes, you should still be on the **Compatibility Issues** page, and it should still show that there are no issues.

1. Select **SQL Server feature parity**. It should now show that the issue has been resolved.

    :::image type="content" source="../media/4-09-fixed-issues.png" alt-text="Fixed issues." loc-scope="azure-database-migration":::

At this point, you've completed the assessment. To return to the list of completed assessments, on the upper-left side of the screen, select the arrow.
