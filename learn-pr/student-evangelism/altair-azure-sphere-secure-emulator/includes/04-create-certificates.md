In this unit, you will learn how to create the certificates required to secure the communications to the test.mosquitto.org MQTT broker.

## Understanding the Altair on Azure Sphere communications architecture

The cloud-enabled Altair on Azure Sphere project connects to the Web Terminal by redirecting standard input and output over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true). The Web Terminal is an HTML/CSS/JavaScript application built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries.

By default, the solution uses the publicly available **test.mosquitto.org** broker. The Altair on Azure Sphere MQTT client communicates with the broker over TLS using the wolfSSL library included with the Azure Sphere.

:::image type="content" source="../media/altair-web-terminal.png" alt-text="The illustration shows the architecture of the web terminal.":::

## Generator MQTT Broker certificates

You need to generate the certificates the MQTT client will use to sign and encrypt the traffic between the Azure Sphere and the MQTT Broker.

It is important to appreciate that even though the MQTT traffic is encrypted over the internet your data is publicly viewable on the *test.mosquitto.org* broker. You will learn later how to create and secure your own private Mosquitto MQTT Broker.

In the next exercise, you will learn how to generate the MQTT client certificates for the test.mosquitto.org MQTT Broker.
