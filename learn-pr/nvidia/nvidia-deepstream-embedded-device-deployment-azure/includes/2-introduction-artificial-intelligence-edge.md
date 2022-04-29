The Internet of Things (IoT) is so much more than blinking lights and reading sensors. IoT also is a mechanism for delivering AI workloads to the masses. Traditionally, it's typical to think of IoT as specialized hardware with physical sensors that report readings up to a cloud service for processing.

With the advent of small form factor GPU-enabled and field programmable gate array (FPGA)-enabled devices, it has become common to see heavier AI applications running directly on embedded hardware. With this paradigm, you can reduce data outflow, but also focus on the important results that come from processing data on the edge.

When you move from relying on the cloud for processing to take advantage of accelerated workloads on the device, you get results much faster, [even in an offline environment](/azure/iot-edge/offline-capabilities?azure-portal=true). Microsoft's [Azure IoT Edge](/azure/iot-edge/about-iot-edge?azure-portal=true) platform is designed for exactly this type of use case.

Azure IoT Edge accomplishes safe deployment of code to IoT devices by using containerized modules. The modules can include containerized forms of popular Azure services including [serverless functions](/azure/iot-edge/tutorial-deploy-function?azure-portal=true), [Stream Analytics](/azure/iot-edge/tutorial-deploy-stream-analytics?azure-portal=true), [Machine Learning modules](/azure/iot-edge/tutorial-deploy-machine-learning?azure-portal=true), [Custom Vision AI services](/azure/iot-edge/tutorial-deploy-custom-vision?azure-portal=true), and even [local storage with SQL Server](/azure/iot-edge/tutorial-store-data-sql-server?azure-portal=true). You can use the IoT Edge platform to get the same powerful features and functionality of cloud services you already know and love in your edge environment. You can similarly modularize containerized workloads that were developed by using NVIDIA Graph Composer, and then deploy the workloads  to IoT Edge-capable hardware.

In this module, you'll explore developing GPU-accelerated workloads that target NVIDIA embedded hardware to deploy an AI workload at the edge by using Azure IoT Edge and related Azure IoT services.

## NVIDIA Jetson embedded hardware

GPU-accelerated workloads on small form factor embedded devices that are ideal for edge environments can run on the [NVIDIA Jetson platform](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/?azure-portal=true). NVIDIA Jetson hardware is a complete system on module (SOM) that has all the CPU, GPU, and memory needed to run computer vision workloads on a device about the size of a modern cell phone.

NVIDIA offers various devices that are suited for AI at the edge in its [Jetson line of device offerings](https://developer.nvidia.com/buy-jetson?azure-portal=true). Offerings include the robust [512-core Jetson AGX Xavier](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-agx-xavier?azure-portal=true) and [Jetson Xavier NX](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-xavier-nx/?azure-portal=true), mid-range 256-core [Jetson TX2](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-tx2/?azure-portal=true), and the entry-level 128-core [Jetson Nano](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano/?azure-portal=true).

The following chart shows specifications for these hardware offerings:

:::image type="content" source="../media/jetson-hardware.png" alt-text="Diagram of a chart that shows an NVIDIA Jetson hardware overview and options." border="false":::

All devices in the NVIDIA Jetson family use ARM-based CPU hardware for processing. The Azure IoT Edge platform can target this architecture, so you can instrument NVIDIA embedded devices to work with the IoT Edge runtime and with related Azure IoT services.

To follow along with this module, you'll need one of the following NVIDIA Jetson embedded devices provisioned with [JetPack 4.6](https://developer.nvidia.com/jetpack-sdk-46):

* [Jetson Xavier NX](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-xavier-nx/?azure-portal=true)
* [Jetson AGX Xavier](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-agx-xavier?azure-portal=true)
* [Jetson TX2](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-tx2/?azure-portal=true)
* [Jetson Nano](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano/)

## Azure IoT Edge

[Azure IoT Edge](/azure/iot-edge/about-iot-edge?azure-portal=true) is designed to simplify the process of producing analytics at the edge. IoT Edge uses a modern approach to application distribution through containerized workloads, known as *modules*. Devices that are instrumented with the IoT Edge runtime can publish insights to the Azure cloud by using high-throughput, low-latency messaging protocols. A device can even continue to produce those insights in offline scenarios. Because of these and other features, Azure IoT Edge is an ideal solution for adopting real-time AI workloads in edge environments.

An IoT Edge-based solution has three components:

* **IoT Edge modules**: Modules are containers that run Azure services, third-party services, or custom code. Containers are deployed by using a specification that's defined in a hub in Azure IoT Hub and they're run locally on IoT Edge instrumented devices.
* **IoT Edge runtime**: The runtime is a service that runs on an IoT Edge device to manage module workloads, provide mechanisms for module-to-module and device-to-cloud/cloud-to-device messaging, and orchestrate workloads that are defined in a hub.
* **Cloud-based interface**: The interface is a collection of Azure services that are included in an Azure IoT Hub resource instance. The services provide a mechanism for secure device registration, a high-throughput mechanism for data ingestion (via AMQP, MQTT, or HTTPS), an ability to define and apply deployment specifications, and an ability to remotely monitor and manage IoT Edge devices.

An IoT Edge solution optionally can incorporate an instance of Azure Container Registry to provide secure distribution of containerized modules. This approach is recommendation for production deployment scenarios. The following image shows how the three core components can work to use a container registry to achieve an end-to-end edge-to-cloud solution architecture:

:::image type="content" source="../media/install-edge-full.png" alt-text="Diagram that depicts how to install Azure IoT Edge." border="false":::

In the preceding image, (1) Azure IoT Hub distributes a deployment specification that (2) defines the modules to run on **yourEdgeDevice**, which has been instrumented with the IoT Edge runtime and securely registered as an IoT Edge device in the hub. Then, (3) the IoT Edge runtime receives this specification, which (4) refers to a **sensor** module that'is stored in Azure Container Registry. This module is retrieved securely and run locally on the edge device, on which it then produces telemetry that flows from the device to the hub.

In this module, you'll deploy a solution that has an architecture that's similar to the one shown here. The main difference is that you'll include a deployment specification that defines a DeepStream-based IoT Edge module to publish object detection results into an IoT hub. The deployment runs on an NVIDIA Jetson embedded device that natively supports the ARM64 distribution of the IoT Edge runtime.

### Try this

If your task is to deploy a solution of AI at the edge, how might you save time to production by using cloud service offerings?  What benefits would you gain by using a service like Azure IoT Edge during implementation?
