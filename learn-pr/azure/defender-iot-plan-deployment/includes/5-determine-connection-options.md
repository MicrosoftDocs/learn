In the last unit, you organized your car manufacturing organization locations into sites and zones. This unit considers the types of sensor management you need. Specifically, the type of cloud-connected sensor that best fits your organizational needs.
<!-- 
    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

## Cloud-connected sensors

A Cloud-connection has on-premises sensors connected to Defender for IoT via Azure. Sensor detected data is displayed in the sensor console and delivered to Azure for analysis and sharing. Microsoft threat intelligence packages are pushed automatically to cloud-connected sensors. The sensor name defined during onboarding is displayed in the sensor and is read-only from the sensor console.

### Connection Types

 Consider what type of connection methods to use for your cloud-connected sensors. Possible types include:

- Proxy connections with an Azure proxy
- Proxy connections with proxy chaining
- Direct connection
- Multicloud connections

Use the following questions to help you choose the connection for your manufacturing organization.

#### Proxy connections with an Azure proxy

- Do you need private connectivity between your sensor and Azure?
- Is your site connected to Azure via ExpressRoute, or over a VPN?

In the image to ensure communication confidentiality, sensors are connected to the Defender for IoT portal in Azure through a proxy in the Azure virtual network.
:::image type="content" source="../media/5-proxy.png" alt-text="Diagram of a proxy connection using an Azure proxy.":::

#### Proxy connections with proxy chaining

- Does your sensor need a proxy to reach the cloud from the OT network?
- Do you want multiple sensors to connect to Azure through a single point?

Here, sensors connect to the Defender for IoT portal in Azure through multiple proxies.

:::image type="content" source="../media/5-proxy-chaining.png" alt-text="Diagram of a proxy connection using proxy chaining.":::

#### Direct connection

- Do you want to connect your sensor to Azure directly?

An example of how you can connect your sensors to the Defender for IoT portal in Azure directly over the internet.
:::image type="content" source="../media/5-direct.png" alt-text="Diagram of a direct cloud connection.":::

#### Multicloud connections

- Do you have sensors hosted in multiple public clouds?

Consider which connectivity method to use:

- Public IP addresses over the internet
- site-to-site VPN over the internet
- ExpressRoute

<!-- Pattern for complex chunks (repeat as needed) -->
<!-- ## Air-gapped locally connected sensors

An air-gapped on-premises sensor connection isn't connected to the cloud. This is for when you want to isolate your network from the cloud or other networks for security reasons. For instance, an automotive manufacturing organization that produces only military or autonomous vehicles might choose this option.

With Air-gapped connections:

- Specific sensor data must be viewed from the sensor console.
- The on-premises management console can be used to manage air-gapped sensors and to view aggregated data and configure settings.
- You must manually upload any threat intelligence packages to locally managed sensors.
- Sensor names are updated in the sensor console.

## Hybrid connection

A hybrid sensor connection includes sensors connected to the cloud as well as locally managed sensors. For instance, in an automotive manufacturing organization which has networks which require isolation in addition to networks which can take advantage of the cloud connection. -->

## Sensor management

All data collection, processing, analysis, and alerting takes place directly on the sensor. Only telemetry and insights are transferred on for management to the Azure portal.

## Knowledge Check
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->