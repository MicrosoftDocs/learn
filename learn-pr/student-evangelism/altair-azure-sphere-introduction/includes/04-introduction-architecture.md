The core of the cloud-connected system is the open-source Intel 8080 CPU emulator that runs compiled Intel 8080 binaries. Layered on the emulator is Altair BASIC and the CP/M operating system. On CP/M, three languages are available: BASIC, C, and Assembly.

The solution integrates several Azure cloud services, including:
  - Azure IoT Central to configure the Altair emulator and reporting.
  - An Azure static web app for the Altair web terminal.
  - An Azure virtual machine. The virtual machine runs the virtual disk and MQTT broker services.

:::image type="content" source="../media/altair-azure-sphere-architecture.jpg" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

The Altair emulator running on Azure Sphere is accessible via a browser-based terminal.

The Altair emulator runs on the Azure Sphere Cortex-A7. Depending on your hardware configuration, either a virtual disk cache or an SD card server runs on one of the real-time Cortex-M4 cores.

## The Altair emulator application architecture

The Altair emulator consists of two applications: one high-level application and one real-time core application.

:::image type="content" source="../media/azure-sphere-app-architecture.jpg" alt-text="Diagram that shows the application architecture of Altair on Azure Sphere." border="false":::

- The *Altair emulator* high-level application is responsible for running the Altair emulator and managing communications. The Altair project is a dual-communications stack project. The built-in Azure IoT C SDK is used for communications with Azure IoT Central. The Altair emulator's stdin, stdout, and disk requests are passed over MQTT and a back-end MQTT broker.

- The *Altair disk cache service* real-time application provides cache-aside services that use a Least Recently Used eviction policy for the Altair emulator virtual file system. The Altair emulator uses the cache to improve virtual disk performance. The cache-aside pattern is useful in a wide range of scenarios. For example, you could cache price look-up codes for retail solutions.

- The *Altair SD card service* real-time application provides SD card support for the Altair emulator for the Avnet Azure Sphere Starter Kits with MikroE microSD Click. MikroE microSD Click must be plugged into socket 1 on the Avnet Azure Sphere Starter Kit.

## Altair web terminal

The cloud-connected Altair on Azure Sphere project connects to the web terminal by redirecting standard input and output over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true).

The web terminal is an HTML/CSS/JavaScript application built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries.

:::image type="content" source="../media/altair-web-terminal.jpg" alt-text="Diagram that shows the architecture of the MQTT-based Altair web terminal." border="false":::

The Altair web terminal is implemented as an [Azure static web app](/azure/static-web-apps?azure-portal=true).

## Altair virtual disk cache

Applications that run on CP/M will have read/write access to drive B. This access enables you to save files when the virtual disk server is running. The virtual disk server can run on your desktop or in a cloud-based Azure virtual machine.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.jpg" alt-text="Diagram that shows the Altair web terminal architecture." border="false":::

Drive B disk-sector reads and writes are sent over MQTT to the Python-based virtual disk server. The disk sector cache-aside cache is used to improve the performance of the virtual drive.
