In this unit, you'll install the software required for Azure Sphere development.

The following list outlines the steps you'll need to complete. Be sure to follow the steps for your computer operating system.

1. Install Visual Studio Code.
1. Install the Azure Sphere SDK.
1. Claim your Azure Sphere device.
1. Configure the Azure Sphere Wi-Fi network.
1. Update the Azure Sphere OS.
1. Enable app development on the device.
1. Clone the Altair Emulator repository.
1. Update and test build the Altair emulator project.

## Windows 10 users

This module uses Visual Studio Code. If you're a Windows user who's comfortable with Visual Studio, you can still complete the exercises. Just be aware that the IDE screenshots included in this module will be different from your experience.

Complete the following steps:

1. Install the latest Azure Sphere SDK.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The quickstart [Install the Azure Sphere SDK for Windows](/azure-sphere/install/install-sdk?pivots=vs-code&azure-portal=true) will step you through the process.

### Install the Git client for Windows

The Git client is required to clone the learning path labs and the Azure Sphere SDK samples. [Install Git for Windows](https://git-scm.com/downloads?azure-portal=true).

### Install PowerShell for Windows

[Install the latest version of PowerShell](/powershell/scripting/install/installing-powershell-core-on-windows) on your computer.

### Install the real-time core GNU Arm Embedded Toolchain for Windows

[Download and install the latest GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads?azure-portal=true) for Windows.

### Restart your computer

When you've completed all steps, restart your computer.

## Ubuntu 18.04 or 20.04 LTS users

Complete the following steps:

1. Install the Azure Sphere SDK.
   
   >[!NOTE]
   > Be sure to install the new **azsphere CLI v2**.
1. Set up the device connection.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The quickstart [Install the Azure Sphere SDK for Linux](/azure-sphere/install/install-sdk-linux?pivots=vs-code-linux&azure-portal=true) will step you through the process.

### Install the Git client for Linux

The Git client is required to clone the learning path labs and the Azure Sphere SDK samples. To install it, use the following code:

```bash
sudo apt install git
```

### Install PowerShell for Linux

[Install the latest version of PowerShell for Linux](/powershell/scripting/install/installing-powershell-core-on-linux) on your computer.

### Install the real-time core GNU Arm Embedded Toolchain for Linux

1. Download the latest [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads?azure-portal=true) for Linux.
2. Install the downloaded package. The following code installs the toolchain in the */opt* folder:

    ```bash
    sudo tar -xjvf gcc-arm-none-eabi-<version-number>-major-x86_64-linux.tar.bz2 -C /opt
    ```

3. Update your path. Open *~/.bashrc* and add the following code to the end:

    ```bash
    export PATH=$PATH:/opt/gcc-arm-none-eabi-<version-number>-major/bin
    ```

4. Optional: The real-time core debugger relies on the *libncurses.so.5* library. Depending on your system setup, this library might already be installed. If not, run the following commands:

    ```bash
    sudo add-apt-repository universe
    sudo apt-get install libncurses5
    ```

## Windows and Ubuntu users

### Delete existing applications on Azure Sphere

1. From the Windows PowerShell command line or Linux terminal, run the following command to delete any existing applications on the device:

   ```azsphere
   azsphere device sideload delete
   ```

2. Restart Azure Sphere:

   ```azsphere
   azsphere device restart
   ```

### Enable high-level core development

From the Windows PowerShell command line or Linux terminal, run the following command to enable high-level app development on the device:

```azsphere
azsphere device enable-development
```

### Enable real-time core development

From the Windows PowerShell command line or Linux terminal, run the following command to enable real-time app development on the device:

```azsphere
azsphere device enable-development -r
```

### Clone the repository

Use the following command to clone the AzureSphereAltair8800 GitHub repository.

> [!NOTE]
> Clone the *Altair project* to a folder that's close to the root folder on your computer. For example, clone it to *c:\lab* or *~/*. The reason is that the Azure Sphere build process uses CMake, which can struggle with long path and folder names.

```
git clone --recurse-submodules https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.git
```

### Update and test your Azure Sphere installation

When the Altair emulator project was released, it targeted version 10 of the Azure Sphere APIs and version 21.07 of the Azure Sphere SDK. It's likely that you installed a more recent version of the Azure Sphere SDK.

Follow these steps to update the configuration files for all high-level Azure Sphere projects in the *Altair8800Emulator* folder:

1. Open a command prompt.
1. Go to the *Altair8800Emulator* folder that you cloned to your computer.
1. Run the *update_config* PowerShell script:

    ```pwsh
    pwsh ./tools/build-tools/update_config.ps1

    ```

> [!NOTE]
> The *update_config* script updates the *cmake/azsphere_config.cmake* file for each high-level Azure Sphere project in the *Altair8800Emulator* folder that you cloned.

Test that you can build the Altair 8800 projects:

1. From the command prompt, ensure that you're still in the *Altair8800Emulator* folder that you cloned to your computer.
1. Run the *build_all* PowerShell script:

    ```pwsh
    pwsh ./tools/build-tools/build_all.ps1

    ```

1. Check the build completion message to confirm a successful build. The build completion message will be similar to `Build All completed successfully. Elapsed time: 00:00:17`. If the build process fails, check that you installed all the required components. On Windows, check that you added Ninja and CMake to the path.

1. Close the command prompt.
