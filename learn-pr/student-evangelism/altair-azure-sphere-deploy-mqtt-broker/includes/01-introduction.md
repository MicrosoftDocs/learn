In this module, you'll learn how to deploy your own private MQTT Broker.

So far, you have been using the public **test.mosquitto.org** broker. The disadvantages of using the public broker include:

* All data from the Altair emulator, Web Terminal, and Virtual Disk Server is publicly viewable on the MQTT Broker.
* The MQTT broker performance varies depending on the number of devices that are connected and the volume of MQTT messages being routed. These factors will affect the performance and reliability of the Altair emulator

The advantages of running an MQTT broker in a virtual machine include:

* Private, secure, reliable, and predictable performance.
* You can run the virtual disk server on the same virtual machine. The Altair virtual disk drive B: will be faster when the virtual disk server is installed on the same computer as the MQTT broker as it eliminates a network round trip.

In this module, you will:

* Create an Ubuntu virtual server.
* Install and secure Mosquitto MQTT Broker.
* Install Let's Encrypt to provide CA certificate authentication.
* Run the Python virtual disk server in the virtual machine.

## Prerequisites

* You have completed the previous module of the learning path.
* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.
* An Azure Account. Sign up for a free [Student Azure account](https://azure.microsoft.com/free/students?azure-portal=true), or free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to deploy your own private MQTT Broker.
