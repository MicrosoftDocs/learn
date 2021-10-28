The core of the system is the Open Source Intel 8080 CPU emulator that runs compiled Intel 8080 binaries. Layered on the emulator is Altair BASIC and the CP/M operating system. On CP/M, three languages are available: BASIC, C, and Assembly.

- The solution integrates several Azure cloud services including:
  - Azure IoT Central to configure the Altair emulator and reporting.
  - An Azure Static Web App for the Altair Web Terminal
  - An Azure Virtual Machine. The virtual machine runs the virtual disk and MQTT broker services.

:::image type="content" source="../media/altair-azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

- The Altair emulator running on the Azure Sphere is accessible via a web browser-based terminal.

- The Altair emulator runs on the Azure Sphere Cortex A7. Depending on your hardware configuration, a virtual disk cache or SD Card server is running on one of the real-time Cortex M4 cores.

## The Altair emulator application architecture

The Altair emulator consists of two applications, one high-level application, and one real-time core application.

:::image type="content" source="../media/azure-sphere-app-architecture.png" alt-text="Diagram that shows the Altair on Azure Sphere application architecture." border="false":::

- The **Altair emulator** high-level application is responsible for running the Altair emulator and managing communications.

  - The Altair project is a dual communications stack project. The built-in Azure IoT C SDK is used for communications with IoT Central. The Altair emulator's stdin, stdout, and disk requests are passed over MQTT and a back-end MQTT broker.

- The **Altair disk cache service** real-time application.

  - The disk cache service application provides Cache-Aside services using a Least Recently Used eviction policy for the Altair emulator virtual file system. The Altair emulator uses the cache to improve virtual disk performance. The cache-aside pattern is useful in a wide range of scenarios. For example, you could cache Price Look-Up codes for retail solutions.

- The **Altair SD Card service** real-time application.

  - SD card support for the Altair emulator for the Avnet Azure Sphere Starter Kits with the MikroE microSD Click. The MikroE microSD Click must be plugged into socket 1 on the Avnet Azure Sphere Starter Kit.

## Altair Web Terminal

The cloud-connected Altair on Azure Sphere project connects to the Web Terminal by redirecting standard input and output over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true).

The Web Terminal is an HTML/CSS/JavaScript application built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries.

:::image type="content" source="../media/altair-web-terminal.png" alt-text="Diagram that shows the architecture of the MQTT-based Altair Web Terminal." border="false":::

## Altair Web Terminal Azure Static Web Apps

The Altair Web Terminal is implemented as an [Azure Static Web App](/azure/static-web-apps?azure-portal=true).

In the following exercise, you'll learn how to deploy the Altair Web Terminal Static Web App.

## Altair virtual disk cache

Applications running on CP/M will have read/write access to drive B: enabling you can save files when the virtual disk server running. The virtual disk server can run on your desktop, or in a cloud-based Azure Virtual Machine.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram that shows the Altair Web Terminal architecture." border="false":::

Drive B: disk sector reads and writes are sent over MQTT to the Python-based virtual disk server. The disk sector **Cache-aside** cache is used to improve the performance of the virtual drive.
