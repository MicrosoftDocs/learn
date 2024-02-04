Here you'll learn about the core components and capabilities of Azure IoT and see how they all fit together in a solution:

* Device development
* Device connectivity
* Device management and control
* Process and route messages
* Extend your IoT solution
* Analyze and visualize your IoT data
* Manage your solution
* Secure your solution
* Scalability and high availability

## Device development

:::image type="content" source="../media/iot-architecture-developer.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting device development areas." border="false":::

In Azure IoT, a device developer writes the code to run on the devices in the solution. This code typically:

* Establishes a secure connection to a cloud endpoint.
* Sends telemetry collected from attached sensors to the cloud.
* Manages device state and synchronizes that state with the cloud.
* Responds to commands sent from the cloud.
* Enables the installation of software and firmware updates from the cloud.
* Enables the device to keep functioning while it's disconnected from the cloud.

### Device types

IoT devices can be separated into two broad categories, microcontrollers (MCUs) and microprocessors (MPUs):

* MCUs are less expensive and simpler to operate than MPUs.
* An MCU contains many of the functions, such as memory, interfaces, and I/O on the chip itself. An MPU accesses this functionality from components in supporting chips.
* An MCU often uses a real-time OS (RTOS) or runs bare-metal (no OS) and provides real-time responses and highly deterministic reactions to external events. MPUs generally run a general purpose OS, such as Windows, Linux, or macOS that provides a nondeterministic real-time response. There's typically no guarantee as to when a task will complete.

### Primitives

An Azure IoT device can use the following primitives to interact with the cloud:

* *Device-to-cloud* messages to send time series telemetry to the cloud. For example, temperature data collected from a sensor attached to the connected coffee machine.
* *File uploads* for media files such as captured images and video. Intermittently connected devices can send telemetry batches. Devices can compress uploads to save bandwidth.
* *Device twins* to share and synchronize state data with the cloud. For example, a device can use the device twin to report the current state of a valve it controls to the cloud and to receive a desired target temperature from the cloud.
* *Digital twins* to represent a device in the digital world. For example, a digital twin can represent a device's physical location, its capabilities, and its relationships with other devices.
* *Direct methods* to receive commands from the cloud. A direct method can have parameters and return a response. For example, the cloud can call a direct method to request the connected coffee machine to reset in 30 seconds.
* *Cloud-to-device* messages to receive one-way notifications from the cloud. For example, a notification that an update for the connected coffee machine is ready to download.

### Azure IoT device SDKs

The device SDKs provide high-level abstractions that let you use the primitives without knowledge of the underlying communications protocols. The device SDKs also handle the details of establishing a secure connection to the cloud and authenticating the device.

Although you're recommended to use one of the device SDKS, there may be scenarios where you prefer not to. In these scenarios, your device code must directly use one of the communication protocols that IoT Hub and the Device Provisioning Service (DPS) support.

### Containerized device code

Using containers, such as Docker, to run your device code lets you deploy code to your devices by using the capabilities of the container infrastructure. Containers also let you define a runtime environment for your code with all the required library and package versions installed. Containers make it easier to deploy updates and to manage the lifecycle of your IoT devices.

Azure IoT Edge runs device code in containers. You can use Azure IoT Edge to deploy code modules to your devices.

## Device connectivity

:::image type="content" source="../media/iot-architecture-connectivity.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting device connectivity areas." border="false":::

A device can establish a secure connection to an IoT hub in the cloud:

* Directly, in which case you must provide the device with a connection string that includes the hostname.
* Indirectly by using the Device Provisioning Service (DPS), in which case the device connects to a well-known DPS endpoint to retrieve the connection string for the IoT hub it's assigned to.

The advantage of using DPS is that you don't need to configure all of your devices with connection-strings that are specific to your IoT hub. Instead, you configure your devices to connect to a well-known, common DPS endpoint where they discover their connection details.

### Authentication and authorization

Azure IoT devices use TLS to verify the authenticity of the IoT hub or DPS endpoint they're connecting to. The device SDKs include the DigiCert Global Root G2 TLS certificate they currently need to establish a secure connection to the IoT hub.

Azure IoT devices can use either shared access signature (SAS) tokens or X.509 certificates to authenticate themselves to an IoT hub. X.509 certificates are recommended in a production environment.

### Protocols

An IoT device can use one of several network protocols when it connects to an IoT Hub or DPS endpoint:

* [MQTT](https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.pdf)
* MQTT over WebSockets
* [Advanced Message Queuing Protocol (AMQP)](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-complete-v1.0-os.pdf)
* AMQP over WebSockets
* HTTPS

Industrial IoT scenarios often use the [open platform communications unified architecture (OPC UA)](https://opcfoundation.org/about/opc-technologies/opc-ua/) industry standard open interface. To enable connectivity to IoT Hub, use the OPC Publisher that runs as a module on IoT Edge.

### Connection patterns

There are two broad categories of connection patterns that IoT devices use to connect to the cloud:

* Persistent connections are required when your solution needs *command and control* capabilities. In command and control scenarios, your IoT solution sends commands to devices to control their behavior in near real time. Persistent connections maintain a network connection to the cloud and reconnect whenever there's a disruption. Use either the MQTT or the AMQP protocol for persistent device connections to an IoT hub. The IoT device SDKs enable both the MQTT and AMQP protocols for creating persistent connections to an IoT hub.

* Ephemeral connections are brief connections for devices to send telemetry to your IoT hub. After a device sends the telemetry, it drops the connection. The device reconnects when it has more telemetry to send. Ephemeral connections aren't suitable for command and control scenarios. A device client can use the HTTP API if all it needs to do is send telemetry.

### Field gateways

Field gateways (sometimes referred to as edge gateways) are typically deployed on-premises and close to your IoT devices. Field gateways handle communication with the cloud on behalf of your IoT devices. Field gateways may:

* Do protocol translation. For example, enabling Bluetooth enabled devices to connect to the cloud.
* Manage offline and disconnected scenarios. For example, buffering telemetry when the cloud endpoint is unreachable.
* Filter, compress, or aggregate telemetry before it's sent to the cloud.
* Run logic at the edge to remove the latency associated with running logic on behalf of devices in the cloud. For example, detecting a spike in temperature and opening a valve in response.

You can use Azure IoT Edge to deploy a field gateway to your on-premises environment. IoT Edge provides a set of features that enable you to deploy and manage field gateways at scale. IoT Edge also provides a set of modules that you can use to implement common gateway scenarios.

### Bridges

A device bridge enables devices that are connected to a third-party cloud to connect to your IoT solution. Examples of third-party clouds include [Sigfox](https://www.sigfox.com/), [Particle Device Cloud](https://www.particle.io/), and [The Things Network](https://www.thethingsnetwork.org/).

## Device management and control

:::image type="content" source="../media/iot-architecture-device-management.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting device management areas." border="false":::

In Azure IoT, *command and control* refers to the processes that let you send commands to devices and receive responses from them. For example, you can send a command to a coffee machine device to:

* Request maximum and minimum temperature values for the last two hours.
* Set the telemetry interval to 10 seconds.

In Azure IoT, *device management* includes tasks such as:

* *Device registration*: Before a device can connect to an IoT hub, it must be registered. Device registration is the process of creating a device identity in the cloud. Each IoT hub has its own internal device registry. The device identity is used to authenticate the device when it connects to Azure IoT.
* *Device provisioning*: You must configure each device in your solution with the details of the IoT hub it should connect to. You can manually configure each device in your solution, but this may not be practical for a large number of devices. To get around this problem, you can use the Device Provisioning Service (DPS) to automatically register each device with an IoT hub, and then provision each device with the required connection information.
* *Device deployment*: In Azure IoT, device deployment typically refers to the process of installing software on an IoT Edge device. When an IoT Edge device connects to an IoT hub, it receives a *deployment manifest* that contains details of the modules to run on the device. The deployment manifest also contains configuration information for the modules. There are a number of standard modules available for IoT Edge devices. You can also create your own custom modules.
* *Device updates*: Typically, your IoT solution must include a way to update device software. For an IoT Edge device, you can update the modules that run on the device by updating the deployment manifest. The *Device Update for IoT Hub* service provides a managed solution for updating non-IoT Edge devices.
* *Device monitoring*: As part of overall solution monitoring, you may want to monitor the health of your devices. For example, you may want to monitor the health of your devices or detect when a device is no longer connected to the cloud.

## Process and route messages

:::image type="content" source="../media/iot-architecture-processing.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting message processing areas." border="false":::

In Azure IoT, message processing refers to processes such as routing and enriching telemetry messages sent by devices. These processes are used to control the flow of messages through the IoT solution and to add additional information to the messages.

### Route messages

An IoT hub provides a cloud entry point for the telemetry messages that your devices send. In a typical IoT solution, these messages are delivered to other downstream services for storage or analysis. Both IoT Hub and IoT Central provide mechanisms for routing messages to other services.

### Enrich or transform messages

To simplify downstream processing, you may want to add data to telemetry messages or modify their structure.

IoT Hub message enrichments let you add data to the messages sent by your devices. You can add:

* A static string
* The name of the IoT hub processing the message
* Information from the device twin

IoT Central has two options for transforming telemetry messages:

* Use mappings to transform complex device telemetry into structured data on ingress to IoT Central.
* Use transformations to manipulate the format and structure of the device data before it's exported to a destination.

### Process messages at the edge

An Azure IoT Edge module can process telemetry from an attached sensor or device before it's sent to an IoT hub. For example, before it sends data to the cloud an IoT Edge module can:

* Filter data
* Aggregate data
* Convert data

### Other cloud services

You can use other Azure services to process telemetry messages from your devices. Both IoT Hub and IoT Central can route messages to other services. For example, you can forward telemetry messages to Azure Stream Analytics or Azure Functions for further processing.

## Extend your IoT solution

:::image type="content" source="../media/iot-architecture-extensibility.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting solution extensibility areas." border="false":::

In Azure IoT, solution extensibility refers to the ways you can add to the built-in functionality of the IoT cloud services and build integrations with other services. For example:

* A typical IoT solution includes the analysis and visualization of the data from your devices to enable business insights. For example, a dashboard that shows the current status of your connected coffee machines.
* An IoT solution may include other systems such as asset management, work scheduling, and control automation systems. For example, when an in-warranty coffee machine requires maintenance a work order is automatically created in the work scheduling system.

Mechanisms available to extend your IoT solution include:

* Service APIs that let you build interactions with your IoT hub and devices.
* Routing, rules, and data export that let you send data to other services for analysis or processing.

## Analyze and visualize your IoT data

:::image type="content" source="../media/iot-architecture-visualize.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting analysis and visualization areas." border="false":::

In Azure IoT, analysis and visualization services are used to identify and display business insights derived from your IoT data. For example, you can use a machine learning model to analyze device telemetry and predict when maintenance should be carried out on a connected coffee machine. You can also use a visualization tool to display a map of the location of your coffee machines.

Analysis and visualization services and tools you can incorporate into your IoT solution include:

* The *Azure Digital Twins* service lets you build and maintain models that are live, up-to-date representations of the real world. You can query, analyze, and generate visualizations from these models to extract business insights. An example model might be a representation of a building that includes information about the rooms, the devices in the rooms, and the relationships between the rooms and devices.

* *Azure Data Explorer* is a fully managed, high-performance, big-data analytics platform that makes it easy to analyze high volumes of data in near real time:

* Use *Azure Databricks* to process, store, clean, share, analyze, model, and monetize datasets with solutions from BI to machine learning. Use the Azure Databricks platform to build and deploy data engineering workflows, machine learning models, analytics dashboards, and more.

* *Azure Stream Analytics* is a fully managed stream processing engine that is designed to analyze and process large volumes of streaming data with low latency. Patterns and relationships can be identified in data that originates from various input sources including applications, devices, and sensors.

* *Power BI* is a collection of software services, apps, and connectors that work together to turn your unrelated sources of data into coherent, visually immersive, and interactive insights. Power BI lets you easily connect to your data sources, visualize and discover what's important, and share that with anyone you want.

* *Azure Maps* is a collection of geospatial services and SDKs that use fresh mapping data to provide geographic context to web and mobile applications.

* *Grafana* is visualization and analytics software that lets you query, visualize, alert on, and explore your metrics, logs, and traces no matter where they're stored. It provides you with tools to turn your time-series database data into insightful graphs and visualizations.

## Manage your solution

:::image type="content" source="../media/iot-architecture-solution-management.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting solution management areas." border="false":::

There are many options for managing your IoT solution including the Azure portal, PowerShell, and ARM templates:

* The Azure portal offers a consistent GUI environment for managing your Azure IoT services.

* To implement infrastructure as code for your Azure IoT solutions, use Azure Resource Manager templates and Azure DevOps tools.

* Use PowerShell or the Azure CLI to automate the management of your IoT solution from a command line environment.

## Secure your solution

:::image type="content" source="../media/iot-architecture-security.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting security." border="false":::

You can divide security in an IoT solution into the following three areas:

* *Device security*: Secure the IoT device while it's deployed in the wild.

* *Connection security*: Ensure all data transmitted between the IoT device and the IoT cloud services is confidential and tamper-proof.

* *Cloud security*: Secure your data while it moves through, and is stored in the cloud.

*Microsoft Defender for IoT* can automatically monitor some key security recommendations. Microsoft Defender for IoT should be the first line of defense to protect your resources in Azure. Microsoft Defender for IoT periodically analyzes the security state of your Azure resources to identify potential security vulnerabilities. It then provides you with recommendations on how to address them.

## Scalability

:::image type="content" source="../media/iot-architecture-scalability.svg" alt-text="Diagram that shows the high-level IoT solution architecture highlighting solution scalability." border="false":::

An IoT solution may need to support millions of connected devices. You need to ensure that the components in your solution can scale to meet the demands:

* Use the Device Provisioning Service (DPS) to provision devices at scale. DPS is a helper service for IoT Hub and IoT Central that enables zero-touch device provisioning at scale.

* Use the Device Update for IoT Hub helper service to manage over-the-air updates to your devices at scale.

* You can scale the IoT Hub service vertically and horizontally. Use IoT Hub routing to handle scaling out the services that IoT Hub delivers messages to.

* IoT Edge can help to scale your solution. IoT Edge lets you move cloud analytics and custom business logic from the cloud to your devices. This approach lets your cloud solution focus on business insights instead of data management. Scale out your IoT solution by packaging your business logic into standard containers, deploy those containers to your devices, and monitor them from the cloud.
