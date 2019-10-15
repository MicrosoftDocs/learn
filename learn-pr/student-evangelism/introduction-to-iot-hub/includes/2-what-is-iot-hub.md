IoT Hub is a cloud-based service that acts as a central message hub for bi-directional communication between your IoT application and the devices it manages. Let us first take a quick tour of some definitions, which will help you explore the suitability of IoT Hub for your business problems.

**Telemetry:** Telemetry is the process of recording and transmitting values received by an IoT device. Telemetry is an essential function of an IoT application.

**Scaling:** For cloud applications, scaling involves the need to ramp up (or down) the scope of the solution. The ability to scale a solution up or down gives the developer flexibility to deploy different kinds of solutions.

**Provisioning:** The act of provisioning a device to the cloud uniquely identifies the device to the cloud. Provisioning also establishes the security protocols for the device and its access rights and privileges.

**Routing:** Message routing enables you to send messages from your devices to cloud services in an automated, scalable, and reliable manner. You can send either device telemetry messages or events (for example device lifecycle events).

**Service availability:** Service availability aims to ensure an agreed level of operational performance (typically uptime) for a cloud service. Service availability is defined by the service level agreement(SLA)

IoT hub enables you to:

**Scale your solution:** IoT Hub allows you to scale to millions of simultaneously connected devices and millions of events per second to support your IoT workloads.  There are two considerations to determining how to scale your application: the features you plan to use and the amount of data you plan to move daily.

Azure IoT Hub offers two tiers: the basic tier and the standard tier. To develop full-featured and bi-directional communication capabilities, you should use the standard tier. The basic tier provides a subset of features and is intended for applications that only need uni-directional communication from devices to the cloud. Both basic and standard tiers offer the same security and authentication features.

Data throughput is the second consideration in determining how to scale your application. Each IoT Hub tier is available in three sizes, numerically identified as 1, 2, and 3. Each unit of a level 1 IoT hub can handle 400 thousand messages a day, while a level 3 unit can handle 300 million.

**Secure your communications:** IoT Hub enables secure communications for your devices to send data providing per-device authentication with multiple authentication types.

**Route device data:** IoT Hub enables you to send messages based on automated rules. IoT Hub can also send Cloud-to-device messages. Cloud-to-device messages enable you to send commands and notifications to your connected devices tracking events such as device creation, device failures, and device connections.

 **Integrate with other services:** You can integrate IoT Hub with other Azure services to build an end-to-end solution. For example, you can incorporate IoT Hub with Azure Logic Apps to automate business processes.

 **Manage and configure your devices:** Using IoT Hub, you can manage your connected devices at scale. You can set and query the device status and automatically respond to a change in state for devices.

**Create highly available solutions:** Create solutions, which are highly available as per a specified service level agreement.

 **Connect your devices:** Using Azure IoT SDK libraries, you can build applications, which run on connected devices and interact with IoT Hub. You can also connect devices natively to the IoT Hub using protocols such as  MQTT, HTTPS 1.1, or AMQP. You can also use custom protocols.  
