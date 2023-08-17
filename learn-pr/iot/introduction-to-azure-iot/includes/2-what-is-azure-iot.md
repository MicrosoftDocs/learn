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
## What is Azure IoT?

Azure IoT includes a set of managed cloud services that you can use to connect, monitor, and manage your IoT devices. The Azure IoT device SDKs let you build devices that connect securely to your cloud services. The Azure IoT gateways enable you to run some services at the edge and enable more connectivity scenarios for your devices.

The following diagram shows a high-level view of the components in a typical IoT solution. This article focuses on the key groups of components: devices, IoT cloud services, other cloud services, and solution-wide concerns. Other articles in this section provide more detail on each of these components.

:::image type="content" source="../media/iot-architecture.svg" alt-text="Diagram that shows the high-level IoT solution architecture.":::

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

There's a wide variety of devices available from different manufacturers to build your solution. For a list of devices certified to work with Azure IoT Hub, see the [Azure Certified for IoT device catalog](https://devicecatalog.azure.com). For prototyping a microprocessor device, you can use a device such as a [Raspberry Pi](https://www.raspberrypi.org/). The Raspberry Pi lets you attach many different types of sensor.

<!-- Pattern for complex chunks (repeat as needed) -->
## Connectivity

Typically, IoT devices send telemetry from their attached sensors to cloud services in your solution. However, other types of communication are possible such as a cloud service sending commands to your devices. The following are examples of device-to-cloud and cloud-to-device communication:

* A connected coffee machine sends water temperature every minute to an IoT Hub.

* A cloud service sends a command to a connected coffee machine to put it into maintenance mode.

* A device monitoring a batch reactor in a chemical plant sends an alert when the temperature exceeds a certain value.

* A thermostat reports the maximum temperature the device has reached since the last reboot.

* A cloud service sets the target temperature for a thermostat device.

The IoT Device SDKs and IoT Hub support common communication protocols such as HTTP, MQTT, and AMQP for device-to-cloud and cloud-to-device communication. In some scenarios, you may need a gateway to connect your IoT devices to your cloud services.

IoT devices have different characteristics when compared to other clients such as browsers and mobile apps. Specifically, IoT devices:

* Are often embedded systems with no human operator.
* Can be deployed in remote locations, where physical access is expensive.
* May only be reachable through the solution back end.
* May have limited power and processing resources.
* May have intermittent, slow, or expensive network connectivity.
* May need to use proprietary, custom, or industry-specific application protocols.

The device SDKs help you address the challenges of connecting devices securely and reliably to your cloud services.

### Cloud services

In an IoT solution, the cloud services typically:

* Receive telemetry at scale from your devices, and determine how to process and store that data.
* Analyze the telemetry to provide insights, either in real time or after the fact.
* Send commands from the cloud to specific devices.
* Provision devices and control which devices can connect to your infrastructure.
* Control the state of your devices and monitor their activities.
* Manage the firmware installed on your devices.

For example, in a remote monitoring solution for an oil pumping station, the services use telemetry from the pumps to identify anomalous behavior. When a cloud service identifies an anomaly, it can automatically send a command to the device to take a corrective action. This process implements an automated feedback loop between the device and the cloud that greatly increases the solution efficiency.

Some cloud services, such as IoT Hub and the Device Provisioning Service, are IoT specific. Other cloud services, such as storage and visualization, provide generic services to your solution.

### Solution wide concerns

Any IoT solution must address the following solution-wide concerns:

* Security including physical security, authentication, authorization, and encryption
* Solution management including deployment and monitoring.
* High availability and disaster recovery for all the components in your solution.
* Scalability for all the services in your solution.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->