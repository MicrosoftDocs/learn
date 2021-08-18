In this module, you will learn how to deploy your own private MQTT Broker.

So far, you have been using the public **test.mosquitto.org** broker. The downside of using the public broker include:

* All data from the Altair emulator, Web Terminal, and Virtual Disk Server is publicly viewable on the MQTT Broker.
* The MQTT broker performance varies depending on the number of devices connected and the volume of MQTT messages routed. These factors will impact the performance and reliability of the Altair emulator

The advantages of running an MQTT broker in a virtual machine include:

* Private, secure, reliable and predictable performance.
* You can run the virtual disk server on the same virtual machine. The Altair virtual disk drive B: will be faster when the virtual disk server is installed on the same computer as the MQTT broker as it eliminates a network round trip.

In this module, you'll learn how to:

## Prerequisites

Add a list or write None.