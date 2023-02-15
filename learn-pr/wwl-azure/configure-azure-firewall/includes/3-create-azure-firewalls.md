When you deploy a firewall, the recommended approach is to implement a **hub-spoke** network topology. 

The **hub** is a virtual network in Azure that acts as a central point of connectivity to your on-premises network.

**Spokes** are virtual networks that peer with the hub, and can be used to isolate workloads.

Traffic flows between an on-premises datacenter and the hub network through an Azure connection, such as Azure ExpressRoute, Azure VPN Gateway, or Azure Bastion.

:::image type="content" source="../media/firewall-tasks-7b6dbe0f.png" alt-text="Diagram that shows traffic flowing between an on-premises network to a hub-spoke network with subnets." border="false":::

### Things to consider when using a hub-spoke network

There are several benefits to using a hub-spoke network for your Azure Firewall implementation.

- **Consider cost savings**. Implement a hub-spoke network and reduce your costs by centralizing services that can be shared by multiple workloads in a single location. Examples of services that can use shareable workloads include network virtual appliances (NVAs) and DNS servers.

- **Consider subscription limits**. Overcome subscription limits by peering your virtual networks from different subscriptions to the central hub network.

- **Consider role separation**. Use a hub-spoke network configuration to support separation of responsibilities. The hub-spoke firewall topology lets you distribute maintenance tasks between central IT (SecOps, InfraOps) and workloads (DevOps).

- **Consider shared services**. Support workloads in different environments that require shared services, but not connectivity to each other. Examples of these environments include development and testing where each requires DNS. Place shared services in the hub virtual network, and deploy each environment to a spoke to maintain isolation.

- **Consider centralized control**. Apply the hub-spoke network for enterprises that require central control over security aspects. A common example is a firewall located in the hub and workloads placed in each spoke.
