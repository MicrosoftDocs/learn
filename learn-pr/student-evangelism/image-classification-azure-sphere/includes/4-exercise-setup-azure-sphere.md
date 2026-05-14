## Install the Azure Sphere SDK and development tools

Use Azure Sphere Integrated tooling from a standard PowerShell, Windows Command Prompt, or Bash shell. Don't use the legacy Azure Sphere Developer Command Prompt or `azsphere` tenant workflow; the legacy CLI and service interfaces retire on 27 September 2027.

1. Confirm that your development computer is running Windows 11, Windows 10 Anniversary Update or later, Ubuntu 24.04 LTS x64, or Ubuntu 22.04 LTS x64. Make sure you have an unused USB port, or USB pass-through if you're using a virtual machine.

2. Install [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) if it isn't already installed. Open a standard shell and check the Azure CLI version:

   ```azurecli
   az version
   ```

   If `azure-cli` is earlier than 2.45.0, update Azure CLI before you install the Azure Sphere extension.

3. Install the Azure Sphere SDK for your operating system:

   - [Azure Sphere SDK for Windows](https://aka.ms/AzureSphereSDKDownload/Windows)
   - [Azure Sphere SDK for Linux](https://aka.ms/AzureSphereSDKInstall/Linux)

   On Linux, make sure your account has `sudo` permission, then install the required packages before you run the SDK installer:

   ```bash
   sudo apt-get update && sudo apt-get install -y net-tools curl
   ```

   When the Linux SDK installer asks `Set up the default udev rule and group (azsphere), and add the current user to it?`, answer `Y`. After the installer finishes, log out and back in, or restart, so PATH and the `azsphere` group membership take effect before you run `az sphere` commands.

   Restart your computer if the installer requests it.

4. Install CMake, Ninja, and Visual Studio Code. In Visual Studio Code, install the **Azure Sphere** and **CMake Tools** extensions. For RTApp development, install the GNU Arm Embedded Toolchain.

5. Open a standard shell and sign in to Azure:

   ```azurecli
   az login
   ```

6. Add the Azure Sphere extension for Azure CLI:

   ```azurecli
   az extension add --name azure-sphere
   ```

   If the extension is already installed, update it with `az extension update --name azure-sphere`.

7. If your account has access to more than one subscription, select the subscription that contains or will contain your Azure Sphere resources:

   ```azurecli
   az account set --subscription <SubscriptionNameOrId>
   ```

## Connect your Azure Sphere dev kit and verify USB drivers

1. Connect your Azure Sphere dev kit to your computer through USB. On Windows, the SDK and Windows Update should install the FTDI drivers automatically the first time the device is connected.

2. Open **Device Manager** and expand **Universal Serial Bus controllers**. Verify that the board appears as four **USB Serial Converter** entries. If RTApp development was previously enabled on this board, three **USB Serial Converter** entries can be normal.

3. If the USB Serial Converter entries don't appear, right-click the device in **Device Manager** and select **Update driver**. Only if automatic installation and **Update driver** both fail, download the matching FTDI VCP driver from [Future Technology Devices International (FTDI)](https://www.ftdichip.com/Drivers/VCP.htm).

## Create or select an Azure Sphere catalog

An Azure Sphere catalog is an Azure resource in a resource group. Access is controlled by Azure RBAC on the resource group, catalog, product, or device group. Use Azure Sphere-specific roles—Azure Sphere Owner, Azure Sphere Contributor, Azure Sphere Publisher, and Azure Sphere Reader—at the least scope that grants the needed access. You need permissions such as Azure Sphere Contributor or Azure Sphere Owner to create a catalog or claim a device. Generic Azure Reader doesn't work as expected for Azure Sphere resources; use Azure Sphere Reader for read-only access.

1. If you don't already have a resource group for Azure Sphere resources, create one:

   ```azurecli
   az group create --name <ResourceGroupName> --location <AzureRegion>
   ```

2. If your organization already has an Azure Sphere catalog, ask for Azure RBAC access to the resource group or catalog and list the catalogs you can use:

   ```azurecli
   az sphere catalog list --resource-group <ResourceGroupName>
   ```

3. If you need a new catalog, create one. Catalog names can contain alphanumeric characters, underscores, and hyphens, and must be fewer than 30 characters.

   ```azurecli
   az sphere catalog create --resource-group <ResourceGroupName> --name <CatalogName>
   ```

4. Set Azure CLI defaults so later Azure Sphere commands don't require you to repeat the same resource group and catalog:

   ```azurecli
   az config set defaults.group=<ResourceGroupName> defaults.sphere.catalog=<CatalogName>
   ```

## Claim your device

> [!NOTE]
> If this Azure Sphere device is already claimed into the catalog you plan to use, continue to the next section. Claiming is a one-time operation. After a device is claimed, it can't be moved to another catalog.

1. List the attached devices and copy the device ID:

   ```azurecli
   az sphere device list-attached
   ```

2. Claim the device into your catalog. Replace `<DeviceIdValue>` with the device ID from the previous command.

   ```azurecli
   az sphere device claim --resource-group <ResourceGroupName> --catalog <CatalogName> --device <DeviceIdValue>
   ```

## Configure the Azure Sphere Wi-Fi network

Configure networking so the device can receive Azure Sphere OS updates and use Azure Sphere cloud management. Wi-Fi doesn't allow the RTApp in this module to use the internet or Azure IoT Hub directly; that would require a high-level partner application and separate IoT Hub/DPS setup.

Azure Sphere supports 802.11b/g/n Wi-Fi networks that use WPA2-PSK, EAP-TLS, or open (no password) authentication. WEP isn't supported. SSIDs are case-sensitive. The commands in this section cover WPA2-PSK and open networks; for enterprise EAP-TLS networks, follow the [EAP-TLS setup docs](https://learn.microsoft.com/azure-sphere/network/eap-tls-overview?view=azure-sphere-integrated).

1. If your network requires MAC address registration, get the device MAC address and register it with your network administrator:

   ```azurecli
   az sphere device wifi show-status
   ```

2. Scan for available Wi-Fi access points:

   ```azurecli
   az sphere device wifi scan
   ```

3. Add your Wi-Fi network to the device. For a WPA2-PSK network, replace `<SSID>` with the exact network name and `<NetworkKey>` with the WPA2-PSK key.

   ```azurecli
   az sphere device wifi add --ssid <SSID> --psk <NetworkKey>
   ```

   For an open network, omit `--psk`. If the SSID is hidden, add `--targeted-scan`. If the SSID or key contains spaces or special characters, enclose it in quotes.

4. Check the Wi-Fi connection status:

   ```azurecli
   az sphere device wifi show-status
   ```

## Update the Azure Sphere OS

After the device is claimed and connected to the internet, it checks for Azure Sphere OS and application updates when it boots, when it first connects, and at 24-hour intervals. Normal cloud-managed device groups can receive OS and application updates from deployments. In this module, you'll use sideloaded apps in the Development device group; that group receives OS updates but not cloud application updates.

1. Check deployment and update status:

   ```azurecli
   az sphere device show-deployment-status --resource-group <ResourceGroupName> --catalog <CatalogName> --device <DeviceIdValue>
   ```

2. If updates are available, allow 15-20 minutes for download and installation. Azure Sphere OS updates are staged; between stages the board can appear functional, and during a stage it can be unresponsive or restart.

3. Check the installed OS version:

   ```azurecli
   az sphere device show-os-version
   ```

4. If you have an early Seeed Azure Sphere MT3620 Development Kit that has never been used and it can't be claimed, connected, or updated, connect it by USB and run device recovery before retrying the claim and Wi-Fi steps:

   ```azurecli
   az sphere device recover
   ```

## Enable app development and RT-core debugging

Enable development before you delete, sideload, deploy, or debug applications. This command enables application sideloading and debugging, enables RT-core debugging, and assigns the device to the Development device group. The Development group receives OS updates but not cloud application updates.

1. On Windows, open PowerShell or Windows Command Prompt as an administrator because RT-core debugging installs USB debugger drivers. On Linux, use a standard shell.

2. Run the following command:

   ```azurecli
   az sphere device enable-development --enable-rt-core-debugging --catalog <CatalogName> --resource-group <ResourceGroupName>
   ```

3. On Windows, close the administrator shell after the command completes.

## Delete any existing applications on Azure Sphere

1. Delete existing sideloaded applications from the device:

   ```azurecli
   az sphere device sideload delete
   ```

2. Restart the device:

   ```azurecli
   az sphere device restart
   ```
