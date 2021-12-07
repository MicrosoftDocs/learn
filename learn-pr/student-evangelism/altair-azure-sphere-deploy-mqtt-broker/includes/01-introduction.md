Welcome to the learning path about the cloud-connected Altair 8800 on Azure Sphere. In this module, you'll learn how to deploy your own private MQTT broker.

## Scenario: Privacy

So far, you've been using the public *test.mosquitto.org* MQTT broker for the Altair emulator. The disadvantages of using the public broker include:

* All data from the Altair emulator, web terminal, and virtual disk server is publicly viewable on the MQTT broker.
* The MQTT broker's performance varies depending on the number of connected devices and the volume of routed MQTT messages. These factors will affect the performance and reliability of the Altair emulator.

The advantages of running an MQTT broker on a virtual machine include:

* It offers enhanced privacy, security, and reliability, along with predictable performance.
* You can run the virtual disk server on the same virtual machine. Altair virtual disk drive B is faster when the virtual disk server is installed on the same computer as the MQTT broker, because it eliminates a network round trip.

## What will you learn?

In this module, you'll learn how to install and help secure an MQTT broker running on a cloud-based Azure virtual machine.
