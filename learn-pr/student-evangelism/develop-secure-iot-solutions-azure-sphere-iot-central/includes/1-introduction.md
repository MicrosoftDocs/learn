Building and running an application on microcontroller IoT devices can be challenging. These challenges could range from ease of development to securely capturing and transferring the data to a server.

With Azure Sphere, you can build IoT solutions that are secure by default with the confidence that your device is protected, your application is protected, and data is protected in transit.

You can build applications with Visual Studio, Visual Studio Code, or integrate with your existing toolchains on Windows and Linux. Visual Studio and Visual Studio Code development environments provide integrated microcontroller debuggers, full source code control, along with collaboration and productivity tools.

## Measuring the environment

Suppose you're a scientist in a microbiology laboratory who is responsible for storing samples from tests. You want to build a system that monitors the environment around the laboratory equipment in real time. This system would monitor the following room conditions:

- Pressure
- Light
- Temperature
- Humidity

Previously these were recorded manually by the lab assistants using sensors at regular intervals. Manual recording of ambient conditions is a tedious job which is also prone to human error. Having any issues with the sensors would invalidate the tests performed in the Lab environment.

Maintaining the room conditions accurately is critical for managing the laboratory. The lab needs to maintain the right conditions to help you get more accurate results. Any variation in the conditions can affect the equipment temperature during the storage and manipulation of the samples, specimens, and lab equipment. This could impact the ability to produce the correct and stable results and can also have an economic impact on the organization.

## Proposed new system

The proposed new system would have need to have the following factors:

- It would need the sensors within the lab at multiple points.
- These sensors will automate the reading of air pressure, temperature, humidity, and light conditions at defined intervals.
- The sensor data from the devices will be transmitted securely for the analysis of data trends.

This solution will thus provide a platform to create secure IoT solutions without worrying about the underlying security vulnerabilities. Additionally, the system can trigger an alarm or alert message to concerned authority when any of the defined variables drops below a specific threshold range.

![The illustration shows Azure Sphere dashboard based on scenario.](../media/azure-sphere-dashboard.png)

## Learning objectives

In this module, you will:

- Create an IoT Central Application
- Configure your Azure Sphere application to IoT Central
- Build and deploy the Azure Sphere application
- Display the environment telemetry in the IoT Central Dashboard
- Control an Azure Sphere application using Azure IoT Central properties and commands

## Prerequisites

- Azure Sphere kit
- Visual Studio Code installed in your computer
- Ability to use Visual Studio Code
- Git installed in your computer
- Ability to use Git/Github
- Basic knowledge of Azure Sphere
- Basic knowledge of Azure IoT
