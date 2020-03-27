Azure File Sync provides multiple ways to monitor and diagnose sync issues. Tools are provided in the sync group, and are on the Windows Server. You can also set up alerts in Azure Monitor. 

You've deployed Azure File Sync and configured both the Azure and on-premises environments. Now, you need to troubleshoot a rogue file that's not syncing. You'll use the tools provided by Microsoft.

In this exercise, you'll first check that file sync is working correctly. Then generate a file with invalid characters. You'll see how to diagnose sync issues and resolve them.

## Find your connection details

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the same account you activated the sandbox with.
1. Go to the storage account. Select **All resources** > **extendcadfiles**.
1. Under **Settings**, select **Access keys**.

   ![Screenshot the access key option under settings.](../media/10-access-keys-option.png)

1. Under **key1**, copy the **Key** value. You'll use this key to set up the mapped drive.

## Create a mapped drive to Azure File Share

1. If you closed your Remote Desktop Connection, use the following steps to connect to the virtual machine (VM).
    1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the same account you activated the sandbox with.
    1. Go to **Virtual machines** > **FileServerLocal**.
    1. Select **Connect** > **Download RDP File** > open the RDP file.
    1. In the **Windows Security** window, select **More choices** > **Use a different account**.
    1. Enter the username **learnadmin** and the password you used when you created the VM.
1. On the toolbar, select **File Explorer** > **This PC**.
1. In the menu bar, select **Computer** > **Map network drive**.
1. In the Folder, type **\\\extendcadfiles.file.core.windows.net\cadfileshare**.
1. Check **Connect using different credentials**.
1. Select **Finish**.
1. For user name, type **AZURE\extendcadfiles**.
1. For the password, paste the key you copied above.
1. Select **OK**.

## Check file sync

1. Open a new **File Explorer** window.
1. Put the two File Explorer windows side by side, with **D:\CADFolder** on the left and the mapped **cadfilesshare** on the right.

    ![Screenshot of two File Explorer windows side by side.](../media/10-side-by-side.png)

1. In the left window, below the **CADFolder**, right-click to open the context menu and select **New** > **Text Document**.
1. Rename the file to **test**.
1. Wait to see the file replicated to the Azure file share in the right window.

## Create an invalid file

1. Go to the **CADFolder** in both windows.
1. Open **create-bad-file.js** on the left.
1. See that a new file named, **invalid╘«nameÉ.txt** has been created.
1. This file won't replicate into the Azure file share.

## Troubleshoot file synchronization

You can troubleshoot on your on-premises server or on the Azure portal. Syncing to the portal can take some time, so start troubleshooting locally.

### View the file sync issue on the Windows Server

1. Right-click on **Start**, the select **Windows PowerShell (Admin)**.
1. In the console move to the File Sync folder.

    ```powershell
    cd 'C:\Program Files\Azure\StorageSyncAgent\'
    ```
1. Run the error report script.

    ```powershell
    .\FileSyncErrorsReport.ps1
    ```

    ![Screenshot of the PowerShell window showing the error report.](../media/10-powershell-sync-error.png)

1. View the output of the command. The **ErrorDescription** field describes what's wrong. The **ItemPath** field gives the location of the problematic file.

1. Verify that the error is `0x8007007b` and that it relates to the invalid file we generated.

### View the file sync issue in Azure portal

1. On your local machine, return to the Azure portal.
1. Go to the sync group. Select **All resources** > **CADSyncService** > **CADFiles**.
1. Under server endpoints, select **FileServerLocal**.
1. Next to **Transient**, select **1 files**. It may take a few minutes for the file to show up.

    ![Screenshot of the Server Endpoint Properties shows a transient error.](../media/10-transient-error.png)

1. Under **Remediation**, Azure provides advice on how to resolve the issue.

Because the file sync issues just started, they're listed as transient. If this file remained in the folder with the invalid characters for more than 24 hours, the status would change to a persistent error.

### Resolve the file sync

1. Return to the Remote Desktop Connection.
1. Remove the invalid characters from the file. In the left **File Explorer**, rename the **invalid╘«nameÉ.txt** file to **valid-name**.
1. The file should now sync. Confirm the sync works by rerunning the following command.

    ```powershell
    .\FileSyncErrorsReport.ps1
    ```

    ![Screenshot showing running the report, and no errors are found.](../media/10-error-fixed.png)