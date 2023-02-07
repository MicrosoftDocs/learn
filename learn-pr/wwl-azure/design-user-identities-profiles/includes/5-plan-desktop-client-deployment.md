
You use the Remote Desktop client for Windows Desktop to access Windows apps and desktops remotely from a different Windows device.

> [!NOTE]
> This unit is **not** intended for the Remote Desktop Connection (MSTSC) client that ships with Windows.

The new Remote Desktop client (MSRDC) supports:

 -  Windows 10
 -  Windows 10 IoT Enterprise
 -  Windows 7 client devices

## Install the client

Choose the client that matches the version of Windows.

 -  [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2068602)
 -  [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2098960)

Launch it from the Start menu by searching for **Remote Desktop**.

## Workspaces

Get the list of managed resources you can access, such as apps and desktops, by subscribing to the Workspace your admin provided you. When you subscribe, the resources become available on your local PC. The Windows Desktop client currently supports resources published from Azure Virtual Desktop.

The following diagram shows an Azure Virtual Desktop workspace with two host pools.

:::image type="content" source="../media/azure-virtual-desktop-workspaces-f199a309.png" alt-text="Diagram that shows the relationship of a workspace, host pool, and application group.":::


 -  **Host pool A** has two application groups: Desktop and RemoteApp. These resources are shared (pooled) across the sales team.
 -  **Host pool B** has a Desktop application group with personal desktops available to an engineering team.

### Subscribe to a Workspace

There are methods you can subscribe to a Workspace. The client can try to discover the resources available to you from your work or school account or you can directly specify the URL where your resources are for cases where the client is unable to find them. Once you've subscribed to a Workspace, you can launch resources with one of the following methods:

 -  Go to the Connection Center and double-click a resource to launch it.
 -  You can also go to the Start menu and look for a folder with the Workspace name or enter the resource name in the search bar.

## Subscribe with a user account

1.  From the main page of the client, tap **Subscribe**.
2.  Sign in with your user account when prompted.
3.  The resources will appear in the Connection Center grouped by Workspace.

### Subscribe with URL

1.  From the main page of the client, tap **Subscribe with URL**.
2.  Enter the Workspace URL or your email address:

    > [!NOTE]
    > To use **email**, enter your email address. This tells the client to search for a URL associated with your email address if your admin has setup email discovery.

3.  Tap **Next**.
4.  Sign in with your user account when prompted.
5.  The resources will appear in the Connection Center grouped by Workspace.
