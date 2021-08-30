In this module, you'll learn how to configure IoT Central, create the Altair Web Terminal, and run the Altair virtual disk server.

## Configure IoT Central

When your Altair emulator connects to IoT Central, you can set several properties, including startup CPU State and LED brightness. You also can report memory usage and environment data.

> [!div class="mx-imgBorder"]
> ![The illustration shows the IoT Central properties view of the Altair emulator.](../media/iot-central-view-properties.png)

From IoT Central, you can monitor the current state of the Altair emulator including how well the virtual disk cache is working.

> [!div class="mx-imgBorder"]
> ![The illustration shows the IoT Central about view of the Altair emulator.](../media/iot-central-view-about.png)

## Create the Altair Web Terminal

The Altair emulator redirects keyboard and terminal messages over MQTT, via an MQTT broker to the MQTT enabled web terminal. The Altair web terminal is how you'll connect to the Altair emulator.

The following image shows connecting to the Altair emulator from a web browser.

> [!div class="mx-imgBorder"]
> ![The illustration shows the Altair web terminal connecting to the Altair emulator.](../media/web-terminal-connect.png)

## Run the Altair virtual disk server

If you don't have the MikroE microSD Click, then you can run the virtual disk server for read/write storage for your CP/M applications. The virtual disk server can run on your desktop or in a cloud-based Azure Virtual Machine.

Drive B: disk sector reads and writes are redirected over MQTT to an MQTT enabled Python-based virtual disk server. Drive B: disk sectors are also cached on one of the real-time cores. Caching significantly improves read/write performance.

![Altair virtual disk Architecture ](../media/altair-azure-sphere-disk-cache-server.png)

Disk reads work as follows:

1. The Altair emulator first checks if the disk sector is available from the disk sector cache.
1. If the disk sector is found in the cache, then the sector is returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector is not found in the cache, then the sector is requested from the virtual disk server.
1. When the virtual disk server returns the disk sector, it is added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

In this module, you will:

* Set up IoT Central to run with the Altair 8800 emulator.
* Customize the Altair emulator in an Azure Sphere template.
* Create an Altair Web Terminal as an Azure static web app.
* Install and run the Altair Python virtual disk server.

## Prerequisites

* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.
* An Azure Account. Sign up for a free [Student Azure account](https://azure.microsoft.com/free/students?azure-portal=true), or free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to customize an IoT Central application for the Altair emulator.
