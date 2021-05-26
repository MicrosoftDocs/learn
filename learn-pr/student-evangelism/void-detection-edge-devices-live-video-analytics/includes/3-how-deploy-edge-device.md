In this module, we use an existing Ubuntu-based virtual machine to act as your IoT Edge device. Alternately, you could install the Azure IoT Edge runtime on your own physical Linux device (X64, ARM32, or ARM64) or Azure Stack device. Below we consider only the scenario of a virtual device.

## Overview

Firstly we configure the device as an IoT Edge device and set up communication between IoT Edge and IoT Hub to run our module on the IoT Edge device. To set up the communication between the IoT Hub and IoT Edge, we provide a device connection string during the configuration. This string associates your physical device with the IoT Edge device identity in Azure. When your device is ready, you'll open 8181 network port, which will set up a network connection between your web application and your edge device. Your video analytics-based application will be able to listen on that port.

Before you begin, if you don't have an active Azure subscription, you need to create a free account. You can use 30 days free trial, or you can create your pay-as-you-go subscription.

## Steps to follow

You'll complete the following steps to deploy an edge device.

1. Define the resource group or use a pre-existing one
2. Create Azure IoT Hub or use an existing one
3. Register the IoT Edge device to IoT Hub
4. Create an Azure IoT Edge device
5. Configure an IoT Edge device
6. Open 8181 network port.

## What is a Resource Group

A Resource Group is a container that holds related resources for a solution. The resource group includes those resources that you want to manage as a group. You logically group-related resources such as storage accounts, virtual networks, and virtual machines (VMs) to deploy, manage, and maintain them as a single entity. 

## How to create IoT Hub

Azure IoT Hub enables the communication between the virtual device and the cloud. Creating an IoT Hub involves the following required properties:

- Define a unique name of the IoT Hub
- Choose the resource group to be deployed

To create a new Azure IoT Hub with the Azure CLI, you'll use the **az iot hub create** command set. Only one free IoT hub instance is allowed in each subscription. The free level of IoT Hub works for this exercise. If you've used IoT Hub in the past and already have a free hub created, you can use that IoT hub.

## Register the IoT Edge device to IoT Hub

The registration process of an IoT device involves creating a device identity in IoT Hub for your Edge device. This device identity enables you to communicate with your IoT Hub. The device identity lives in the cloud and uses a unique device connection string to associate a physical device to a device identity. You'll need the following properties:

- Define a unique name of the device
- Choose the IoT Hub to be deployed

To create a device in your hub, you'll use **az iot hub device-identity create** command set . Then you'll use the **az iot hub device-identity connection-string show** command to retrieve the connection string. Copy the value of the connectionString key from the JSON output and save it. You'll use this connection string to configure the IoT Edge device.

## How to configure your IoT Edge device

The process of configuration of your IoT Edge device involves creating a new virtual machine and installing the IoT Edge runtime on it. In this scenario, you'll create your edge device using a pre-built template that takes the following parameters:

- Choose a subscription
- Choose the resource group to be deployed
- Choose the region you want to deploy the virtual machine
- Define Dns label prefix
- Define an admin username
- Enter the connection string that you retrieve in the previous step
- Enter the admin password or the key

Once the deployment is complete, you can connect to your edge device and check the IoT Edge runtime status running actively.

## Add inbound security rule

Now that you've configured your edge device, you'll need to add an inbound rule to allow network traffic between your device and your web application from the internet over TCP port 8181. To open port 8181, you'll specify the following parameters:

- Define destination port ranges
- Define name for your security ruleSteps to follow