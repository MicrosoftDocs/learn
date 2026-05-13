Before starting to prototype and develop Azure Sphere applications, you need to set up Azure Sphere on your PC and connect the device to Azure Sphere (Integrated) in Azure. In this unit, you'll learn how to install the Azure Sphere SDK, install the Azure Sphere extension for Azure CLI, claim your device into an Azure Sphere catalog, and prepare the device for application deployments.

> [!IMPORTANT]
> Before you provision hardware, review the Azure Sphere lifecycle. Microsoft announced Azure Sphere retirement on March 20, 2026. The MT3620 MCU reaches end of life on July 31, 2026, and extended support for Azure Sphere OS and the Azure Sphere Security Service ends on July 31, 2031. The setup steps below remain relevant for supported Azure Sphere lab kits and existing fleets, but new product designs should evaluate replacement architectures and supported silicon before adopting MT3620. For details, see [Retirement of Azure Sphere](/azure-sphere/product-overview/retirement?view=azure-sphere-integrated).

### Steps to install

The steps you'll need to take are:

- **Install the latest Azure Sphere SDK and command-line tools**: install the SDK for your operating system, the Azure CLI, and the Azure Sphere extension for Azure CLI. Current Azure Sphere operations use `az sphere` commands.
- **Choose or create Azure resources**: Azure Sphere (Integrated) uses an Azure subscription, resource group, and Azure Sphere catalog. Access is controlled by Azure role-based access control (RBAC). You need the appropriate Azure Sphere role, such as Administrator or Contributor on the catalog, to claim and manage devices.
- **Claim your device**: each device is claimed once into an Azure Sphere catalog. After you claim your device, you can't move it to a different catalog. Claiming the device associates its unique, immutable device ID with your catalog. The Azure Sphere Security Service uses the device ID to identify and authenticate the device.
- **Configure Azure Sphere for network connection and update the device OS**: The Azure Sphere device checks for OS and application updates when it connects to the internet after power-on or reset, and periodically thereafter. Microsoft Learn currently describes this cadence differently across the [over-the-air updates article](/azure-sphere/deployment/device-updates?view=azure-sphere-integrated) and the [networking quickstart](/azure-sphere/install/configure-wifi?view=azure-sphere-integrated), so don't rely on an exact interval for this setup step. Azure Sphere can also communicate with services such as Azure IoT Hub.
- **Enable development**: enable sideloading and debugging on the device and assign it to a development device group that does not receive cloud application updates.

> [!NOTE]
> Azure Sphere Legacy service interfaces and the legacy command-line interface retire on 27 September 2027. Use the Azure Sphere extension for Azure CLI and `az sphere` commands for new documentation, scripts, and exercises.

## Configuration steps

The steps you follow are:

1. Install Visual Studio Code and the Azure Sphere extension for Visual Studio Code, if you plan to use Visual Studio Code.
1. Install the latest Azure Sphere SDK for your operating system:
   - Windows 11 or Windows 10 Anniversary Update, or later.
   - Ubuntu 24.04 LTS or Ubuntu 22.04 LTS on an x86-64 processor.
1. Install the Azure CLI and add or update the Azure Sphere extension. To add the extension, run:

   ```azurecli
   az extension add --name azure-sphere
   ```

   If the extension is already installed, update it with:

   ```azurecli
   az extension update --name azure-sphere
   ```

   > [!IMPORTANT]
   > A few early Seeed Azure Sphere MT3620 Development Kits require a manual OS update if they have never been used. Update the OS manually before you log in, claim the device, or connect the device to the internet. Other dev kits, including the Seeed MT3620 Mini Dev Board, or already-used Seeed Azure Sphere MT3620 Development Kits update automatically after connecting to the internet; manual update isn't required. For details, see [Quickstart: Choose a catalog and claim your device](/azure-sphere/install/claim-device?view=azure-sphere-integrated).

1. Sign in to Azure and select the subscription that contains, or will contain, your Azure Sphere catalog.

   ```azurecli
   az login
   az account set --subscription <subscription-id-or-name>
   ```

1. Choose or create an Azure resource group and Azure Sphere catalog. If the catalog already exists, make sure your account has the required Azure RBAC permissions.

   ```azurecli
   az group create --name <resource-group> --location <azure-region>
   az sphere catalog create --resource-group <resource-group> --name <catalog>
   az config set defaults.group=<resource-group> defaults.sphere.catalog=<catalog>
   ```

1. Claim your Azure Sphere device into the catalog.

   ```azurecli
   az sphere device list-attached
   az sphere device claim --resource-group <resource-group> --catalog <catalog> --device <device-id>
   ```

1. Configure networking for the Azure Sphere device. For Wi-Fi, add the network and verify the connection status.

   ```azurecli
   az sphere device wifi add --ssid <SSID> --psk <network-key>
   az sphere device wifi show-status
   ```

   Azure Sphere devices don't support WEP. For an open Wi-Fi network, omit `--psk`.
1. Let the Azure Sphere OS update from the cloud and check deployment status.

   ```azurecli
   az sphere device show-deployment-status --resource-group <resource-group> --catalog <catalog> --device <device-id>
   ```

   The device checks for Azure Sphere OS and application updates after it connects to the internet following power-on or reset and then periodically thereafter. Because current Microsoft Learn pages differ on the exact periodic cadence, this lab relies on connecting the device and checking deployment status rather than waiting for a specific interval; see [About over-the-air updates](/azure-sphere/deployment/device-updates?view=azure-sphere-integrated) and [Configure networking and update the device OS](/azure-sphere/install/configure-wifi?view=azure-sphere-integrated). If updates are available, installation can take 15-20 minutes and might restart the device. If you're using one of the early Seeed Azure Sphere MT3620 Development Kits described in the Important note above, perform the manual recovery update before connecting the device to the internet. Because `az sphere device recover` requires `--catalog` and `--resource-group` (per the [CLI reference](/azure-sphere/reference/cli/azsphere-device?view=azure-sphere-integrated#az-sphere-device-recover)), sign in, set defaults, and then run recovery:

   ```azurecli
   az login
   az account set --subscription <subscription-id-or-name>
   az config set defaults.group=<resource-group> defaults.sphere.catalog=<catalog>
   az sphere device recover --resource-group <resource-group> --catalog <catalog>
   ```

   If you've already run `az config set` for `defaults.group` and `defaults.sphere.catalog`, you can omit those flags from the recover command.
1. Enable app development on the device before you sideload or delete applications.

   ```azurecli
   az sphere device enable-development --resource-group <resource-group> --catalog <catalog> --device <device-id>
   ```

After you successfully complete this unit, the components that you need will be installed and your development environment will be set up to develop applications.
