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

## Create and connect to a Windows server

Next, create a Windows Server VM to simulate an on-premises machine running in the finance company's datacenter or branch office.

1. Using Cloud Shell, create a Windows VM with the Azure CLI. When you're prompted for a password, enter a complex password of your choice and note it for reference later.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name 2019FileServer \
        --image Win2019Datacenter \
        --admin-username azureuser
    ```

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. On the home page, under **Azure services**, select **Virtual machines**, and then select the **2019FileServer** VM you created. The **2019 FileServer** Virtual machine *Overview* pane appears.

1. On the top menu bar, select **Connect** > **RDP**, and then select **Download RDP File**.

1. Run the RDP file, and select **Connect** when you're prompted.

1. On the **Enter your credentials** prompt, select **More choices**. Then select **Use a different account**. In the **Username/Email address** field, enter *azureuser*, and enter the password you created earlier.

1. Select **OK**, and then select **Yes** to open the remote desktop.

## Map drives to the Azure file shares

1. In the Azure portal's top search bar, select or search for **Storage accounts**.

1. Select the storage account that you created, which should be named **learnazurefileshare** followed by random numbers.

1. In the middle menu pane, under **Data storage**, select **File shares**.

    :::image type="content" source="../media/4-select-file-shares.png" alt-text="Screenshot of the Azure portal showing the storage account overview." lightbox="../media/4-select-file-shares.png#lightbox":::

    Your storage account **File shares** pane appears.

1. Select **data**.

    :::image type="content" source="../media/4-select-data.png" alt-text="Screenshot of the file shares in the storage account." lightbox="../media/4-select-data.png#lightbox":::

1. On the top menu bar, select **Connect**. The **Connect** pane appears.

1. In the **Drive letter** dropdown list, select the **F**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

    :::image type="content" source="../media/4-connect-share.png" alt-text="Screenshot of the data file share and its connection commands." lightbox="../media/4-connect-share.png#lightbox":::

1. On your virtual machine, in the lower left task bar, right-click **Start**, and select **Windows PowerShell (Admin)**.

    :::image type="content" source="../media/4-connect-powershell-admin.png" alt-text="Screenshot of the Windows virtual machine showing the contextual menu of the Start menu with Windows PowerShell (Admin) highlighted." lightbox="../media/4-connect-powershell-admin.png#lightbox":::

1. In the PowerShell window, paste the script you copied, and press <kbd>Enter</kbd>.

1. Return to the Azure portal, go back to the **File shares** pane, and select the **reports**.

    :::image type="content" source="../media/4-navigate-back.png" alt-text="Screenshot of how to go back to the file shares." lightbox="../media/4-navigate-back.png#lightbox":::

1. On the top menu bar, select **Connect**, The **Connect** pane appears,

1. In the **Drive letter** dropdown list, select the **G**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

1. In the PowerShell window, paste the copied commands, and press <kbd>Enter</kbd>.

## Test the mounted drive

1. In the VM, open File Explorer, and select **This PC**.

    :::image type="content" source="../media/4-explorer-mapped-drives.png" alt-text="Explorer showing This PC." lightbox="../media/4-explorer-mapped-drives.png#lightbox":::

1. Select the *data* drive named **F**.

1. Right-click the main window, and select **New** > **Text Document**.

1. Name the file **test upload**.

1. Return to the Azure portal in your browser, go back to the **File shares** pane, and select **data**. You should see the file in the portal.

1. Keep this connection open for the next exercise.
