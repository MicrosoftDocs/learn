In this unit, you'll learn how to deploy the Altair Web Terminal.

## The Web Terminal architecture

The cloud-connected Altair on Azure Sphere project connects to the Web Terminal by redirecting standard input and output over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true). 

The Web Terminal is an HTML/CSS/JavaScript application built on the [MQTT](https://www.eclipse.org/paho/index.php?page=clients/js/index.php&azure-portal=true) and [Xterm](https://xtermjs.org?azure-portal=true) JavaScript libraries. The Altair Web Terminal is built on [Azure Static Web Apps](/azure/static-web-apps?azure-portal=true).

:::image type="content" source="../media/altair-web-terminal.png" alt-text="Diagram that shows the architecture of the MQTT-based Altair Web Terminal." border="false":::

## The Altair Web Terminal

You'll be able to connect to the Altair emulator using the web terminal. The following image shows how to connect to the Altair emulator from your web browser.

:::image type="content" source="../media/web-terminal-connect.png" alt-text="Screenshot that shows the Altair web terminal connecting to the Altair emulator.":::
