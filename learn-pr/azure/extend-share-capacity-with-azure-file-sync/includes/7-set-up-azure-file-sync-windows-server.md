Azure File Sync has a sync agent for all the supported versions of Windows Server. Using the agent completes the setup of the trust relationship between your on-premises Windows Server, and the Azure Storage Sync Service.

You've successfully setup your company's Azure resources to support Azure File Sync. Now you're going to prepare your Windows File Server  to deploy the required Azure File Sync components.

In this unit, you'll learn how to prepare the **Windows Server** environment for Azure File Sync.

## 1. Disable IE Enhanced security configuration

The default configuration for all versions of Windows Server is to have restrictions in place for web browsing, and downloading additional software. You must disable this protection for the initial server registration. Re-enable this protection after the agent is installed. In the **Server Manager** console, set **IE Enhanced Security Configuration** to **Off** for both administrators and users.

## 2. Install the Azure File Sync agent

Download the latest version of the agent from the [Microsoft Download Center](https://go.microsoft.com/fwlink/?linkid=858257). Download the version of the Storage Sync Agent that matches your version of Windows Server.

Run the installer, and accept all defaults in the wizard to complete the installation.

In the **Server Manager** console, set **IE Enhanced Security Configuration** to **On** for both administrators and users.

## 3. Register the Windows Server

This step establishes the trust between the local server and the Storage Sync Service. Each server can only be registered and connected to one Storage Sync Service at a time. However, the server can sync with other servers and Azure file shares that are associated with that service.

Run the agent and sign in with your Azure account. All you need to do to register the file server is to select the subscription, resource group, and Storage Sync Service.

## 4. Add the server endpoint

To finish set up of the trust relationship, return to the Azure portal and the sync group you created. Within the sync group, you should already have a cloud endpoint. Now add its matching server endpoint. Because you've registered your server, click **Add a server endpoint**, and select your server.

We'll complete these steps in the next unit.