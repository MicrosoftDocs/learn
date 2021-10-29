The IoT is so much more than blinking lights and reading sensors. The IoT also is a mechanism for delivering AI workloads to the masses. Traditionally, it's typical to think of IoT as specialized hardware that has physical sensors that report readings up to a cloud service for processing.

With the advent of small form factor GPU- and field programmable gate array (FPGA)-enabled devices, it's becoming common to see more heavy AI applications running directly on embedded hardware. This paradigm allows us to reduce data outflow, but at the same time focus on the important results that come from processing your data on the edge.

When users and organizations reduce reliance on the cloud for processing by taking advantage of accelerated workloads on-device, they obtain and make use of results much faster, [even if they aren't connected to the internet](/azure/iot-edge/offline-capabilities). Microsoft's [Azure IoT Edge](/azure/iot-edge/about-iot-edge) platform is designed for exactly this type of use case.

Azure IoT Edge accomplishes safe deployment of code to IoT devices by using containerized modules. These modules can include containerized forms of popular Azure services including [Serverless Functions](/azure/iot-edge/tutorial-deploy-function), [Stream Analytics](/azure/iot-edge/tutorial-deploy-stream-analytics), [Machine Learning modules](/azure/iot-edge/tutorial-deploy-machine-learningo), [Custom Vision AI services](/azure/iot-edge/tutorial-deploy-custom-vision), and even [local storage with SQL Server](/azure/iot-edge/tutorial-store-data-sql-server). You can use the IoT Edge platform to use the cloud services you already know and love in your edge environment to facilitate the same powerful features and functionality you've grown to expect from using these services in the cloud. You can similarly modularize containerized workloads that were developed by using the NVIDIA Graph Composer, and then deploy them to IoT Edge-capable hardware.

In this module, you'll explore developing GPU-accelerated workloads that target NVIDIA embedded hardware to enable deployment of an AI workload at the edge by using Azure IoT Edge and related Azure IoT services.

## Introduction to NVIDIA Jetson embedded hardware

The [NVIDIA Jetson platform](https://www.nvidia.com/autonomous-machines/embedded-systems/) allows for running GPU-accelerated workloads on small form factor embedded devices that are ideal for edge environments. NVIDIA Jetson hardware is offered as complete System on Module (SOM) that contains all of the CPU, GPU, and memory needed to execute computer vision workloads on a device that is about the size of a modern cell phone.

NVIDIA produces various devices suited for AI at the Edge solutions in its [Jetson line of device offerings](https://developer.nvidia.com/buy-jetson). Offerings include the robust [512-Core Jetson AGX Xavier](https://amzn.to/2XMaSIL) and [Jetson Xavier NX](https://amzn.to/3i1Iuuj), mid-range 256-Core [Jetson TX2](https://amzn.to/2IMGmDV), and the entry-level 128-Core [Jetson Nano](https://amzn.to/2WFE5zF).

The following image shows specifications for these hardware offerings:

:::image type="content" source="../media/jetson-hardware.png" alt-text="Chart that shows an NVIDIA Jetson hardware overview and options.":::

You will notice that all devices in the NVIDIA Jetson family use ARM-based CPU hardware for processing. The Azure IoT Edge platform is capable of targeting this architecture and will allow us to instrument NVIDIA embedded devices to work with the IoT Edge runtime and related Azure IoT Services.

To follow along with this module, you'll need one of the following NVIDIA Jetson embedded devices provisioned with [JetPack 4.5.1 GA](https://developer.nvidia.com/jetpack-sdk-451-archive):

* [Jetson Xavier NX](https://amzn.to/3i1Iuuj)
* [Jetson AGX Xavier](https://amzn.to/2XMaSIL)
* [Jetson TX2](https://amzn.to/2IMGmDV)
* [Jetson Nano](https://amzn.to/2WFE5zF)

## Introduction to Azure IoT Edge

[Azure IoT Edge](/azure/iot-edge/about-iot-edge) is designed to simplify the process of producing analytics at the edge. IoT Edge uses a modern approach to application distribution through containerized workloads known as *modules*. Devices that are instrumented with the IoT Edge runtime can publish insights to the Azure cloud by using high-throughput, low-latency messaging protocols. It can even continue to produce those insights in offline scenarios. Due to these and other features, Azure IoT Edge is an ideal solution for adopting real-timeAI workloads in edge environments.

An IoT Edge-based solution has three components:

* **IoT Edge modules**: Containers that run Azure services, third-party services, or custom code. Containers are deployed by using a specification defined in an Azure IoT hub and they're executed locally on IoT Edge instrumented devices.
* **IoT Edge runtime**: The runtime is a service that runs on an IoT Edge device to manage module workloads, provide mechanisms for module-to-module and device-to-cloud/cloud-to-device messaging, and orchestrate workloads that are defined in an IoT hub.
* **Cloud-based interface**: A collection of Azure services that are included in an Azure IoT Hub resource instance. The services provide a mechanism for secure device registration, a high-throughput mechanism for ingestion of data (via AMQP, MQTT, or HTTPS), ability to define and apply deployment specifications, and remotely monitor / manage IoT Edge devices

An IoT Edge solution optionally can incorporate an Azure Container Registry to provide secure distribution of containerized modules. This approach is recommendation for production deployment scenarios. The image below shows how the three core components can work use an Azure Container Registry to achieve an end-to-end Edge-to-Cloud solution architecture: 

:::image type="content" source="../media/install-edge-full.png" alt-text="Diagram that depicts how to install I o T Edge.":::

In the preceding image, the Azure IoT Hub (1) distributes a deployment specification that defines the modules to run on `yourEdgeDevice` (2), which has been instrumented with the IoT Edge runtime and securely registered as an IoT Edge device in the IoT Hub. The IoT Edge runtime (3) receives this specification, which refers to a `sensor` module (4) that is stored in an Azure Container Registry. This module is retrieved securely and executed locally on the edge device where it then produces telemetry that flows from the device into the IoT Hub.

In this module, you'll deploy a solution with a similar architecture to the one shown here. The main difference is that you'll include a deployment specification that defines a DeepStream-based IoT Edge module that will publish object detection results into an IoT hub. This deployment will run on an NVIDIA Jetson embedded device that natively supports the ARM64 distribution of the IoT Edge runtime.

### Try this

If your task is to deploy a solution of AI at the edge, how might you save time to production by using cloud service offerings?  What benefits would you gain by using a service like Azure IoT Edge during implementation?
