The Microsoft Remote Desktop client is used to connect to Azure Virtual Desktop to access your desktops and applications. This unit shows you how to connect to Azure Virtual Desktop with the Remote Desktop client for Windows, which only allows you to subscribe to a feed made available to you by your organization administrators.

There are three versions of the Remote Desktop client for Windows, which are all supported for connecting to Azure Virtual Desktop:

 -  Standalone download as an MSI installer.
 -  Azure Virtual Desktop app from the Microsoft Store. This is a preview version of the Remote Desktop client for Windows.
 -  Remote Desktop app from the Microsoft Store. This version is no longer being developed.

> [!TIP]
> You can also connect to Azure Virtual Desktop with Windows App, a single app to securely connect you to Windows devices and apps from Azure Virtual Desktop, Windows 365, Microsoft Dev Box, Remote Desktop Services, and remote PCs. For more information, see [What is Windows App?](/windows-app/overview)

You can find a list of all the Remote Desktop clients you can use to connect to Azure Virtual Desktop at [Remote Desktop clients overview](/azure/virtual-desktop/users/remote-desktop-clients-overview).

If you want to connect to Remote Desktop Services or a remote PC instead of Azure Virtual Desktop, see [Connect to Remote Desktop Services with the Remote Desktop app for Windows](/windows-server/remote/remote-desktop-services/clients/windows).

Before you can access your resources, you'll need to meet the prerequisites.

 -  Internet access.
 -  A device running one of the following supported versions of Windows:
    
    
     -  Windows 11
     -  Windows 10

## Download and install the Azure Virtual Desktop app

The Azure Virtual Desktop app is available from the Microsoft Store. To download and install it, follow these steps:

1.  Go to the [Azure Virtual Desktop Store app in the Microsoft Store](https://aka.ms/AVDStoreClient).
2.  Select **Install** to start downloading the app and installing it.
3.  Once the app has finished downloading and installing, select **Open**. The first time the app runs, it will install the *Azure Virtual Desktop (HostApp)* dependency automatically.

> [!IMPORTANT]
> If you have the Azure Virtual Desktop app from the Microsoft Store and the Remote Desktop client (MSI) installed on the same device, you may see the message that begins **A version of this application called Azure Virtual Desktop was installed from the Microsoft Store**. Both apps are supported, and you have the option to choose **Continue anyway**, however it could be confusing to use the same remote resource across both apps. We recommend using only one version of the app at a time.

## Subscribe to a workspace

A workspace combines all the desktops and applications that have been made available to you by your admin. To be able to see these in the Azure Virtual Desktop app, you need to subscribe to the workspace by following these steps:

1.  Open the **Azure Virtual Desktop** app on your device.
2.  The first time you subscribe to a workspace, from the **Let's get started** screen, select **Subscribe** or **Subscribe with URL**. Use the tabs after this for your scenario.
    
    
     -  If you selected **Subscribe**, sign in with your user account when prompted, for example user@contoso.com. After a few seconds, your workspaces should show the desktops and applications that have been made available to you by your admin.
     -  | **Azure environment**       | **Workspace URL**                                |
        | --------------------------- | ------------------------------------------------ |
        | Azure cloud *(most common)* | https://rdweb.wvd.microsoft.com                  |
        | Azure for US Government     | https://rdweb.wvd.azure.us/api/arm/feeddiscovery |
        | Azure operated by 21Vianet  | https://rdweb.wvd.azure.cn/api/arm/feeddiscovery |

1.  Select **Next**.
2.  Sign in with your user account when prompted. After a few seconds, the workspace should show the desktops and applications that have been made available to you by your admin.

Once you've subscribed to a workspace, its content will update automatically regularly and each time you start the client. Resources may be added, changed, or removed based on changes made by your admin.

## Connect to your desktops and applications

Once you've subscribed to a workspace, here's how to connect:

1.  Open the **Azure Virtual Desktop** app on your device.
2.  Double-click one of the icons to launch a session to Azure Virtual Desktop. You may be prompted to enter the password for your user account again, depending on how your admin has configured Azure Virtual Desktop.
3.  To pin your desktops and applications to the Start Menu, right-click one of the icons and select **Pin to Start Menu**, then confirm the prompt.
