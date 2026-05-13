Install the following software on your computer.

## Troubleshooting

1. If you have trouble connecting to Azure Sphere over USB, temporarily disconnect VPN software and check whether your PC can reach the device status endpoint at `https://192.168.35.2/status`.
2. Azure Sphere tools communicate with attached development boards by using an IP network over USB on subnet `192.168.35.*`, and the Azure Sphere SDK for Windows installs the **Azure Sphere TAP-Windows Adapter V9** if required. If you have multiple TAP adapters, a non-Azure Sphere TAP adapter, or Cisco AnyConnect redirecting traffic away from the TAP adapter, follow the [Azure Sphere troubleshooting guidance](/azure-sphere/install/troubleshoot-installation?azure-portal=true#connection-problems-caused-by-tap-windows-adapter-configuration) to repair the TAP adapter or VPN filter settings. Reinstall the Azure Sphere SDK only if the troubleshooting steps require it.

## Azure Sphere SDK version

This learning module requires Azure Sphere SDK version 24.03 (the GA release of Azure Sphere (Integrated), March 2024) or newer. The Microsoft Learn release notes list SDK 25.04 (May 2025) as the latest SDK release and Azure CLI `azure-sphere` extension 1.0.3 as a subsequent extension-only update. Check [What's new in Azure Sphere](/azure-sphere/product-overview/whats-new?azure-portal=true) before installing so you update both the SDK and the Azure CLI extension when newer versions are available.

## Windows 10 or Windows 11 users

This learning module supports developers on Linux and Windows using Visual Studio Code. However, if you are a Windows user comfortable using Visual Studio then you can still complete the exercises appreciating that the IDE screenshots included in this module will be different.

You need to do the following:

1. Install the latest Azure Sphere SDK.
1. Install the Azure CLI and the Azure Sphere extension for Azure CLI (`az extension add --name azure-sphere`) so you can use the current `az sphere` commands.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Windows](/azure-sphere/install/install-sdk?azure-portal=true&pivots=vs-code) steps through SDK and development environment installation. Claiming the device and configuring networking are covered by the [claim-device](/azure-sphere/install/claim-device?azure-portal=true) and [Wi-Fi configuration](/azure-sphere/install/configure-wifi?azure-portal=true) quickstarts.

### Install the Git client for Windows

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

Install [Git for Windows](https://git-scm.com/downloads?azure-portal=true).

### Install Azure IoT Explorer for Windows

This learning module uses [Azure IoT Explorer](/azure/iot/howto-use-iot-explorer?azure-portal=true) to work with Azure IoT Hub devices.

**Download** and install the latest Azure IoT Explorer **.msi** package from the [Azure IoT explorer releases](https://github.com/Azure/azure-iot-explorer/releases?azure-portal=true) GitHub page.

> [!NOTE]
> The Azure IoT Explorer GitHub repository is no longer actively developed — the project README states that all active development has stopped, and only critical fixes might still be considered. The released installers (`.msi` for Windows, `.deb` for Linux) remain available on the Releases page and are fully functional for this module.

### Install the Arm GNU Toolchain for Windows

1. Download the [Arm GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads?azure-portal=true) (formerly known as the GNU Arm Embedded Toolchain) for Windows. Pick the **AArch32 bare-metal target (arm-none-eabi)** package that includes a compiler for the ARM Cortex-M4 processor.
2. Run the installer to install the Arm GNU Toolchain. The examples in this module use **14.3.Rel1** as a version example; if Arm has released a newer supported `arm-none-eabi` version, install that version and substitute its path in any commands. If Visual Studio Code doesn't find the toolchain automatically, set **Azure Sphere: Arm Gnu Path** in Visual Studio Code settings to the toolchain installation folder.

## Ubuntu 22.04 or 24.04 LTS users

You need to do the following:

1. Install the Azure Sphere SDK. The SDK installs the `azsphere` CLI (Azure Sphere (Legacy)). For new work, also install the Azure CLI and the `az sphere` extension for the Azure CLI — Azure Sphere (Integrated), which is the recommended interface going forward. The `az sphere` extension is installed with `az extension add --name azure-sphere`; the procedure is documented in the [Quickstart: Install the Azure Sphere SDK for Linux](/azure-sphere/install/install-sdk-linux?azure-portal=true) page.
1. Set up the device connection.
1. Install CMake and Ninja. Follow the SDK quickstart instructions and don't install CMake or Ninja by using `snap`.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Linux](/azure-sphere/install/install-sdk-linux?azure-portal=true&pivots=vs-code-linux) steps through SDK and development environment installation. Claiming the device and configuring networking are covered by the [claim-device](/azure-sphere/install/claim-device?azure-portal=true) and [Wi-Fi configuration](/azure-sphere/install/configure-wifi?azure-portal=true) quickstarts.

### Install the Git client for Linux

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

```bash
sudo apt install git
```

### Install Azure IoT Explorer for Ubuntu

This learning module uses [Azure IoT Explorer](/azure/iot/howto-use-iot-explorer?azure-portal=true) to work with Azure IoT Hub devices.

**Download** and install the latest Azure IoT Explorer **.deb** package from the [Azure IoT explorer releases](https://github.com/Azure/azure-iot-explorer/releases?azure-portal=true) GitHub page.

### Install the Arm GNU Toolchain for Linux

Install the Arm GNU Toolchain (formerly the GNU Arm Embedded Toolchain) for Linux.

1. Download the [Arm GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads?azure-portal=true). Pick the **AArch32 bare-metal target (arm-none-eabi)** Linux x86_64 tarball that includes a compiler for the ARM Cortex-M4 processor. The commands below use **14.3.Rel1** as a version example; substitute the version you downloaded into the commands and PATH entry.
2. Install the downloaded package. The following installs the toolchain in the /opt directory.

    ```bash
    sudo tar -xJvf arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi.tar.xz -C /opt
    ```

3. Update your path. Open ~/.bashrc and add to the end:

    ```bash
    export PATH=$PATH:/opt/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/bin
    ```

4. Optional troubleshooting for real-time core debugging: if the Arm debugger reports a missing `libncurses.so.5` library, first confirm that you installed the current Azure Sphere SDK and a current Arm GNU Toolchain. On Ubuntu 22.04 LTS (Jammy), `libncurses5` is available from the official Ubuntu repositories; if the `universe` repository is not enabled, enable it before installing.

    ```bash
    sudo add-apt-repository universe
    sudo apt-get install libncurses5
    ```

   On Ubuntu 24.04 LTS (Noble), `libncurses5` is not available in the official Ubuntu repositories. Do not install compatibility libraries from older Ubuntu releases; use the current Arm GNU Toolchain and follow Microsoft's guidance for installing the Azure Sphere SDK on Linux: [Quickstart: Install the Azure Sphere SDK for Linux](/azure-sphere/install/install-sdk-linux?azure-portal=true).

## Recommended Visual Studio Code extension

The Peacock extension allows you to change the color of your Visual Studio Code workspace. The Peacock extension is useful when you have multiple instances of Visual Studio Code open. In one of the exercises an instance of Visual Studio Code will be attached to the real-time core, and another instance will be attached to the high-level application core.

   1. Open Extensions sideBar panel in Visual Studio Code
      - Or choose the menu options for View → Extensions
   1. Search for Peacock
   1. Click Install
   1. Click Reload, if required

## Enable high-level core development

1. From the Windows **PowerShell command line** or Linux **Terminal**, run the following Azure Sphere (Integrated) CLI command to enable high-level app development on the attached device. Replace the resource group and catalog names with your values, or omit them if you configured Azure CLI defaults.

   ```
   az sphere device enable-development --resource-group <ResourceGroupName> --catalog <CatalogName>
   ```

   If you are intentionally using the Azure Sphere (Legacy) CLI, use the legacy equivalent:

   ```
   azsphere device enable-development
   ```

## Delete existing applications on Azure Sphere

Now that the device has the `appDevelopment` capability, you can delete existing sideloaded applications. (This step requires the `appDevelopment` capability that you just enabled.)

1. From the Windows **PowerShell command line** or Linux **Terminal**, run the following Azure Sphere (Integrated) CLI command to delete any existing sideloaded applications on the device.

   ```
   az sphere device sideload delete
   ```

   If you are intentionally using the Azure Sphere (Legacy) CLI, use the legacy equivalent:

   ```
   azsphere device sideload delete
   ```

2. Restart the Azure Sphere device.

   ```
   az sphere device restart
   ```

   Legacy equivalent:

   ```
   azsphere device restart
   ```

> [!TIP]
> See the [`az sphere device` reference](/azure-sphere/reference/cli/azsphere-device?azure-portal=true) for the full Integrated CLI command set.

## Enable real-time core development

### Windows 10 or Windows 11 users

1. Open the Windows **PowerShell command line** as **Administrator**, and run the following Azure Sphere (Integrated) CLI command to enable real-time core development on the device. The `--enable-rt-core-debugging` parameter requires administrator privileges on Windows because it installs USB drivers for the debugger.

   ```
   az sphere device enable-development --enable-rt-core-debugging --resource-group <ResourceGroupName> --catalog <CatalogName>
   ```

   If you are intentionally using the Azure Sphere (Legacy) CLI, use the legacy equivalent:

   ```
   azsphere device enable-development -r
   ```

2. Close the Windows **PowerShell command line**

### Linux users

1. Open the Linux **Terminal** and run the following Azure Sphere (Integrated) CLI command to enable real-time core development on the device.

   ```bash
   az sphere device enable-development --enable-rt-core-debugging --resource-group <ResourceGroupName> --catalog <CatalogName>
   ```

   If you are intentionally using the Azure Sphere (Legacy) CLI, use the legacy equivalent:

   ```bash
   azsphere device enable-development -r
   ```

## Clone the Azure Sphere Developer Learning Path

> [!NOTE]
> Clone the *Azure Sphere Developer Learning Path* to a directory close to the root directory on your computer. For example, **c:\lab**, or **~/**. The reason is that the Azure Sphere build process uses CMake which can struggle with long path and directory names.

> [!TIP]
> The [`MicrosoftDocs/Azure-Sphere-Developer-Learning-Path`](https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path?azure-portal=true) repository is in maintenance mode (last update July 2022). The lab content used in this module still works, but the upstream samples are no longer actively developed. For the latest, actively maintained Microsoft Azure Sphere samples, see the [Azure Sphere samples repository](https://github.com/Azure/azure-sphere-samples?azure-portal=true) on the `main` branch.

```
git clone --depth 1 https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path.git Azure-Sphere
```
