In this unit, you'll learn how certificates help secure the connection to an MQTT broker.

## Understand the Altair emulator communications architecture

The Altair emulator connects to the web terminal by redirecting the keyboard and terminal over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true).

The web terminal is an HTML/CSS/JavaScript application that's built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries.

:::image type="content" source="../media/altair-web-terminal.png" alt-text="Diagram of the architecture of the Altair 8800 emulator on Azure Sphere." border="false":::

## Generate MQTT broker certificates

By default, the Altair emulator uses the public test.mosquitto.org MQTT broker. The Altair emulator communicates with the MQTT broker over a secure encrypted connection by using the wolfSSL library that's included with Azure Sphere.

You'll generate certificates that the MQTT client will use to sign and encrypt the traffic between Azure Sphere and the MQTT broker.

In this process, your MQTT messages are encrypted, but your data is visible on the *test.mosquitto.org* broker. Later, you'll learn how to create and secure your own Mosquitto MQTT broker.

