In this unit, you'll learn about what software you need to install on your computer.

As an overview, you will be following these steps.

1. Install the Azure Sphere SDK on your computer.
1. Claim your Azure Sphere device.
1. Set up your Azure Sphere for application deployments.

## Troubleshooting

Take a moment to review the following list. It provides a useful set of references if you have problems setting the Azure Sphere software on your computer.

- See the [Troubleshoot Azure Sphere issues](/azure-sphere/install/troubleshoot-installation) article.
- If you have trouble connecting to the Azure Sphere over USB, try disabling any active VPNs.
- The **TAP-Windows Adapter V9** installed with VPN clients, including the OpenVPN client is not compatible with the **TAP-Windows Adapter V9** required and installed by the Azure Sphere SDK. You'll need to uninstall the VPN client and reinstall the Azure Sphere SDK for Visual Studio.
- Windows Users. If running the IoT Central ShowIoTCentralConfig command fails with a missing library message, then delete the folder from ShowIoTCentralConfig from AppData\\Local\\Temp\\.net.
- Windows and VS Code users. Add the Ninja and CMake to the Windows path. To do add these applications to the Windows path, press the Windows key, type ```path```, select **Edit the system environment variables**, select **Environment Variables**, select **Path** in the **User variables for ...**, select **edit**, and add the paths for "ninja-win" and "CMake\bin", then select **OK**.

