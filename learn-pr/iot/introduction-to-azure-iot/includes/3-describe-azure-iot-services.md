<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
This overview should help you to understand the capabilities and features of the core Azure IoT services and SDKs. Azure IoT technologies and services provide you with options to create a wide variety of IoT solutions that enable digital transformation for your organization. For example, you can:

* Use *Azure IoT Central* to quickly evaluate your IoT scenario and assess the opportunities it can create for your business. To streamline the development of a complex and continually evolving IoT infrastructure, IoT Central lets you focus your efforts on determining the business impact you can create with the IoT data stream.

* Use Azure IoT platform services such as *Azure IoT Hub* and the *Device Provisioning Service* to build a custom IoT solution from scratch.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is (concept)?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(concept) is..." (ensure this is a definition, do not give use cases like "(concept) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

## Devices and device SDKs

You can implement your own embedded code using the open-source device SDKs. The device SDKs support multiple operating systems, such as Linux, Windows, and real-time operating systems. There are SDKs for multiple programming languages, such as C, Node.js, Java, .NET, and Python.

You can further simplify how you create the embedded code for your devices by following the *IoT Plug and Play* conventions. At the core of IoT Plug and Play, is a *device capability model* schema that describes device capabilities. Use the device capability model to configure a cloud-based solution such as an IoT Central application.

*Azure IoT Edge* lets you offload parts of your IoT workload from your Azure cloud services to your devices. IoT Edge can reduce latency in your solution, reduce the amount of data your devices exchange with the cloud, and enable off-line scenarios. You can manage IoT Edge devices from IoT Central.

Azure Sphere is a secured, high-level application platform with built-in communication and security features for internet-connected devices. It includes a secured  microcontroller unit, a custom Linux-based operating system, and a cloud-based security service that provides continuous, renewable security.

> [!IMPORTANT]
> Because IoT Central uses IoT Hub internally, any device that can connect to an IoT Central application can also connect to an IoT hub.

## Azure IoT Central

IoT Central is a managed app platform that reduces the burden and cost of developing, managing, and maintaining IoT solutions.

The web UI lets you quickly connect devices, monitor device conditions, create rules, and manage devices and their data throughout their life cycle. Furthermore, it enables you to act on device insights by extending IoT intelligence into line-of-business applications.  

As a fully managed app platform, IoT Central has a simple, predictable pricing model.

## Custom solutions

To build an IoT solution from scratch, use one or more of the following Azure IoT technologies and services:

### Cloud connectivity

The *Azure IoT Hub* service enables reliable and secure bidirectional communications between millions of IoT devices and a cloud-based solution. *Azure IoT Hub Device Provisioning Service* is a helper service for IoT Hub. The service provides zero-touch, just-in-time provisioning of devices to the right IoT hub without requiring human intervention. These capabilities enable customers to provision millions of devices in a secure and scalable manner.

### Bridge the gap between the physical and digital worlds

*Azure Digital Twins* is an IoT service that enables you to model a physical environment. It uses a spatial intelligence graph to model the relationships between people, spaces, and devices. By corelating data across the digital and physical worlds you can create contextually aware solutions.

IoT Central uses digital twins to synchronize devices and data in the real world with the digital models that enable users to monitor and manage those connected devices.

### Data and analytics

IoT devices typically generate large amounts of time series data, such as temperature readings from sensors. Azure Data Explorer can connect to an IoT hub, read the telemetry stream from your devices, store that data, and enable you to query and visualize it.

*Azure Maps* is a collection of geospatial services that use fresh mapping data to provide accurate geographic context to web and mobile applications. You can use a REST API, a web-based JavaScript control, or an Android SDK to build your applications.

### Actions and notifications

A solution may required automated actions based on device data. For example, you may want to send an email or text message when a device reports a critical condition.

*Azure Functions* is a serverless compute service that enables you to run code on-demand without having to explicitly provision or manage infrastructure. Use Azure Functions to create event-driven, serverless apps that can run actions in response to conditions identified in telemetry streams.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->