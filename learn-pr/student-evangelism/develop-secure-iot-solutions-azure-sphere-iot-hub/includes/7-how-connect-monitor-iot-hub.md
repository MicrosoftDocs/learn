In this unit, you'll learn how to secure, build, deploy, and debug your high-level Azure Sphere application onto the Azure Sphere A7 Core. Your Azure Sphere device application will connect to Azure IoT Hub and send room environment telemetry to Azure IoT Hub.

## Components needed

- **Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for both Azure IoT Hub and Azure IoT Central.

- **Azure IoT Hub:** This enables highly secure and reliable communication between your IoT application and the devices it manages. Azure IoT Hub provides a cloud-hosted solution to connect virtually any device. Extend your solution from the cloud to the edge with per-device authentication, built-in device management, and scaled provisioning.

- **Device provisioning service:** This component of Azure IoT Hub enables zero-touch, just-in-time, large-scale device provisioning.

- **High-level application:** Every Azure Sphere device has a high-level application, which runs on the Azure Sphere operating system and uses the application libraries. A high-level application can:

  - Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces.
  - Communicate with RTApps.
  - Communicate with the internet and cloud-based services.
  - Broker trust relationships with other devices and services via certificate-based authentication.

## Steps to connect the monitor to Azure IoT Hub

To set up the connectivity between the high-level Azure Sphere application and Azure IoT Hub, do the following:

1. Create Azure resources.
2. Set up a trusted relationship between your Azure Sphere device tenant and the device provisioning service.
3. Configure the Azure Sphere application to connect to Azure IoT Hub.
   1. Open the lab project with Visual Studio Code.
   2. Set your developer board configuration.
   3. Review the high-level (A7) Core application security requirements.
      1. Review pin mappings.
      2. Review application capabilities in the manifest file.
   4. Update the Azure IoT application connection properties in the manifest file.
4. Deploy and debug your application.
   1. Connect Azure Sphere to your computer.
   2. Start app deployment.
   3. View the debugger output to see device telemetry data on Visual Studio Code.
5. View the device telemetry from Azure Cloud Shell.

By the end of the module, you'll be able to view the environment telemetry on Visual Studio Code, and then display the telemetry data in the cloud.