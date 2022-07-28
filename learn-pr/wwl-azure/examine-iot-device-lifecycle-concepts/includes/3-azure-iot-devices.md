The devices that you implement within an Azure IoT solution can range from constrained sensors and single purpose microcontrollers, to powerful gateways that route communications for groups of devices.

## Azure IoT device types

The physical devices that connect to IoT Hub are defined as either IoT Devices or IoT Edge Devices.

 -  IoT Devices: An IoT device is typically a small-scale, standalone computing device that may collect data or control other devices. For example, a device might be an environmental monitoring device, or a controller for the watering and ventilation systems in a greenhouse.
 -  IoT Edge Devices: IoT Edge devices have the IoT Edge runtime installed and are flagged as IoT Edge device in the device details. An IoT Edge device can be used as a field gateway device, meaning that it's an IoT Edge device that connects downstream devices to the Azure IoT Hub (downstream devices can be either IoT devices or IoT Edge devices).

> [!NOTE]
> Microsoft maintains an online device catalog that provides a list of hardware devices certified to work with IoT Hub: [Azure Certified Device Catalog](https://devicecatalog.azure.com).

Simulated devices can be used in various stages during the rollout of an IoT solution to represent individual device behaviors or to generate a telemetry workload. A simulated device is a software representation of a physical device that runs on your local machine or in the cloud.

## IoT Plug and Play

IoT Plug and Play devices are devices that don't require manual configuration when a customer connects them to an IoT Plug and Play-enabled application. As an Azure IoT developer, you can use IoT Central or IoT Hub to develop a cloud-hosted IoT solution that uses IoT Plug and Play devices. IoT Plug and Play is useful for two types of developers:

 -  A solution builder (Azure IoT Developer) who is responsible for developing an IoT solution using Azure IoT Hub and other Azure resources, and for identifying IoT devices to integrate. To learn more about using IoT Plug and Play as an Azure IoT Developer, see [IoT Plug and Play service developer guide](/azure/iot-develop/concepts-developer-guide-service).<br>
 -  A device builder who is responsible for creating the embedded device code for devices that will connect to an IoT solution. To learn more, see [IoT Plug and Play device developer guide](/azure/iot-develop/concepts-developer-guide-device).<br>
