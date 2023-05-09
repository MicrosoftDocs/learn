IoT Central is an IoT application platform as a service (aPaaS) that reduces the burden and cost of developing, managing, and maintaining enterprise-grade IoT solutions. Choosing to build with IoT Central gives you the opportunity to focus time, money, and energy on transforming your business with IoT data. Businesses that choose IoT Central will benefit by reducing their time spent maintaining and updating their IoT infrastructure.

The web UI lets you monitor device conditions, create rules, and manage millions of devices and their data throughout their life cycle. Furthermore, it enables you to act on device insights by extending IoT intelligence into line-of-business applications.

> [!NOTE]
> It is important for Azure IoT solution developers to know when Azure IoT Central is the right choice for their business or a customer. IoT Central offers an easy to manage alternative to the full PaaS solution option. It is also important to recognize the IoT Plug and Play support provided by Azure IoT Central. For production environments, you can build an IoT central application based on an industry-focused application template.

## User roles

The IoT Central documentation refers to four personas who interact with an IoT Central application:

 -  A solution builder is responsible for defining the types of devices that connect to the application, customizing the application for the operator, and building custom applications that integrate with the IoT Central using the IoT Central REST APIs.
 -  An operator manages the devices connected to the application.
 -  An administrator is responsible for administrative tasks such as managing user roles and permissions within the application.
 -  A device developer creates the code that runs on a device or IoT Edge module connected to your application.

> [!NOTE]
> In smaller organizations, a single individual could complete the responsibilities of multiple roles.

## Azure IoT Central applications

As a solution builder, you use IoT Central to create a custom, cloud-hosted IoT solution for your organization. A custom IoT solution typically consists of:

 -  A cloud-based application that receives telemetry from your devices and enables you to manage those devices.
 -  Multiple devices running custom code connected to your cloud-based application.

You can quickly deploy a new IoT Central application and then customize it to your specific requirements in your browser. You can start with one of the industry-focused application templates, or you can choose to start with a custom/empty application template.

As a solution builder, you use the web-based tools to create a device template for the devices that connect to your application.

## Device templates

A device template is the blueprint that defines the characteristics and behavior of a type of device. A device template includes items such as:

 -  The telemetry it sends.
 -  The business properties that an operator can modify.
 -  The device properties that are set by a device and are read-only in the application.
 -  The properties, that an operator sets, that determine the behavior of the device.
 -  The commands that an operator can call, that run on a device.

A device template includes:

 -  A model that describes the capabilities a device should implement such as the telemetry it sends and the properties it reports.
 -  The cloud properties that define information about your device and which are stored by IoT Central (such as the date a device was created).
 -  The customizations that can be used to modify capabilities.
 -  The views that are used to visualize the data from the device, and forms to manage and control a device.

As a solution builder, you have several options for creating device templates:

 -  Design the device template in IoT Central and then implement its device capability model in your device code.
 -  Import a device template from the Azure Certified for IoT device catalog. Optionally, customize the device template to your requirements in IoT Central.
 -  When the device connects to IoT Central, have it send the model ID of the model it implements. IoT Central uses the model ID to retrieve the model from the model repository and to create a device template. Add any cloud properties, customizations, and views your IoT Central application needs to the device template.
 -  When the device connects to IoT Central, let IoT Central autogenerate a device template definition from the data the device sends.
 -  Author a device model using the Digital Twin Definition Language (DTDL) V2. Manually import the device model into your IoT Central application. Then add the cloud properties, customizations, and views your IoT Central application needs.

As a solution builder, you can use IoT Central to generate code for test devices to validate your device templates.

## Stay connected

IoT Central applications are fully hosted by Microsoft, which reduces the administration overhead of managing your applications.

As an operator, you use the IoT Central application to manage the devices in your IoT Central solution. Operators do tasks such as:

 -  Monitoring the devices connected to the application.
 -  Troubleshooting and remediating issues with devices.
 -  Provisioning new devices.

As a solution builder, you can define custom rules and actions that operate over data streaming from connected devices. An operator can enable or disable these rules at the device level to control and automate tasks within the application.

Administrators manage access to your application with user roles and permissions.

## Integrate with other services

As an application platform, IoT Central lets you transform your IoT data into the business insights that drive actionable outcomes. Rules, data export, and the public REST API are examples of how you can integrate IoT Central with line-of-business applications.

You can generate business insights, such as determining machine efficiency trends or predicting future energy usage on a factory floor, by building custom analytics pipelines to process telemetry from your devices and store the results. Configure data exports in your IoT Central application to export telemetry, device property changes, and device template changes to other services where you can analyze, store, and visualize the data with your preferred tools.

## Build custom IoT solutions and integrations with the REST APIs

Build IoT solutions such as:

 -  Mobile companion apps that can remotely set up and control devices.
 -  Custom integrations that enable existing line-of-business applications to interact with your IoT devices and data.
 -  Device management applications for device modeling, onboarding, management, and data access.

## Quotas

Each Azure subscription has default quotas that could impact the scope of your IoT solution. Currently, IoT Central limits the number of applications you can deploy in a subscription to 10. If you need to increase this limit, contact Microsoft support.
