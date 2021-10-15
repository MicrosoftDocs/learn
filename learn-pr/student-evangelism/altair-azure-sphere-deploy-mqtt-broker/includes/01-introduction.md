Welcome to the cloud-connected Altair 8800 on Azure Sphere learning path. In this module, you'll learn how to deploy your own private MQTT broker.

## Scenario: Privacy

So far, you have been using the public **test.mosquitto.org** MQTT broker for the Altair emulator. The disadvantages of using the public broker include:

* All data from the Altair emulator, Web Terminal, and Virtual Disk Server is publicly viewable on the MQTT broker.
* The MQTT broker performance varies depending on the number of devices that are connected and the volume of MQTT messages being routed. These factors will affect the performance and reliability of the Altair emulator

The advantages of running an MQTT broker in a virtual machine include:

* Private, secure, reliable, and predictable performance.
* You can run the virtual disk server on the same virtual machine. The Altair virtual disk drive B: will be faster when the virtual disk server is installed on the same computer as the MQTT broker as it eliminates a network round trip.

## What will you learn?

In this module, you'll learn how to install and secure your own MQTT broker running in an Azure Virtual Machine.

## What is the main goal?

This module will focus on installing and securing an MQTT broker running in a cloud based Azure Virtual Machine.

