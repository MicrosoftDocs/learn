In this exercise, you will use the Azure Data Migration Assistant to assess your existing social database for any issues and ensure it is compatible with Azure SQL Database. This is an important step to ensure your company's database can be successfully migrated to Azure. 

## Install the Azure Data Migration Assistant

1. You'll need to install the Data Migration Assistant on your virtual machine, so begin by opening the Azure Portal. Then click on the link to open up the **admsdemorg** resource group.

1. In the list of objects that belong to the resource group, click the link to the **admsdemovm** virtual machine.

1. In the toolbar above the VM info, click the **Connect** button. 

    ![Connect to VM](../media/4-00a-connect-vm.jpg)

1. In the pane that appears to the left, click the **Download RDP File** button and save it to your computer in a location of your choosing.

    ![Connect to VM](../media/4-00b-rdp.jpg)

1. Double click on the RDP file to open it, click the **Connect** button, and supply the credentials. For these lessons we are using **learner** for the user name and **SecureP@ssW0rd** for the password.

1. Before you can download the Data Migration Assistant, you will want to disable the server's IE security setting or it will block the download. Since this is just a learning environment, you will be safe in doing so, but avoid doing this in production. Instead, download on another computer and copy up to your server.

1. By default, the Server Manager should be open, but if you closed it, use the **Start** menu to open it.

1. Click on **Local Server** in the side bar.

1. In the upper right, find the _IE Enhanced Security Configuration_ setting and click on the **On** link.

1. Change the setting to **Off** for Administrators. Click **OK** to close.

1. Open Internet Explorer and go to [Azure Data Migration Assistant download page](https://www.microsoft.com/download/details.aspx?id=53595).

1. Download and install the migration assistant.

## Select the Project Type

1. Open the Data Migration Assistant.

1. Click the **+** (New) button in the left-side toolbar to begin a new assessment.

    ![New Assessment](../media/4-01-new-assessment.png)

1. In the blade that opens, make sure the Project type is set to **Assessment**.

1. For the Project name, enter **Social Assessment**.

1. For this particular project, you can take the defaults for the remaining fields. Assessment type will be **Database Engine**, Source server type will be **SQL Server**, and Target server type will be **Azure SQL Database**.

1. When done, click **Create**.

    ![Project Type](../media/4-02-project-type.png)

## Configure the Project

1. The next screen begins the workflow. Step one is to select options. Leave all of the options set for this exercise, then click **Next**.

    ![Options](../media/4-03-options.png)

1. In the next step you will configure the source to convert. To do so, you need to connect to a server. A blade will appear on the right, Connect to a server. For the server name, we'll use the name of the VM and enter **admsdemovm**. 

1. Under Authentication type, leave **Windows Authentication** selected.

1. Under Connection properties, leave the **Encrypt** connection checked, and add a check beside **Trust server certificate**.

1. Click **Connect** at the bottom to test your connection.

    ![Connect to a server](../media/4-04-connect-to-server.png)

1. The blade updates to show the list of databases on the server. Place a check beside the **Social** database.

1. Click the **Add** button.

    ![Add sources](../media/4-05-add-sources.png)

1. The Select Sources page now updates to show the database you have selected. You can now click the **Start Assessment** button on the bottom right to begin the assessment.

    ![Select sources](../media/4-06-select-sources.png)

## Review Results

Allow the analysis to run. When it completes, it will produce results and break them into SQL Server feature parity issues or compatibility issues. Start by looking at the SQL Server feature parity results, which is the default.

  ![Review results](../media/4-07-review-results.png)

In the middle of the page you will see the section _Unsupported features_. The second and third items show **N/A** under the impacted objects, meaning nothing was found in the source system for these two items.

Look closer at the first row, though, and you will see that _Service Broker feature is not supported in Azure SQL Database_. It includes instructions on how to solve this, and fortunately our database doesn't need this feature, so we can disable it without any problems.

1. Open SQL Server Management Studio and connect to the **admsdemovm** server, then to the **social** database.

1. Click on the **New Query** button.

1. Enter and execute the following query:

```sql
ALTER DATABASE [Social] SET DISABLE_BROKER;
```

In a moment you will rerun the assessment, but first click on the **Compatibility issues** button to the upper left. It will show that there were no compatibility issues with the database. If there had been, it would have listed them and you would need to resolve them before you could continue the migration.

![Compatibility Issues](../media/4-08-compatibility-issues.png)

## Rerun the Assessment

1. In the upper right corner is a button, **Restart Assessment**. Click it to have the Data Migration Assistant re-assess the fixed database.

1. When it completes, you should still be on the Compatibility Issues page, and it should still show there are none.

1. Click on the **SQL Server feature parity** option in the upper left. It should now show the issue has been resolved.

    ![Fixed Issues](../media/4-09-fixed-issues.png)

At this point you have completed the assessment. Click the left arrow in the upper left side of the screen to return to the list of completed assessments.
