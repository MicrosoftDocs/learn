Firstly, you create an IoT Hub and virtual device to act as an IoT Edge device in the cloud. Then you will register the device with the IoT Hub. Finally, you'll configure the IoT Edge device to connect to the IoT Hub so that your edge device will communicate with the cloud.

Secondly, you'll create a Cognitive Service resource that will consume the Text Analytics API.

Thirdly you'll deploy a module to the edge device. To do that, you'll select the Language Detection module from the Azure Marketplace and set your target IoT Edge device to receive the module. Then you'll configure Cognitive Service endpoint and API key for billing information.
Finally, you'll specify the route for how messages are passed between modules and to IoT Hub.

In this case, we specify that all messages from all modules to go directly to the IoT Hub.

You'll use the following components for this stage:

**Resource group:** a collection of resources for a solution.

**IoT Hub:** allows communication between your IoT solution and the devices it manages. It connects to the devices with per-device authentication.

**Device identity:** lives in the cloud. When you create a device identity in the IoT Hub, the hub generates a unique device connection string to associate with the physical device.

Virtual device as an IoT Edge device: The runtime can be deployed on devices as small as a Raspberry Pi or as large as an industrial server. Once a device is configured with the IoT Edge runtime, you can start deploying business logic to it from the cloud. In this module, you'll create a virtual device on the cloud. It will act as an IoT Edge device.

The steps we follow are:

1. Create the resource group

2. Create a virtual device as an IoT Edge device

3. Create an Azure IoT Hub

4. Register the IoT Edge to the IoT Hub

5. Configure IoT Edge to connect to the IoT hub

Before you begin, if you don't have an active Azure subscription, you need to create a free account, and you can use 30 days free trial, or you can create your pay-as-you-go subscription.

After completing this unit, your device will be connected to the IoT Hub, and your device will be registered and configured to the IoT Hub.
