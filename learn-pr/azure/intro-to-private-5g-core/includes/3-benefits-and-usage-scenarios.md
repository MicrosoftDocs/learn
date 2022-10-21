Deploying a private mobile network using Azure Private 5G Core at the enterprise edge ensures that the enterprise has complete ownership of all data. It also positions the packet core instance as close as possible to the devices it serves, removing any reliance on cloud connectivity. Additionally, local data processing can ensure low latency levels and reduced backhaul for IoT applications.

## Key benefits

Azure Private 5G Core provides the following key benefits:

- **Complete 5G core network functions**

  Each *packet core* instance that Azure Private 5G Core deploys is a complete set of 5G network functions. These network functions include the subscriber database, policy control, control plane, and user plane.

  You can also configure a packet core instance to operate in 4G mode to support Private Long-Term Evolution (LTE) use cases.

- **Centralized service management**
  
  In addition to local management, Azure Private 5G Core provides a centralized software lifecycle and service management for the private mobile network across multiple sites. You can use the Azure portal and Azure Resource Manager (ARM) APIs to carry out provisioning, orchestration, monitoring tasks.

  The following diagram illustrates the network configuration for remote and local management of Azure Private 5G Core:

  :::image type="content" source="../media/remote-local-management.png" alt-text="A diagram that illustrates the network configuration for remote and local management" border="true":::

- **Log Analytics integration**

  Azure Private 5G Core integrates with Azure Monitor and Log Analytics to collect data from all sites and provide comprehensive monitoring and data analytics for the entire private mobile network.

  Enterprises can use queries to retrieve records and visualize data in charts, either remotely through Azure or locally through other applications.

  Azure Private 5G Core provides proactive, real-time analysis of all message traffic, including NGAP/NAS messages and HTTP requests and responses. With this analysis, you can diagnose many common configuration, network, and interoperability problems affecting relevant services.

## Usage scenarios

The following videos introduce several private MEC application scenarios, in which Azure Private 5G Core plays a key role:

TBD: A video that introduces several private MEC application scenarios

As discussed in the video, you can typically use private MEC solutions with Azure Private 5G Core in these areas:

- **Machine to machine automation** - Ultra reliable low latency connectivity (URLLC) for command and control messages from automated systems like robots or automated guide vehicles.
- **Massive IoT telemetry** - Secure cloud connectivity for data collection from a large density and volume of IoT sensors and devices.
- **Real-time analytics** - Local processing of real-time operational and diagnostics data.

The low latency levels, combined with the security and high bandwidth offered by private 5G networks, put Azure Private 5G Core in the optimal position to support Industry 4.0 use cases, such as the following applications:

- **Manufacturing** - Production-line analytics and warehouse automation with robots.
- **Public safety** - Mobility and connectivity for emergency workers and disaster recovery operatives.
- **Energy and utilities** - Backhaul networks for smart meters and network slicing/control.
- **Defense** - Connected command posts and battlefield with real-time analytics.
- **Smart farms** - Connected equipment for farm operation.
