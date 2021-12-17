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

- Ability to create an IoT Central application using the web UI  
- Ability to use Azure CLI at the beginner level
- Ability to use Azure blob storage at the beginner level
- Experience using REST APIs at the beginner level
- Experience administering an IoT Central application using the web UI at the intermediate level
- Experience managing device templates and devices in an IoT central application using the web UI at the intermediate level

## Summary

Manage an IoT Central application programmatically using the REST API and Azure CLI commands. You create an IoT Central application, add device templates and devices, and configure a continuous data export to Azure blob storage.

## Learning objectives

1. Create an IoT Central application
2. Generate an API token to use to authorize REST API calls
3. Manage device templates and devices using the REST API
4. Query device telemetry and control your devices using the REST API
5. Enable integration with other services by configuring data export from your application using the REST API

## Chunk your content into subtasks

Identify the subtasks of *Manage IoT Central applications by using the REST API*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an IoT Central application | Creating an IoT Central application to manage | Exercise | 1 | No, "Generate API token" |
| Generate API token | Manage an IoT Central application programmatically using the REST API  | Exercise & Knowledge Check | 2 | No, "Create an IoT Central application" |
| Create and publish a device template | Add device templates | Exercise & Knowledge Check | 3 | No, "Add real and simulated devices" |
| Add real and simulated devices | Add devices  | Exercise & Knowledge Check | 3 | No, "Create and publish a device template" |
| Monitor and control a device | Manage an IoT Central application programmatically  | Exercise & Knowledge Check | 4 | Yes |
| Configure data export | configure a continuous data export to Azure blob storage | Exercise & Knowledge Check | 5 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're building a store analytics solution for a retail company that plans to deploy IoT devices in stores to enable environmental monitoring and control. You want to integrate common device management functions into your existing store management application. To enable this scenario, you need to access your IoT Central application programmatically using the REST API.

1. **Create an IoT Central application and generate an API token**

    List the content that will enable the learner to *Create an IoT Central application*:

    - A brief introduction to Azure IoT Central
        - What is IoT Central?
        - How does IoT Central relate to an IoT solution
    - Create and sign in to an IoT Central application
        - How to create an IoT Central application
        - What do you see when you sign in to the web UI

    List the content that will enable the learner to *Generate API token*:

    - REST API authorization
        - Why do we need to authorize
        - What is an API token
        - How can I generate an API token
    - How to authorize
        - How to use the API token in a REST API call

1. **Exercise - Create an IoT Central application and generate an API token**

    List the steps which apply the learning content from previous unit:

    - Install the `az` IoT extension
    - Use an `az` command to create an IoT Central application
    - Sign in to the IoT Central application's web UI
    - Create an API token in the IoT Central web UI
    - Use the API token in a REST API call to list the applications you have access to

1. **Knowledge check**

    What types of questions will test *Generate an API token to use to authorize REST API calls*?

    - What type of authorization does IoT Central require a REST API call to use?
    - How do you generate the authorization key?

1. **Add device templates and devices to your application programmatically**

    List the content that will enable the learner to *Create and publish a device template*:

    - An overview of device templates in IoT Central
        - Create a template
        - Import a capability model
        - Publish the template
    - How to use the REST API to manage device templates

    List the content that will enable the learner to *Add real and simulated devices*:

    - What is a device in IoT Central?
        - Devices are created from device templates
        - Devices are real or simulated
        - Real devices authenticate either with a SAS or an X.509 certificate
    - How to use the REST API to manage devices

1. **Exercise - Add device templates and devices to your application programmatically**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to add a device template
    - Use the REST API to add 3 simulated devices.
    - Use the REST API to list the devices - there are now three.
    - Use the REST API to add 3 real devices.
    - Use the REST API to list the devices - there are now six.

1. **Knowledge check**

    What types of questions will test *Manage device templates and devices using the REST API*?

    - How do you list the device templates in an IoT Central application?
    - What types of device can you create in an IoT Central application?

1. **Monitor and control your devices**

    List the content that will enable the learner to *Monitor and control a device*:

    - Device telemetry
        - Query for telemetry values sent by the device
    - Control a device
        - Set writeable properties
        - Send commands
    - How to use the REST API to monitor and control devices

1. **Exercise - Monitor and control your devices**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to retrieve the last known value of a telemetry stream from a simulated device.
    - Use the REST API to set the target temperature on a simulated device.
    - Use the REST API to send a command to a simulated device.

1. **Knowledge check**

    What types of questions will test *Query device telemetry and control your devices using the REST API*?

    - How do you invoke an action on a device such as asking it to reboot?
    - What REST API call do you use to view a telemetry value from a device?

1. **Export telemetry data from your application**

    List the content that will enable the learner to *Configure data export*:

    - Export data from IoT Central
        - What data can you export
        - Where can you send the exported data
    - How to use the REST API to manage data export

1. **Exercise - Export telemetry data from your application**

    List the steps which apply the learning content from previous unit:

    - Use `az` commands to create a storage blob container to receive exported telemetry
    - Use the REST API to configure continuous telemetry export to the blob.
    - Use an `az` command to download data from the blob to view.

1. **Knowledge check**

    What types of questions will test *Enable integration with other services by configuring data export from your application using the REST API*?

    - What types of data can you export from your IoT Central application?
    - What are valid destinations to export telemetry values to?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    You wanted to integrate common device management functions into your existing store management application. To enable this scenario, you needed to access your IoT Central application programmatically.

    Without integration, an operator would need to use both the existing store management application and the IoT Central dashboards to manage the store.

    By using the IoT Central REST API, you were able to integrate device management, device monitoring and control, and data export management capabilities into the existing store management application, simplifying the operator's job.
