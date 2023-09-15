<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
This overview should help you to understand how the Azure IoT services and SDKs can help you to build an IoT solution to monitor and manage your devices.

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
## Azure IoT high-level view

Azure IoT includes a set of managed cloud services that you can use to connect, monitor, and manage your IoT devices. The Azure IoT device SDKs let you build devices that connect securely to your cloud services. The Azure IoT gateways enable you to run some services at the edge and enable more connectivity scenarios for your devices.

The following diagram shows a high-level view of the components in a typical IoT solution. This module focuses on the key groups of components: devices, IoT cloud services, other cloud services, and solution-wide concerns.

:::image type="content" source="../media/iot-architecture.svg" alt-text="Diagram that shows the high-level IoT solution architecture." border="false":::

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## (product) definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(product) is..." (ensure this is a definition, do not give use cases like "(product) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the (product) solves one of the customer tasks in your (scenario).
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to (solve scenario)"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the (product) solved the (scenario).
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->


<!-- 5. Additional content (optional, as needed) ------------------------------------------------

    Goal:
        The section is a catch-all for any information not covered in the sections above.
        Repeat the pattern here as many times as needed.

    Possible topics:
        - Key feature(s).
        - Example use case in addition to the scenario.
        - High-level of how practitioners use the product (e.g. there's an API and a web UI to support multiple use cases).
        - Business value (e.g. it lets you do something that would be difficult to achieve without (product)).

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote (image preferred).

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## IoT devices

An IoT device is typically made up of a circuit board with sensors attached that uses WiFi to connect to the internet. For example:

* Temperature, pressure, and water level sensors in a connected coffee machine.
* Temperature and humidity sensors in an air-conditioning unit.
* An accelerometer in an elevator.
* Presence sensors in a room.

There's a wide variety of devices available from different manufacturers to build your solution. For a list of devices certified to work with Azure IoT Hub, see the [Azure Certified for IoT device catalog](https://devicecatalog.azure.com). For prototyping a microprocessor device, you can use a device such as a [Raspberry Pi](https://www.raspberrypi.org/). The Raspberry Pi lets you attach many different types of sensors.

IoT devices have different characteristics when compared to other clients such as browsers and mobile apps. Specifically, IoT devices:

* Are often embedded systems with no human operator.
* Can be deployed in remote locations, where physical access is expensive.
* May only be reachable through the solution back end.
* May have limited power and processing resources.
* May have intermittent, slow, or expensive network connectivity.
* May need to use proprietary, custom, or industry-specific application protocols.

The device SDKs help you address the challenges of connecting devices securely and reliably to your cloud services:

* You can implement your own embedded device code using the open-source device SDKs. The device SDKs support multiple operating systems, such as Linux, Windows, and real-time operating systems. There are SDKs for multiple programming languages, such as C, Node.js, Java, .NET, and Python. Choose the SDK that best fits development for your connected coffee machine.

* You can further simplify how you create the embedded code for your devices by following the *IoT Plug and Play* conventions. At the core of IoT Plug and Play, is a *device capability model* schema that describes device capabilities. Use the device capability model to configure a cloud-based solution such as an IoT Central application.

> [!IMPORTANT]
> Because IoT Central uses IoT Hub internally, any device that can connect to an IoT Central application can also connect to an IoT hub.

<!-- Pattern for complex chunks (repeat as needed) -->
## Connectivity

Typically, IoT devices send telemetry from their attached sensors to cloud services in your solution. However, other types of communication are possible such as a cloud service sending commands to your devices. The following are examples of device-to-cloud and cloud-to-device communication:

* A connected coffee machine sends water temperature every minute to an IoT Hub.

* A cloud service sends a command to a connected coffee machine to put it into maintenance mode.

* A device monitoring a batch reactor in a chemical plant sends an alert when the temperature exceeds a certain value.

* A thermostat reports the maximum temperature the device has reached since the last reboot.

* A cloud service sets the target temperature for a thermostat device.

The IoT Device SDKs and IoT Hub support common communication protocols such as HTTP, MQTT, and AMQP for device-to-cloud and cloud-to-device communication. In some scenarios, you may need a gateway to connect your IoT devices to your cloud services.

### Cloud services

In an IoT solution, the cloud services typically:

* Receive telemetry at scale from your devices, and determine how to process and store that data.
* Analyze the telemetry to provide insights, either in real time or after the fact.
* Send commands from the cloud to specific devices.
* Provision devices and control which devices can connect to your infrastructure.
* Control the state of your devices and monitor their activities.
* Manage the firmware installed on your devices.

For example, in a remote monitoring solution for connected coffee machines, the services use telemetry from the coffee machines to identify anomalous behavior. When a cloud service identifies an anomaly, it can automatically send a notification to the maintenance department

Some cloud services, such as IoT Hub and the Device Provisioning Service, are IoT specific. Other cloud services, such as storage and visualization, provide generic services to your solution.

### Azure IoT Central

IoT Central is a managed app platform that reduces the burden and cost of developing, managing, and maintaining IoT solutions.

The web UI lets you quickly connect devices, monitor device conditions, create rules, and manage devices and their data throughout their life cycle. Furthermore, it enables you to act on device insights by extending IoT intelligence into line-of-business applications.  

As a fully managed app platform, IoT Central has a simple, predictable pricing model.

You could use the built-in features of IoT Central to build your connected coffee machine solution. IoT Central lets you:

* Manage your connected coffee machines and their data throughout their life cycle.
* Create rules to monitor the data from your connected coffee machines and email the maintenance department when a machine requires servicing.
* Create a dashboard to visualize the location and status of your connected coffee machines.

### Custom solutions

To build an IoT solution from scratch, use one or more of the following Azure IoT technologies and services:

* For cloud connectivity, the *Azure IoT Hub* service enables reliable and secure bidirectional communications between millions of IoT devices and a cloud-based solution. You can use IoT Hub to manage your connected coffee machines and their data throughout their life cycle.

* The *Azure IoT Hub Device Provisioning Service* (DPS) is a helper service for IoT Hub. The service provides zero-touch, just-in-time provisioning of devices to the right IoT hub without requiring human intervention. These capabilities enable customers to provision millions of devices in a secure and scalable manner. You can use DPS to provision your connected coffee machines to your IoT hub.

* To bridge the gap between the physical and digital worlds, *Azure Digital Twins* lets you to model a physical environment. It uses a spatial intelligence graph to model the relationships between people, spaces, and devices. By corelating data across the digital and physical worlds you can create contextually aware solutions.

* *Azure IoT Edge* lets you offload parts of your IoT workload from your Azure cloud services to your devices. IoT Edge can reduce latency in your solution, reduce the amount of data your devices exchange with the cloud, and enable off-line scenarios.

* *Azure Sphere* is a secured, high-level application platform with built-in communication and security features for internet-connected devices. It includes a secured  microcontroller unit, a custom Linux-based operating system, and a cloud-based security service that provides continuous, renewable security.

* To analyze the large amounts of time series data, such as temperature readings from sensors, you can use *Azure Data Explorer*. This service can connect to an IoT hub, read the telemetry stream from your devices, store that data, and enable you to query and visualize it.

* *Azure Maps* is a collection of geospatial services that use fresh mapping data to provide accurate geographic context to web and mobile applications. You can use a REST API, a web-based JavaScript control, or an Android SDK to build your applications. You can use Azure Maps to build a visualization of your connected coffee machines.

* Use *Azure Functions* to automate actions and notifications based on device data. For example, you may want to send an email or text message when a connected coffee machine reports a critical condition.

### Solution wide concerns

Any IoT solution must address the following solution-wide concerns:

* Security including physical security, authentication, authorization, and encryption.
* Solution management including deployment and monitoring.
* High availability and disaster recovery for all the components in your solution.
* Scalability for all the services in your solution.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->