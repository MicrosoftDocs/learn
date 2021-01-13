Your new Web app for Contoso Fashions is nearly ready for some initial pilot testing, and you'd like to review and analyze all the various trace messages that have been saved to your app's log files. Before you can do any review, you need to know how to find the logged information.

In this unit, you'll retrieve log files ready for later offline analysis.

### Retrieve file system logs using Azure CLI

In this step, you'll use Azure CLI to retrieve file system logs to your cloud share storage, and then view these logs.

   > [!NOTE]
   > The full Azure Cloud Shell has a toolbar that includes a file download and upload tool, and you could use this option to download contosofashions.zip to your local computer. This functionality is not currently available in the Microsoft Learn sandbox shell. So, in this exercise, to view the logs from within the Cloud Shell file share, you'll use some Bash tools.

1. In the Azure Cloud Shell, to download the logs to **contosofashions.zip** in the cloud share storage, replacing **\<_your-number_\>** with the random number that was generated to uniquely identify your app, run the following command.

    ```azurecli
   az webapp log download --log-file contosofashions.zip  --resource-group <rgn>[sandbox resource group name]</rgn> --name contosofashions<your-number>
   ```

1. In the Azure Cloud Shell, to show the log files contained in the downloaded **contosofashions.zip** file, run the following command.

    ```
   zipinfo -1 contosofashions.zip
   ```

1. In the Azure Cloud Shell, to extract just the app log file from the downloaded **contosofashions.zip** file, run the following command.

   ```
   unzip -j contosofashions.zip LogFiles/Application/*.txt
   ```

1. In the Azure Cloud Shell, to display the application log file, run the following command.

   ```
   code *.txt
   ```

1. Click in the Azure Cloud Shell, and to close the editor, press <kbd>Ctrl+Q</kbd>.

### Retrieve file system logs using Kudu

In this step, to download file system logs to your computer, you'll use the Kudu console.

1. On the Azure portal menu, or from the **Home** page, select **App Services**.

1. In the **App Services** list, select **contosofashions\<_your-number_\>**.

1. In the **Development Tools** section, select **Advanced Tools**, and on the Advanced Tools pane, select **Go**.

1. In the new **Kudu Services** tab, in the **Kudu** menu, select **Debug console**, and then select **CMD**.

1. In the file explorer section, select **LogFiles**.

1. For the **Application** folder, select **Download**. The logs will be downloaded to your computer as **Application.zip**.

1. On your computer, open **Application.zip**, and view the log file; this should be the same logs as you looked at using the Cloud Shell.

1. Close the Kudu Services tab.

### Search logs saved in Azure Blob Storage

In this procedure, you'll open the verbose logs that were saved into your Azure Blob Storage container, and then search for specific log entries.

1. On the Azure portal menu or from the **Home** page, select **Storage accounts**.

1. In the **Storage accounts** list, select **sacontosofashions\<_your-number_\>**, and then in the top section of the storage account pane, select **Storage Explorer (Preview)**.

1. In the **Storage Explorer (preview)** pane, expand **BLOB CONTAINERS**, and then select **asplogs**.

1. In the container pane, double-click **contosofashions\<_your-number_\>**, then double-click each of the year, month, and date folders.

1. You should now see a folder for each hour that the application has been logging to blob storage. Double-click the hour folder (or the earliest, if there is more than one).

1. The folder should contain one or more CSV files; to download it, double-click the largest file (you may need to scroll right to see the file sizes). If you have Microsoft Excel on your computer, the log file will automatically open as a worksheet; otherwise, open the file using a text editor, such as Notepad.

1. In the opened log file, search for the following string.

   ```
   Warning message
   ```

   There should be several occurrences of this message in the log.

1. Close the log file.
