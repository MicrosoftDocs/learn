# Title

Manage IoT Central applications by using the REST API

## Role(s)

- Developer
- Solution architect

## Level

intermediate

## Product(s)

Azure IoT Central

## Prerequisites

- Create an IoT Central application using the web UI
- Administer an IoT Central application using the web UI
- Manage device templates and devices in an IoT Central application using the web UI

## Summary

Manage an IoT Central application programatically using the REST API and Azure CLI commands. You create an IoT Central application, add device templates and devices, and configure a continuous data export to Azure blob storage.

## Learning objectives

1. Authorize REST API calls that interact with your IoT Central application
2. Use REST API calls to view device templates and manage devices
3. Use REST API calls to query device telemetry and control your devices
4. Use REST API calls to configure data export from your application

## Chunk your content into subtasks

Identify the subtasks of *Manage IoT Central applications by using the REST API*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an IoT Central application | Creating an IoT Central application to manage | Exercise | 1 | No, "Create and publish a device template" |
| Create and publish a device template | Add device templates | Exercise | 2 | No, "Create an IoT Central application" |
| Generate SAS key | Manage an IoT Central application programatically using the REST API  | Exercise & Knowledge Check | 1 | Yes |
| Add real and simulated devices | Add devices  | Exercise & Knowledge Check | 2 | Yes |
| Manage and control a device | Manage an IoT Central application programatically  | Exercise & Knowledge Check | 3 | Yes |
| Configure data export | configure a continuous data export to Azure blob storage | Exercise & Knowledge Check | 4 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're building a store analytics solution for a retail company that plans to deploy IoT devices in stores to enable environmental monitoring and control. You want to integrate common device management functions into your existing store management application. To enable this scenario, you need to access your IoT Central application programatically using the REST API.

1. **Prepare an IoT Central application**

    List the content that will enable the learner to *Create an IoT Central application*:

    - A brief introduction to Azure IoT Central
        - What is IoT Central?
        - How does IoT Central relate to an IoT solution
    - Create and sign in to an IoT Central application
        - How to create an IoT Central application
        - What do you see when you sign in to the web UI

    List the content that will enable the learner to *Create and publish a device template*:

    - An overview of device templates in IoT Central
        - Create a template
        - Import a capability model
        - Publish the template

1. **Exercise - Prepare an IoT Central application**

    List the steps which apply the learning content from previous unit:

    - Install the `az` IoT extension
    - Use an `az` command to create an IoT Central application
    - Sign in to the IoT Central application's web UI
    - Import a device capability model to create a device template
    - Publish the device template

1. **Authorize REST API calls to access your IoT Central application**

    List the content that will enable the learner to *Generate SAS key*:

    - REST API authorization
        - Why do we need to authorize
        - What is a shared access signature (SAS)
        - How can I generate a SAS
    - How to authorize
        - How to us the SAS in a REST API call

1. **Exercise - Authorize REST API calls to access your IoT Central application**

    List the steps which apply the learning content from previous unit:

    - Create a SAS in the IoT Central web UI
    - Use the SAS in a REST API call to list device templates in the application

1. **Add devices to your application programatically**

    List the content that will enable the learner to *Add real and simulated devices*:

    - What is a device in IoT Central?
        - Devices are created from device templates
        - Devices are real or simulated
        - Real devices authenticate either with a SAS or an X.509 certificate

1. **Exercise - Add devices to your application programatically**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to list the devices - there are zero to begin with.
    - Use the REST API to add 3 simulated devices.
    - Use the REST API to list the devices - there are now three.
    - Use the REST API to add 3 real devices.
    - Use the REST API to list the devices - there are now six.

1. **Manage and control your devices**

    List the content that will enable the learner to *Manage and control a device*:

    - Device telemetry
        - Query for telemetry values sent by the device
    - Control a device
        - Set writeable properties
        - Send commands

1. **Exercise - Manage and control your devices**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to retrieve the last known value of a telemetry stream from a simulated device.
    - Use the REST API to set the target temperature on a simulated device.
    - Use the REST API to send a command to a simulated device.

1. **Export telemetry data from your application**

    List the content that will enable the learner to *Configure data export*:

    - Export data from IoT Central
        - What data can you export
        - Where can you send the exported data

1. **Exercise - Export telemetry data from your application**

    List the steps which apply the learning content from previous unit:

    - Use `az` commands to create a storage blob container to receive exported telemetry
    - Use the REST API to configure continuous telemetry export to the blob.
    - Use an `az` command to download data from the blob to view.

1. **Knowledge check**

    What types of questions will test *Authorize REST API calls that interact with your IoT Central application*?

    - What type of authorization does IoT Central require a REST API call to use?
    - How do you generate the authorization key?

    What types of questions will test *Use REST API calls to view device templates and manage devices*?

    - How do you list the device templates in an IoT Central application?
    - What types of device can you create in an IoT Central application?

    What types of questions will test *Use REST API calls to query device telemetry and control your devices*?

    - How do you invoke an action on a device such as asking it to reboot?
    - What REST API call do you use to view a telemetry value from a device?

    What types of questions will test *Use REST API calls to configure data export from your application*?

    - What types of data can you export from your IoT Central application?
    - What are valid destinations to export telemetry values to?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    You wanted to integrate common device management functions into your existing store management application. To enable this scenario, you needed to access your IoT Central application programatically.

    Without integration, an operator would need to use both the existing store management application and the IoT Central dashboards to manage the store.

    By using the IoT Central REST API, you were able to integrate key device management capabilities into the existing management application, simplifying the operator's job.
