 Firstly, you create an IoT Hub and register the device with the IoT Hub. Then you will configure the IoT device (Mxchip AZ3166) to connect to the WiFi.  

 You will use the following components for this stage:  

- **Resource Group:** a collection of resources for a solution.

- **IoT Hub:** allows communication between your IoT solution and the devices it manages. It connects to the devices with per-device authentication. 

- **Device identity:** lives in the cloud. When you create a device identity in the IoT Hub, the hub generates a unique device connection string to associate with the physical device.

- **MXChip IoT Devkit (a.k.a IoT Devkit):** is an Arduino compatible IoT device with rich peripherals and sensors. It also has a WiFi chip for wireless connectivity and an OLED screen, microphone, and audio out and a MicroUSB connection. You can also program it with Azure. The Mxchip device connects directly to Azure IoT Hub, which is a bi-directional service. You can capture telemetry information from the MXChip and send it back to Azure.

 The steps we follow are:

1.  Create the resource group
2.  Create an Azure IoT Hub  
3.  Create a device identity
4.  Configure IoT device to connect to the WiFi

Before you begin, if you don't have an active Azure subscription, you need to create a free account, and you can use 30 days free trial, or you can create your pay-as-you-go subscription.

After completing this unit, your device will be connected to the WiFi, and you will have a device identity created in the IoT Hub. The device identity retrieves the connection string that will be used to configure the IoT device to send the data to the cloud.

