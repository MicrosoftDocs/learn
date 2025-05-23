In the development phase of an IoT project, the continuous streams of data typically generated by deployed IoT devices aren't easy to acquire. Simulate data by using a prebuilt module as an executable package and deploying it as a container on an IoT Edge device.

Suppose you're a developer deploying IoT applications for factory automation. You want to capture data about machines running on the factory floor, like the server room or wind turbine. But you also want to capture data about the environment around the machines, like the ambient temperature. It isn't easy to acquire and visualize this data from the factory floor before the application goes live. So, you need a way to simulate data that mimics your scenarios to test your application.

![An illustration showing the flow for deploying prebuilt module to the Edge device.](../media/deploy-prebuilt-module.png)

This article explores the following engineering-led themes:

- Forecasting behavior of a component or system
- Design of solutions
- Anticipating constraints/tolerances and specific operating conditions
- Safety and security considerations
- Building tools that help to create the solution  

In this module, you register an IoT Edge device to your IoT hub. Then, you start the IoT Edge runtime on your virtual device. Next, you remotely deploy a prebuilt module to an IoT Edge device that simulates sensors running on that device. Finally, you view the module's generated data to verify that the module is running on the device. This article uses Azure IoT Edge on an Ubuntu virtual machine. In this case, your device already has the IoT Edge runtime installed. This setup doesn't run IoT Edge on a local machine or an ARM32 or ARM64 device.

## Learning objectives

In this module, you:

- Launch a module from Azure portal to IoT Edge
- Generate simulated data from an edge device
- Verify data generated from the edge device

## Prerequisites

- Ability to use IoT Hub in Azure
- Ability to use Azure Cloud Shell
- Experience creating and managing resources using the Azure portal or Azure Cloud Shell at the beginner level
- Basic knowledge of Azure IoT Edge
