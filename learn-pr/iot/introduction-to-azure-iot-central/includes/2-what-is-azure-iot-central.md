Let's begin with an overview of Azure IoT Central. The definitions and features that follow can be used to determine if Azure IoT Central will meet the requirements for your IoT solution(s).

## What is Internet of Things?

*Internet of Things (IoT)* refers to the network of connected devices and objects that can send and receive data over the internet to other devices and/or systems. Common IoT devices include: smart refrigerators, personal assistants and fitness trackers. IoT devices have sensors that detect and measure various ambient conditions like temperature, location, light, humidity, pressure, acceleration and more. Data collected from IoT devices can be used for live monitoring, analysis, and decision-making.

:::image type="content" source="../media/2-internet-of-things.svg" alt-text="Diagram showing various types of IoT devices connecting to the cloud." border="false" lightbox="../media/2-internet-of-things-expanded.svg":::

## Azure IoT Central definition

Azure IoT Central is Azure's solution for the challenges faced by IoT professionals. It's an application platform as a service (*aPaaS*) offering that provides a cloud environment to build, manage, and deliver your IoT solution with less work required on your part.

The goal of aPaaS offerings is to accelerate application development by providing a complete solution for a specific business need. As a subcategory of the platform as a service (*PaaS*) cloud service type, aPaaS offerings handle the scaling and configuration for you but still require some developer input to complete the solution. Using the Azure IoT Central platform, you can start building your IoT Central solutions right from your internet browser.

:::image type="content" source="../media/2-azure-iot-central-homepage.svg" alt-text="Screenshot of the Azure IoT Central homepage." border="true" lightbox="../media/2-azure-iot-central-homepage-expanded.svg":::

Its features let you quickly implement IoT solutions with little to no code required. Allowing your organization to focus more attention, efforts, and money on creating business value from your IoT data. Instead of simply gathering the data itself.

Since most of the work required to produce a production-ready, enterprise-level IoT solution is handled by Azure IoT Central, you can have your devices connected after completing a few steps. There are four key user roles that assist with these efforts:

1. **Administrator**: handles administrative tasks, such as assigning user roles and permissions.
1. **Device Developer**: writes code for IoT devices.
1. **Operator**: manages devices connected to the IoT cloud application.
1. **Solution Builder**: builds the IoT cloud solution that devices connect to.

## Attributes of a successful IoT solution

IoT solutions are valuable for business and personal use. However, building IoT solutions from the ground up can be a daunting task. The key attributes of successful IoT solutions are centered around the following considerations:

| Attribute | Description |
| ------------- | --------------- |
| Scale | Scaling to hundreds of millions of devices creates system requirements for increased data processing, storage, compute, networking, multi-tenancy and more. |
| Device Management | Systematic pattern to provision, deprovision, manage, monitor and update your IoT devices, and manage device data transmission. |
| Big Data Management | Manage how your applications capture, store, retain and analyze data across hot, warm and cold paths and different storage options. |
| Analytics, Insights & Extensibility | Monitor device data in aggregate and over time. Establish rules that automate actions based on device data, and set up integrations with your broader business systems. |
| High availability & disaster recovery | Ensure your mission-critical applications and data are built for resiliency and protect your resources from network, compute and data failures. |
| Security & Compliance | Develop a strategy that ensures secure connectivity between devices and the cloud, secure integration with other applications, secure data protection in the cloud with regulatory compliance. |
| Total cost of ownership | Understand how to estimate long-term aggregated costs of cloud services, including how operational and infrastructure costs grow as your device and message volume grows. |
| DevOps | Effectively build, operate and maintain cloud services. Manage, provision and deploy code, prevent and manage security issues and test your solution before product deployment. |

## How to leverage Azure IoT Central

Capturing data from IoT devices is a common motivating factor for the development of IoT solutions, and may be why you're interested in creating your own. IoT data is often used to make critical business decisions and predictions, like those introduced in the previous unit for our national grocery store chain scenario. Let's explore how Azure IoT Central can help us **collect**, **monitor** and **analyze** this scenario's IoT data.

:::image type="content" source="../media/2-collect-monitor-analyze-decide.svg" alt-text="Diagram showing the process of collecting, monitoring and analyzing IoT data." border="false" lightbox="../media/2-collect-monitor-analyze-decide.svg":::

### Collect IoT data

:::row:::
    :::column span="2":::
        In order to take advantage of the features and benefits of Azure IoT Central, you must start with connecting your IoT devices to the platform to establish secure communication between the two. In our example scenario, not only do you need to collect a massive amount of data but you also have to handle various types of data sent from different types of devices, such as: proximity sensors at entrances, optical sensors on building exteriors and accelerometers on shopping carts.

        Azure IoT Central helps you connect tens to millions of devices.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-collect.svg" alt-text="Diagram showing the process of collecting, monitoring and analyzing IoT data with the collect phase emphasized." border="false" lightbox="../media/2-collect-expanded.svg":::
    :::column-end:::
:::row-end:::

### Monitor IoT data

:::row:::
    :::column:::
        :::image type="content" source="../media/2-monitor.svg" alt-text="Diagram showing the process of collecting, monitoring and analyzing IoT data with the monitor phase emphasized." border="false" lightbox="../media/2-monitor-expanded.svg":::
    :::column-end:::
    :::column span="2":::
        Once a secure connection has been established between Azure IoT Central and your IoT devices, you'll be able to monitor your IoT cloud application, devices, and device data in real time. Azure IoT Central has various charting and visual features that you can use to provide real-time data monitoring to the store managers in our example scenario.

        To implement this requirement, you can simply use the built-in dashboards or create your own custom dashboards. Using Azure IoT Central's dashboards, you can give store managers the option to view and monitor devices individually or as a group to better aid with investigating, troubleshooting and fixing device issues.
    :::column-end:::
:::row-end:::

### Analyze IoT data

:::row:::
    :::column span="2":::
        Live monitoring can be valuable, but there may be times when you'll need to analyze historical data sent from your IoT devices in the past. For instance, the ultimate goal of our fictional IoT solution is to improve the customer experience by ensuring staff availability. To help store managers reach this goal, it's important that they're able to analyze IoT data to base their staffing needs on.

        Azure IoT Central has several options for analyzing the IoT data it collects. Historical device data can be viewed by building Dashboards, viewing the *Analytics* page, or exported to other Azure services or custom applications for additional analysis. Store managers can use these features for reporting purposes or spotting trends in their store's data.
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/2-analyze.svg" alt-text="Diagram showing the process of collecting, monitoring and analyzing IoT data with the analyze phase emphasized." border="false" lightbox="../media/2-analyze-expanded.svg":::
    :::column-end:::
:::row-end:::
