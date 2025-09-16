The following steps summarize how to set up and configure IoT Edge, an IoT Hub, and an IoT device to deploy a module to it.

1. Define a resource group or use an existing one.
1. Create an Azure IoT Edge device.
1. Create an Azure IoT Hub or use an existing one.
1. Register the IoT Edge device to the IoT Hub.

Although you can run the Azure IoT Edge runtime on a physical Linux device, this article uses an Ubuntu-based virtual machine in Azure as the IoT Edge device.

You need an active Azure subscription to follow the exercises. Create a free account with a 30-day trial or use a pay-as-you-go subscription.

## What is a resource group?

A resource group is a container to logically group Azure resources. These resources can include storage accounts, virtual networks, and virtual machines (VMs) that you treat as a single entity. The resource group stores metadata about the resources. When you specify a location for the resource group, you select where that metadata is stored. For compliance reasons, you might need to keep your data in a particular region.

## Create an Azure IoT Edge device

IoT Edge devices have the IoT Edge runtime installed. The Azure "IoT Edge on Ubuntu" virtual machine is an IoT device that's ready for use.

The **IoT Edge runtime** is a collection of programs that turn a device into an IoT Edge device. These components let IoT Edge devices receive code to run at the edge and communicate results with an IoT Hub.

* **IoT Edge module runtime:** starts whenever an IoT Edge device boots and initializes the device by running the IoT Edge agent.
* **IoT Edge agent:** manages deployment and monitoring of modules on the IoT Edge device, including the IoT Edge hub.
* **IoT Edge hub:** handles communications between modules on the IoT Edge device and between the device and IoT Hub. 

## Create an IoT Hub

Azure IoT Hub lets the virtual device communicate with the cloud. To create a new Azure IoT Hub with the Azure CLI, use the `az iot hub create` command set.

> [!NOTE]
> Only one **free** IoT hub instance is allowed in a subscription. The free level of IoT Hub works for this exercise. If you've used IoT Hub in the past and already created a free hub, use that IoT hub.

## Register the IoT Edge device with IoT Hub

1. Run the `az iot hub device-identity create` command to create a device identity for your Edge device on Azure. The device identity lets the device communicate with your IoT Hub.
1. Run the `az iot hub device-identity connection-string show` command to retrieve the connection string. Each device identity uses a unique connection string to associate it with a physical device.
1. Set up the connection string on the IoT Edge device so it can connect to the IoT Hub. Do this remotely without connecting to the virtual machine by running a script on the device. Run the `az vm run-command` command to invoke a script on the edge device and pass the connection string as a parameter.

## Ensure the IoT Edge device is ready to run prebuilt modules

Once the edge device is configured, check if it's ready to run a prebuilt module.

* Sign in to the edge device using the public IP address for the device and run the `ssh command`.
* Use `iotedge` commands to check if the IoT Edge security daemon is running as a system service.

> [!NOTE]
> Elevated privileges are required to run `iotedge` commands.
