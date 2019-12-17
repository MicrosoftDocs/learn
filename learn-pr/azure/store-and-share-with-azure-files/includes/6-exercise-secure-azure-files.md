Azure provides several options to improve security and restrict access to file shares you've created. 

The finance company you're working for wants to migrate existing data files from their on-premises file shares. Before moving these files to the cloud, the company wants to ensure that only their data center and branch offices can access them. To ensure security is in place, you'll enable secure transfers, and then only allow access from a specific set of IP addresses.

In this exercise, you'll check that secure transfers are enforced on the file shares you created previously. After checking, you'll add firewall rules to restrict access to a specific IP address, then test that it can't be accessed from anywhere else. You'll use AzCopy to move all the local files to Azure now that adequate security is in place.

## Enable secure file transfer

1. Connect to your VM using the Remote Desktop Connection.
1. Use the browser to sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. In the portal menu on the left, select **Storage Accounts**.
1. Select the created storage account that should be named **learnazurefileshare** followed by random numbers.
1. Under **Settings**, select **Configuration**.

    ![Screenshot of the configuration page of storage accounts](../media/5-secure-transfer.png)

1. Check that **Secure transfer required** is enabled.

## Add a firewall rule to restrict access to an IP address

1. Under **Settings**, select **Firewalls and virtual networks**.

    ![Screenshot showing the firewalls and virtual networks options](../media/6-add-firewall-protections.png)

1. Select to allow access from **Selected networks**.
1. Under Firewall, select **Add your client IP address**.
1. Select **Save**.

## Test security of the file share

1. On your host machine, try to mount one of the network shares.
1. In your browser, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. In the portal menu on the left, select **Storage Accounts**.
1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.
1. Select **File shares**.

    ![Screenshot of the Azure portal showing the storage account overview](../media/4-select-file-shares.png)

1. Select the **data** file share.

    ![Screenshot showing access is denied to the share](../media/6-access-denied.png)

1. Return to the **Firewalls and virtual networks** settings.
1. Select the **Add your client IP address** check box.
1. Select **Save**.
1. Select **Overview**, then select **File shares**.
1. Select the **data** file share.

## Install AzCopy and log in to Azure

1. Connect to your VM using the Remote Desktop Connection.
1. Use the browser to download AzCopy by going to [https://aka.ms/downloadazcopy-v10-windows](https://aka.ms/downloadazcopy-v10-windows).
1. In the browser, select **Save**.
1. Open the folder containing the zip file.

    ![Screenshot of expanding the AzCopy zip folder](../media/6-unzip-azcopy.png)

1. Select the **azcopy_windows_amd64** zip file.
1. In the menu, select **Compressed Folder Tools**, then select **Extract all**.
1. In the Extract Compressed (Zipped) Folders window, select **Extract**.
1. Select **Start**, then the **Windows PowerShell folder**, then select **Windows PowerShell**.
1. Move to the folder containing **AzCopy**.

    ```powershell
    cd C:\Users\azureuser\Downloads\azcopy_windows_amd64_10.3.2\azcopy_windows_amd64_10.3.2
    ```

1. Use AzCopy to copy the files to Azure, by first signing into the sandbox.

    ```powershell
    .\azcopy.exe login
    ```

1. The console prompts you to browse to [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin). Use the code displayed.

## Copy local files with AzCopy to Azure

1. Create some local example test files using PowerShell.

    ```powershell
    1..1000 | % { New-Item -Path D:\ -Name "$_.txt" -Value (Get-Date).toString() -ItemType file}
    ```

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. In the portal menu on the left, select **Storage Accounts**.
1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.
1. Under **Settings**, select **Shared access signatures**.

    ![text](../media/6-SAS-connection-string.png)

1. AzCopy requires a shared access signature to authorize access to the share. 
1. Select **Generate SAS and connection string**.
1. Copy the **File service SAS URL**.
1. Paste the connection string into notepad and add a path to the data share. Change the string by adding `data/` to the path from:

    https://learnazurefileshare6438.file.core.windows.net/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D
    
    To: 
    
    https://learnazurefileshare6438.file.core.windows.net/**data/**?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D

1. Use this new SAS connection string in the AzCopy command to copy the files to Azure. Use this command in the PowerShell window.

    ```powershell
    .\azcopy copy "D:\*.txt" "https://learnazurefileshare6438.file.core.windows.net/data/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D" --recursive=true
    ```

1. You should see the output from AzCopy:

    ```powershell
    INFO: Scanning...
    
    Job fadb5656-752c-0e46-6a01-703c18c6fe17 has started
    Log file is located at: C:\Users\azureuser\.azcopy\fadb5656-752c-0e46-6a01-703c18c6fe17.log
    
    99.6 %, 997 Done, 0 Failed, 4 Pending, 0 Skipped, 1001 Total, 2-sec Throughput (Mb/s): 0.0113
    
    
    Job fadb5656-752c-0e46-6a01-703c18c6fe17 summary
    Elapsed Time (Minutes): 0.1674
    Total Number Of Transfers: 1001
    Number of Transfers Completed: 1001
    Number of Transfers Failed: 0
    Number of Transfers Skipped: 0
    TotalBytesTransferred: 21650
    Final Job Status: Completed
    ```

## Create a share snapshot

1. On the [Azure portal](https://portal.azure.com/?azure-portal=true), in the portal menu on the left, select **Storage Accounts**.
1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.
1. Select **File shares**, then select the **data** share.
1. At the top of the pane, select **Create Snapshot**.

    ![Screenshot showing the Create Snapshot option](../media/5-create-a-snapshot.png)

1. Return to your VM, and open **File Explorer**.
1. Browse to the data share mounted at the **A:** drive, right-click on any of the text files, and select **Properties**. 
1. In the File properties window, select **Previous Versions**, and see the listed snapshots created on the file share.

    ![Screenshot of the file properties window, showing previous snapshots](../media/6-previous-versions.png)