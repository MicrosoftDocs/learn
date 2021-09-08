In this module, you'll learn how to secure the Altair emulator network communications. 

Azure Sphere is secure by design and applications running on Azure Sphere are secure by default. You  grant capabilities to the application. Granting capabilities is key to Azure Sphere security and is also known as the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege?azure-portal=true). You grant only the capabilities that the Azure Sphere application needs to run correctly, and no more.

You must declare all network endpoints, peripherals, and inter-core communications the Altair emulator will be using in the **Capabilities** section of the project **app_manifest.json** file. Any attempt by an Azure Sphere application to connect to resources not declared in the Capabilities section will fail.

The Altair emulator connects to two cloud services. IoT Central for configuration and reporting, and an [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) broker. The MQTT broker is used to relay messages between the Altair emulator, the Web Terminal, and the virtual disk server.

In this module, you will:

* Declare the network endpoints for the Altair emulator.
* Get connection information for Azure IoT Central.
* Secure communications to the test.mosquitto.org MQTT broker.

## Prerequisites

* A computer with an x86-64-based processor running one of the following operating systems:
  * Windows 10 Anniversary Update or later
  * 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS
* An Azure Sphere developer board that has one of the following kits:
  * Avnet Azure Sphere Starter Kit Rev 1 or 2
  * Seeed Studio Azure Sphere MT3620 Development Kit
* A GitHub account.
* An Azure account. Sign up for a free [Azure for Students account](https://azure.microsoft.com/free/students?azure-portal=true) or a free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to declare the network endpoints required by the Altair emulator.
