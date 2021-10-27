In this unit, you'll learn how to create certificates to secure the connection to an MQTT broker.

## Understanding the Altair emulator communications architecture

The Altair emulator connects to the Web Terminal by redirecting the keyboard and terminal over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true).

The Web Terminal is an HTML/CSS/JavaScript application built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries.

:::image type="content" source="../media/altair-web-terminal.png" alt-text="Diagram that shows the architecture of the web terminal." border="false":::

## Generator MQTT broker certificates

By default, the Altair emulator uses the public **test.mosquitto.org** MQTT broker. The Altair emulator communicates with the MQTT broker over a secure encrypted connection using the wolfSSL library included with Azure Sphere.

You'll generate certificates the MQTT client will use to sign and encrypt the traffic between the Azure Sphere and the MQTT broker.

Note, your MQTT messages are encrypted, but your data will be visible on the *test.mosquitto.org* broker. Later, you'll learn how to create and secure your own Mosquitto MQTT broker.

