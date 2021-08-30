In this unit, you will:

1. Install Visual Studio Code
1. Install the Azure Sphere SDK.
1. Claim your Azure Sphere device.
1. Configure the Azure Sphere Wi-Fi network.
1. Update the Azure Sphere OS.
1. Enable app development on the device.

Install the following software on your Windows 10 or Linux computer.

## Troubleshooting

1. See the [Troubleshoot Azure Sphere issues](/azure-sphere/install/troubleshoot-installation) article.
1. If you have trouble connecting to the Azure Sphere over USB, try disabling any active VPNs.
1. The **TAP-Windows Adapter V9** installed with VPN clients, including the OpenVPN client is not compatible with the **TAP-Windows Adapter V9** required and installed by the Azure Sphere SDK. You'll need to uninstall the VPN client and reinstall the Azure Sphere SDK for Visual Studio.
1. Windows Users. If running the IoT Central ShowIoTCentralConfig command fails with a missing library message, then delete the folder from ShowIoTCentralConfig from AppData\\Local\\Temp\\.net.
1. Windows and VS Code users. Add the Ninja and CMake to the Windows path. To do add these applications to the Windows path, press the Windows key, type ```path```, select **Edit the system environment variables**, select **Environment Variables**, select **Path** in the **User variables for ...**, select **edit**, and add the paths for "ninja-win" and "CMake\bin", then select **OK**.

## Azure Sphere SDK version

This learning module requires the Azure Sphere SDK 21.07 release or newer.

## Windows 10 users

This learning module uses Visual Studio Code. However, if you are a Windows user comfortable with Visual Studio then you can still complete the exercises appreciating that the IDE screenshots included in this module will be different.

Complete the following steps:

1. Install the latest Azure Sphere SDK.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Windows](https://docs.microsoft.com/en-us/azure-sphere/install/install-sdk?pivots=vs-code&azure-portal=true) will step you through the process.

### Install the Git client for Windows

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

Install [Git for Windows](https://git-scm.com/downloads?azure-portal=true).

### Install the real-time core GNU Arm Embedded Toolchain for Windows

1. Download the latest [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads?azure-portal=true) for Windows.
2. Install the GNU Arm Embedded Toolchain

## Ubuntu 18.04 or 20.04 LTS users

Complete the following steps:

1. Install the Azure Sphere SDK.
    **Ensure you install the new azsphere CLI v2**.
1. Set up the device connection.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The [Quickstart: Install the Azure Sphere SDK for Linux](https://docs.microsoft.com/en-us/azure-sphere/install/install-sdk-linux?pivots=vs-code-linux&azure-portal=true) will step you through the process.

### Install the Git client for Linux

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

```bash
sudo apt install git
```

### Install the real-time core GNU Arm Embedded Toolchain for Linux

Install the GNU Arm Embedded Toolchain for Linux

1. Download the latest [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads?azure-portal=true).
2. Install the downloaded package. The following installs the toolchain in the /opt folder.

    ```bash
    sudo tar -xjvf gcc-arm-none-eabi-<version-number>-major-x86_64-linux.tar.bz2 -C /opt
    ```

3. Update your path. Open ~/.bashrc and add to the end.

    ```bash
    export PATH=$PATH:/opt/gcc-arm-none-eabi-<version-number>-major/bin
    ```

4. Optional: The real-time core debugger relies on the *libncurses.so.5* library. Depending on your system setup, this library may already be install, if not, then run the following commands.

    ```bash
    sudo add-apt-repository universe
    sudo apt-get install libncurses5
    ```

## Recommended Visual Studio Code Extension

The Peacock extension allows you to change the color of your Visual Studio Code workspace. The Peacock extension is useful when you have multiple instances of Visual Studio Code open.

   1. Open Extensions sideBar panel in Visual Studio Code, or from the menu, select View → Extensions.
   1. Search for Peacock.
   1. Select Install.
   1. Select Reload, if necessary.

## Delete existing applications on Azure Sphere

1. From the Windows **PowerShell command line** or Linux **Terminal**, run the following command to delete any existing applications on the device.

   ```azsphere
   azsphere device sideload delete
   ```

2. Restart Azure Sphere.

   ```azsphere
   azsphere device restart
   ```

## Enable high-level core development

1. From the Windows **PowerShell command line** or Linux **Terminal**, run the following command to enable high-level app development on the device.

   ```azsphere
   azsphere device enable-development
   ```

## Enable real-time core development

### Windows 10 users

1. Open the Windows **PowerShell command line** as **Administrator**, and run the following command to enable real-time core development on the device.

   ```azsphere
   azsphere device enable-development -r
   ```

2. Close the Windows **PowerShell command line**

### Linux users

1. Open the Linux **Terminal** and run the following command to enable real-time core development on the device.

   ```bash
   azsphere device enable-development -r
   ```

## Clone the Altair on Azure Sphere git repository

> [!NOTE]
> Clone the *Altair project* to a folder close to the root folder on your computer. For example, **c:\lab**, or **~/**. The reason is that the Azure Sphere build process uses CMake which can struggle with long path and folder names.

```bash
git clone --recurse-submodules --depth 1 https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.git
```
