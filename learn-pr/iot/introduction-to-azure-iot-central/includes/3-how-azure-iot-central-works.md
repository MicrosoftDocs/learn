Now that you have an understanding of what Azure IoT Central is from the previous unit, you'll learn how it works in this one. As mentioned before, Azure IoT Central is an application platform as a service offering in Azure. As a result, the platform is built upon many Azure services that you may already be familiar with.

:::image type="content" source="../media/3-azure-services.svg" alt-text="Image showing six of the more than 30 Azure services that power Azure IoT Central. The services shown are Azure Stream Analytics, Azure Maps, Azure Time Series Insights, Azure IoT Hub, Azure Cosmos DB, and the Azure Device Provisioning Service." border="false" lightbox="../media/3-azure-services-expanded.svg":::

By now, you've probably noticed the reoccurring theme for our module: **collect**, **monitor**, and **analyze**. Let's explore the inner workings of Azure IoT Central as they relate to this theme.

## Collect

Azure IoT Central solutions require setup for both the cloud application and the IoT devices that will connect to it. Secure communication between the two is the first step in ensuring secure collection of your IoT data.

### Cloud application

The Azure IoT Central *cloud application* has a user-friendly interface that is used to manage your connected devices, the IoT data they send and users who connect to the application.

<!-- Add extended alt-text description -->

:::image type="content" source="../media/3-dashboard.svg" alt-text="Screenshot of an Azure IoT Central dashboard showing IoT data for simulated devices." border="true" lightbox="../media/3-dashboard-expanded.svg":::

There are three options available for creating and managing Azure IoT Central applications, which are the Command Line Interface (CLI), the Azure IoT Central application manager website, and the Azure portal. With these options, client applications can be developed with generic or custom application templates. *Generic application templates* are industry-focused templates for the retail, energy, government, and healthcare industries. *Custom application templates* are uploaded versions of your own custom-built application code.

When you create your Azure IoT Central application, dozens of Azure services are created behind the scenes to prepare your application.

### Device provisioning

Connecting and configuring the necessary IoT infrastructure is an important step in building IoT solutions. This step is known as *device provisioning*. In terms of IoT solutions, device provisioning in the cloud consists of registering the device for the IoT solution in the cloud and configuring it based on the requirements of that solution. In other words, you have to connect your device(s) to Azure IoT Central's cloud application and prepare the device to send the data that the application expects to receive.

Device provisioning in Azure IoT Central is powered by the Azure IoT Hub Device Provisioning Service. This service helps you quickly and securely setup millions of IoT devices with little effort. Each device provisioned to Azure IoT Central uses a *device template*, which acts as a blueprint that defines the device's characteristics and behaviors.

### Supported devices

Your devices must be developed by your device developers using the Azure IoT Hub Device SDKs or the Azure IoT Edge Runtime. Each device needs to be programmed with the right credentials for successful provisioning with the cloud application. Ready-to-use, Azure certified devices can also be purchased from the Azure Certified Device Catalog. These devices are made using the Azure IoT Plug and Play feature, which allows developers to connect IoT devices with little to no code required.

Your device developers can choose from three main types of devices to implement for your Azure IoT Central solution:

| Device Type      | Description | Uses |
| ---------------- | ----------- | ---- |
| IoT Device       | Free-standing device that sends its individual sensor data directly to Azure IoT Central. | Sends telemetry data, reports property values, receives writable property values, and responds to commands. |
| IoT Edge Device  | Device that connects directly to Azure IoT Central but also has the ability to process data locally. | Acts as a standalone IoT device or as a middleman for other devices that can't connect directly to Azure IoT Central. |
| Gateway Devices  | IoT device that connects to downstream devices.  | Manages other devices that connect to Azure IoT Central. |

### Communication

:::row:::
    :::column span="2":::
        One of the most important components of any IoT solution is secure communication between devices and the applications they connect to. The connections for bilateral communication between an Azure IoT Central application and its IoT devices are established by Azure IoT Hub. The connections are secured using shared access signatures, X.509 certificates, or a Trusted Platform Module (TPM). You can choose from several different communication protocols, including: *MQTT*, *AMQP*, or *HTTPs*.

        Devices can send messages to the cloud application using the built-in service endpoints from Azure IoT Hub or define their own custom endpoints. This type of messaging is known as *device-to-cloud* messaging. Standard IoT Hub pricing tiers also allow for *cloud-to-device* messaging.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/3-communication.svg" alt-text="Diagram showing how bilateral communication is established between Azure IoT Central's cloud application and IoT devices using MQTT, AMQP or HTTPs protocols." border="false" lightbox="../media/3-communication-expanded.svg":::
    :::column-end:::
:::row-end:::

### Data storage

Every IoT solution needs proper data storage to be effective. Azure IoT Central supports 30-day storage of device data and also has data exporting features that provide more storage options, as well as analytics and insights. You can export data from your cloud application and send it to other Azure services, such as:

| Azure Service | Use |
| ------------- | ------|
| Azure Event Hubs | Process, transform, and store millions of events with speed and precision. |
| Azure Service Bus | Send messages between your devices, applications, and services in the cloud |
| Azure Blob Storage | Store large amounts of unstructured data. |
| Azure Data Lake Storage | Process and analyze large amounts of data. |
| Webhook Endpoints | Trigger *HTTP* callbacks to other applications based on predefined rules. |
| | |

## Monitor

Azure IoT Central provides several features that let you monitor the health of your applications and IoT devices, and analyze historical data collected by your devices in the past.

### Device monitoring

There are several reasons why you'll need to monitor your IoT devices. For instance, monitoring your devices allows you to identify when there are issues with them. Azure IoT Central allows you to monitor the state of each individual device using pre-built or custom dashboards and set rules to send email notifications to operators when issues occur. The email will contain a link to the device *Overview* page for the affected device(s). You may also view more detailed information on the *About* and *Commands* pages for that device. Information on these pages can help you quickly troubleshoot and fix device issues.

:::image type="content" source="../media/3-device-dashboard.svg" alt-text="Screenshot of a simulated device dashboard from the Azure IoT Central website." border="true" lightbox="../media/3-device-dashboard-expanded.svg":::

### Application monitoring

In addition to device issues, issues can arise within the cloud application itself. Remember that Azure IoT Central is powered by dozens of individual Azure services. The platform has dependencies that could affect your application. For example, if you decide to use the data export feature and the database or service you're exporting your data to is offline. You'll need to know in order to correct the issue in a timely manner. Therefore, it's recommended that administrators monitor the overall health of the Azure IoT Central application. Metrics are provided by charts available using the Azure portal, REST API, or queries written with PowerShell or Azure CLI.

A few of the metrics provided by Azure IoT Central are:

- Total Provisioned Devices
- Total Connected Devices
- Failed Device Property Reads from Azure IoT Central
- Successful Device Property Updates from Azure IoT Central

## Analyze

The analytic features in Azure IoT Central are powered by Azure Stream Analytics, Azure Maps, and Time Series Insights. Azure Stream Analytics enables real-time analytics, Azure Maps gives you access to location services and the Time Series Insights service allows you to scale your IoT-specific analytic data.

Azure IoT Central's analytic features provide an interactive experience for you to better visualize historical data your devices have sent to the application. You can query your data using your predefined device groups or query per device, based on the telemetry you want to analyze. Then, refine the results even more by showing/hiding telemetry or changing the time duration.

:::image type="content" source="../media/3-analytics.svg" alt-text="Screenshot of a simulated Azure IoT Central analytics page showing a graph of the battery lives of connected devices for the past 24 hours." border="true" lightbox="../media/3-analytics-expanded.svg":::
