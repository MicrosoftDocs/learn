Before starting to prototype and develop Azure Sphere applications, you need to set up your Azure Sphere on your PC. In this unit, you'll learn how to install Azure Sphere SDK, claim your device and set up your Azure Sphere for application deployments.

Firstly you'll install the Azure Sphere SDK so that you work with **azsphere** command-line utility.

Secondly, you'll claim your device by an Azure Sphere tenant. Each device is claimed once and after you claim your device you can't move it to different tenant. Claiming the device associates its unique, immutable device ID with your Azure Sphere tenant. The Azure Sphere Security Service uses the device ID to identify and authenticate the device.

Then, you'll configure the Azure Sphere for network connection and update the device OS. The Azure Sphere device checks and receives OS update and application updates from Azure Sphere Security each time it boots. Azure Sphere can also communicate with services such as an Azure IoT Hub.

The components you'll need to know are:

- **Azure Sphere SDK:** includes the azsphere command-line utility, device libraries, and Visual Studio extensions for managing devices, developing and deploying applications, and working with cloud services.
- **Azure Sphere tenant:** is associated with your organization’s Azure Active Directory (Azure AD) instance. It provides a secure way for your organization to remotely manage its Azure Sphere devices in isolation from other customers’ devices. Your organization must create an Azure Sphere tenant and then claim each of its devices into that tenant, so that you can manage those devices remotely and securely.
- **Azure Sphere OS:** is a custom Linux-based microcontroller operating system created to run on an Azure Sphere-certified chip and to connect to the Azure Sphere Security Service.
- **Azure Sphere Security Service:** communicates securely with devices and deploys both the Azure Sphere OS and your engineering team’s software updates to the Azure Sphere devices.

The steps you follow:

1. Install Azure Sphere SDK
2. Claim your Azure Sphere
   1. Log in Azure Sphere
   2. Create a new tenant
   3. Set default Azure Sphere tenant
   4. Claim your Azure Sphere
3. Configure the Azure Sphere Wi-Fi network
4. Update Azure Sphere OS
5. Enable app development on the device

After successfully completing this unit, the components that you need will be installed and your development environment will be set up to develop applications.
