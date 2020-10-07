Your Azure Sphere application will connect to Azure IoT Central and send room environment telemetry to Azure IoT Central. We'll learn how to secure, build, deploy, and debug your High-Level (HL) Azure Sphere application onto the Azure Sphere A7 Core.

## Components used

The components for this unit:

**Azure IoT:** Your Azure Sphere device can securely connect and communicate with cloud services. Azure Sphere includes built-in library support for both Azure IoT Hub and Azure IoT Central. This module focuses on Azure IoT Central.

This project leverages the [Azure IoT Hub Device Provisioning Service (PDS)](https://docs.microsoft.com/azure-sphere/app-development/use-azure-iot), which is included with Azure IoT Central. The Device Provisioning Service (DPS) enables zero-touch, just-in-time, large-scale device provisioning.

**Azure IoT Central:** IoT Central is an IoT application platform. [Azure IoT Central](https://azure.microsoft.com/services/iot-central/) provides an easy way to connect, monitor, and manage your Internet of Things (IoT) assets at scale.

**Azure IoT Central Application:** Azure IoT Central application simplifies the creation of IoT solutions. You'll learn how to create, customize, manage, and use an Azure IoT Central application.

**High-Level Application:** Every Azure Sphere device has a high-level application, which runs on the Azure Sphere OS and uses the application libraries.

A high-level application can:

- Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces
- Communicate with RTApps
- Communicate with the internet and cloud-based services
- Broker trust relationships with other devices and services via certificate-based authentication

## Setup overview

By the end of the module you'll be able to view the environment telemetry on VS Code and then display the telemetry data in the cloud from Azure IoT Central Dashboard.

### Steps to follow

An overview of the steps you'll follow are:

- Create an Azure IoT Central Application
- Set up a trusted relationship between your Azure Sphere Tenant and IoT Central
- Configure the Azure Sphere Application to connect to Azure IoT Central.
  1. Open the lab project with Visual Studio Code
  2. Set your developer board configuration
  3. Review the High-Level (A7) Core application security requirements
     1. Review pin mappings
     2. Review application capabilities in manifest file
  4. Update the Azure IoT Central Application connection properties in manifest file
- Deploy and debug your application
  1. Connect Azure Sphere to your computer
  2. Start app deployment
  3. View debugger output to see device telemetry data on VS Code
- View the device telemetry on the Azure IoT Central Dashboard