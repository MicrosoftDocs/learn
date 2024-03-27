Azure File Sync has a sync agent for all the supported versions of Windows Server. The agent completes the setup of the trust relationship between your on-premises Windows Server computer and the Azure Storage Sync Service.

You successfully set up your company's Azure resources to support Azure File Sync. Now, you're going to prepare your Windows file server to deploy the required Azure File Sync components.

In this unit, you learn how to prepare the Windows Server environment for Azure File Sync.

## 1. Disable IE Enhanced Security Configuration

The default configuration for all versions of Windows Server is to restrict web browsing and downloads of other software. You must disable this protection for the initial server registration. In the Server Manager console, set **IE Enhanced Security Configuration** to **Off** for both administrators and users. Re-enable this protection after the agent is installed.

## 2. Install the Azure File Sync agent

Download the latest version of the agent from the [Microsoft Download Center](https://go.microsoft.com/fwlink/?linkid=858257). Download the version of the Storage Sync agent that matches your version of Windows Server.

Run the installer. Accept all defaults in the wizard to complete the installation.

## 3. Register Windows Server

This step establishes the trust between the local server and the Storage Sync Service. Each server can be registered and connected to only one Storage Sync Service at a time. However, the server can sync with other servers and Azure file shares that are associated with that service.

Run the agent and sign in with your Azure account. To register the file server, select the subscription, resource group, and Storage Sync Service.

## 4. Add the server endpoint

To finish setup of the trust relationship, return to the Azure portal and the sync group you created. In the sync group, you should already have a cloud endpoint. Now add its matching server endpoint. Because you registered your server, select **Add a server endpoint**, and then select your server.

You complete these steps in the next unit.
