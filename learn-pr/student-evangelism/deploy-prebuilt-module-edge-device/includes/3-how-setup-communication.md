## Overview 

In this module, we use an existing Ubuntu-based virtual machine to act as your IoT Edge device. Alternately, you could run the Azure IoT Edge runtime on your own physical Linux device (X64, ARM32, or ARM64). Below, we consider only the scenario of a virtual device.  

We set up communications between IoT Edge and IoT Hub so that we can deploy our module to the IoT device.  To set up communications between the IoT Hub and IoT Edge, you start by creating a Microsoft provided Ubuntu virtual device by using the scripts provided. This virtual device has all the prerequisites installed. You then create an IoT Hub using the Cloud Shell. Next, you register the IoT Edge device to the IoT Hub and retrieve the connection string. We'll need this string to configure the IoT Edge device in subsequent steps. 

To summarise the process - to register an IoT Edge device to your IoT Hub, you first create a device identity for your Edge device. This device identity enables you to communicate with your IoT Hub. The device identity lives in the cloud and uses a unique device connection string to associate a physical device to a device identity. Your IoT Edge device connects to the IoT Hub – either to an existing hub or a newly created hub.  The connection string links the IoT device with its identity in the IoT Hub.  Thus, the process of registration for a device involves retrieving the connection string associated with an edge device which represents the device identity in the IoT Hub. After this, you set up the connection string on the IoT Edge device. 

Before you begin, if you don't have an active Azure subscription, you need to create a free account, and you can use 30 days free trial, or you can create your own pay-as-you-go subscription.

Hence, the steps we follow are:  

1)	Define the resource group or use a pre-existing one  

2)	Create an Azure IoT Edge device

3)	Create Azure IoT Hub or use an existing one

4)	Register the IoT Edge device to IoT Hub 

## What is a Resource Group

A Resource group is a container that holds related resources for a solution. The resource group includes those resources that you want to manage as a group. You logically group related resources such as storage accounts, virtual networks, and virtual machines (VMs) to deploy, manage, and maintain them as a single entity. The resource group stores metadata about the resources. Therefore, when you specify a location for the resource group, you are specifying where that metadata is stored. For compliance reasons, you may need to ensure that your data is stored in a particular region.

## How to create an IoT Edge device

After the Resource group has been created, you can create a preconfigured IoT Virtual device within this resource group.  Creating a new virtual edge device involves two required properties:  Defining a name of the virtual device and choosing the resource group to be deployed. Because you are using the Azure IoT Edge on Ubuntu virtual machine as described in the prerequisites, your device already has the IoT Edge runtime installed. The **IoT Edge runtime** is a collection of programs that turn a device into an IoT Edge device. Collectively, the IoT Edge runtime components enable IoT Edge devices to receive code to run at the edge and to communicate the results with the IoT hub.

The IoT Edge runtime is deployed on all IoT Edge devices. It has three components. **The IoT Edge security daemon** starts each time an IoT Edge device boots and bootstraps the device by starting the IoT Edge agent. **The IoT Edge agent** facilitates deployment and monitoring of modules on the IoT Edge device, including the IoT Edge hub. **The IoT Edge hub** manages communications between modules on the IoT Edge device and between the device and IoT Hub. You can use the **az IoT hub device-identity create** command to create an IoT Edge device.

## How to create IoT Hub

Azure IoT Hub enables communication between the virtual device and the cloud. Creating an IoT Hub involves the following required properties: 	Defining a unique name of the IoT Hub and Choosing the resource group to be deployed. To create a new Azure IoT Hub with the Azure CLI, you will use the **az IoT hub create** command set. Note that only one free IoT hub instance is allowed in each subscription. The free level of IoT Hub works for this exercise. If you've used IoT Hub in the past and already have a free hub created, you can use that IoT hub.  

## Register the IoT Edge device to IoT Hub

The process of registration of an IoT device involves retrieving the connection string for your device. The device identity lives in the cloud, and you use a unique device connection string to associate a physical device to a device identity. Use the **az iot hub device-identity show-connection-string** command to retrieve the connection string. Copy the value of the connectionString key from the JSON output and save it. You'll use this connection string to configure the IoT Edge runtime.

## How to configure your IoT Edge device

The process of configuration of your IoT Edge device involves setting the connection string on the IoT Edge device. You can set the connection string remotely without having to connect to the virtual machine by running a script on the device. You use the **az vm run-command** to invoke a script on the edge device and passing the connection string as a parameter.  

## How to ensure that your IoT Edge device is ready to run pre-built modules

Once the edge device has been configured, you should check if the IoT edge device is ready to run a pre-built module.  To do so, you should first log on to the edge device using the public IP address for the device and the **ssh command**. You will check to see that the IoT Edge security daemon is running as a system service by using iotedge commands. You need elevated privileges to run iotedge commands.