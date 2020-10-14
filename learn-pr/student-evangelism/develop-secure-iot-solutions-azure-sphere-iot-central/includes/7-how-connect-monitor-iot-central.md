Your Azure Sphere application will connect to Azure IoT Central and send room environment telemetry to Azure IoT Central. You'll learn how to secure, build, deploy, and debug your high-level Azure Sphere application onto the Azure Sphere A7 core.

## Components used

The components for this unit:

**Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for both Azure IoT Hub and Azure IoT Central. This module focuses on Azure IoT Central.

This project leverages the [Azure IoT Hub Device Provisioning Service](https://docs.microsoft.com/azure-sphere/app-development/use-azure-iot), which is included with Azure IoT Central. The Device Provisioning Service enables zero-touch, just-in-time, large-scale device provisioning.

**Azure IoT Central:** This service is an Internet of Things (IoT) application platform. [Azure IoT Central](https://azure.microsoft.com/services/iot-central/) provides an easy way to connect, monitor, and manage your IoT assets at scale.

**Azure IoT Central application:** An Azure IoT Central application simplifies the creation of IoT solutions. You'll learn how to create, customize, manage, and use an Azure IoT Central application.

**High-level application:** Every Azure Sphere device has a high-level application, which runs on the Azure Sphere OS and uses the application libraries.

A high-level application can:

- Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces.
- Communicate with RTApps.
- Communicate with the internet and cloud-based services.
- Broker trust relationships with other devices and services via certificate-based authentication.

## Setup overview

By the end of the module, you'll be able to view the environment telemetry on Visual Studio Code and then display the telemetry data in the cloud from the Azure IoT Central dashboard.

### Steps to follow

An overview of the steps you'll follow is:

1. Create an Azure IoT Central application.
1. Set up a trusted relationship between your Azure Sphere tenant and Azure IoT Central.
1. Configure the Azure Sphere application to connect to Azure IoT Central.
   1. Open the lab project with Visual Studio Code.
   1. Set your developer board configuration.
   1. Review the security requirements for the high-level (A7) core application.
      - Review pin mappings.
      - Review application capabilities in a manifest file.
   1. Update the Azure IoT Central application's connection properties in the manifest file.
1. Deploy and debug your application.
   1. Connect Azure Sphere to your computer.
   1. Start app deployment.
   1. View debugger output to see device telemetry data on Visual Studio Code.
1. View the device telemetry on the Azure IoT Central dashboard.