Your new Web App for Contoso Fashions is nearly ready for some initial pilot testing. You want to review and analyze all the various trace messages that have been saved to your app's log files. Before you can do any review, you need to know how to find the logged information.

In this unit, you retrieve log files ready for later offline analysis.

### Retrieve file system logs using Azure CLI

In this step, you use Azure CLI to retrieve file system logs to your cloud share storage, and then view these logs.

   > [!NOTE]
   > The full Cloud Shell has a toolbar that includes a file download and upload tool, and you could use this option to download contosofashions.zip to your local computer. This functionality is not currently available in the Microsoft Learn sandbox shell. So, in this exercise, to view the logs from within the Cloud Shell file share, we use some Bash tools.

1. In Cloud Shell, to download the logs to **contosofashions.zip** in the cloud share storage, replacing **\<_your-number_\>** with the random number that was generated to uniquely identify your app, run the following command.

    ```azurecli
   az webapp log download --log-file contosofashions.zip  --resource-group <rgn>[sandbox resource group name]</rgn> --name contosofashions<your-number>
   ```

1. In Cloud Shell, to show the log files contained in the downloaded **contosofashions.zip** file, run the following command.

    ```azurecli
   zipinfo -1 contosofashions.zip
   ```

1. In Cloud Shell, to extract just the app log file from the downloaded **contosofashions.zip** file, run the following command.

   ```azurecli
   unzip -j contosofashions.zip LogFiles/Application/*.txt
   ```

1. In Cloud Shell, to display the application log file, run the following command.

   ```azurecli
   code *.txt
   ```

1. In Cloud Shell, press <kbd>Ctrl+Q</kbd> to close the editor.

### Retrieve file system logs using Kudu

In this step, to download file system logs to your computer, use the Kudu console.

1. On the Azure portal menu, or from the **Home** page, select **App Services**. The **App Services** pane appears.

1. In the **App Services** list, select **contosofashions\<_your-number_\>**. The **contosofashions\<_your-number_\>** App Service pane appears.

1. In the middle menu pane, under**Development Tools**, select **Advanced Tools**.  The **Advanced Tools** pane appears.

1. Select **Go**. The *Kudu Services* window appears.

1. In the top menu bar, select **Debug console**, and then select **CMD**.

1. In the file explorer section, select **LogFiles**.

1. For the **Application** folder, select **Download**. The logs are downloaded to your computer as **Application.zip**.

1. On your computer, open **Application.zip**, and view the log file. These logs should be the same as the ones you looked at using Cloud Shell.

1. Close the Kudu Services tab.

### Search logs saved in Azure Blob Storage

In this procedure, you open the verbose logs that were saved into your Azure Blob Storage container, and then search for specific log entries.

1. On the Azure portal menu or from the **Home** page, select **Storage accounts**. The **Storage accounts** pane appears.

1. In the **Storage accounts** list, select **sacontosofashions\<_your-number_\>**.

1. In the middle menu pane, select **Storage browser**. The **Storage browser** pane appears.

1. Expand **Blob containers**, and then select **appsrvplogs**.

1. In the container pane, double-click **contosofashions\<_your-number_\>**, then double-click each of the year, month, and date folders.

1. You should now see a folder for each hour that the application has been logging to blob storage. Double-click the hour folder (or the earliest, if there's more than one).

1. The folder should contain one or more CSV files; to download it, double-click the largest file (you may need to scroll right to see the file sizes). If you have Microsoft Excel on your computer, the log file automatically opens as a worksheet. Otherwise, open the file using a text editor, such as Notepad.

1. In the opened log file, search for the following string.

   ```txt
   Warning message
   ```

    There should be several occurrences of this message in the log.

1. Close the log file.
