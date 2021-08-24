Azure provides several options to improve security and restrict access to file shares you've created.

The finance company you're working for wants to migrate existing data files from their on-premises file shares. Before moving these files to the cloud, the company wants to ensure that only their datacenter and branch offices can access them. To ensure security is in place, you'll enable secure transfers, and then allow access only from a specific set of IP addresses.

In this exercise, you'll check that secure transfers are enforced on the file shares you created previously. After checking, you'll add firewall rules to restrict access to a specific IP address, and then test that it can't be accessed from anywhere else. Finally, you'll create a snapshot of your file share that you can use to recover files.

## Enable secure file transfer

1. In the Azure portal you should still have open from the previous exercise, select the storage account you created, named **learnazurefileshare** followed by random numbers.

1. In the middle menu pane, under **Settings**, select **Configuration**.

    :::image type="content" source="../media/5-secure-transfer.png" alt-text="Screenshot of the configuration page of storage accounts.":::

1. Ensure that **Secure transfer required** is enabled.

## Add a firewall rule to restrict access to an IP address

1. In the middle menu pane, under **Security + networking**, select **Networking**. The Storage account **Networking** pane appears with the **Firewalls and virtual networks** tab highlighted.

   :::image type="content" source="../media/6-add-firewall-protections.png" alt-text="Screenshot showing the firewalls and virtual networks options.":::

1. Under **Allow access from**, select **Selected networks**.

1. Under **Firewall**, in the address range input, note the public IP address of your VM. You can see this address in the title bar of the remote desktop connection.

1. On the top menu bar, select **Save**.

## Test security of the file share

1. On your host machine, try to mount one of the network shares.

1. In the Azure portal you should still have open, select the storage account you previously created, named **learnazurefileshare** followed by random numbers.

1. In the left menu pane, under **Data storage**, select **File shares**. The **File shares** pane appears for your storage account.

    ![Screenshot of the Azure portal showing the storage account overview.](../media/4-select-file-shares.png)

1. You should see **Access Denied**.

    ![Screenshot showing access is denied to the share.](../media/6-access-denied.png)

1. In the middle menu pane, under **Security + networking**, select **Networking**. The **Firewalls and virtual networks** tab is highlighted.

1. Select the **Add your client IP address** check box, and in the top menu bar, select **Save**.

1. In the left menu pane, select **Overview**, and under **Data storage**, select **File shares**.

1. Select the **data** file share. You can now browse the file share in your local browser.

    > [!NOTE]
    > You might need to go to the reports share because the error page could be cached for the data file share.

1. Use the browser on your computer to download AzCopy by going to [https://aka.ms/downloadazcopy-v10-windows](https://aka.ms/downloadazcopy-v10-windows).

1. Connect to your VM by using the remote desktop connection.

1. Open the file share in the Azure portal, upload the azcopy.exe file so it is available on the VM.

1. On the VM, drag the file to the desktop for easy use.

    ![Screenshot of expanding the AzCopy zip folder.](../media/6-unzip-azcopy.png)

1. Select the **azcopy** zip file.

1. On the menu, select **Compressed Folder Tools**, and then select **Extract all**.

1. In the Extract Compressed (Zipped) Folders window, select **Extract**.

1. Select **Start**, then select the **Windows PowerShell folder**, and then select **Windows PowerShell**.

1. Move to the folder that contains **AzCopy**.

    ```powershell
    cd C:\Users\azureuser\Desktop
    ```

1. Run AzCopy to copy the files to Azure by first signing in to the sandbox.

    ```powershell
    .\azcopy.exe login
    ```

    > [!NOTE]
    > To optimize security, you need to use an external web browser. Enter the URL into another device. Your phone works well for this step. Enter the code to complete the connection.

## Copy local files to Azure

1. Create some local example test files using PowerShell.

    ```powershell
    1..100 | % { New-Item -Path F:\ -Name "$_.txt" -Value (Get-Date).toString() -ItemType file}
    ```

1. In the Azure portal you should still have open, select the storage account you previously created, named **learnazurefileshare** followed by random numbers.

1. In the left menu pane, under **Security + networking**, select **Shared access signature**.

    :::image type="content" source="../media/6-sas-connection-string.png" alt-text="Screenshot showing Shared access signatures.":::

    AzCopy requires a shared access signature (SAS) to authorize access to the share.

1. At the bottom of the pane, select **Generate SAS and connection string**.

1. Copy the **File service SAS URL**.

1. Paste the connection string into Notepad, and add a path to the data share. Change the string by adding `data/` to the path from:

    `https://learnazurefileshare6438.file.core.windows.net/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D`

    to:

    `https://learnazurefileshare6438.file.core.windows.net/data/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D`

1. Use this new SAS connection string in the AzCopy command to copy the files to Azure. Run this command in the PowerShell window.

    ```powershell
    .\azcopy copy "D:\*.txt" "https://learnazurefileshare6438.file.core.windows.net/data/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-05T20:46:09Z&st=2019-12-05T12:46:09Z&spr=https&sig=TW1ZMwzksKMhKMqJxSCMBy5wFmut7yuR3vNlTSwFhKQ%3D" --recursive=true
    ```

    You should see the following output from AzCopy.

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

1. In the Azure portal you should still have open, select the storage account you previously created, named **learnazurefileshare** followed by random numbers.

1. In the left menu pane, under **Data storage**, select **File shares**. The Storage account **File shares** pane appears.

1. Select the **data** share.

1. In the **Operations** section, select **Snapshots**.

1. Select **Add snapshot**, and then select **OK**.

1. Return to your VM, and open **File Explorer**.

1. Browse to the data share mounted on the **F** drive, right-click any of the text files, and select **Properties**.

1. In the File properties window, select **Previous Versions**, and note the listed snapshots created on the file share.

    ![Screenshot of the file properties window showing previous snapshots.](../media/6-previous-versions.png)

1. From here, you can select **Open** to open the previous version to browse the files at that snapshot. Otherwise, you can select **Restore** to restore files from a snapshot.
