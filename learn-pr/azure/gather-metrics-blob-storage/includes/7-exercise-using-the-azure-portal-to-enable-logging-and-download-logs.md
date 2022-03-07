Before you move customer proofs into Azure Blob Storage, you want to see how you can retrieve logging status and how to download the service log files from Azure. After downloading the log files, you would normally want to check what information is included in the log.

In this exercise, you'll check the logging status for your storage account by using PowerShell. You'll then download and review a log file.

## Check logging status for Blob Storage

First, create a virtual machine scale set by using the Azure portal:

1. In the Azure portal, on the top toolbar, select **Cloud Shell**.

1. On the **Azure Cloud Shell** pane, enter the following commands:

   ```powershell
   Get-AzStorageAccount
   Set-AzCurrentStorageAccount -Name <StorageAccountName> -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
   Get-AzStorageServiceLoggingProperty -ServiceType blob
   ```

   In the `Set` command, `<StorageAccountName>` is the name of the storage account that you created in the first exercise. An example is `monitorstorageaccount`.
  
1. Notice which operations are currently logged and the log retention period. If `LoggingOperations` is set to `None`, you need to enable logging. To do so, enter the following command on the **Azure Cloud Shell** pane:

   ```powershell
   Set-AzureStorageServiceLoggingProperty -ServiceType Blob -LoggingOperations read,write,delete -RetentionDays 5
   ```

> [!NOTE]
> For more information, see [Azure Storage Analytics logging](/rest/api/storageservices/enabling-storage-logging-and-accessing-log-data).

## Download and install Azure Storage Explorer

Download the Azure Storage Explorer tool to download the Storage Analytics log files:

1. Open a new tab in your browser, and go to the [Storage Explorer product page](https://azure.microsoft.com/features/storage-explorer/).

1. Ensure that you have the correct operating system selected, and then select **Download Storage Explorer free**.

1. If a pop-up dialog box appears and asks what to do with the file, select **Save**.

1. When the download is complete, open the downloaded file.

1. If you're prompted to approve **User Account Control**, select **Yes**.

1. In the **Setup - Microsoft Azure Storage Explorer** dialog box, select **I accept the agreement** > **Install**.

1. On the **Select Destination Location** page, select **Next**.

1. On the **Select Start Menu Folder** page, select **Next**.

1. On the **Completing the Microsoft Azure Storage Explorer Setup Wizard** page, select **Finish**.

## Use Azure Storage Explorer to download storage log files

1. Open Azure Storage Explorer.

1. On the left-side toolbar, select the icon for **Add Account**.

1. When the **Connect to Azure Storage** dialog box appears:

   1. Select **Add an Azure Account** > **Sign in**.

   1. In the **Sign in** dialog box, enter your username for your Azure subscription, and then select **Next**.

   1. If a page appears and prompts you to select between **Work or school account** and **Personal account**, select the appropriate option for your account.

   1. Enter your password, and then select **Sign In**.
  
   1. If you're prompted for a two-factor authentication (2FA) code, enter the code from your authenticator app, and then select **Verify**.

   1. If a dialog box appears with the message **Let Us Know What You Think**, select **Dismiss**.

1. In Storage Explorer:

   1. If you're prompted to choose an Azure subscription, make sure that you choose the subscription that you used when you created your Azure storage account, and then select **Apply**.

   1. In the **Explorer** view, under the associated Azure subscription, expand **Storage Accounts**, expand the storage account that you created in the first exercise, and expand **Blob Containers**.

   1. Select **$logs**.

   1. In the details pane, double-click the **blob** folder, double-click the folder for the current year, double-click the folder for the current month, double-click the folder for the current day, and double-click the folder for the hour.

   1. Select one of the log files, and on the toolbar, select **Open**. A Notepad window should open, showing the log entries. Note that semicolons delimit each of the fields captured in an entry, and a new line denotes the next entry.

   1. Close Notepad.

## View log data in Excel (optional)

If you have Microsoft Excel, you can download and import the log data for easier analysis.

1. In Storage Explorer, ensure that a log file is still selected. On the toolbar, select **Download**.

1. In the **Specify where to save the downloaded blob** dialog box, select a location on your local computer, such as your **Downloads** folder. Then select **Save**.

1. Select **Start** > **Excel**.

1. In Excel, select **Blank workbook**.

1. In Excel, on the **Data** tab, select the **Get Data** menu, select **From File**, and then select **From Text/CSV**.

1. In the **Import Data** dialog box, in the **Text Files (\*.prn;\*.txt;\*.csv)** drop-down list, select **All Files (\*.\*)**.

1. In the **Import Data** dialog box, browse to the location where you downloaded the log file, such as **Downloads**. Select the downloaded log file, and then select **Import**.

1. In the preview window for the log file, ensure that **Delimiter** shows **Semicolon**, and that the entries appear to have columns correctly separated by field. Then select **Load**.

1. Review the log data in Excel. You can use the log format reference from the previous unit to identify which columns show which information.