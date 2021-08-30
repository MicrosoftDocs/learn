In this module, you're going to learn about the supported Altair 8800 emulator hardware configurations and how to set up the Azure Sphere development environment.

## Hardware requirements

There are three supported configurations for the Altair emulator on the Azure Sphere.

## Standalone Azure Sphere

Either an Avnet or Seeed Studio Azure Sphere.

| Seeed Studio Azure Sphere Developer Kit     | Avnet Azure Sphere Starter Kit Rev 1 or Rev 2    |
|----------------|---------------|
| ![Seeed Studio Azure Sphere](../media/seeed-studio-azure-sphere-rdb.png) | ![Avnet Azure Sphere](../media/avnet-azure-sphere.png) |

### Avnet Azure Sphere plus MikroE 8800 Retro Click and microSD Card

An Avnet Azure Sphere Starter Kit with the [MikroE 8800 Retro Click](https://www.mikroe.com/8800-retro-click?azure-portal=true) and [MikroE microSD Card Click](https://www.mikroe.com/microsd-click?azure-portal=true).

![Avnet Azure Sphere plus MikroE Click panel and MikroE microSD Card.](../media/avnet-azure-sphere-rev-2-microSD-click.png)

### Altair front panel

The Seeed Studio or Avnet with the Altair Front Panel. Full details for building and wiring the Altair front panel can be found on the [Altair 8800 Hardware repo](https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.Hardware?azure-portal=true).

![Avnet Azure Sphere with the Altair front panel.](../media/avnet-front-panel.png)

![Seeed Studio Azure Sphere with the Altair front panel.](../media/altair-front-panel.png)

## Software requirements

There are five components to the cloud-connected Altair on Azure Sphere solution. The components are:

1. The Altair emulator running on the Azure Sphere.
2. An IoT Central application for configuration and reporting.
3. The Web Terminal Azure Static Website.
4. The Virtual disk server.
5. And optionally, a private MQTT Broker.

In this module, you will:

* Learn the hardware and software requirements for the Altair 8800 emulator.
* Learn about the five components to a cloud-connected Altair on Azure Sphere solution.
* Install and configure the components.

## Prerequisites

* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.
* An Azure Account. Sign up for a free [Student Azure account](https://azure.microsoft.com/free/students?azure-portal=true), or free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to install the required software and deploy the Altair 8800 emulator to your Azure Sphere.
