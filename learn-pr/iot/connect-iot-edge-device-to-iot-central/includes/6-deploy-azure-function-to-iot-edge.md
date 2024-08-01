To reduce the amount of telemetry sent to your Azure IoT Central application, you want to filter the data on your IoT Edge device before it gets sent.

To reduce the costs associated with sending telemetry from your stores to your application, you want to filter the data on the IoT Edge device. Doing so also helps ensure that your operators only see important data. You determined that operators only need to see telemetry when the ambient temperature is above 21&deg;C.

Here, you learn how to use Azure Functions as a module on your IoT Edge device to implement the filter. You also review how to update the deployment manifest to your Azure IoT Central application. Then, IoT Edge devices that are connected to your Azure IoT Central application download it and update the modules on the device.

## What is Azure Functions?

Azure Functions is a service that lets you run small pieces of code, called _functions_, without worrying about application infrastructure. With Azure Functions, the cloud infrastructure provides all the up-to-date servers you need to keep your application running at scale.

You can also use Azure Functions to deploy a function to your IoT Edge device as a module so that the function runs locally, at the edge, rather than in the cloud.

You're planning to implement your filter using Azure Functions to run as one of the modules on your IoT Edge device. This filter limits the amount of machine temperature telemetry sent to your Azure IoT Central application.

## How to create an IoT Edge module that contains a function

You can use multiple languages to create a function for Azure Functions. The following steps outline how to build an IoT Edge module that contains a function implemented in C#:

1. Create a project that includes the scaffolding for an Azure Function module. You can create such a project using Visual Studio Code, or at the command line using the `dotnet` command.
1. Implement the business logic for the function in C#.
1. Build the project to generate a Docker image that contains the function and required Azure Functions runtime.
1. Upload the Docker image to a container registry.
1. Modify the deployment manifest for your IoT Edge device to include your new module. The configuration includes the address of the Docker image and how the function module interacts with other modules in the IoT Edge runtime.

The following snippet shows `modules` section with the new `filterfunction` module in the updated deployment manifest:

:::code language="json" source="~/../iot-central-docs-samples/iotedge/EnvironmentalSensorManifestFilter-1-4.json" range="38-59":::

Depending on the container registry you use and its configuration, your deployment manifest might require credentials to access the registry.

The following snippet shows how the telemetry is routed between the modules in the updated deployment manifest:

:::code language="json" source="~/../iot-central-docs-samples/iotedge/EnvironmentalSensorManifestFilter-1-4.json" range="65-68":::

## Update the deployment manifest in Azure IoT Central

To deploy the new module to your IoT Edge device, update the deployment manifest to your Azure IoT Central application. When you update a deployment manifest like this, the IoT Edge devices that are connected to your Azure IoT Central application download it and update the modules on the device.
