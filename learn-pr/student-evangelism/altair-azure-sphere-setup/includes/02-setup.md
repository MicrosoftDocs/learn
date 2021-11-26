In this module, you'll learn about what software you need to install on your computer. As an overview, you'll be following these steps:

1. Install the Azure Sphere SDK on your computer.
1. Claim your Azure Sphere device.
1. Set up Azure Sphere for application deployments.

Take a moment to review the following list. It provides useful tips if you have problems setting up the Azure Sphere software on your computer.

- See the [Troubleshoot Azure Sphere issues](/azure-sphere/install/troubleshoot-installation) article.
- If you have trouble connecting to Azure Sphere over USB, try disabling any active VPNs.
- The TAP-Windows Adapter V9 interface that's installed with VPN clients, including the OpenVPN client, is not compatible with the TAP-Windows Adapter V9 interface the Azure Sphere SDK requires and installs. Uninstall the VPN client and reinstall the Azure Sphere SDK for Visual Studio.
- If you're using Windows and the Azure IoT Central `ShowIoTCentralConfig` command fails with a message about a missing library, delete the *ShowIoTCentralConfig* folder from *AppData\\Local\\Temp\\.net*.
- If you're using Windows and Visual Studio Code, add the Ninja and CMake applications to the Windows path:

  1. Select the Windows logo key.
  1. Type **path**, and then select **Edit the system environment variables**.
  1. Select **Environment Variables**.
  1. In **User variables for**, select **Path**.
  1. Select **edit**, and add the paths for *ninja-win* and *CMake\bin*. 
  1. Select **OK**.

