Install the following software on your computer.

------

## Troubleshooting

1. If you have trouble connecting to the Azure Sphere over USB be sure to disable any VPNs you might have enabled.
2. The **TAP-Windows Adapter V9** installed with VPN clients, including OpenVPN client is not compatible with the **TAP-Windows Adapter V9** required and installed by the Azure Sphere SDK. You will need to uninstall the VPN client and reinstall the Azure Sphere SDK for Visual Studio.

------

## Windows 10 users

You need to do the following:

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

------

## Ubuntu 18.04 or 20.04 LTS users

You need to do the following:

1. Install the Azure Sphere SDK.
1. Set up the device connection.
1. Install CMake and Ninja.
1. Install Visual Studio Code.
1. Install the Visual Studio Code Azure Sphere extension.
1. Claim your device.
1. Configure networking for the device.

The following [Quickstart: Install the Azure Sphere SDK for Linux](https://docs.microsoft.com/en-us/azure-sphere/install/install-sdk-linux?pivots=vs-code-linux&azure-portal=true) will step you through the process.

### Install the Git client for Linux

The Git client is required to clone the Learning Path Labs and the Azure Sphere SDK Samples.

```bash
sudo apt install git
```

------

## Delete any existing applications on Azure Sphere

1. From the **Azure Sphere Developer Command Prompt**, run the following command to delete any existing applications on the device.

   ```bash
   azsphere device sideload delete
   ```

2. Restart Azure Sphere.

   ```bash
   azsphere device restart
   ```

------

## high-level core device debugging

1. From the **Azure Sphere Developer Command Prompt**, run the following command to enable app development on the device.

   ```bash
   azsphere device enable-development
   ```

------

## Enable Azure RTOS Real-time development

### Windows users

Open the **Azure Sphere Developer Command Prompt** as administrator, run the following command to enable app development on the device.

```bash
azsphere device enable-development -r
```

### Ubuntu users

Install the GNU Arm Embedded Toolchain.

1. Download the [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads?azure-portal=true). At the time of writing this was *Version 9-2020-q2-update*.
2. Install the downloaded package. The following installs the toolchain in the /opt directory.

    ```bash
    sudo tar -xjvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 -C /opt
    ```

3. Update your path. Open ~/.bashrc and add to the end.

    ```bash
    export PATH=$PATH:/opt/gcc-arm-none-eabi-9-2020-q2-update/bin
    ```

------

## Clone the Azure Sphere Developer Learning Path

> [!NOTE]
> On Windows, clone the *Azure Sphere Developer Learning Path* to a directory close to the root directory on your computer. For example, **c:\lab**, or **~/**. The reason is that the Azure Sphere build process uses CMake which can struggle with long path and directory names.

```bash
git clone --depth 1 https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path.git Azure-Sphere
```

------

## Clone the Azure Sphere samples

The Azure Sphere samples repository includes a tool required for listing Azure IoT Central network endpoints.

Clone this repository into the same directory that you cloned the Azure Sphere Developer Learning Path into.

```bash
git clone https://github.com/Azure/azure-sphere-samples.git
```
