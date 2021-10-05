The Internet of Things is so much more than blinking lights and reading sensors, it is also a mechanism for delivering Artificial Intelligence workloads to the masses. When we traditionally think of IoT, it is typical to consider specialized hardware with physical sensors that report readings up to a cloud service for processing. 

With the advent of small form-factor GPU and FPGA enabled devices, we are beginning to see more heavy AI applications running directly on embedded hardware. This paradigm allows us to reduce data outflow, while at the same time focusing on the important results that come from processing our data on the edge.

When we are able to reduce our reliance on the cloud for processing by taking advantage of accelerated workloads on-device, we are able to obtain and make use of results much faster [even if we are disconnected from the internet](https://docs.microsoft.com/azure/iot-edge/offline-capabilities). Microsoft's [Azure IoT Edge](https://docs.microsoft.com/azure/iot-edge/about-iot-edge) platform is designed for exactly this type of use case. 

Azure IoT Edge accomplishes safe deployment of code to IoT devices by using containerized modules. These modules can include containerized forms of popular Azure services including [Serverless Functions](https://docs.microsoft.com/azure/iot-edge/tutorial-deploy-function), [Stream Analytics](https://docs.microsoft.com/azure/iot-edge/tutorial-deploy-stream-analytics), [Machine Learning modules](https://docs.microsoft.com/azure/iot-edge/tutorial-deploy-machine-learningo), [Custom Vision AI services](https://docs.microsoft.com/en-us/azure/iot-edge/tutorial-deploy-custom-vision), and even [local storage with SQL Server](https://docs.microsoft.com/azure/iot-edge/tutorial-store-data-sql-server). The IoT Edge platform  allows you to take the cloud services you already know and love and use them in your edge environment to facilitate the same powerful features and functionality you've grown to expect from using these services in the cloud. In a similar fashion, we can modularize containerized workloads developed using the NVIDIA Graph Composer and deploy them to IoT Edge capable hardware.

In this module, we'll explore developing GPU accelerated workloads, which target NVIDIA embedded hardware to enable deployment of Artificial Intelligence workload at the edge using Azure IoT Edge and related Azure IoT Services.

### Introduction to NVIDIA Jetson Embedded Hardware

The [NVIDIA Jetson Platform](https://www.nvidia.com/autonomous-machines/embedded-systems/) allows for running GPU accelerated workloads on small form-factor embedded devices that are ideal for edge environments.  NVIDIA Jetson hardware is offered as complete System on Module (SOM) that contains all of the CPU, GPU, and memory needed to execute computer vision workloads on a device that is about the size of a modern cell phone.

Nvidia produces a variety of devices suited for AI at the Edge solutions in their [Jetson line of device offerings](https://developer.nvidia.com/buy-jetson). These offerings include the beefy [512-Core Jetson AGX Xavier](https://amzn.to/2XMaSIL) and [Jetson Xavier NX](https://amzn.to/3i1Iuuj), mid-range 256-Core [Jetson TX2](https://amzn.to/2IMGmDV), and the entry-level 128-Core [Jetson Nano](https://amzn.to/2WFE5zF).

Specifications for these hardware offerings are shown below:

![NVIDIA Jetson Hardware Overview](../media/jetson-hardware.jpg)

You will notice that all devices in the NVIDIA Jetson family use ARM-based CPU hardware for processing.  The Azure IoT Edge platform is capable of targeting this architecture and will allow us to instrument NVIDIA embedded devices to work with the IoT Edge runtime and related Azure IoT Services.

To follow along with this module, you will need one of the following NVIDIA Jetson embedded devices provisioned with [JetPack 4.5.1 GA](https://developer.nvidia.com/jetpack-sdk-451-archive):

* [Jetson Xavier NX](https://amzn.to/3i1Iuuj)
* [Jetson AGX Xavier](https://amzn.to/2XMaSIL)
* [Jetson TX2](https://amzn.to/2IMGmDV)
* [Jetson Nano](https://amzn.to/2WFE5zF)
 
### Introduction to Azure IoT Edge

[Azure IoT Edge](https://docs.microsoft.com/azure/iot-edge/about-iot-edge) is designed to simplify the process of producing analytics at the Edge by employing a modern approach to application distribution by using containerized workloads known as "modules". Devices instrumented with the IoT Edge runtime can publish insights to the Azure Cloud using high-throughput low-latency messaging protocols and may even continue to produce those insights in offline scenarios. Due to these and other features, Azure IoT Edge is an ideal solution for adopting real-time Artificial Intelligence workloads into edge environments.

The three components that make up an IoT Edge based solution are the following:

* IoT Edge Modules - Containers that run Azure services, third-party services, or custom code that are deployed using a specification defined in an Azure IoT Hub and executed locally on IoT Edge instrumented devices.
* IoT Edge Runtime - The service that runs on an IoT Edge device that manages module workloads, provides mechanisms for module-to-module and device-to-cloud / cloud-to-device messaging, and performs orchestration of workloads defined in an Azure IoT Hub.
* Cloud-based Interface - A collection of services in Microsoft Azure included as part of an Azure IoT Hub resource instance that provides a mechanism for secure registration of devices, a high throughput mechanism for ingestion of data (via AMQP, MQTT, or HTTPS), ability to define and apply deployment specifications, and remotely monitor / manage IoT Edge devices

An IoT Edge solution can optionally incorporate an Azure Container Registry to provide secure distribution of containerized "modules". This approach is the recommendation for production deployment scenarios. The image below shows how the three core components can work use an Azure Container Registry to achieve an end-to-end Edge-to-Cloud solution architecture: 

![Install IoT Edge Full Overview](../media/install-edge-full.png)

In the image above, the Azure IoT Hub (1) distributes a deployment specification that defines the modules to run on `yourEdgeDevice` (2), which has been instrumented with the IoT Edge runtime and securely registered as an IoT Edge device in the IoT Hub. The IoT Edge runtime (3) receives this specification, which refers to a `sensor` module (4) that is stored in an Azure Container Registry.  This module is retrieved securely and executed locally on the edge device where it then produces telemetry that flows from the device into the IoT Hub.

In this module, we will deploy a solution with a similar architecture to the one shown above.  The main difference is that we will include a deployment specification that defines a DeepStream-based IoT Edge module that will publish object detection results into an IoT Hub.  This deployment will run on an NVIDIA Jetson Embedded device that natively supports the ARM64 distribution of the IoT Edge Runtime. 

### Try this

If you were tasked with deploying an Artificial Intelligence at the Edge solution, how might you save time to production by using cloud service offerings?  What benefits would you gain by using a service like Azure IoT Edge during implementation? 