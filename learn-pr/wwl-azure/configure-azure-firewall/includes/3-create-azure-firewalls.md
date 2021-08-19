It's recommended to use a hub-spoke network topology when deploying a firewall.

 -  The *hub* is a virtual network in Azure that acts as a central point of connectivity to your on-premises network.
 -  The *spokes* are virtual networks that peer with the hub, and can be used to isolate workloads.
 -  Traffic flows between the on-premises datacenter and the hub through an ExpressRoute or VPN gateway connection.

:::image type="content" source="../media/firewall-tasks-7b6dbe0f.png" alt-text="Diagram with three subnets. Numbers are aligned with the subnets.":::


The benefits of this topology include:

 -  Cost savings by centralizing services that can be shared by multiple workloads, such as network virtual appliances (NVAs) and DNS servers, in a single location.
 -  Overcome subscriptions limits by peering virtual networks from different subscriptions to the central hub.
 -  Separation of concerns between central IT (SecOps, InfraOps) and workloads (DevOps).

Typical uses for a hub-spoke network architecture include:

 -  Workloads in different environments that require shared services. For example, development and testing environments that require DNS. Shared services are placed in the hub virtual network. Each environment is deployed to a spoke to maintain isolation.
 -  Workloads that don't require connectivity to each other, but require access to shared services.
 -  Enterprises that require central control over security aspects. For example, a firewall in the hub and workloads in each spoke.
