This unit provides an overview of a few Azure IoT services that are useful to know when you build and deploy an edge AI solution with Azure Percept.

## Introduction to Azure IoT

Azure IoT is a collection of Microsoft-managed cloud services that connect, monitor, and control up to millions of IoT assets. In simpler terms, an IoT solution is made up of one or more IoT devices and one or more back-end services running in the cloud that communicate with each other.

**Use Azure IoT to**:

- **Reimagine your business processes** by reducing data silos between customers, operations, products/assets, and employees.

- **Deploy managed software** as a service for IoT with minimal cloud expertise (SaaS solutions) using Azure IoT Central.

- **Customize industry-specific IoT solutions** for common IoT scenarios - PaaS solutions through Azure IoT solution accelerators.

- **Extend intelligence** from the cloud to your edge devices using Azure IoT Edge. Connect, monitor, and control billions of IoT assets using Azure IoT Hub.

- **Generate an automated feedback loop** between the device and the cloud to increase the efficiency of your solution.

**_To learn more, see additional resources in the summary section._**

## Introduction to Azure IoT Hub

Azure IoT Hub enables secure and reliable communications between your IoT solution and the devices it manages. It provides a cloud-hosted solution backend to connect devices with per-device authentication, device management, and scaled provisioning.

**Use IoT Hub to**:

- **Secure your communications**: IoT Hub enables secure communications for your devices to send data. It provides per-device authentication with multiple authentication types.

- **Scale your solution**: IoT Hub allows you to scale to millions of simultaneously connected devices and millions of events per second to support your IoT workloads.

- **Integrate with other services**. You can seamlessly integrate IoT Hub with other Azure services to build an end-to-end solution.

- **Manage and configure your devices**: Using IoT Hub, you can manage your connected devices at scale. You can set and query the device status and automatically respond to a change in state for devices.

**_To learn more, see additional resources in the summary section._**

## Introduction to Azure IoT Edge

Azure IoT Edge is a combination of a cloud service that runs in the cloud and a runtime that runs on the device. The runtime starts and manages workflows on the device. The workflow comprises a set of containers that you link together in a specific order to create an end-to-end scenario. IoT Hub manages IoT Edge, enabling you to run workloads on the edge devices you develop using cloud services. A workload is a module deployed using docker compatible containers.

**Use IoT Edge to**:

- **Manage edge devices**: IoT Edge provides a cloud interface and a runtime module, which enables you to manage and deploy workloads to edge devices remotely through the IoT Hub.

- **Deploy using secure and certified hardware**: You can access certified IoT Edge hardware on Linux or Windows devices that support container engines.

- **Distribute AI and analytics workloads to the edge**: You can deploy models built and trained in the cloud and run them on edge devices. IoT Edge uses these models to process data locally and respond to the event rapidly.

- **Provide security for edge deployments**: IoT Edge provides added security by integrating with Microsoft Defender for Cloud. Also, IoT Edge can make use of any hardware security modules, if available, to provide strong authenticated connections for confidential computing.

**_To learn more, see additional resources in the summary section._**
