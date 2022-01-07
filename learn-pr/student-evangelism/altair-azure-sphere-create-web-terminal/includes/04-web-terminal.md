This unit describes the Altair web terminal architecture.

## Web terminal architecture

The cloud-connected Altair on Azure Sphere project connects to a web terminal by redirecting standard input and output over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true). 

A web terminal is an HTML/CSS/JavaScript application that's built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries. The Altair web terminal is built on [Azure Static Web Apps](/azure/static-web-apps?azure-portal=true).

:::image type="content" source="../media/altair-web-terminal.png" alt-text="Diagram of the architecture of the MQTT-based Altair web terminal." border="false":::

## The Altair web terminal

You'll be able to connect to the Altair emulator by using the web terminal. The following image shows how to connect to the Altair emulator from your web browser.

:::image type="content" source="../media/web-terminal-connect.png" alt-text="Screenshot that shows the Altair web terminal connecting to the Altair emulator.":::

