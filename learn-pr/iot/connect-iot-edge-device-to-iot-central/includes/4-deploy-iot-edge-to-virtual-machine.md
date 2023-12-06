To test your IoT Edge configuration, you need to deploy the IoT Edge runtime to a virtual machine (VM).

Before you deploy real IoT Edge devices to your stores, you want to verify that the devices will work as expected. To test your scenario, you plan to deploy the IoT Edge runtime to an Azure Linux VM, and then deploy your IoT Edge modules to this VM.

Here, you'll review some core IoT Edge concepts, learn how an IoT Edge device connects to an IoT Central application, and how IoT Central deploys your IoT Edge modules to the IoT Edge runtime.

## What is the IoT Edge runtime?

The Azure IoT Edge runtime enables custom and cloud logic on IoT Edge devices. The runtime sits on the IoT Edge device, and performs management and communication operations. The runtime:

- Installs and update workloads on the device.
- Maintains Azure IoT Edge security standards on the device.
- Ensures that IoT Edge modules are always running.
- Reports module health to the cloud for remote monitoring.
- Manages communication between downstream devices and an IoT Edge device, between modules on an IoT Edge device, between an IoT Edge device and the cloud, and between IoT Edge devices.

## What are IoT Edge modules?

IoT Edge modules are units of execution that run your business logic at the edge. Modules are implemented as Docker-compatible containers. Multiple modules can be configured to communicate with each other, creating a data processing pipeline. You can develop custom modules or package certain Azure services into modules that provide insights offline and at the edge. Because the modules run in Docker containers, they behave in the same way whether they're installed on a VM or on a real device.

In the next unit, you'll install the IoT Edge runtime and deploy a custom module that collects environmental data to send to IoT Central. An IoT Central operator can then monitor the environmental conditions in your stores by viewing the telemetry on dashboards in the application.

## How does an IoT Edge device connect to IoT Central?

IoT Edge devices, like other devices, use the IoT Hub Device Provisioning Service (DPS) to connect to your IoT Central application. In the previous unit, when you added a device to your IoT Central application, you made a note of the *scope ID*, *device ID*, and *device key*. You add these values to the IoT Edge configuration file on the IoT Edge device. The relevant section of this TOML file looks like the following. The `registration_id` is the device ID:

```toml
[provisioning]
source = "dps"
global_endpoint = "https://global.azure-devices-provisioning.net"
id_scope = "YOUR_ID_SCOPE"

[provisioning.attestation]
method = "symmetric_key"
registration_id = "YOUR_DEVICE_ID"
symmetric_key = { value = "YOUR_DEVICE_KEY" }
```

In the next unit, the deployment script you use for the IoT Edge device edits the configuration file for you.

## How does IoT Central deploy modules to an IoT Edge runtime?

In the previous unit, when you created the device template for the environmental sensor, you uploaded a deployment manifest to the template. When the IoT Edge runtime connects to your IoT Central application, it downloads the deployment manifest. The runtime uses the information in the deployment manifest to determine which modules to install and how to configure them. Modules download from a container registry such as Azure Container Registry or Docker Hub.

The deployment manifest you used installs the two required system modules, `edgeAgent` and `edgeHub`, and a custom `SimulatedTemperatureSensor` module. This custom module sends ambient and machine telemetry to IoT Central and has two properties, **SendData** and **SendInterval**, that an operator can use to configure the module:

:::code language="json" source="~/../iot-central-docs-samples/iotedge/EnvironmentalSensorManifest-1-4.json":::
