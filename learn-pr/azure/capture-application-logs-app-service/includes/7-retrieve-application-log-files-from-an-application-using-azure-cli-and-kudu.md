Your new Web app for Contoso Fashions is nearly ready for some initial pilot testing, and you'd like to review and analyze all the various trace messages that have been saved to your app's log files. But before you can do any review, you need to know how to find  the logged information.

In this unit, you'll retrieve log files ready for later offline analysis. 

::: zone pivot="csharp"

### Retrieve file system logs using Azure CLI

In this step, you'll use Azure CLI to retrieve file system logs to your cloud share storage, and then view these logs.
>[!NOTE]
>
>The full Azure Cloud Shell has a toolbar that includes a file download and upload tool, and you could use this option to download contosofashions.zip to your local computer. This functionality is not currently available in the Microsoft Learn sandbox shell. So, in this exercise, you'll use some Bash tools to view the logs from within the Cloud Shell file share.

1. In the Azure Cloud Shell, run the following command to download the logs to **contosofashions.zip** in the cloud share storage, replacing **\<_your-number_\>** with the random number that was generated to uniquely identify your app.
   ```azurecli
   az webapp log download --log-file contosofashions.zip  --resource-group <rgn>[sandbox resource group name]</rgn> --name contosofashions<your-number>
   ```
1. In the Azure Cloud Shell, run the following command to show the log files contained in the downloaded **contosofashions.zip** file.

   ```
   zipinfo -1 contosofashions.zip
   ```

1. In the Azure Cloud Shell, run the following command to extract just the application log file from the downloaded **contosofashions.zip** file.

   ```
   unzip -j contosofashions.zip LogFiles/Application/*.txt
   ```

1. In the Azure Cloud Shell, run the following command to display the application log file.

   ```
   code *.txt
   ```

1. Click in the Azure Cloud Shell, and then press Ctrl + Q to close the editor.


### Retrieve file system logs using Kudu

In this step, you'll use the Kudu console to download file system logs to your computer.

1. In the Azure portal, click **App Services** in the sidebar menu on the left.
1. In the **App Services** list, click **contosofashions\<_your-number_\>**, and then in the **Development Tools** section, click **Advanced Tools**, and then on the Advanced Tools blade, click **Go**. 
1. In the new Kudu Services tab, in the **Kudu** menu, click **Debug Console**, and then click **CMD**.
1. In the file explorer section, click **LogFiles**.
1. Click the **Download** button for the **Application** folder; the logs will be downloaded to your computer as **Application.zip**.
1. On your computer, open **Application.zip**, and view the log file; this should be the same logs as you looked at using the Cloud Shell.
1. Close the Kudu Services tab.

### Search logs saved in Azure Blob Storage

In this step, you'll open the verbose logs that were saved into your Azure Blob Storage container, and then search for specific log entries.

1. In the Azure portal, click **Storage accounts** in the sidebar menu on the left.

1. In the **Storage accounts** list, click **sacontosofashions\<_your-number_\>**, and then in the top section of the storage account blade, click **Storage Explorer (Preview)**. 

1. In the Storage Explorer (preview) blade, expand **BLOB CONTAINERS**, and then click **asp logs**.

1. In the container blade, double-click **contosofashions\<_your-number_\>**, then double-click each of the year, month, and date folders.

1. You should now see a folder for each hour that the application has been logging to blob storage. Double-click the hour folder (or the earliest, if there is more than one).

1. The folder should contain one or more CSV files; double-click the largest file (you may need to scroll right to see the file sizes) to download it. If you have Microsoft Excel on your computer, the log file will automatically open as a worksheet; otherwise, open the file using a text editor such as Notepad.

1. In the opened log file, search for the following string.

   ```
   Warning message
   ```

1. There should be several occurrences of this message in the log.

1. Close the log file.

::: zone-end

::: zone pivot="javascript"

### Retrieve file system logs using Azure CLI

In this step, you'll use Azure CLI to retrieve file system logs to your cloud share storage, and then view these logs.

> [!NOTE]
>
> The full Azure Cloud Shell has a toolbar that includes a file download and upload tool, and you could use this option to download contosofashions.zip to your local computer. This functionality is not currently available in the Microsoft Learn sandbox shell. So, in this exercise, you'll use some Bash tools to view the logs from within the Cloud Shell file share.

1. In the Azure Cloud Shell, run the following command to download the logs to **contosofashions.zip** in the cloud share storage, replacing **\<_your-number_\>** with the random number that was generated to uniquely identify your app.

   ```azurecli
   az webapp log download --log-file contosofashions.zip  --resource-group <rgn>[sandbox resource group name]</rgn> --name contosofashions<your-number>
   ```
1. In the Azure Cloud Shell, run the following command to show the log files contained in the downloaded **contosofashions.zip** file.

   ```
   zipinfo -1 contosofashions.zip
   ```

1. In the Azure Cloud Shell, run the following command to extract just the application log file from the downloaded **contosofashions.zip** file.

   ```
   unzip -j contosofashions.zip LogFiles/*docker*.log
   ```

1. In the Azure Cloud Shell, run the following command to display the application log file.

   ```
   code *default_docker.log
   ```

1. Click in the Azure Cloud Shell, and then press Ctrl + Q to close the editor.

### Retrieve file system logs using Kudu

In this step, you'll use the Kudu console to retrieve file system logs.

1. In the Azure portal, click **App Services** in the sidebar menu on the left.
1. In the **App Services** list, click **contosofashions\<_your-number_\>**, and then in the **Development Tools** section, click **Advanced Tools**, and then on the Advanced Tools blade, click **Go**. 
1. In the **Azure App Service** page, click the **Download as Zip** link next to **Current Docker Logs**; the logs will be downloaded to your computer as **dockerlogs\<_date-time_\>.zip**.
1. On your computer, open **dockerlogs\<_date-time_\>.zip**, and view the **default_docker.log** file; this should be the same logs as you looked at using the Cloud Shell.
1. Close the Kudu Services tab.

::: zone-end