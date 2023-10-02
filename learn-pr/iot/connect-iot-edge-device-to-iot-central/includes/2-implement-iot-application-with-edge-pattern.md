To verify your solution design you need an IoT Central application with a device template for your IoT Edge device.

You plan to evaluate an environmental monitoring solution for your stores with IoT Central. To collect data and manage local sensors, you plan to install an IoT Edge device in each store. The IoT Edge device will connect to your IoT Central application to send telemetry collected from the sensors and respond to commands sent from the application.

Here, you'll review some core IoT Central and IoT Edge concepts, and learn how to create a device template for your IoT Edge devices in IoT Central.

## What is IoT Central?

Azure IoT Central is an IoT application platform as a service (aPaaS) that reduces the burden and cost of developing, managing, and maintaining IoT solutions. Use IoT Central to quickly evaluate your IoT scenario and assess the opportunities it can create for your business. IoT Central enables you to:

- Connect to and control IoT devices.
- Collect and analyze telemetry from the connected devices.
- Send data from the connected devices to other applications or services for further processing or storage.

You have two options to create an IoT Central application:

- Use the [Azure portal](https://portal.azure.com/).
- Use the Azure CLI.

In this module, you'll use the Azure CLI to create your application in an Azure sandbox.

All three options require you to provide information such as the country or region for the deployment, an application name, a payment plan, and an application template.

## What is IoT Edge?

Azure IoT Edge moves cloud analytics and custom business logic to devices so that your organization can focus on business insights instead of data management. You can scale out your IoT solution by packaging your business logic into standard containers, then you can deploy those containers to any of your devices and monitor it all from a cloud-based environment such as IoT Central.

Analytics drives business value in IoT solutions, but not all analytics needs to be in the cloud. If you want to respond to emergencies as quickly as possible, you can run anomaly detection workloads at the edge. If you want to reduce bandwidth costs and avoid transferring terabytes of raw data, you can clean and aggregate the data locally and then only send the insights to the cloud for analysis.

Azure IoT Edge is made up of three components:

- IoT Edge modules are containers that run Azure services, third-party services, or your own code. IoT Edge modules are deployed to IoT Edge devices and execute locally on those devices. In this module, you'll use various IoT Edge modules including one that generates simulated environmental telemetry and one that runs an Azure function to filter that telemetry. You use a *deployment manifest* to specify the modules to deploy to your IoT Edge device. You can use IoT Central to manage the deployment manifests in your solution.
- The IoT Edge runtime runs on each IoT Edge device and manages the modules deployed to each device. When an IoT Edge device connects to an IoT Central application, the IoT Edge runtime downloads the deployment manifest to determine which modules it should install and run on the device.
- A cloud-based interface enables you to remotely monitor and manage IoT Edge devices. In this module you use IoT Central as the cloud-based interface.

## What is a device template?

In IoT Central, a device template specifies the capabilities of a device you want to connect to your application. For example, a device template can specify:

- The types of telemetry, such as temperature, that your device sends to IoT Central.
- Properties, such as firmware version, that your device reports to IoT Central.
- Properties, such as target temperature, that IoT Central sets on your device.
- Commands, such as reboot, that IoT Central sends to your device.

The capabilities in a device template are grouped into interfaces. Interfaces enable you to share groups of related capabilities across templates. For example, the common *Device Information* interface defines device properties such as the manufacturer, model, and software version.

You create and manage device templates using the IoT Central web UI or the REST API. In the IoT Central web UI, you can:

- Build a device template from scratch.
- Browse the Azure IoT device catalog, and import device templates for certified devices.
- Import a JSON file that contains a device capability model and interface definitions.

## Views

An IoT Central device template also includes view definitions. These views let you define a custom UI for your devices that includes visualizations for telemetry, forms to manage device properties, and forms that let operators call commands on a device.

If the device template is for an IoT Edge device, there's a view that lets you monitor the IoT Edge modules running on the connected device.

## Publish a device template

Before a real device can connect to your IoT Central application, you must publish the device template within the IoT Central application.

## Add a device based on the device template

Before you can connect an IoT Edge device to an IoT Central application, you add a device on the **Devices** page. On the **Devices** page, you choose the deployment manifest to use, the optional device template to use, a unique device ID, and a friendly name for the device. You can also use the Azure CLI to add a device to your application.
