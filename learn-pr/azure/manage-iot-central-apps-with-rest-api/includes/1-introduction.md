The extensibility surface enabled by the IoT Central REST API lets you integrate IoT insights and device management capabilities into your existing dashboards and business applications.

Suppose you work as an IoT solution developer for a logistics company. The company has an existing fleet management application that fleet managers use to view information such as vehicle locations and the temperature of the vehicle contents. The company plans to deploy IoT devices in vehicles to enable remote environmental monitoring and control using IoT Central. You've been asked to integrate device management and control functions into the existing fleet management application so that fleet managers can continue to use a single application. To enable this scenario, you need to access the IoT Central application programmatically.

In this module, you'll generate authorization tokens with different permission sets to enable access to the IoT Central application using a REST API. You'll then use the REST API to add and list devices in the application, set device properties and send commands to devices, query device telemetry, and create and run jobs to manage devices in bulk. This module uses command-line tools to call the REST API and show the parameters and payloads you need to send.

The IoT Central REST API operations are *data plane* operations. You use the data plane to use capabilities that your IoT Central application exposes such as managing devices and device templates.

You use the *control plane* to manage resources in your Azure subscription. For example, you can use the [Azure CLI for Azure IoT](/cli/azure/azure-cli-reference-for-iot) for control plane operations such as creating an IoT Central application.

The IoT Central REST API is now generally available, but some specific APIs are still in public preview. This module highlights any uses of preview APIs.

By the end of this module, you'll be able to use the REST API data plane operations to manage and control devices connected to your IoT Central application. You'll also be able to use the REST API to configure and run jobs to bulk-manage your devices.

## Learning objectives

In this module, you:

- Create an IoT Central application programmatically
- Generate API tokens for different users to use to authorize REST API calls
- Manage device templates and devices using the REST API
- Query device telemetry and control your devices using the REST API
- Create and use jobs to perform bulk device updates

## Prerequisites

- Ability to create an IoT Central application using the web UI  
- Ability to use Azure CLI at the beginner level
- Experience using REST APIs at the beginner level
- Experience administering an IoT Central application using the web UI at the intermediate level
- Experience managing device templates and devices in an IoT central application using the web UI at the intermediate level
