In this unit, you'll learn how to secure, build, deploy, and debug your high-level Azure Sphere application onto the Azure Sphere A7 Core. Your Azure Sphere device application will connect to Azure IoT Hub and send room environment telemetry to Azure IoT Hub.

## Components needed

- **Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for Azure IoT Hub.

- **Azure IoT Hub:** This enables highly secure and reliable communication between your IoT application and the devices it manages. Azure IoT Hub provides a cloud-hosted solution to connect virtually any device. Extend your solution from the cloud to the edge with per-device authentication, built-in device management, and scaled provisioning.

- **Device provisioning service:** This component of Azure IoT Hub enables zero-touch, just-in-time, large-scale device provisioning.


## Steps to connect the monitor to Azure IoT Hub

To set up the connectivity between the high-level Azure Sphere application and Azure IoT Hub, do the following:

1. Create Azure resources.
1. Set up a trusted relationship between your Azure Sphere device tenant and the device provisioning service.
1. Connect Azure IoT Explorer to your IoT Hub.
