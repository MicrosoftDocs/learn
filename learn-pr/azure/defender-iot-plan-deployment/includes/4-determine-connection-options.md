In the last unit, you identified the types of sites and zones you'll need for your car manufacturing organization. This unit considers the types of sensor management methods you need. Specifically, the type of cloud-connected sensor that best fits your organizational needs.

This learn module doesn't cover on-premises only (air-gapped) or hybrid environments.

## Cloud-connected sensors

A cloud-connection has on-premises sensors connected to Defender for IoT via Azure. Sensor detected data is displayed in the sensor console and delivered to Azure for analysis and sharing. You can push software updates and configuration changes to cloud-connected sensors and configure automatic updates for Microsoft threat intelligence packages.

All data collection, processing, analysis, and alerting takes place directly on the sensor. Only telemetry and insights are transferred on to the Azure portal for management.

### Connection types

 Consider what type of connection methods to use for your cloud-connected sensors. Possible types include:

- Direct connections
- Proxy connections with proxy chaining
- Proxy connections with an Azure proxy
- Multicloud connections

Use the following questions to help you choose the right connection for your manufacturing organization.

#### Direct connection

- Do you want to connect your sensor to Azure directly?

If so, you don't need a proxy at all. The following image shows an example of how you can connect your sensors to Defender for IoT portal and Azure directly over the internet.

:::image type="content" source="../media/4-direct.png" alt-text="Diagram of a direct cloud connection." border="false":::

#### Proxy connections with proxy chaining

- Does your sensor need a proxy to reach the cloud from the OT network?
- Do you want multiple sensors to connect to Azure through a single point?

If your answers to these questions are *Yes*, use a proxy connection with proxy chaining.

In the following image, sensors connect to Defender for IoT and Azure through multiple proxies.

:::image type="content" source="../media/4-proxy-chaining.png" alt-text="Diagram of a proxy connection using proxy chaining." border="false":::

#### Proxy connections with an Azure proxy

- Do you need private connectivity between your sensor and Azure?
- Is your site connected to Azure via ExpressRoute, or over a VPN?

If your answers to these questions are *Yes*, use a proxy connection with an Azure proxy.

In the following image, sensors are connected to Defender for IoT and Azure through a proxy in the Azure virtual network to ensure communication confidentiality.

:::image type="content" source="../media/4-proxy.png" alt-text="Diagram of a proxy connection using an Azure proxy." border="false":::

#### Multicloud connections

- Do you have sensors hosted in multiple public clouds?

If so, consider which connectivity method to use:

- **Public IP addresses over the internet**- use if you *don't* need to exchange data using private IP addresses.
- **Site-to-site VPN over the internet**- use if you *don't* need:

  - Predictable throughput
  - SLA
  - High data volume transfers
  - To avoid connections over the public internet
- **ExpressRoute** - use if you *do* need:
  - Predictable throughput
  - SLA
  - High data volume transfers
  - To avoid connections over the public internet

If you choose ExpressRoute, use with:

- Customer-managed routing if you *do* want to own and manage the routers making the connection.
- A cloud exchange provider if you *don't* need to own and manage the routers making the connection.

## Knowledge check
