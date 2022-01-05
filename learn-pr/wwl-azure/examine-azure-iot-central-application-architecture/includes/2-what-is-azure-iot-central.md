IoT Central is an IoT application platform that reduces the burden and cost of developing, managing, and maintaining enterprise-grade IoT solutions. Choosing to build with IoT Central gives you the opportunity to focus time, money, and energy on transforming your business with IoT data. Businesses that choose IoT Central will benefit by reducing their time spent maintaining and updating their IoT infrastructure.

The web UI lets you monitor device conditions, create rules, and manage millions of devices and their data throughout their life cycle. Furthermore, it enables you to act on device insights by extending IoT intelligence into line-of-business applications.

> [!NOTE]
> It is important for Azure IoT Developers to know when Azure IoT Central is the right choice for their business or a customer. IoT Central offers an easy to manage alternative to the full PaaS solution option. It is also important to recognize that the IoT Plug and Play capabilities in Azure IoT Central are currently in public preview. Do not use an IoT Plug and Play enabled IoT Central application template for production workloads. For production environments use an IoT central application created from a current, generally available, application template.

## User roles

The IoT Central documentation refers to four personas who interact with an IoT Central application:

 -  A solution builder is responsible for defining the types of devices that connect to the application and customizing the application for the operator.
 -  An operator manages the devices connected to the application.
 -  An administrator is responsible for administrative tasks such as managing user roles and permissions within the application.
 -  A device developer creates the code that runs on a device or IoT Edge module connected to your application.

> [!NOTE]
> In smaller organizations, a single individual could complete the responsibilities of multiple roles.

## Azure IoT Central applications

As a solution builder, you use IoT Central to create a custom, cloud-hosted IoT solution for your organization. A custom IoT solution typically consists of:

 -  A cloud-based application that receives telemetry from your devices and enables you to manage those devices.
 -  Multiple devices running custom code connected to your cloud-based application.

You can quickly deploy a new IoT Central application and then customize it to your specific requirements in your browser. You can start with one of the industry-focused application templates for Retail, Energy, Government, or Healthcare. If you want, you can also choose to start with a generic application template.

As a solution builder, you use the web-based tools to create a device template for the devices that connect to your application.

## Device templates

A device template is the blueprint that defines the characteristics and behavior of a type of device. A device template includes items such as:

 -  The telemetry it sends.
 -  The business properties that an operator can modify.
 -  The device properties that are set by a device and are read-only in the application.
 -  The properties, that an operator sets, that determine the behavior of the device.
 -  The commands that an operator can call, that run on a device.

This device template includes:

 -  A device capability model that describes the capabilities a device should implement such as the telemetry it sends and the properties it reports.
 -  Cloud properties that are not stored on the device.
 -  Customizations, dashboards, and forms that are part of your IoT Central application.

As a solution builder, you have several options for creating device templates:

 -  Import a device capability model from the Azure Certified for IoT device catalog and then add any cloud properties, customizations, and dashboards your IoT Central application needs.
 -  Design the device template in IoT Central and then implement its device capability model in your device code.
 -  Create a device capability model by using Visual Studio code and publish the model to a repository. Implement your device code from the model, and connect your device to your IoT Central application. IoT Central finds the device capability model from the repository and creates a simple device template for you.
 -  Create a device capability model by using Visual Studio code. Implement your device code from the model. Manually import the device capability model into your IoT Central application and then add any cloud properties, customizations, and dashboards your IoT Central application needs.

As a solution builder, you can use IoT Central to generate code for test devices to validate your device templates.

## Application UI customization

As a solution builder, you can also customize the IoT Central application UI for the operators who are responsible for the day-to-day use of the application. Customizations that a solution builder can make include:

 -  Defining the layout of properties and settings on a device template.
 -  Configuring custom dashboards to help operators discover insights and resolve issues faster.
 -  Configuring custom analytics to explore time series data from your connected devices.

## Devices

Azure IoT Central uses the Azure IoT Hub Device Provisioning service (DPS) to manage all device registration and connection.

Using DPS enables:

 -  IoT Central to support onboarding and connecting devices at scale.
 -  You to generate device credentials and configure the devices offline without registering the devices through IoT Central UI.
 -  Devices to connect using shared access signatures.
 -  Devices to connect using industry-standard X.509 certificates.
 -  You to use your own device IDs to register devices in IoT Central. Using your own device IDs simplifies integration with existing back-office systems.
 -  A single, consistent way to connect devices to IoT Central.

### Azure IoT Edge devices

In addition to devices created using the Azure IoT SDKs, you can also connect Azure IoT Edge devices to an IoT Central application. Azure IoT Edge lets you run cloud intelligence and custom logic directly on IoT devices managed by IoT Central. The IoT Edge runtime enables you to:

 -  Install and update workloads on the device.
 -  Maintain Azure IoT Edge security standards on the device.
 -  Ensure that IoT Edge modules are always running.
 -  Report module health to the cloud for remote monitoring.
 -  Manage communication between downstream leaf devices and an IoT Edge device, between modules on an IoT Edge device, and between an IoT Edge device and the cloud.

## Stay connected

IoT Central applications are fully hosted by Microsoft, which reduces the administration overhead of managing your applications.

As an operator, you use the IoT Central application to manage the devices in your IoT Central solution. Operators do tasks such as:

 -  Monitoring the devices connected to the application.
 -  Troubleshooting and remediating issues with devices.
 -  Provisioning new devices.

As a solution builder, you can define custom rules and actions that operate over data streaming from connected devices. An operator can enable or disable these rules at the device level to control and automate tasks within the application.

Administrators manage access to your application with user roles and permissions.

## Quotas

Each Azure subscription has default quotas that could impact the scope of your IoT solution. Currently, IoT Central limits the number of applications you can deploy in a subscription to 10. If you need to increase this limit, contact Microsoft support.
