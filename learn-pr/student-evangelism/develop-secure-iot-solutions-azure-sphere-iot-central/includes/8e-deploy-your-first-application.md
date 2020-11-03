In this unit you will learn how to configure and deploy you first application to your Azure Sphere


**Azure Sphere applications:** We will be running high-level and real-time applications on the Azure Sphere.

![Azure Sphere Streaming telemery to IoT Central](../media/azsure-sphere-telemetry-streaming.png)

A high-level application can:

- Configure and interact with Azure Sphere peripherals, such as the general-purpose input/output (GPIO) pins, universal asynchronous receiver/transmitters (UARTs), and other interfaces.
- Communicate with Real-time apps running on the Azure Sphere real-time cores.
- Communicate with the internet and cloud-based services.
- Broker trust relationships with other devices and services via certificate-based authentication.

## Setup overview

By the end of the module, you'll be able to view the environment telemetry in Visual Studio Code and then display the telemetry data in the cloud from the Azure IoT Central dashboard.

------

## Declaring IoT Central network endpoints

You will grant in the application rights to your Azure Sphere application so it can connect to your IoT Central application.  

------

## Hardware definitions

Azure Sphere hardware is available from multiple vendors, and each vendor may expose features of the underlying chip in different ways. Azure Sphere applications manage hardware dependencies by using hardware definition files. For further information, review the [Managing target hardware dependencies](https://docs.microsoft.com/azure-sphere/app-development/manage-hardware-dependencies) article.

The labs for this learning module have a set of hardware definition files for the AVNET and SEEED Studio Azure Sphere developer boards. The **azure_sphere_learning_path** hardware definition file is included in main.c for each lab.

```c
#include "hw/azure_sphere_learning_path.h"
```

You will learn how to select the hardware definition file that matches your Azure Sphere device in the following exercise.
