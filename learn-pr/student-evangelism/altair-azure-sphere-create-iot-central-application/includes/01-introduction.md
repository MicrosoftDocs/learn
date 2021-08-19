In this module, you will learn how to create an Azure IoT Central application.

## Azure IoT Central

Azure IoT Central is a cloud-based Internet of Things (IoT) application platform. [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true) provides an easy way to connect, monitor, and manage your IoT assets at scale. IoT Central is built on Azure IoT Hub, Azure Device Provisioning Service, Stream Analytics, and Time Series Insights.

:::image type="content" source="../media/architecture.png" alt-text="The illustration shows the architecture of Azure IoT Central." border="false":::

Azure IoT Central is built on the [8 attributes of successful IoT solutions](https://azure.microsoft.com/resources/8-attributes-of-successful-iot-solutions?azure-portal=true).

## IoT Central and Azure Sphere tenant trust

Trust is established by sharing your Azure Sphere tenant Certificate Authority certificate with your IoT Central application.

When you establish trust, the Azure Sphere devices in your Azure Sphere tenant will be provisioned in IoT Central when they first connect. Network traffic between your Azure Sphere and your IoT Central application will also be signed and secured using trusted certificates.

In this module, you will:

* Create an Azure IoT Central application. 
* Set up a trusted relationship between your Azure Sphere tenant and Azure IoT Central.
* Create an enrollment group.
* Create and validate a tenant CA certificate.

## Prerequisites

TBD
