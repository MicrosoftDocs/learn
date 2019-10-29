The REST API enables you to manage the devices in your IoT Central application programmatically.

To simplify the job of a store manager, you've been asked to integrate IoT Central device management capabilities into the existing store management application. Store managers want to use the existing store management application to manage devices connected your IoT Central application.

Here, you'll review the types of device and device authentication in an IoT Central application. Then you'll learn how to use the REST API to manage the devices.

## Devices and device templates

Any device that's connected to and managed by an IoT Central application is associated with a device template in the application. The device template acts as a contract between the IoT Central application and the devices connected to it. The device template also includes information about how IoT Central display's information about the device in the web UI. For example, a device template can include definitions of dashboards to show device telemetry or to send commands to a device.

## What is a device template?

A device template specifies the capabilities of a device you want to connect to your application. For example, a device template can specify:

- The types of telemetry, such as temperature, that your device will send to IoT Central.
- Properties, such as firmware version, that your device will report to IoT Central.
- Properties, such as target temperature, that IoT Central will set on your device.
- Commands, such as reboot, that IoT Central will send to your device.

![An example device template for an MXChip IoT DevKit device in the IoT Central UI](../media/4-device-template.png)

The capabilities in a device template are grouped into interfaces. Interfaces enable you to share groups of related capabilities across templates. For example, the common *Device Information* interface defines device properties such as the manufacturer, model, and software version.

![The Device Information interface in the example device template in the IoT Central UI](../media/4-device-information.png)

You create and manage device templates using the IoT Central web UI or the REST API. In the IoT Central web UI, you can:

- Build a device template from scratch.
- Browse the Azure IoT device catalog, and import device templates for certified devices.
- Import a JSON file that contains a device capability model and interface definitions.

To author a JSON device capability model file, use the [Azure IoT Tools for VS Code extension pack](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-tools).

## Publish a device template

Before a real device can connect to your IoT Central application, you must publish the device template within the IoT Central application. After you publish a device template, you can also create simulated devices from the template.

Once a device template is published, significant changes to the device capability model or interface definitions require that you create and publish a new version of the device template.

## Manage device templates using the REST API

The IoT Central REST API lets you:

- Get a list of the device templates in the application
- Get a device template by ID
- Add a device template to your application
- Update a device template in your application
- Delete a device template in your application

## Real devices

Before you connect a device in the real world to an IoT Central application, you must add it in the application. When you add a device in an IoT Central application, you give the device:

- A unique ID within the application
- A friendly name

Each real device also has its own security credentials that the device uses to authenticate with the IoT Central application.

IoT Central also has options to add devices in bulk or allow devices to self-register with the application. However, a discussion of these options and what they might mean for your applications is beyond the scope of this module.

## Real device credentials

IoT Central supports two authentication types for real devices to connect:

- **Shared access signatures (SAS)**: IoT Central automatically generates SAS keys for every real device. A device can use the SAS key to authenticate with your IoT Central application.
- **X.509 certificates**: You can upload a root or intermediate certificate to an IoT Central application and use it to generate device certificates.

X.509 certificates are recommended in a production environment, but SAS keys are convenient to use in a test or proof-of-concept environment.

## Simulated devices

IoT Central can generate simulated devices from a device template. These simulated devices are useful for testing the behavior of your IoT Central application. A simulated device sends telemetry, reports property values, lets the application set property values, and responds to commands. In this module, you'll create some simulated devices to generate telemetry data to export.

## Use the REST API to manage your device templates

The [IoT Central REST API for device templates](https://docs.microsoft.com/rest/api/iotcentral/devices) lets you:

- Create a device template
- Update a device template
- Delete a device template
- Retrieve a device template
- List the devices associated with a template

## Use the REST API to manage your devices

The [IoT Central REST API for devices](https://docs.microsoft.com/rest/api/iotcentral/devices) lets you:

- Get a list of the devices in the application
- Get a device by ID
- Create a device
- Update a device
- Delete a device
- Get a device telemetry value
