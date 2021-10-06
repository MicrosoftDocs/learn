Welcome to the cloud-connected Altair 8800 on Azure Sphere learning path. In this module, you'll learn how to deploy the Altair emulator to your Azure Sphere.

## Scenario: Deploying applications to Azure Sphere

As a reminder, the Azure Sphere microcontroller unit (MCU) has three developer-accessible cores. The Cortex-A7 high-level core, that runs a Linux kernel, and two Cortex-M4 real-time cores. 

:::image type="content" source="../media/azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

The Altair emulator consists of two applications, one high-level Linux application, and one real-time core application. The applications communicate with each other by passing messages over the inter-core bridge.

The following diagram shows what applications will be running on the Azure Sphere MCU. The blue color indicates the A7 high-level core running the Altair emulator, the red color indicates the real-time cores running the cache and SD Card services.

:::image type="content" source="../media/azure-sphere-app-architecture.png" alt-text="Diagram that shows the Altair on Azure Sphere application architecture." border="false":::

- The **Altair emulator** high-level application is responsible for running the Altair emulator and managing communications.

  - The Altair project is a dual communications stack project. The built-in Azure IoT C SDK is used for communications with IoT Central. The Altair emulator's stdin, stdout, and disk requests are passed over MQTT and a back-end MQTT broker.

- The **Altair disk cache service** real-time application.

  - The disk cache service application provides Cache-Aside services using a Least Recently Used eviction policy for the Altair emulator virtual file system. The Altair emulator uses the cache to improve virtual disk performance. The cache-aside pattern is useful in a wide range of scenarios. For example, you could cache Price Look-Up codes for retail solutions.

- The **Altair SD Card service** real-time application.

  - SD card support for the Altair emulator for the Avnet Azure Sphere Starter Kits with the MikroE microSD Click. The MikroE microSD Click must be plugged into socket 1 on the Avnet Azure Sphere Starter Kit.

## What will you learn?

In this module, you'll learn about disk drive services and how to deploy the Altair emulator and services to your Azure Sphere.

## What is the main goal?

This module will focus on configuring and deploying the Altair emulator and services to your Azure Sphere.
