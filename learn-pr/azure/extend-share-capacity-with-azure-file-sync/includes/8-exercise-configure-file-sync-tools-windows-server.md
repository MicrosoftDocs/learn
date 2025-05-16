After you deploy the Azure resources, you need to register your on-premises Windows file server with the sync group. Then connect to your Windows Server computer and install the Azure File Sync agent. After your server is registered, add it as a server endpoint in your Azure subscription.

In this exercise, change the security setting so it allows you to download the Azure File Sync agent. You then install and run the agent to register the server with the Azure sync group.

The following video shows you how set up your on-premises server to work with Azure File Sync. Complete the steps in this exercise to continue following along in your Azure subscription.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=3dbc4b01-5cad-4b07-8ca0-e577a54527be]

### Disable IE Enhanced Security Configuration

1. If you closed your Remote Desktop connection, follow these steps to connect to the virtual machine (VM):
    1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
    1. Go to **Virtual machines** > **FileServerLocal**.
    1. Select **Connect** and then select **Native RDP**.
    1. Select **Download RDP File**, and then open the RDP file.
    1. In the **Windows Security** window, select **More choices** > **Use a different account**.
    1. Enter the username **learnadmin** and the password you used when you created the VM.

1. In your Remote Desktop connection, on the toolbar, select **Server Manager** > **Local Server**.

1. In the **Properties** pane, under **IE Enhanced Security Configuration**, select **On**.

    :::image type="content" source="../media/8-local-server-ie-security-config.png" alt-text="Screenshot that shows the On button for IE Enhanced Security Configuration.":::

1. Select **Off** for **Administrators** and **Users**, and then select **OK**.

### Install Azure File Sync agent

1. From the toolbar in the VM, open Internet Explorer.

1. Go to `https://www.microsoft.com/edge` and select **Accept and download**.

1. Select **Run**. Wait for Microsoft Edge to install.

1. Select **Start without your data** and then **Continue without this data**.

1. Select **Confirm and continue** and then **Confirm and start browsing**.

1. Open the Microsoft Download Center page for Azure File Sync by going to `https://go.microsoft.com/fwlink/?linkid=858257`.

1. Select **Download**.

1. Select **StorageSyncAgent_WS2019.msi**, then select **Download**.

1. When the download is complete, run the installer.

1. Go through the **Storage Sync Agent Setup Wizard** and accept the defaults to install the Storage Sync Agent and complete setup.

1. The agent automatically runs and shows the **Azure File Sync - Agent Update** window. Complete any updates that are necessary.

### Register Windows Server

1. On **Azure File Sync - Server Registration**, select **Sign in**. If the server registration process doesn't start automatically, open the app from `C:\Program Files\Azure\StorageSyncAgent\ServerRegistration.exe`.

1. Sign in by using your Azure credentials.

1. Enter the following values for each setting.

   | Setting              | Value      |
   |----------------------|------------|
   | Azure Subscription   | Subscription where you created the Azure File Sync resources |
   | Resource Group       | learn-file-sync-rg |
   | Storage Sync Service | CADSyncService |

1. Select **Register**.

1. You should see that the registration is successful. Select **Close** to close the window.

    :::image type="content" source="../media/8-server-registration-successful.png" alt-text="Screenshot of the registration successful page.":::

1. Leave your Remote Desktop connection open for the next exercise.

### Add the server endpoint

1. On your local computer, sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Go to the CADFiles sync group you created earlier by going to **Storage Sync Services** > **CADSyncService** > **Sync groups** > **CADFiles**. Your **CADFiles** pane for your *Sync group* appears.

1. Select **+ Add server endpoint**.

1. Enter the following values for each setting.

   | Setting            | Value    |
   |--------------------|----------|
   | Registered Server  | FileServerLocal |
   | Path               | D:\CADFolder |

   :::image type="content" source="../media/8-add-server-endpoint.png" alt-text="Screenshot of the Add server endpoint window.":::

1. For **Cloud Tiering**, select **Enabled**.

1. Accept the defaults for the rest of the values.

1. Select **Create**.

1. When the endpoint is created, the file sync process begins. This process might take a few minutes.

    :::image type="content" source="../media/8-created-endpoint.png" alt-text="Screenshot that shows the status of the endpoint.":::
