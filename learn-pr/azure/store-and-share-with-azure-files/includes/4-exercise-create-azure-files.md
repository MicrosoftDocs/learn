Azure storage accounts enable organizations to replicate their on-premises file shares in a secure, resilient cloud service. Companies can then remove redundant hardware and infrastructure that support the internal SANs and NAS. At the same time, a company can reduce the risk of files being unavailable because of a hardware failure.

The finance company has asked you to duplicate the two file shares that they currently have on-premises. It uses one file share for reports and the other for application data. The storage account needs to be resilient to datacenter failures. That's why you'll create it to use GRS redundancy.

In this exercise, you'll first create a new storage account and two file shares for reports and application data. You'll then create a Windows VM to use as your example customer machine. You'll use the Windows VM to mount drives where you access the file shares. Finally, you'll map two drives to the new Azure file shares and copy reports to them.

## Create a GRS storage account

1. Create a storage account by copying the Azure CLI command and pasting it into Azure Cloud Shell.

    ```azurecli
    export STORAGEACCT=learnazurefileshare$RANDOM

    az storage account create \
        --name $STORAGEACCT \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --sku Standard_GRS
    ```

1. Using Azure CLI commands, save the storage account key in a local variable.

    ```azurecli
    STORAGEKEY=$(az storage account keys list \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --account-name $STORAGEACCT \
        --query "[0].value" | tr -d '"')
    ```

## Create file shares

1. Create a file share to store the finance company's reports.

    ```azurecli
    az storage share create \
        --account-name $STORAGEACCT \
        --account-key $STORAGEKEY \
        --name "reports"
    ```

1. Create a file share to store the finance company's application data.

    ```azurecli
    az storage share create \
        --account-name $STORAGEACCT \
        --account-key $STORAGEKEY \
        --name "data"
    ```

## Create a VM and connect with RDP protocol

Create a Windows Server VM to simulate an on-premises machine running in the finance company's datacenter or branch office.

1. Using Cloud Shell, create a Windows VM with the Azure CLI. When you're prompted for a password, enter a complex password of your choice and note it for reference later.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name 2019FileServer \
        --image Win2019Datacenter \
        --admin-username azureuser
    ```

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. On the home page, under **Azure services**, select **Virtual machines**, and then select the **2019FileServer** VM you created in step 1 of this task. The **2019 FileServer** Virtual machine *Overview* pane appears.

1. On the command bar, select **Connect** > **RDP**, and then select **Download RDP File**.

1. When the RDP file has downloaded, select it to run the program, and then select **Connect** when you're prompted.

1. On the **Enter your credentials** Windows Security prompt, select **More choices**, and then scroll down and select **Use a different account**. In the **Email address** field, enter *azureuser*, and then in the **Password** field, enter the password you created earlier, and then select **OK**.

    > [!NOTE]
    > If you forgot the password, go oto the VM (2019Fileserver) and select **Reset password** under **Help + support > Help** and then select Update in the command bar to update. Restart this task at step 3 to connect and download the RDP file. Alternatively, restart this task. If you encounter any issues, check the sandbox--if it is not still activated, you've lost the resources necessary to complete this exercise. 

1. If you are prompted to verify the remote connection, select **Yes**.

## Map drives to the Azure file shares

1. In the Azure portal's  search bar, select or search for **Storage accounts**.

1. Select the storage account that you created, which should be named **learnazurefileshare** followed by random numbers.

1. In the resource menu for your storage account, under **Data storage**, select **File shares**.

    :::image type="content" source="../media/4-select-file-shares.png" alt-text="Screenshot of the Azure portal showing the storage account overview." lightbox="../media/4-select-file-shares.png#lightbox":::

    The **File shares** pane for your storage account appears.

1. In the file shares list, select **data**. The **data** file share pane appears. 

    :::image type="content" source="../media/4-select-data.png" alt-text="Screenshot of the file shares in the storage account." lightbox="../media/4-select-data.png#lightbox":::

1. In the command bar, select **Connect**. The **Connect** pane appears.

1. In the **Drive letter** dropdown list, select the **F**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

    :::image type="content" source="../media/4-connect-share.png" alt-text="Screenshot of the data file share and its connection commands." lightbox="../media/4-connect-share.png#lightbox":::

1. On your virtual machine, in the system tray, select **Start**, scroll to **Windows PowerShell (Admin)**, or if you don't see **(Amin)**, then right click **Windows PowerShell** and select **Run as Administrator**. 

    :::image type="content" source="../media/4-connect-powershell-admin.png" alt-text="Screenshot of the Windows virtual machine showing Start menu with Windows PowerShell (Admin) selected." lightbox="../media/4-connect-powershell-admin.png#lightbox":::

1. At the command prompt in the PowerShell console, paste the script you copied, and press <kbd>Enter</kbd>. 

    > [!NOTE]
    > If <kbd>Ctrl+V</kbd> is not recognized in your VM, right-click the PowerShell icon in the PowerShell console title bar, and select **Properties**. On the Options tab, ensure that **Use Ctrl+Shift+C/V as Copy/Paste** is selected, and then select **OK**. Now you can use <kbd>Ctrl+Shift+V</kbd> to paste content into your VM PowerShell console.

1. Return to the Azure portal, go back to the **File shares** pane, and select the **reports**.

    :::image type="content" source="../media/4-navigate-back.png" alt-text="Screenshot of how to go back to the file shares." lightbox="../media/4-navigate-back.png#lightbox":::

1. On the top menu bar, select **Connect**, The **Connect** pane appears,

1. In the **Drive letter** dropdown list, select the **G**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

1. In the PowerShell window, paste the copied commands <kbd>Ctrl+Shift+V</kbd>, and then press <kbd>Enter</kbd>.

## Test the mounted drive

1. In the VM, open File Explorer, and select **This PC**.

    :::image type="content" source="../media/4-explorer-mapped-drives.png" alt-text="Explorer showing This PC." lightbox="../media/4-explorer-mapped-drives.png#lightbox":::

1. Select the *data* drive named **F**.

1. Right-click the main window, and select **New** > **Text Document**.

1. Name the file **test upload**.

1. Return to the Azure portal in your browser, go back to the **File shares** pane, and select **data**. You should see the file in the portal.

1. Keep this connection open for the next exercise.
