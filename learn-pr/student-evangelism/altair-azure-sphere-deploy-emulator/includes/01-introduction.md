In this module, you'll learn about the architecture of the Azure Sphere and the Altair emulator. You'll also learn how to deploy the emulator to your Azure Sphere.

## Azure Sphere Architecture

The Azure Sphere microcontroller unit (MCU) has three developer-accessible cores. There is a Cortex-A7 high-level core that runs a Linux kernel and two Cortex-M4 real-time cores. The Cortex-A7 is responsible for running system services and your custom high-level application. The Cortex-M4 cores can run your custom bare-metal apps, or real-time operating systems such as Azure RTOS or FreeRTOS.

![Azure Sphere architecture.](../media/azure-sphere-architecture.png)

## The Altair emulator application architecture

The Altair emulator consists of two applications, one high-level application, and one real-time core application.

![Altair on Azure Sphere application architecture.](../media/azure-sphere-app-architecture.png)

1. The **AltairHL_emulator** high-level application is responsible for running the Altair emulator and managing communications.

    * The Altair project is a dual communications stack project. The built-in Azure IoT C SDK is used for communications with IoT Central. The Altair emulator's stdin, stdout, and disk requests are passed over MQTT and a back-end MQTT Broker.

1. The **AltairRT_disk_cache_server** real-time application.

    * The disk cache server application provides Cache-Aside services using a Least Recently Used eviction policy for the Altair emulator virtual file system. The Altair emulator uses the cache to improve remote disk performance. The cache-aside pattern is useful in a wide range of scenarios. For example, you could cache Price Look-Up codes for retail solutions.

1. The **AltairRT_sd_card_server** real-time application.

    * SD card support for the Altair emulator read/write disk drive B: is supported on the Avnet Azure Sphere **Rev 2** developer board with the MikroE microSD Click. The MikroE microSD Click must be plugged into socket 1 of the Avnet Azure Sphere Rev 2 developer board.

<!-- ## IoT Central IoT Plug and Play model

The IoT Plug and Play model for this learning module can be found in the **IoTPlugAndPlay** folder. This model has been uploaded to the public repository of IoT Plug and Play models. To learn more about IoT Plug and Play visit "[What is IoT Plug and Play](https://docs.microsoft.com/azure/iot-pnp/overview-iot-plug-and-play?azure-portal=true)".

The IoT Plug and Play model used by this learning module is declared in main.c.

```c
#define IOT_PLUG_AND_PLAY_MODEL_ID		"dtmi:com:example:azuresphere:altair;2"
```

IoT Central is an IoT Plug and Play enabled application. When your device first connects to IoT Central, the IoT Plug and Play Model ID is passed to IoT Central. IoT Central then retrieves the IoT Plug and Play model from the public repository of IoT Plug and Play models and creates a device template and default views. -->

In this module, you will:

* Learn about the architecture of Azure Sphere.
* Learn about the application architecture of the Altair emulator.
* Start the app build and deployment process.
* Understand the virtual disk cache-aside server.

## Prerequisites

* You have completed the previous module of the learning path.
* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.

In the next unit, you'll learn about the virtual disk sector cache-aside server.
