Before moving client proofs into Azure Blob storage, you want to see how you can retrieve logging status and how to download the service log files from Azure. After downloading the log files, you would normally want to check what information is included in the log.

In this exercise, you will check the logging status for your storage account using PowerShell, then download and review a log file.

## Check Logging Status for Blob Storage

First, you will create a virtual machine scale set using the Azure portal.

1. In the Azure portal, on the top toolbar, click **Cloud Shell**.

1. In the Azure Cloud Shell pane, enter the following commands:

   ```powershell
   Get-AzStorageAccount
   Set-AzCurrentStorageAccount -Name <StorageAccountName> -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
   Get-AzStorageServiceLoggingProperty -ServiceType blob
   ```

   Where `<StorageAccountName>` is the name of the storage account you created in the first exercise; for example: **monitorstorageaccount**.
  
1. Notice which operations are currently logged and the log retention period. If `LoggingOperations` is set to `None`, then you will need to enable logging. To do so, enter the following command the Azure Cloud Shell pane:

   ```powershell
   Set-AzureStorageServiceLoggingProperty -ServiceType Blob -LoggingOperations read,write,delete -RetentionDays 5
   ```

> [!NOTE]
> For more information, see [Enabling Storage Logging and Accessing Log Data](https://docs.microsoft.com/rest/api/storageservices/enabling-storage-logging-and-accessing-log-data).

## Download and install Azure Storage Explorer

Download the Azure Storage Explorer tool in order to download the storage analytics log files.

1. Open a new tab in your browser, and navigate to https://azure.microsoft.com/features/storage-explorer/.

1. Ensure you have the correct operating system selected, and then click **Download Storage Explorer free**.

1. If a popup dialog appears asking what to do with the file, click **Save**.

1. When the download is complete, launch the downloaded file.

1. If prompted to approve **User Account Control**, click **Yes**.

1. In the **Setup - Microsoft Azure Storage Explorer** dialog box, select **I accept the agreement**, and then click **Install**.

1. On the **Select Destination Location** page, click **Next**.

1. On the **Select Start Menu Folder** page, click **Next**.

1. On the **Completing the Microsoft Azure Storage Explorer Setup Wizard** page, click **Finish**.

## Use Azure Storage Explorer to download storage log files

1. Launch the **Microsoft Azure Storage Explorer**.

1. On the left-side toolbar, click the icon for **Add Account**.

1. When the **Connect to Azure Storage** dialog box appears:

   1. Click **Add an Azure Account**, and then click **Sign in**.

   1. In the **Sign in** dialog box, enter your username for your Azure subscription, and then click **Next**.

   1. If a page appears asking you to select between **Work or school account** and **Personal account**, select the appropriate option for your account.

   1. Enter your password, and then click **Sign In**.
  
   1. If you are prompted for a Two-Factor Authentication (2FA) code, enter the code from your authenticator app, and then click **Verify**.

    1. If a dialog box appears with the message **Let Us Know What You Think**, click **Dismiss**.

1. In **Microsoft Azure Storage Explorer**:

   1. If you are prompted to choose an Azure subscription, make sure that you choose the subscription that you used when you created your Azure Storage Account, and then click **Apply**.

   1. In the Explorer view, under the associated Azure subscription, expand **Storage Accounts**, expand the storage account you created in the first exercise, and expand **Blob Containers**.

   1. Click **$logs**.

   1. In the details pane, double-click the **blob** folder, double-click the folder for the current year, double-click the folder for the current month, double-click the folder for the current day, double-click a folder for the hour.

   1. Select one of the log files, and on the toolbar, click **Open**. A notepad window should open showing the log entries. Note that semicolons delimit each of the fields captured in an entry, and a new line denotes the next entry.

   1. Close the **Notepad** window showing the contents of the log file.

## Optional - View log data in Excel

If you have microsoft Excel, you can download and import the log data for more easy analysis.

1. In **Microsoft Azure Storage Explorer**, ensure that a log file is still selected, and on the toolbar, click **Download**.

1. In the **Specify where to save the downloaded blob** dialog box, select a location on your local computer, such as your **Downloads** folder, and then click **Save**.

1. Click **Start**, on the start menu, click **Excel**.

1. In **Excel**, click **Blank workbook**.

1. In **Excel**, on the **Data** tab, click the **Get Data** menu, click **From File**, then click **From Text/CSV**.

1. In the **Import Data** dialog box, in the **Text Files (\*.prn;\*.txt;\*.csv)** drop down, select **All Files (*.*)**.

1. In the **Import Data** dialog box, browse to the location you downloaded the log file, such as **Downloads**, select the downloaded log file, and click **Import**.

1. In the log file preview window, ensure that **Delimiter** shows **Semicolon**, and that the entries appear to have columns correctly separated by field, then click **Load**.

1. Review the log data in Excel. You can use the log format reference from the previous unit to identify which columns show which information.
