Before starting to prototype and develop Azure Sphere applications, you need to set up Azure Sphere on your PC. In this unit, you'll learn how to install the Azure Sphere SDK, claim your device, and set up Azure Sphere for application deployments.

### Steps to install

The steps you'll need to take are:

- **Install Azure Sphere SDK and CLI tooling**: install the Azure Sphere SDK and the Azure CLI `azure-sphere` extension so you can use the current **az sphere** command-line utility. The SDK also installs the legacy **azsphere** CLI, but the legacy service interfaces retire on 27 September 2027 and are not recommended for new work.
- **Claim your device**: by using an Azure Sphere catalog in Azure Sphere (Integrated), or a tenant if you are intentionally using Azure Sphere (Legacy). Each device is claimed once, and after you claim your device, you can't move it to a different catalog or tenant. Claiming the device associates its unique, immutable device ID with your Azure Sphere catalog or tenant. The Azure Sphere Security Service uses the device ID to identify and authenticate the device.
- **Configure Azure Sphere for network connection and update the device OS**: The Azure Sphere device checks and receives OS updates and application updates from the Azure Sphere Security Service each time it boots. Azure Sphere can also communicate with services such as Azure IoT Hub.

<!-- ## Components needed

The components you'll need to know are:

- **Azure Sphere SDK:** includes the **azsphere** command-line utility, device libraries, and Visual Studio extensions for managing devices, developing and deploying applications, and working with cloud services.
- **Azure Sphere tenant:** is associated with your organization's Azure Active Directory (Azure AD) instance. It provides a secure way for your organization to remotely manage its Azure Sphere devices in isolation from other customers' devices. Your organization must create an Azure Sphere tenant and then claim each of its devices into that tenant, so that you can manage those devices remotely and securely.
- **Azure Sphere OS:** is a custom Linux-based microcontroller operating system created to run on an Azure Sphere-certified chip and to connect to the Azure Sphere Security Service.
- **Azure Sphere Security Service:** communicates securely with devices and deploys both the Azure Sphere OS and your engineering team's software updates to the Azure Sphere devices. -->

## Configuration steps

The steps you follow are:

1. Install Visual Studio Code.
1. Install the Azure Sphere SDK and the Azure CLI `azure-sphere` extension.
1. Claim your Azure Sphere device.
   1. Sign in to Azure by using `az login`.
   1. Choose an existing Azure Sphere catalog or create a new catalog.
   1. Set the active Azure subscription, and optionally configure Azure CLI defaults for your resource group and catalog if you want shorter `az sphere` commands.
   1. Claim your Azure Sphere device into the catalog.
   1. If you're intentionally following legacy `azsphere` commands, select the correct legacy tenant instead of creating a new legacy tenant for new work.
1. Configure the Azure Sphere Wi-Fi network.
1. Update the Azure Sphere OS.
1. Enable app development on the device.

After you successfully complete this unit, the components that you need will be installed and your development environment will be set up to develop applications.
