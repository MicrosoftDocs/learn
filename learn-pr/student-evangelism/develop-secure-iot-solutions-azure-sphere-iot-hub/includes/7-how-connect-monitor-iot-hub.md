In this unit, you'll learn how to secure, build, deploy, and debug your High-Level (HL) Azure Sphere application onto the Azure Sphere A7 Core. Your Azure Sphere application will connect to Azure IoT Hub and send room environment telemetry to Azure IoT Hub.

The components for this unit:

**Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for both Azure IoT Hub and Azure IoT Central. This module focuses on Azure IoT.

**Azure IoT Hub:** enables highly secure and reliable communication between your IoT application and the devices it manages. Azure IoT Hub provides a cloud-hosted solution back-end to connect virtually any device. Extend your solution from the cloud to the edge with per-device authentication, built-in device management, and scaled provisioning.

**Device Provisioning Service:** This project leverages the Azure IoT Hub Device Provisioning Service (DPS). The DPS enables zero-touch, just-in-time, large scale device provisioning.

**High-Level Application:** Every Azure Sphere device has a high-level application, which runs on the Azure Sphere OS and uses the application libraries. A high-level application can:

- Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces
- Communicate with RTApps
- Communicate with the internet and cloud-based services
- Broker trust relationships with other devices and services via certificate-based authentication

The steps you'll follow:

1. Create Azure resources
2. Set up a trusted relationship between your Azure Sphere Tenant and IoT Device Provisioning Service
3. Configure the Azure Sphere Application to connect to Azure IoT Hub.
   1. Open the lab project with Visual Studio Code
   2. Set your developer board configuration
   3. Review the High-Level (A7) Core application security requirements
      1. Review pin mappings
      2. Review application capabilities in manifest file
   4. Update the Azure IoT Application connection properties in manifest file
4. Deploy and debug your application
   1. Connect Azure Sphere to your computer
   2. Start app deployment
   3. View debugger output to see device telemetry data on VS Code
5. View the device telemetry from the Azure Cloud Shell

By the end of the module, you'll be able to view the environment telemetry on VS Code and then display the telemetry data in the cloud.
