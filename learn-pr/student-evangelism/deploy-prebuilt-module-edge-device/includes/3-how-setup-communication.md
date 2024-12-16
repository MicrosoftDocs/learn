The steps below summarize the process of setting up and configuring IoT Edge, an IoT Hub, and the IoT device to deploy our module to it.

1. Define the resource group or use an existing one.
1. Create an Azure IoT Edge device.
1. Create an Azure IoT Hub or use an existing one.
1. Register the IoT Edge device to the IoT Hub.

Although you could execute the Azure IoT Edge runtime on your own physical Linux device, we deploy an Ubuntu-based virtual machine to Azure to act as the IoT Edge device.

As a consequence, you need an active Azure subscription to follow the exercises. Either create a free account that comes with a 30 days trial or use your pay-as-you-go subscription.

## What is a resource group?

A resource group is a container to logically group Azure resources. These resources can be, for example, storage accounts, virtual networks, and virtual machines (VMs) you want to treat as a single entity. The resource group stores metadata about the resources. Therefore, when you specify a location for the resource group, you're selecting where that metadata is stored. For compliance reasons, you may need to keep your data in a particular region.

## Create an Azure IoT Edge device

IoT Edge devices have the IoT Edge runtime installed on them. The Azure "IoT Edge on Ubuntu" virtual machine is an IoT device ready for use.

The **IoT Edge runtime** is a collection of programs that turn a device into an IoT Edge device. Collectively, the IoT Edge runtime components enable IoT Edge devices to receive code to run at the edge and communicate the results with an IoT Hub.

* **IoT Edge module runtime:** starts each time an IoT Edge device boots and bootstraps the device by running the IoT Edge agent.
* **IoT Edge agent:** facilitates deployment and monitoring of modules on the IoT Edge device, including the IoT Edge hub.
* **IoT Edge hub:** manages communications between modules on the IoT Edge device and between the device and IoT Hub. 

## Create an IoT Hub

Azure IoT Hub enables the communication between the virtual device and the cloud. To create a new Azure IoT Hub with the Azure CLI, you'll use the `az iot hub create` command set.

> [!NOTE]
> Only one **free** IoT hub instance is allowed in a subscription. The free level of IoT Hub works for this exercise. If you've used IoT Hub in the past and already have a free hub created, you can use that IoT hub.

## Register the IoT Edge device to IoT Hub

1. Use the `az iot hub device-identity create` command to create a device identity for your Edge device on Azure. The device identity enables you to communicate with your IoT Hub.
1. Retrieve the connection string with the `az iot hub device-identity connection-string show` command. Every device identity uses a unique device connection string to associate it with a physical device.
1. Set up the connection string on the IoT Edge device so it can connect to the IoT Hub. You can do this remotely without connection to the virtual machine by running a script on the device. Use the `az vm run-command` to invoke a script on the edge device and pass the connection string as a parameter.  

## Ensure the IoT Edge device is ready to run pre-built modules

Once the edge device is configured, check if it is ready to run a pre-built module.

* Log on to the edge device using the public IP address for the device and run the `ssh command`.
* With `iotedge` commands, you can check if the IoT Edge security daemon is running as a system service.

> [!NOTE]
> You need elevated privileges to run `iotedge` commands.
