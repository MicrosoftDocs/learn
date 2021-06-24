IoT Central lets you connect IoT Edge devices to an application and manage them from your custom dashboards.

Suppose you work as an IoT solution developer for a retail company. The company plans to deploy environmental monitoring devices to its stores. You've been asked to design a solution that enables central monitoring, command, and control while minimizing the extra infrastructure requirements in each store, is robust if there are connectivity outages, and minimizes the amount of data sent from each store. To enable this scenario, you plan to deploy an IoT Edge device in each store to manage the local sensors and filter the data that's sent to IoT Central.

To test the solution before deploying it to your stores, you'll run the IoT Edge modules on a Linux virtual machine in the cloud. When you're happy with the solution, you can install the IoT Edge modules on a device of your choice.

In this module, you'll configure an IoT Central application with a device template that defines the capabilities of the IoT Edge device. You'll add some dashboards that enable an operator to view telemetry from the IoT Edge device, set properties, and control it with commands. You'll deploy an IoT Edge device to virtual machine and connect the device to your IoT Central application. When the basic scenario is working, you'll use an Azure function to add filtering capabilities to the IoT Edge device.

By the end of this module, you'll be able to implement an IoT application pattern that includes edge devices to manage local devices and filter data.

## Learning objectives

In this module, you'll:

- Gain an understanding of the IoT application pattern with edge device
- Learn how to create an IoT Edge device template in IoT Central
- Learn how to deploy a virtual machine preconfigured with IoT Edge
- Learn how to manage an IoT Edge device from IoT Central
- Learn how to deploy an Azure function to your IoT Edge device

## Prerequisites

- Ability to create an IoT Central application using the web UI  
- Ability to use Azure CLI at the beginner level
- Ability to use Azure virtual machines at the beginner level
- Experience using IoT Edge at the beginner level
- Experience administering an IoT Central application using the web UI at the intermediate level
- Experience managing device templates and devices in an IoT central application using the web UI at the intermediate level
