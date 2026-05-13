Use this exercise as a setup checklist for the development computer and the attached Azure Sphere device. It covers current SDK and CLI installation, common connection troubleshooting, device claim and networking prerequisites, and development-mode preparation for later labs.

## Troubleshooting

1. If you have trouble connecting to the Azure Sphere device over USB, first check that the device is attached and responsive.

   ```azurecli
   az sphere device show-attached
   ```

   On Windows, you can also browse to `https://192.168.35.2/status` and dismiss the certificate warning. A response such as `{"uptime":56}` confirms direct device communication.
1. Windows uses the **Azure Sphere TAP-Windows Adapter V9** to communicate with Azure Sphere development boards over USB. The TAP adapter is required; don't remove VPN clients or TAP drivers as a blanket troubleshooting step.
   - If you see no TAP adapter, more than one TAP adapter, or a single TAP adapter that is not named Azure Sphere, follow the official TAP adapter repair steps. Open an elevated **PowerShell** or **Command Prompt** and run the documented repair sequence: uninstall the TAP adapters from Device Manager, then run the TAP driver installer:

      ```cmd
      powershell -ExecutionPolicy RemoteSigned -File "%ProgramData%\Microsoft\Azure Sphere\TapDriverInstaller\TapDriverInstaller.ps1" Install
      ```

      Then restart the Azure Sphere Device Communication Service:

      ```cmd
      net stop AzureSphereDeviceCommunicationService
      net start AzureSphereDeviceCommunicationService
      ```

      Reinstall the Azure Sphere SDK only if the TAP adapter is still missing after restarting the service. For full guidance, see [Connection problems caused by TAP-Windows Adapter configuration](/azure-sphere/install/troubleshoot-installation?view=azure-sphere-integrated#connection-problems-caused-by-tap-windows-adapter-configuration).
   - If you use Cisco AnyConnect and the Azure Sphere TAP adapter appears unplugged, open the adapter properties and clear the **Cisco AnyConnect Network Access Manager Filter Driver** entry for the Azure Sphere TAP adapter. Then test again with `az sphere device show-attached`.
1. Windows users. If the IoT Central **ShowIoTCentralConfig** command fails with a missing library message, close the tool, delete the `%LOCALAPPDATA%\Temp\.net\ShowIoTCentralConfig` folder, and then run **ShowIoTCentralConfig** again from a command prompt.

## Azure Sphere SDK version

This learning module requires the latest Azure Sphere SDK and the Azure Sphere extension for Azure CLI. Use current `az sphere` commands for Azure Sphere operations. Azure Sphere (Legacy) service interfaces and PAPI retire on 27 September 2027, so update any older scripts or notes before that date.

Install the Azure CLI if you haven't already, and then add or update the Azure Sphere extension. To add the extension, run:

```azurecli
az extension add --name azure-sphere
```

If the extension is already installed, update it with:

```azurecli
az extension update --name azure-sphere
```

> [!IMPORTANT]
> A few early Seeed Azure Sphere MT3620 Development Kits require a manual OS update if they have never been used. Update the OS manually before you log in, claim the device, or connect the device to the internet. Other dev kits, including the Seeed MT3620 Mini Dev Board, or already-used Seeed Azure Sphere MT3620 Development Kits update automatically after connecting to the internet; manual update isn't required. For details, see [Quickstart: Choose a catalog and claim your device](/azure-sphere/install/claim-device?view=azure-sphere-integrated).

Sign in and select the Azure subscription that contains, or will contain, your Azure Sphere catalog.

```azurecli
az login
az account set --subscription <subscription-id-or-name>
```

## Windows users

This learning module supports developers on Linux and Windows using Visual Studio Code. However, if you are a Windows user comfortable using Visual Studio then you can still complete the exercises appreciating that the IDE screenshots included in this module will be different.

Use a PC running Windows 11 or Windows 10 Anniversary Update, or later.

You need to do the following:

1. Install the latest Azure Sphere SDK.
1. Install the Azure CLI and the Azure Sphere extension for Azure CLI.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Choose or create an Azure resource group and Azure Sphere catalog, and make sure your account has the required Azure RBAC permissions for the catalog.
1. Claim your device into the catalog.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Windows](/azure-sphere/install/install-sdk?view=azure-sphere-integrated) will step you through the process.

### Install the Git client for Windows

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

Install [Git for Windows](https://git-scm.com/downloads?azure-portal=true).

### Install the GNU Arm Embedded Toolchain for Windows

The Arm toolchain is required only for real-time capable applications. For high-level applications, you can skip this step.

1. Download the current [Arm GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads) for Windows. Choose the **arm-none-eabi** toolchain that includes the compiler for the Arm Cortex-M4 processor.
1. Install the toolchain. Visual Studio Code usually finds the installation automatically. If it doesn't, set **Azure Sphere: Arm Gnu Path** in Visual Studio Code to the toolchain installation directory.
1. If the sample or project folder contains `vcpkg-configuration.json`, you can instead use vcpkg artifacts to install and activate the toolchain for that project.

### vcpkg artifact installation for Windows

1. From PowerShell, navigate to the real-time application project folder.
1. Verify that the project folder contains `vcpkg-configuration.json`.
1. Download and initialize vcpkg, and then activate the artifacts for the project.

   ```powershell
   iex (iwr -useb https://aka.ms/vcpkg-init.ps1)
   vcpkg activate
   ```

## Ubuntu 22.04 or 24.04 LTS users

Use an x86-64 computer running 64-bit Ubuntu 22.04 LTS or Ubuntu 24.04 LTS. Other processor architectures, including Arm-based Linux computers, are not supported for the Azure Sphere SDK.

You need to do the following:

1. Install the latest Azure Sphere SDK for Linux.
1. Install the Azure CLI and the Azure Sphere extension for Azure CLI.
1. Set up the device connection.
1. Install CMake and Ninja. Don't install CMake or Ninja by using snap.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Choose or create an Azure resource group and Azure Sphere catalog, and make sure your account has the required Azure RBAC permissions for the catalog.
1. Claim your device into the catalog.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Linux](/azure-sphere/install/install-sdk-linux?view=azure-sphere-integrated) will step you through the process.

### Install the Git client for Linux

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

```
sudo apt install git
```

### Install the GNU Arm Embedded Toolchain for Linux

The Arm toolchain is required only for real-time capable applications. For high-level applications, you can skip this step.

You can install the toolchain manually from Arm, or use vcpkg artifacts when the sample or project includes `vcpkg-configuration.json`.

### Manual Arm toolchain installation

1. Download the current [Arm GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads) for Linux. Choose the **arm-none-eabi** toolchain that includes the compiler for the Arm Cortex-M4 processor.
1. Follow the Arm installation instructions for your Linux distribution.
1. If Visual Studio Code or command-line builds can't find the toolchain, add the toolchain `bin` directory that contains `arm-none-eabi-gdb` to your `PATH`, or set **Azure Sphere: Arm Gnu Path** in Visual Studio Code to the toolchain installation directory.

### vcpkg artifact installation

1. From a Linux terminal, navigate to the real-time application project folder.
1. Verify that the project folder contains `vcpkg-configuration.json`.
1. Download and initialize vcpkg, and then activate the artifacts for the project.

    ```bash
    . <(curl https://aka.ms/vcpkg-init.sh -L)
    vcpkg activate
    ```

## Recommended Visual Studio Code Extension

The Peacock extension allows you to change the color of your Visual Studio Code workspace. The Peacock extension is useful when you have multiple instances of Visual Studio Code open. In one of the exercises an instance of Visual Studio Code will be attached to the real-time core, and another instance will be attached to the high-level application core.

   1. Open Extensions sideBar panel in Visual Studio Code
      - Or choose the menu options for View → Extensions
   1. Search for Peacock
   1. Click Install
   1. Click Reload, if required

## Prepare the device for development and sideloading

Before you sideload an application or delete existing sideloaded applications, enable development on the device. This enables sideloading and debugging and assigns the device to a development device group that does not receive cloud application updates.

1. From the Windows **PowerShell command line** or Linux **Terminal**, sign in and set defaults for the subscription, resource group, and Azure Sphere catalog.

   ```azurecli
   az login
   az account set --subscription <subscription-id-or-name>
   az config set defaults.group=<resource-group> defaults.sphere.catalog=<catalog>
   ```

1. Confirm the attached device ID.

   ```azurecli
   az sphere device list-attached
   ```

1. Enable development on the device. You must have the required Azure RBAC permissions on the catalog.

   ```azurecli
   az sphere device enable-development --resource-group <resource-group> --catalog <catalog> --device <device-id>
   ```

1. After development is enabled, delete any existing sideloaded applications on the device if the exercise needs a clean device.

   ```
   az sphere device sideload delete
   ```

1. Restart Azure Sphere. This command depends on the catalog and resource group defaults set above; if those defaults aren't set in the current shell, add `--resource-group <resource-group> --catalog <catalog>` explicitly. See the [`az sphere device restart` reference](/azure-sphere/reference/cli/azsphere-device?view=azure-sphere-integrated#az-sphere-device-restart) for the parameter list.

   ```
   az sphere device restart --device <device-id>
   ```

## Enable real-time core debugging only when needed

Most high-level application exercises don't require real-time core debugging. Only complete this step when an exercise explicitly debugs a real-time capable application.

1. Open the appropriate command line for your operating system:
   - On Windows, open **PowerShell** or **Command Prompt** as **Administrator**. The `--enable-rt-core-debugging` parameter installs USB debugger drivers, so the command requires an elevated shell.
   - On Linux, open a normal **Terminal**. The Azure Sphere SDK udev rules and `azsphere` group membership installed during SDK setup typically provide the access needed for this command. If the command fails with a permissions error, re-run it with `sudo`. See the [`az sphere device enable-development` reference](/azure-sphere/reference/cli/azsphere-device?view=azure-sphere-integrated#az-sphere-device-enable-development), which annotates `--enable-rt-core-debugging` with "Requires administrator permissions."

   ```azurecli
   az sphere device enable-development --resource-group <resource-group> --catalog <catalog> --device <device-id> --enable-rt-core-debugging
   ```

1. If you used an elevated Windows shell, close it after the command completes.

## Clone the Azure Sphere Developer Learning Path

> [!NOTE]
> Clone the *Azure Sphere Developer Learning Path* to a directory close to the root directory on your computer. For example, **c:\lab**, or **~/**. The reason is that the Azure Sphere build process uses CMake which can struggle with long path and directory names.

```
git clone --depth 1 https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path.git Azure-Sphere
```

## Clone the Azure Sphere samples

The Azure Sphere samples repository includes a tool required for listing Azure IoT Central network endpoints.

Clone this repository into the same directory that you cloned the Azure Sphere Developer Learning Path into.

```
git clone --depth 1 https://github.com/Azure/azure-sphere-samples.git
```
