Azure IoT Hub is a managed service that acts as a central message hub in a cloud-based IoT solution, enabling secure and reliable communication between an IoT application and the devices it manages. It helps connect devices with per-device authentication and device management, and it integrates with Azure IoT Hub Device Provisioning Service (DPS) for scaled provisioning.

Let's first take a quick tour of some definitions, which will help you explore the suitability of IoT Hub for your business problems.

**Telemetry:** Telemetry is the process of recording and transmitting values received by an IoT device. Telemetry is an essential function of an IoT solution.

**Provisioning:** Provisioning uniquely identifies a device in the cloud and establishes its security settings, access rights, and privileges. Provisioning is typically handled at scale by the Azure IoT Hub Device Provisioning Service (DPS), which can automatically register devices to the appropriate IoT Hub after both the device and cloud are prepared. Devices need authentication credentials plus the assigned DPS ID scope and endpoint information, and the DPS instance needs enrollments for valid devices and linked target IoT hubs.

**Routing:** Message routing enables you to send messages from your devices to cloud services in an automated, scalable, and reliable manner. You can send either device telemetry messages or events (for example device lifecycle events).

**Scaling:** For cloud solutions, scaling involves the need to ramp up or down the scope of the solution. The ability to scale a solution up or down gives the developer the flexibility to deploy different kinds of solutions.

**Service availability:** Service availability aims to ensure an agreed level of operational performance (typically uptime) for a cloud service. Service availability is defined by the service level agreement (SLA).

IoT Hub enables you to:

**Secure your communications:** IoT Hub enables secure communications for your devices to send data providing per-device authentication with multiple authentication types.

**Scale your solution:** IoT Hub allows you to scale to millions of simultaneously connected devices and millions of events per second to support your IoT workloads. There are two considerations to determining how to scale your solution: the features you plan to use and the amount of data you plan to move daily.

Azure IoT Hub offers two production tiers — Basic and Standard — plus a Free (F1) tier for evaluation and testing. Basic supports device-to-cloud telemetry scenarios but doesn't support features such as cloud-to-device messages or device twins. Standard supports the full feature set, including bidirectional communication and device-management capabilities. Free has the same capabilities as Standard, but with limited messaging allowances; it's meant for testing and evaluation, not production. You can't upgrade an F1 hub to Basic or Standard, so plan to create or migrate to a paid hub when a trial moves toward production. All tiers offer the same security and authentication features.

Data throughput is the second consideration in determining how to scale your solution. Each Basic and Standard IoT Hub tier is available in three sizes, numerically identified as 1, 2, and 3 (for example, B1/B2/B3 for Basic and S1/S2/S3 for Standard). Free is available only as F1. Larger sizes accept higher daily message throughput per unit; the next unit explains how to choose the right size for a workload.

**Route device data:** IoT Hub enables you to send messages based on automated rules to optimize data traffic.

**Communicate from cloud to devices:** IoT Hub supports several cloud-to-device patterns. Use direct methods for immediate commands that need a response, device twin desired properties for desired state or long-running configuration changes, and cloud-to-device messages for one-way notifications.

**Monitor your IoT solution's health:** IoT Hub allows tracking events such as device creation, device communication failures, and device connections.

**Integrate with other services:** You can seamlessly integrate IoT Hub with other Azure services to build an end-to-end solution. For example, you can incorporate IoT Hub with Azure Logic Apps and Event Grid to automate business processes.

**Manage and configure your devices:** Using IoT Hub, you can manage your connected devices at scale. You can set and query the device status and automatically respond to a change in state for devices.

**Create highly available and resilient solutions:** IoT Hub supports solution designs that meet availability and resiliency requirements according to the service level agreement (SLA). Applications and devices still need retry and reconnect behavior for transient failures, and solution owners should plan disaster recovery and failover behavior.

**Connect virtually any device:** Using Azure IoT open-source device SDKs, you can build solutions, which run on connected devices and interact with IoT Hub. You can also connect devices natively to IoT Hub using MQTT, MQTT over WebSockets, AMQP, AMQP over WebSockets, or HTTPS. Devices and service clients must use TLS 1.2 or later with supported strong cipher suites; TLS 1.0/1.1 and weak cipher suites are retired for IoT Hub connections. If a solution requires MQTT v5 or richer broker-style publish/subscribe features, consider Azure Event Grid MQTT broker.
