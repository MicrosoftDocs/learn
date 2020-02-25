In this exercise, you use Data Migration Assistant to assess your existing social database for any issues and ensure it's compatible with Azure SQL Database. This is an important step to ensure that your company's database can be successfully migrated to Azure.

You start by installing Data Migration Assistant on your SQL Server instance.

## Connect to a VM

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) if you don't already have it open. 

1. Select **Resource groups**, and then select the **admsdemorg** resource group that you deployed.

1. In the list of resources in the resource group, select the **admsdemovm** virtual machine (VM).

1. On the toolbar above the VM info, select **Connect**.

1. On the **Connect to virtual machine** pane, select **Download RDP File** and save it to your computer in a location of your choosing.

1. Select the RDP file to open it. Select the **Connect** button, and supply the credentials. Use the **windowsadmin** account, and use the password that you specified for this account.

## Disable Enhanced Security Configuration

Before you can download Data Migration Assistant, you need to disable Enhanced Security Configuration in Internet Explorer, or it will block the download.

1. By default, Server Manager should be open. If you closed it, use the **Start** menu to open it.

1. Select **Local Server** on the left menu.

1. Select the **IE Enhanced Security Configuration** setting.

1. Change the setting to **Off** for **Administrators**, and then select **OK**.

## Download, install, and run Data Migration Assistant

1. Open Internet Explorer and go to the [Data Migration Assistant download page](https://www.microsoft.com/download/details.aspx?id=53595).

1. Select **Download** and install the migration assistant. Accept the defaults through the installation dialog box.

1. Select **Microsoft Data Migration Assistant** on the desktop to start the assistant.

1. Select **+** on the left menu to begin a new assessment.

1. Select a **Project type** of **Assessment**.

1. For **Project name**, enter **Social Database Assessment**.

1. Leave the remaining fields at their default values and select **Create**.

    ![Project type](../media/4-02-project-type.png)

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

    ![Connect to a server](../media/4-04-connect-to-server.png)

1. Select **Connect**.

1. On the **Add sources** pane, select the **Social** database, and then select **Add**.

1. The assessment now shows the database you've selected. Select **Start Assessment** to begin the assessment.

    ![Select sources](../media/4-06-select-sources.png)

## Review the assessment results and address issues

Allow the analysis to run. When it finishes, it produces results and breaks them into SQL Server *feature parity* issues or *compatibility issues*. Start by looking at the SQL Server feature parity results, which are the default.

  ![Review results](../media/4-07-review-results.png)

In the middle of the page, look for the section **Unsupported features**. The second and third items show **N/A** under the affected objects, meaning that nothing was found in the source system for these two items.

Look closer at the first row, though, and you'll see the issue **Service Broker feature is not supported in Azure SQL Database**. The information for that issue includes instructions on how to solve it. The database that you're migrating doesn't need this feature, so you can disable it without any problems.

Select **Compatibility issues**. It shows that there were no compatibility issues with the database. If there had been issues, it would have listed them and you would need to resolve them before you could continue the migration.

![Compatibility issues](../media/4-08-compatibility-issues.png)

1. Open SQL Server Management Studio and connect to the **admsdemovm** server with Windows authentication. Then connect to the **social** database.

1. Select **New Query**.

1. Enter and run the following query:

    ```sql
    ALTER DATABASE [Social] SET DISABLE_BROKER;
    ```

## Rerun the assessment

1. Switch back to Data Migration Assistant. Select **Restart Assessment** to have Data Migration Assistant reassess the fixed database.

1. When the assessment finishes, you should still be on the **Compatibility Issues** page, and it should still show that there are none.

1. Select **SQL Server feature parity**. It should now show that the issue has been resolved.

    ![Fixed issues](../media/4-09-fixed-issues.png)

At this point, you've completed the assessment. Select the arrow on the upper-left side of the screen to return to the list of completed assessments.
