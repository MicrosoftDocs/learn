During the past decade, the Internet of Things (IoT) has been defined in many ways by many people. Here is definition that captures the essence of IoT for developers:

*The Internet of Things is a network of Internet connected devices that communicate embedded sensor data to the cloud for centralized processing*.

As this simple definition points out, an IoT solution involves two essential components:

 -  A device-side (made up of individual devices) that acts as a data source.
 -  A cloud-side that gathers data and provides resources for analyzing and managing that data.

Once your business begins planning an IoT solution you find that both the device-side and the cloud-side involve complex implementations that provide hundreds of required features, and even the communication between the device and cloud can be complex and will require secure communication protocols. Breaking down the solution into subsystems helps to provide clarity.

## Core subsystems

At its core, an IoT solution architecture consists of the following subsystems:

 -  Devices that have the ability to securely register with the cloud, and connectivity options for sending and receiving data (between devices and the cloud).
 -  A cloud gateway service, or hub, that provides device management capabilities and securely accepts data from devices.
 -  Stream processors that consume data from the hub, integrate with business processes, and place the data into storage.
 -  A user interface to visualize telemetry data and facilitate device management.

These core subsystems can be aligned to a Things/Insights/Actions model, as shown below in a high-level view of the Azure IoT Reference Architecture.

:::image type="content" source="../media/m01-l02-core-subsystems-iot-architecture-8158ad9e.png" alt-text="Diagram that shows the core subsystems of the Azure IoT reference architecture.":::


**IoT Devices**: The physical devices where our data originates.

**Cloud Gateway**: The Cloud Gateway provides a cloud hub for secure connectivity, telemetry, and event ingestion and device management (including command and control) capabilities.

**User Interface and Reporting**: The user interface for an IoT application can be delivered on a wide array of device types, in native applications, and browsers.

**Stream Processing**: Processes large streams of data records and evaluates rules for those streams.

**Storage**: Storage can be divided into warm path (data that is required to be available for reporting and visualization immediately from devices), and cold path (data that is stored longer term and used for batch processing).

**Business Process Integration**: Facilitates executing actions based on insights garnered from device telemetry data during stream processing. Integration could include storage of informational messages, alarms, sending email or SMS, integration with CRM, and more.

## Optional subsystems

In addition to the core subsystems many IoT applications will include subsystems for:

 -  Edge devices that provide enhanced device connections and local processing.
 -  Data transformation of telemetry data sent from devices.
 -  User management interfaces that provide the right tooling for different roles and users.
 -  Machine learning to support scenarios such as predictive maintenance.
 -  Hot/warm/cold storage paths.
 -  Bulk device provisioning for deploying fleets of devices.

:::image type="content" source="../media/m01-l02-optional-subsystems-iot-architecture-416c18f0.png" alt-text="Diagram that shows the optional subsystems of the Azure IoT reference architecture.":::


**Data transformation**: The manipulation or aggregation of the telemetry stream either before or after it is received by the cloud gateway service (the IoT Hub). Manipulation can include protocol transformation (for example, converting binary streamed data to JSON), combining data points, and more.

**Machine Learning (ML) Subsystem**: Enables systems to learn from data and experiences and to act without being explicitly programmed. Scenarios such as predictive maintenance are enabled through ML.

**User Management Subsystem**: Allows specification of different capabilities for users and groups to perform actions on devices (for example, command and control such as upgrading firmware for a device) and capabilities for users in applications.

**Edge Devices**: These devices serve an active role in managing access and information flow. They may help with device provisioning, data filtering, batching and aggregation, buffering of data, protocol translation, event rules processing, and more.

**Bulk Provisioning**: Facilitates provisioning of large numbers of devices.
