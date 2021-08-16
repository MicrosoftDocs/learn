In this unit, you will learn about the virtual disk server.

## Starting the Virtual Disk Server

Applications running on CP/M will have read/write access to drive B: enabling you can save files with the virtual disk server running. The virtual disk server can run on your desktop, or in a cloud-based Azure Virtual Machine.

Disk sectors reads and writes for drive B: are redirected over MQTT via the Mosquitto MQTT Broker to a Python-based virtual disk server. Disk sectors are also cached on one of the real-time cores to significantly improve read/write performance on the Altair emulator.

![Altair Web Terminal Architecture ](../media/altair-on-azure-sphere-disk-cache-server.png)

In the following exercise, we will learn how to:

1. Install the virtual disk server.
1. Run the virtual disk server.

In the following exercise, you will install and run the Altair emulator virtual disk server.
