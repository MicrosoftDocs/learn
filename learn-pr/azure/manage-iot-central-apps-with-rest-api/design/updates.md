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

1. Create an IoT Central application programatically
2. Generate API tokens for different users to use to authorize REST API calls
3. Manage device templates and devices using the REST API
4. Query device telemetry and control your devices using the REST API
5. Create and use jobs to perform bulk device updates
6. Query your application

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're building a fleet management solution for a logistics company that plans to deploy IoT devices in vehicles to enable monitoring and control. You want to integrate common device management functions into your existing store management application. To enable this scenario, you need to access your IoT Central application programmatically using the REST API.

1. **Create an IoT Central application and generate an API token**

    List the content that will enable the learner to *Create an IoT Central application*:

    - A brief introduction to Azure IoT Central
        - What is IoT Central?
        - How does IoT Central relate to an IoT solution
    - Introduction to control plane and data place
        - Control plane - Azure CLI and ARM SDK
        - Data plane - REST API - focus of this Learn module
    - Create and sign in to an IoT Central application
        - How to create an IoT Central application programatically
        - What do you see when you sign in to the web UI

    List the content that will enable the learner to *Generate API tokens*:

    - REST API authorization
        - Why do we need to authorize
        - What are bearer tokens and API tokens
        - How can I generate a bearer token
        - How can I generate an API token
    - How to authorize
        - How to use the API token in a REST API call

1. **Exercise - Generate a bearer token, create an IoT Central application, and generate API tokens**

    List the steps which apply the learning content from previous unit:

    - Install the `az` IoT extension
    - Use an `az` command to create a bearer token
    - Use the ARM to create an IoT Central application (control plane)
    - Sign in to the IoT Central application's web UI
    - Use REST API to generate admin and operator API tokens (data plane)
    - Use the API token in a REST API call to list the applications you have access to

1. **Knowledge check**

    What types of questions will test *Generate an API token to use to authorize REST API calls*?

    - What type of authorization does IoT Central require a REST API call to use?
    - How do you generate the authorization key?
    - Does the REST API operate on the control plane or data plane?

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
        - Add device
        - Block device
        - Unblock device

1. **Exercise - Add device templates and devices to your application programmatically**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to add a device template
    - Use the REST API to add 3 simulated devices.
    - Use the REST API to list the devices - there are now three.
    - Use the REST API to add 3 real devices.
    - Use the REST API to list the devices - there are now six.
    - Use the REST API to block a device

1. **Knowledge check**

    What types of questions will test *Manage device templates and devices using the REST API*?

    - How do you list the device templates in an IoT Central application?
    - What types of device can you create in an IoT Central application?
    - What is th impact of blocking a device?

1. **Monitor and control your devices**

    List the content that will enable the learner to *Monitor and control a device*:

    - Device telemetry
        - Query for telemetry values sent by the device
    - Control a device
        - Set writeable properties
        - Send commands
        - View command history
    - How to use the REST API to monitor and control devices

1. **Exercise - Monitor and control your devices**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to retrieve the last known value of a telemetry stream from a simulated device.
    - Use the REST API to set a writable property value on a simulated device.
    - Use the REST API to send a command to a simulated device.
    - Use the REST API to view the command history.

1. **Knowledge check**

    What types of questions will test *Query device telemetry and control your devices using the REST API*?

    - How do you invoke an action on a device such as asking it to reboot?
    - What REST API call do you use to view a telemetry value from a device?

1. **Use jobs to bulk manage your devices**

    List the content that will enable the learner to *Create and use jobs*:

    - View device groups
    - Create jobs
    - Run jobs
    - How to use the REST API to create and run jobs

1. **Exercise - Create and run a job**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to view the available device groups.
    - Use the REST API to create a job.
    - Use the REST API to run a job.
    - Use the REST API to view the job results.

1. **Knowledge check**

    What types of questions will test *Create and use jobs*?

    - How to you identify the devices to target for a job?
    - What are the options for scheduling jobs?

1. **Use queries to retrive information about your application**

    List the content that will enable the learner to *Create and run queries*:

    - What data can you query?
    - Query syntax
    - Running a query and retrieving results

1. **Exercise - Create and run a query**

    List the steps which apply the learning content from previous unit:

    - Use the REST API to create and run a query.

1. **Knowledge check**

    What types of questions will test *Create and run a query*?

    - What data can you query in IoT Central?
    - How do you process the query results?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    You wanted to integrate common device management functions into your existing fleet management application. To enable this scenario, you needed to access your IoT Central application programmatically.

    Without integration, an operator would need to use both the existing fleet management application and the IoT Central dashboards to manage the vehicle fleet.

    By using the IoT Central REST API, you were able to integrate device management, device monitoring and control, and query operations into the existing fleet management application, simplifying the operator's job.
