Welcome to the learning path about the cloud-connected Altair 8800 on Azure Sphere. In this module, you'll learn how to deploy the Altair emulator to your Azure Sphere device.

## Scenario: Deploying applications to Azure Sphere

The Azure Sphere microcontroller unit (MCU) has three developer-accessible cores: the Cortex-A7 high-level core that runs a Linux kernel, and two Cortex-M4 real-time cores. 

:::image type="content" source="../media/azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

The Altair emulator consists of two applications: one high-level Linux application and one real-time core application. The applications communicate with each other by passing messages over the intercore bridge.

The following diagram shows what applications run on the Azure Sphere MCU. The blue color indicates the A7 high-level core running the Altair emulator. The red color indicates the real-time cores running the cache and SD card services.

:::image type="content" source="../media/azure-sphere-app-architecture.png" alt-text="Diagram that shows the application architecture for Altair on Azure Sphere." border="false":::

- The *Altair emulator* high-level application is responsible for running the Altair emulator and managing communications.

  The Altair project has a dual communications stack. The built-in Azure IoT C SDK is used for communications with Azure IoT Central. The Altair emulator's stdin, stdout, and disk requests are passed over MQTT and a back-end MQTT broker.

- The *Altair disk cache service* real-time application provides cache-aside services that use a Least Recently Used eviction policy for the Altair emulator virtual file system. The Altair emulator uses the cache to improve virtual disk performance. 

  The cache-aside pattern is useful in a wide range of scenarios. For example, you could cache price look-up codes for retail solutions.

- The *Altair SD card service* real-time application provides SD card support for the Altair emulator for the Avnet Azure Sphere Starter Kit with the MikroE microSD Click. The MikroE microSD Click must be plugged into socket 1 on the Avnet Azure Sphere Starter Kit.

## What will you learn?

In this module, you'll learn about disk drive services and how to deploy the Altair emulator and services to Azure Sphere.
