In this module, you will learn how to create an Azure IoT Central application.

## Azure IoT Central

Azure IoT Central is a cloud-based Internet of Things (IoT) application platform. [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true) provides an easy way to connect, monitor, and manage your IoT assets at scale. IoT Central is built on Azure IoT Hub, Azure Device Provisioning Service, Stream Analytics, and Time Series Insights.

:::image type="content" source="../media/architecture.png" alt-text="The illustration shows the architecture of Azure IoT Central." border="false":::

Azure IoT Central is built on the [Eight attributes of successful IoT solutions](https://azure.microsoft.com/resources/8-attributes-of-successful-iot-solutions?azure-portal=true).

## IoT Central and Azure Sphere tenant trust

Trust is established by sharing your Azure Sphere tenant Certificate Authority certificate with your IoT Central application.

With trust established, your devices will be provisioned with your Altair IoT Central application. Trusted certificates are used to sign and secure network traffic between your Azure Sphere and IoT Central.

In this module, you will:

* Create an Azure IoT Central application. 
* Set up a trusted relationship between your Azure Sphere tenant and Azure IoT Central.
* Create an enrollment group.
* Create and validate a tenant CA certificate.

## Prerequisites

* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.
* An Azure Account. Sign up for a free [Student Azure account](https://azure.microsoft.com/free/students?azure-portal=true), or free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to create a cloud-based Azure IoT Central application for the Altair 8800 emulator.
