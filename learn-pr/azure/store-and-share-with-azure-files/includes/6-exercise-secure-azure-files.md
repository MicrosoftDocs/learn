Azure provides several options to improve security and restrict access to file shares you've created.

The finance company you're working for wants to migrate existing data files from their on-premises file shares. Before moving these files to the cloud, the company wants to ensure that only their datacenter and branch offices can access them. To ensure security is in place, you'll enable secure transfers, and then allow access only from a specific set of IP addresses.

In this exercise, you'll check that secure transfers are enforced on the file shares you created previously. After checking, you'll add firewall rules to restrict access to a specific IP address, and then test that it can't be accessed from anywhere else. Finally, you'll create a snapshot of your file share that you can use to recover files.

## Enable secure file transfer

1. Open your local browser to sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. In the portal menu on the left, select **Storage accounts**.

1. Select the created storage account that should be named **learnazurefileshare** followed by random numbers.

1. Under **Settings**, select **Configuration**.

    :::image type="content" source="../media/5-secure-transfer.png" alt-text="Screenshot of the configuration page of storage accounts.":::

1. Check that **Secure transfer required** is enabled.

## Add a firewall rule to restrict access to an IP address

1. Under **Settings**, select **Networking** > **Firewalls and virtual networks**.

   :::image type="content" source="../media/6-add-firewall-protections.png" alt-text="Screenshot showing the firewalls and virtual networks options.":::

1. Under **Allow access from**, select the **Selected networks** option.

1. Under **Firewall**, in the address range input, note the public IP address of your VM. You can see this address in the title bar of the remote desktop connection.

1. Select **Save**.

## Test security of the file share

1. On your host machine, try to mount one of the network shares.

1. In your browser, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. In the portal menu on the left, select **Storage Accounts**.

1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.

1. Select **File shares**.

    ![Screenshot of the Azure portal showing the storage account overview](../media/4-select-file-shares.png)

1. You should see **Access Denied**.

    ![Screenshot showing access is denied to the share](../media/6-access-denied.png)

1. Return to the **Firewalls and virtual networks** settings.

1. Select the **Add your client IP address** check box, and select **Save**.

1. Select **Overview**, and then select **File shares**.

1. Select the **data** file share. You can now browse the file share in your local browser.

    > [!NOTE]
    > You might need to go to the reports share because the error page could be cached for the data file share.

1. Use the browser on your computer to download AzCopy by going to [https://aka.ms/downloadazcopy-v10-windows](https://aka.ms/downloadazcopy-v10-windows).

1. Connect to your VM by using the remote desktop connection.

1. Open the file share in the Azure portal, upload the azcopy.exe file so it is avalibal on the VM. On the VM drag to the desktop for easy use.

    ![Screenshot of expanding the AzCopy zip folder](../media/6-unzip-azcopy.png)

1. Select the **azcopy** zip file.

1. On the menu, select **Compressed Folder Tools**, and then select **Extract all**.

1. In the Extract Compressed (Zipped) Folders window, select **Extract**.

1. Select **Start**, select the **Windows PowerShell folder**, and then select **Windows PowerShell**.

1. Move to the folder that contains **AzCopy**.

    ```powershell
    cd C:\Users\azureuser\Desktop
    ```

1. Run AzCopy to copy the files to Azure by first signing in to the sandbox.

    ```powershell
    .\azcopy.exe login
    ```
    
    > [!NOTE]
    > Due to security you now need to use an external web browser.  You will need to type the URL into another device, your phone works well.  Enter the code to completed the connection.

## Copy local files to Azure

1. Create some local example test files by using PowerShell.

    ```powershell
    1..100 | % { New-Item -Path F:\ -Name "$_.txt" -Value (Get-Date).toString() -ItemType file}
    ```

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. In the portal menu on the left, select **Storage Accounts**.

1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.

1. Under **Settings**, select **Shared access signatures**.

    :::image type="content" source="../media/6-sas-connection-string.png" alt-text="Screenshot showing Shared access signatures.":::

    AzCopy requires a shared access signature (SAS) to authorize access to the share.

1. Select **Generate SAS and connection string**.

1. Copy the **File service SAS URL**.

1. Paste the connection string into Notepad, and add a path to the data share. Change the string by adding `data/` to the path from:

    `https://learnazurefileshare6438.file.core.windows.net/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D`

    to:

    `https://learnazurefileshare6438.file.core.windows.net/data/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D`

1. Use this new SAS connection string in the AzCopy command to copy the files to Azure. Run this command in the PowerShell window.

    ```powershell
    .\azcopy copy "D:\*.txt" "https://learnazurefileshare6438.file.core.windows.net/data/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D" --recursive=true
    ```

1. You should see the following output from AzCopy.

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
    ``` -->

## Create a share snapshot

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), in the portal menu on the left, select **Storage Accounts**.

1. Select the created storage account. It should be named **learnazurefileshare** followed by random numbers.

1. Select **File shares**, and then select the **data** share.

1. In the **Operations** section, select **Snapshots**.

1. Select **+ Add snapshot**, and select **OK**.

1. Return to your VM, and open **File Explorer**.

1. Browse to the data share mounted at the **F** drive, right-click any of the text files, and select **Properties**.

1. In the File properties window, select **Previous Versions**, and note the listed snapshots created on the file share.

    ![Screenshot of the file properties window showing previous snapshots](../media/6-previous-versions.png)

    From here, you can select **Open** to open the previous version to browse the files at that snapshot. Otherwise, you can select **Restore** to restore files from a snapshot.
