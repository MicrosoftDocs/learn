## Motivation

Before moving client proofs into Azure Blob storage, you want to see how you can retrieve logging status and how to download the service log files from Azure. After downloading the log files, you would normally want to check what information is included in the log.

In this exercise, you will check the logging status for your storage account using PowerShell, then download and review a log file.

## Check Logging Status for Blob Storage
First, you will create a virtual machine scale set using the Azure portal.

1. In the Azure portal, on the top toolbar, click **Cloud Shell**.
2. In the Azure Cloud Shell pane, type the following command and press ENTER. 

```powershell
Get-AzStorageAccount
Set-AzCurrentStorageAccount -Name <StorageAccountName> -ResourceGroupName MonitorResourceGroup
Get-AzStorageServiceLoggingProperty -ServiceType blob
```

Where <StorageAccountNAme> is the name of the storage account you created in the first exercise.
Notice which operations are currently logged and the log retention period.

## Download and install Azure Storage Explorer
Download the Azure Storage Explorer tool to be able to download the storage analytics log files.

1. Open a new tab in your browser, and navigate to https://azure.microsoft.com/features/storage-explorer/.
2. Ensure you have the right operating system selected, and then click **Download Storage Explorer for free**.
3. If a popup dialog appears asking what to do with the file, click **Save**.
4. When a message appears to say the download is complete, click **Run** or launch the downloaded file.
5. In the **User Account Control** dialog box, click **Yes**.
6. In the **Setup - Microsoft Azure Storage Explorer** dialog box, select **I accept the agreement**, and then click **Install**.
7. On the **Select Destination Location** page, click **Next**.
8. On the **Select Start Menu Folder** page, click **Next**.
9. On the **Completing the Microsoft Azure Storage Explorer Setup Wizard** page, click **Finish**.

## Use Azure Storage Explorer to download storage log files

1. In the **Microsoft Azure Storage Explorer - Connect** window, click **Sign in**.
2. In the **Sign in** box enter your username for your Azure subscription and click **Next**.
3. If a page appears asking you to select between **Work or school account** and **Personal account**, select the appropriate option for your account.
4. Enter your password and click **Sign In**.
5. If a dialog box appears with the message **Let Us Know What You Think**, click **Dismiss**.
6. In **Microsoft Azure Storage Explorer**, in the Explorer view, under the associated Azure subscription, expand **Storage Accounts**, expand the storage account you created in the first exercise, and expand **Blob Containers**.
7. Click **$logs**.
8. In the details pane, double-click the **blob** folder, double-click the folder for the current year, double-click the folder for the current month, double-click the folder for the current day, double-click a folder for the hour.
9. Select one of the log files, and on the toolbar, click **Open**. A notepad window should open showing the log entries. Note that semicolons delimit each of the fields captured in an entry, and a new line denotes the next entry.
10. Close the **Notepad** window showing the contents of the log file.

## Optional - view log data in Excel
If you have microsoft Excel, you can download and import the log data for more easy analysis.

1. In **Microsoft Azure Storage Explorer**, ensure that a log file is still selected, and on the toolbar, click **Download**.
2. In the **Specify where to save the downloaded blob** dialog box, select a location on your local computer, such as your **Downloads** folder, and then click **Save**.
3. Click **Start**, on the start menu, click **Excel**.
4. In **Excel**, click **Blank workbook**.
5. In **Excel**, on the **Data** tab, click the **Get Data** menu, click **From File**, then click **From Text/CSV**.
6. In the **Import Data** dialog box, in the **Text Files (*.prn;*.txt;*.csv)** drop down, select **All Files (*.*)**.
7. In the **Import Data** dialog box, browse to the location you downloaded the log file, such as **Downloads**, select the downloaded log file, and click **Import**.
8. In the log file preview window, ensure that **Delimiter** shows **Semicolon**, and that the entries appear to have columns correctly separated by field, then click **Load**.
9. Review the log data in Excel. You can use the log format reference from the previous unit to identify which columns show which information.

## Summary
In this exercise, you applied the knowledge you gained in the previous module in a practical environment. You checked the logging setting for a storage account, and then used the Azure Storage Explorer to download storage logs. 