Now that you've learned how Azure IoT can be applied to various industries, let's learn more about when and how you can use Azure IoT services.

### Azure IoT Services

The two top-tier services are IoT Hub, and IoT Central. All IoT solutions must have one or the other of these resources.

|Business Need | Azure Services | Description | Benefits |
|---------|---------|---------|---------|
|Connect, monitor, and control millions of IoT assets.|Azure IoT Hub |A managed service hosted in the cloud, Azure IoT Hub acts as a central message hub for bi-directional communication between your IoT application and the devices it manages. It provides reliable and secure communications between millions of IoT devices and a cloud-hosted solution backend.|Azure IoT Hub monitoring helps you maintain the health of your solution by tracking events such as device creation, device failures, and device connections.|
|An easier entry point for IoT app building.|Azure IoT Central|A hosted IoT app platform that's secure, scales with you as your business grows, and integrates with your existing business apps.|Simplify setup, and reduce management burden, operational costs, and overhead of a typical IoT project. ​Bring solutions to market faster, while staying focused on your customers​|

There are many services that support the top-tier resources. Let's start with security.

|Business Need | Azure Services | Description | Benefits |
|---------|---------|---------|---------|
|Security in IoT must be end-to-end. Devices, device to cloud messaging, and cloud to device messaging, must all be secure.|  Azure Sphere|Azure Sphere certified microcontrollers, from silicon partners, with built-in Microsoft security technology, provide connectivity and a dependable hardware root of trust. The Azure Sphere Security Service guards every Azure Sphere device; it brokers trust for device-to-device and device-to-cloud communication, detects emerging threats, and updates device security.|With Azure Sphere, product manufacturers can create secure, connected devices that can be updated, controlled, monitored, and maintained remotely. These devices can then be used to create a secured application environment. This technology minimizes security risks due to spoofing, rogue software, denial of service attacks, and other threats.|
|Ability to authenticate a huge number of IoT devices, with little or no human involvement.|Azure Device Provisioning Service|Azure DPS provisions devices globally, at scale, from a single cloud control point.|Zero touch device registration. Devices are automatically and securely connected to the IoT Hub service and provisioned with an initial configuration. Removes manual errors.|
|Ability to view all security issues, recommendations, threats, from a single portal location.|Azure Security Center for IoT|Provides a holistic view of IoT solution security posture for DevOps and IoT solution managers. |Review and manage day to day security status.|

There are services aimed at improving the flow, efficiency, and customization of IoT data.

|Business Need | Azure Services | Description | Benefits |
|---------|---------|---------|---------|
|Ability to route data to multiple locations. A cold path for storage, a warm path for analytics.|Azure IoT Event Hubs|Provides a sophisticated range of routing options, for masses of incoming data.|Manages multiple goals, such as a cold path for archiving data, a warm path for rapid analysis, and a cooler path for in-depth analysis.|
|Extend intelligence from the cloud to your edge devices.|Azure IoT Edge|Azure IoT Edge is a service that builds on top of Azure IoT Hub. This service is meant for customers who want to analyze data on devices instead of in the cloud. Azure IoT Edge devices can be deployed and executed locally.|Enable scenarios that aren't currently cloud-feasible due to networking issues, low-latency requirements, or regulatory concerns.|
|For intermediate and advanced developers, the ability to build custom IoT devices.|Azure IoT Device SDK|A REST-based SDK, to support third-party industry-specific sensors, and other IoT devices. Supports RTOS, Linux, Windows, Android, and iOS.|Provides the customization options that might be needed for specialized devices.|

There are many services that enable data analysis, here are some of them.

|Business Need | Azure Services | Description | Benefits |
|---------|---------|---------|---------|
|Ability to view anomalies in data, which can be hard to detect visually.|Azure Time Series Insights|Connect to billions of events in Azure IoT Hub or Azure Event Hub, and visualize and analyze billions of events to spot anomalies, and discover hidden trends in your data.|Automates the process of detecting problems that are only apparent in the early stages to learning algorithms. Preventive maintenance is often the goal.|
|Ability to view the locations of vehicles on a map, and to calculate best routes.|Azure Maps|Plan a transit route from A to B taking into consideration different transit options: vehicle type, hazmat cargo, vehicle dimensions, current traffic.|Render maps and satellite imagery across many geographies in several styles. Calculates best transit routes given a myriad of parameters and preferences.|
|Create and work with a digital model of your physical space or assets.|Azure Digital Twins|Azure Digital Twins is an IoT service that creates comprehensive models of the physical environment. The solution can query data from a physical space rather than from many disparate sensors.|This service helps you build spatially aware experiences that link streaming data across the digital and physical world. Digital Twins can be used to build solutions to manage facility operations more efficiently. In addition, it can increase and optimize the efficiency of the building and design process by modeling physical environments.

>[!TIP]
>For more details on the full set of Azure IoT products and services, use the products tab on azure.com. See links in the "Summary and resources" unit at the end of the module.

|           |  |
|           ----------- | -------------|
|![Icon of lightbulb](../media/lightbulb.png)|*Azure IoT solutions offer a wide range of capabilities while adapting to your existing infrastructure. Whether you are just embarking on your IoT journey, or you already have IoT assets to manage and deploy, Azure IoT solutions can help you take your next step. First, take a moment to reflect on the outcomes you would like to achieve. Then, consider any possibilities you can imagine with IoT to further drive your digital transformation.*
|

Now, let's wrap up everything you've learned with a knowledge check.
