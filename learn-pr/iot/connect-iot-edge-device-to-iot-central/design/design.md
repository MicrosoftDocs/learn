# Title

Connect an IoT Edge device to your IoT Central application

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
- Ability to use Azure virtual machines at the beginner level
- Experience using IoT Edge at the beginner level
- Experience administering an IoT Central application using the web UI at the intermediate level
- Experience managing device templates and devices in an IoT central application using the web UI at the intermediate level

## Summary

Connect an IoT Edge device to your IoT Central application and then interact with the device using the IoT Central web UI. You run the IoT Edge modules in an Azure Linux virtual machine to verify the behavior of the solution.

## Learning objectives

1. Understand the IoT Edge application pattern.
2. Learn how to create an IoT Edge device template in IoT Central.
3. Learn how to deploy a virtual machine preconfigured with IoT Edge.
4. Learn how to manage an IoT Edge device from IoT Central.
5. Learn how to deploy an Azure Function to your IoT Edge device.

## Chunk your content into subtasks

Identify the subtasks of *Connect an IoT Edge device to your IoT Central application*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an IoT Central application | Creating the IoT Central application to manage the IoT Edge device | Exercise & Knowledge Check | 1 | No |
| Add an IoT Edge device template | Deploying an IoT Edge device  | Exercise & Knowledge Check | 2 | No, "Create an IoT Central application" |
| Add dashboards to the device template | Enabling environmental monitoring & control  | Exercise & Knowledge Check | 2 | No, "Create an IoT Central application" |
| Publish the device template | Enabling environmental monitoring & control  | Exercise & Knowledge Check | 2 | No, "Create an IoT Central application" |
| Add a device to your IoT Central application | Deploying devices  | Exercise & Knowledge Check | 3 | No, "Create and publish a device template" |
| Deploy an IoT Edge enabled Linux VM  | Deploying devices | Exercise & Knowledge Check | 3 | No |
| View telemetry from the device | Enabling environmental monitoring & control  | Exercise & Knowledge Check | 4 | No, "Deploy an IoT Edge enabled Linux VM" |
| View device properties | Enabling environmental monitoring & control  | Exercise & Knowledge Check | 4 | No, "Deploy an IoT Edge enabled Linux VM" |
| Call device commands | Enabling environmental monitoring & control  | Exercise & Knowledge Check | 4 | No, "View telemetry from the device" |
| Deploy an Azure Function to the IoT Edge device | Filter data on the edge | Exercise & Knowledge Check | 5 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're building a store analytics solution for a retail company that plans to deploy IoT devices in stores to enable environmental monitoring and control. In each store you want to deploy a single, internet-connected, IoT Edge device that forwards data from multiple local sensors to your IoT Central application. You want to use the IoT Edge device to filter data from the sensors before the data is sent to IoT Central.

1. **Implement the IoT application with IoT Edge pattern**

    List the content that will enable the learner to *Implement the IoT application with IoT Edge pattern*:

    - IoT application pattern with IoT Edge
    - Create an IoT Central application
    - Add an IoT Edge device template to the application
    - Add views to the template
    - Publish the template
    - Create a device from the template

1. **Exercise - Create an IoT Central application**

    List the steps that apply the learning content from previous unit:

    - Install the `az` IoT extension
    - Use an `az` command to create an IoT Central application
    - Sign in to the IoT Central application's web UI
    - Create a device template by importing a deployment manifest
    - Add telemetry and properties to the template
    - Add a view to the template
    - Publish the template
    - Use an `az` command to add a device

1. **Knowledge check**

    What types of questions will test *Create an IoT Central application*?

    - What is the role of the deployment manifest?
    - What do you need to add to the template after importing a deployment manifest?

1. **Deploy an IoT Edge enabled Linux VM**

    List the content that will enable the learner to *Deploy an IoT Edge enabled Linux VM*:

    - An overview of IoT Edge
        - Docker
        - Modules
        - Deployment manifests
    - Does using a Linux VM facilitate end-to-end testing for IoT Edge
    - How to deploy IoT Edge to a Linux VM
    - How to interact with the IoT Edge device from IoT Central

    List the content that will enable the learner to *Add real and simulated devices*:

1. **Exercise - Deploy a IoT Edge device and manage and control it from IoT Central**

    List the steps that apply the learning content from previous unit:

    - Use the Azure Resource Manager template and script to deploy the IoT Edge device
    - View the running modules in IoT Central
    - View the telemetry in IoT Central
    - Set a property in IoT Central
    - Call a command from IoT Central

1. **Knowledge check**

    What types of questions will test *Deploy an IoT Edge enabled Linux VM*?

    - How does the IoT Edge device connect to IoT Central?
    - How can you view the status of the IoT Edge modules?

1. **Use an Azure Function to filter data at the edge**

    List the content that will enable the learner to *Use an Azure Function to filter data at the edge*:

    - Overview of Azure functions
    - Role of Azure functions in IoT Edge
    - How to deploy an Azure function to IoT Edge

1. **Exercise - Deploy an Azure Function to IoT Edge**

    List the steps that apply the learning content from previous unit:

    - Create an Azure function that filters telemetry
    - Create an IoT Edge module to package the function
    - Version your deployment manifest
    - Deploy the module to your IoT Edge device
    - Observe the change in telemetry in IoT Central

1. **Knowledge check**

    What types of questions will test *Deploy and Azure Function to IoT Edge*?

    - What's the benefit of running an Azure Function at the Edge as opposed to in the cloud?
    - What do you need to configure in the deployment manifest when you add a new module?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    You're building a store analytics solution for a retail company that plans to deploy IoT devices in stores to enable environmental monitoring and control. In each store you want to deploy a single, internet-connected, IoT Edge device that forwards data from multiple local sensors to your IoT Central application. You want to use the IoT Edge device to filter data from the sensors before the data is sent to IoT Central.

    You wanted to deploy a single, internet-connected, device in each store that forwards data from multiple local sensors to your IoT Central application. To enable this scenario, you needed use IoT Edge in the device.

    Without IoT Edge, you would have needed multiple internet-connected devices in each store that would have made the solution more costly and complex.

    You also wanted to reduce the amount of data sent from each store. By using an Azure Function deployed on the IoT Edge device, you implement local filtering.

    By using the IoT Central and IoT Edge, you were able to create a solution with a simpler and less costly infrastructure.
