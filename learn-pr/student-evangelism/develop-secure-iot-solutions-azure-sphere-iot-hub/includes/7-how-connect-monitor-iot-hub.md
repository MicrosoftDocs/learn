In this unit, you'll learn how to configure Azure IoT Hub and Device Provisioning Service (DPS) for Azure Sphere, then build, deploy, and debug a high-level Azure Sphere application that runs on the Cortex-A7 application core. The application authenticates with DPS, connects to the linked IoT hub, and sends room environment telemetry.

## Components needed

- **Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for Azure IoT Hub.

- **Azure IoT Hub:** This enables highly secure and reliable communication between your IoT application and the devices it manages. Azure IoT Hub provides a cloud-hosted solution to connect virtually any device. Extend your solution from the cloud to the edge with per-device authentication, built-in device management, and scaled provisioning.

- **Device Provisioning Service (DPS):** A *helper service* for IoT Hub that enables zero-touch, just-in-time provisioning of devices to the right IoT hub at scale, without human intervention. DPS is a separate Azure service that links to one or more IoT hubs. See [About IoT Hub Device Provisioning Service](/azure/iot-dps/about-iot-dps?azure-portal=true).


## Steps to connect the monitor to Azure IoT Hub

To set up the connectivity between the high-level Azure Sphere application and Azure IoT Hub, do the following:

1. Create the Azure resources: an IoT hub, a DPS instance, and a link from DPS to the IoT hub.
1. Set up a trusted relationship between your Azure Sphere catalog (called a tenant in the legacy CLI) and DPS by verifying the catalog CA certificate and creating a DPS enrollment group.
1. Connect Azure IoT Explorer to your IoT hub so you can view devices, telemetry, properties, and commands.
