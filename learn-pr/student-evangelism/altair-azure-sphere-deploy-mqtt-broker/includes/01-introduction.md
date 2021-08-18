In this module, you will learn how to deploy your own private MQTT Broker.
So far, you have been using the public **test.mosquitto.org** broker. The downside of using the public broker include:
1. All data from the Altair emulator, Web Terminal, and Virtual Disk Server is publicly viewable on the MQTT Broker.
1. The MQTT broker performance varies depending on the number of devices connected and the volume of MQTT messages routed. These factors will impact the performance and reliability of the Altair emulator

The advantages of running an MQTT broker in a virtual machine include:
1. Private, secure, reliable and predictable performance.
1. You can run the virtual disk server on the same virtual machine. The Altair virtual disk drive B: will be faster when the virtual disk server is installed on the same computer as the MQTT broker as it eliminates a network round trip.

In the following unit, you will learn how to install the Mosquitto Broker.