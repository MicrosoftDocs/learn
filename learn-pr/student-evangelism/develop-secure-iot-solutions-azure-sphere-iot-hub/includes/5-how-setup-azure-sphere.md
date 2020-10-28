Before starting to prototype and develop Azure Sphere applications, you need to set up Azure Sphere on your PC. In this unit, you'll learn how to install the Azure Sphere SDK, claim your device, and set up Azure Sphere for application deployments.

### Steps to install

The steps you'll need to take are:

1. **Install Azure Sphere SDK** so that you work with the **azsphere** command-line utility.
1. **Claim your device** by using an Azure Sphere tenant. Each device is claimed once, and after you claim your device, you can't move it to different tenant. Claiming the device associates its unique, immutable device ID with your Azure Sphere device tenant. The Azure Sphere security service uses the device ID to identify and authenticate the device.
1. **Configure the Azure Sphere for network connection and update the device operating system**. The Azure Sphere device checks and receives operating system updates and application updates from the Azure Sphere security service each time it boots. Azure Sphere can also communicate with services such as Azure IoT Hub.

## Components needed

The components you'll need to know are:

- **Azure Sphere SDK:** This includes the azsphere command-line utility, device libraries, and Visual Studio extensions for managing devices, developing and deploying applications, and working with cloud services.
- **Azure Sphere tenant:** This is associated with your organization’s Azure Active Directory (Azure AD) instance. It provides a secure way for your organization to remotely manage its Azure Sphere devices in isolation from other customers’ devices. Your organization must create an Azure Sphere tenant and then claim each of its devices into that tenant, so that you can manage those devices remotely and securely.
- **Azure Sphere operating system:** This is a custom, Linux-based, microcontroller operating system. It's created to run on an Azure Sphere-certified chip and to connect to the Azure Sphere security service.
- **Azure Sphere security service:** This service communicates securely with devices, and deploys both the Azure Sphere operating system and your engineering team’s software updates to the Azure Sphere devices.

## Configuration steps

The steps you follow:

1. Install the Azure Sphere SDK.
1. Claim your Azure Sphere device.
   1. Sign in to Azure Sphere.
   1. Create a new tenant.
   1. Set the default Azure Sphere tenant.
   1. Claim your Azure Sphere device.
1. Configure the Azure Sphere Wi-Fi network.
1. Update the Azure Sphere operating system.
1. Enable app development on the device.

After you successfully complete this unit, the components that you need will be installed and your development environment will be set up to develop applications.
