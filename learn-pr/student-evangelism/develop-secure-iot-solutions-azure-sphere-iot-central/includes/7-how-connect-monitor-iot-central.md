Your Azure Sphere application will connect to Azure IoT Central and send room environment telemetry to Azure IoT Central. You'll learn how to secure, build, deploy, and debug your high-level Azure Sphere application onto the Azure Sphere A7 core.

## Components used

The components for this unit:

**Azure IoT Central:** This service is an Internet of Things (IoT) application platform. [Azure IoT Central](https://azure.microsoft.com/services/iot-central&azure-portal=true) provides an easy way to connect, monitor, and manage your IoT assets at scale. IoT Central is built on Azure IoT Hub, Azure Device Provisioning Service, Stream Analytics, and Time Series Insights.

**Azure IoT Central application:** An Azure IoT Central application simplifies the creation of IoT solutions. You'll learn how to create, customize, manage, and use an Azure IoT Central application.

**Azure Sphere applications:** We will be running high-level and real-time applications on the Azure Sphere.

A high-level application can:

- Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces.
- Communicate with Real-time apps running on the Azure Sphere real-time cores.
- Communicate with the internet and cloud-based services.
- Broker trust relationships with other devices and services via certificate-based authentication.

## Setup overview

By the end of the module, you'll be able to view the environment telemetry in Visual Studio Code and then display the telemetry data in the cloud from the Azure IoT Central dashboard.

### Steps to follow

An overview of the steps you'll follow is:

1. Create an Azure IoT Central application.
1. Set up a trusted relationship between your Azure Sphere tenant and Azure IoT Central.
1. Configure the Azure Sphere application to connect to Azure IoT Central.
1. Deploy and debug your application.
1. View the device telemetry on the Azure IoT Central dashboard.
1. Integrate a high-level application with a real-time core application.
