Now that you've learned how Azure IoT can be applied to various industries, let's learn more about when and how you can use Azure IoT services.

### Top-tier Azure IoT services

The two top-tier services are IoT Hub, and IoT Central. All IoT solutions must have one or the other of these resources.

|Business need | Azure services | Description | Benefits |
|---------|---------|---------|---------|
|Connect, monitor, and control millions of IoT assets.|Azure IoT Hub |A managed service hosted in the cloud, Azure IoT Hub acts as a central message hub for bi-directional communication between your IoT application and the devices it manages. It provides reliable and secure communications between millions of IoT devices and a cloud-hosted backend solution.|Azure IoT hubs are designed to handle billions of telemetry messages from millions of devices. Metrics are maintained, devices monitored, and alerts can be defined to trigger actions. These actions range from sending a warning email, to triggering an automated Azure Function. A host of other specialized features can be attached to an IoT hub, such as routing, storage, automated device provisioning, time series insights, and machine learning.|
|An easier entry point for IoT app building.|Azure IoT Central|A hosted IoT app platform that's secure, scales with you as your business grows, and integrates with your existing business apps.|Simplify setup, and reduce management burden, operational costs, and overhead of a typical IoT project. ​Bring solutions to market faster, while staying focused on your customers.​|

> [!NOTE]
> Both Azure IoT Hub and Azure Event Hubs are cloud services that can ingest large amounts of data and process or store that data for business insights. The two services are similar in that they both support ingestion of data with low latency and high reliability, but they are designed for different purposes. IoT Hub was developed to address the unique requirements of connecting IoT devices to the Azure cloud, while Event Hubs was designed for big data streaming. Microsoft recommends using Azure IoT Hub to connect IoT devices to Azure.

### Azure IoT security

There are many services that support the top-tier resources. Let's start with security. In the IoT world, authenticating a device is known as _provisioning_.

|Business need | Azure services | Description | Benefits |
|---------|---------|---------|---------|
|Security in IoT must be end-to-end. Devices, device to cloud messaging, and cloud to device messaging, must all be secure.|  Azure Sphere|Azure Sphere certified microcontrollers, from silicon partners, with built-in Microsoft security technology, provide connectivity and a dependable hardware root of trust. The Azure Sphere Security Service guards every Azure Sphere device; it brokers trust for device-to-device and device-to-cloud communication, detects emerging threats, and updates device security. The Azure Sphere OS runs on Azure Sphere-certified chips, and provides a platform for app development.|With Azure Sphere, product manufacturers can create secure, connected devices that can be updated, controlled, monitored, and maintained remotely. These devices can then be used to create a secured application environment. This technology minimizes security risks due to spoofing, rogue software, denial of service attacks, and other threats. Microsoft security experts monitor emerging threats, and design best-in-class updates to counter those threats. |
|Ability to securely connect and configure a huge number of IoT devices, with little or no human involvement.|Azure Device Provisioning Service (DPS)|Azure DPS provisions devices globally, at scale, from a single cloud control point.|Zero touch device registration. Devices are automatically and securely connected to the IoT Hub service, and provisioned with an initial configuration. Eliminates manual provisioning errors.|
|Ability to easily view security issues, recommendations, and known threats.|Microsoft Defender for Cloud for IoT|Provides a holistic view of IoT solution security posture for DevOps and IoT solution managers. |Review and manage day to day security status, from a single portal location.|

### Azure IoT Edge devices

An edge device exists on the edge of the cloud, communicating with the IoT hub. The edge device could be a gateway, handling the telemetry data from any number of IoT devices. These IoT devices are connected locally to the edge gateway. The edge gateway may also have considerable processing power of its own.

|Business need | Azure services | Description | Benefits |
|---------|---------|---------|---------|
|Extend intelligence from the cloud to your edge devices.|Azure IoT Edge|Azure IoT Edge is a fully managed service, that is built on Azure IoT Hub. An edge device has similar capabilities to a hub. This service is meant for customers who want to analyze the bulk of device data locally, instead of in the cloud.|Enable scenarios that aren't currently cloud-feasible, perhaps because of networking issues, low-latency requirements, or regulatory concerns.|

### Azure IoT data analysis

There are many services that enable data analysis, here are some of them.

|Business need | Azure services | Description | Benefits |
|---------|---------|---------|---------|
|Ability to view anomalies in data, which can be hard to detect visually.|Azure Time Series Insights|Connect to billions of events in Azure IoT Hub or Azure Event Hub, and visualize and analyze billions of events to spot anomalies, and discover hidden trends, in your time series data.|Automates the process of detecting problems, that might only be apparent in the early stages to learning algorithms. Preventive maintenance is often the goal.|
|Ability to view the locations of vehicles on a map, and to calculate best routes.|Azure Maps|Azure Maps includes a host of features to handle geospatial data. For IoT apps, useful features include traffic, routing, weather, and search. For example, plan a route from A to B, taking into consideration different transit options: vehicle type, hazmat cargo, vehicle dimensions, intermediate stops, traffic, and so on.|Render maps and satellite imagery across many geographies in several styles. Calculates best transit routes given a myriad of parameters and preferences.|
|Create and work with a digital model of your physical space or assets.|Azure Digital Twins|Azure Digital Twins is an IoT service that creates comprehensive software models of the physical environment. The solution can query data from a modeled space, rather than from many disparate sensors.|This service helps you build spatially aware experiences that link streaming data across the digital and physical world. Digital Twins can be used to build solutions that manage facility operations more efficiently.

### Azure IoT Hub SDKs

For intermediate and advanced developers, there is a range of IoT SDKs. The SDKs support new features from IoT Hub, as updates are released, so you can incorporate these new features with minimal code, and ensure your solution is up-to-date.

In the context of IoT, a _module_ is an independent connection from a device to a hub. Suppose a device has three sensors, and each sensor sends telemetry to a different department in your organization. If your IoT solution uses modules, then each department will only have visibility to the sensor data that they own.

The SDKs support .NET, C, Java, Node.js, Python, and iOS.

|Business need | Azure services | Description | Benefits |
|---------|---------|---------|---------|
|The ability to build apps that run on your IoT devices, using device-client or module-client architecture.|Azure IoT Device SDKs|The Microsoft Azure IoT device SDKs contain code that facilitates building apps that connect to, and are managed by, Azure IoT Hub services. |Provides the customization options that might be needed for specialized devices.|
|The ability to build backend apps that interact with the hub.|Azure IoT Service SDKs|The Azure IoT service SDKs contain code to facilitate building applications that interact directly with IoT Hub, to manage devices and security.|Send messages, schedule jobs, invoke direct methods, and send desired property updates to your IoT devices or modules.|
|The ability to customize device communication with the Device Provisioning Service.|Provisioning Device SDKs|Enables you to build apps that run on your IoT devices, to communicate with the Device Provisioning Service.|The SDKs contain many libraries that address key problems and needs of IoT solutions.|
|The ability to customize backend services with the Device Provisioning Service.|Provisioning Service SDKs|Enables you to build backend applications, to manage your enrollments in the Device Provisioning Service.|The SDKs evolve with Azure IoT Hub. For example, a library is now included which enables the use of different Hardware Security Modules (HSMs).|

>[!TIP]
>For more details on the full set of Azure IoT products and services, use the products tab on azure.com. See links in the "Summary and resources" unit at the end of the module.

|           |  |
|           ----------- | -------------|
|![Icon of lightbulb](../media/lightbulb.png)|*Azure IoT solutions offer a wide range of capabilities, while adapting to your existing infrastructure. Whether you are just embarking on your IoT journey, or you already have IoT assets to manage and deploy, Azure IoT solutions can help you take your next step. First, take a moment to reflect on the outcomes you would like to achieve. Then, consider any possibilities you can imagine with IoT to further drive your digital transformation.*
|

Now, let's wrap up everything you've learned with a knowledge check.
