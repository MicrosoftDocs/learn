


You can use the platform-provided Azure load balancer to enhance availability and scalability of virtual machines by configuring them as a load-balanced set. Azure load balancer provides functionality similar to hardware load balancers by eliminating single points of failure (application or hardware), increasing uptime during planned maintenance or upgrades, and distributing workloads across multiple, identically configured compute nodes.

Azure load balancer can handle traffic originating from within the same Azure virtual network, from any directly connected network, or from the internet. In addition, you can configure it to implement the network address translation (NAT) capability, providing connections to individual virtual machines in the load-balanced set.

Azure load balancer is available in two SKUs: Basic and Standard.

:::row:::
  :::column:::

  :::column-end:::
  :::column:::
    **Standard load balancer**
  :::column-end:::
  :::column:::
    **Basic load balancer**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Scenario**
  :::column-end:::
  :::column:::
    Equipped for load-balancing network layer traffic when high performance and ultra-low latency is needed. Routes traffic within and across regions, and to availability zones for high resiliency.
  :::column-end:::
  :::column:::
    Equipped for small-scale applications that don't need high availability or redundancy. Not compatible with availability zones.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Backend type**
  :::column-end:::
  :::column:::
    IP based, NIC based
  :::column-end:::
  :::column:::
    NIC based
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Protocol**
  :::column-end:::
  :::column:::
    TCP, UDP
  :::column-end:::
  :::column:::
    TCP, UDP
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Backend pool endpoints**
  :::column-end:::
  :::column:::
    Any virtual machines or virtual machine scale sets in a single virtual network.
  :::column-end:::
  :::column:::
    Virtual machines in a single availability set or virtual machine scale set.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[Health probes](/azure/load-balancer/load-balancer-custom-probe-overview#types)**
  :::column-end:::
  :::column:::
    TCP, HTTP, HTTPS
  :::column-end:::
  :::column:::
    TCP, HTTP
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[Health probe down behavior](/azure/load-balancer/load-balancer-custom-probe-overview#probedown)**
  :::column-end:::
  :::column:::
    TCP connections stay alive on an instance probe down **and** on all probes down.
  :::column-end:::
  :::column:::
    TCP connections stay alive on an instance probe down. All TCP connections end when all probes are down.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Availability Zones**
  :::column-end:::
  :::column:::
    Zone-redundant and zonal frontends for inbound and outbound traffic.
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Diagnostics**
  :::column-end:::
  :::column:::
    [Azure Monitor multi-dimensional metrics](/azure/load-balancer/load-balancer-standard-diagnostics)
  :::column-end:::
  :::column:::
    Not supported
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **HA ports**
  :::column-end:::
  :::column:::
    [Available for Internal load balancer](/azure/load-balancer/load-balancer-ha-ports-overview)
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Secure by default**
  :::column-end:::
  :::column:::
    Closed to inbound flows unless allowed by a network security group. Internal traffic from the virtual network to the internal load balancer is allowed.
  :::column-end:::
  :::column:::
    Open by default. Network security group optional.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Outbound rules**
  :::column-end:::
  :::column:::
    [Declarative outbound NAT configuration](/azure/load-balancer/load-balancer-outbound-connections#outboundrules)
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **TCP reset on idle**
  :::column-end:::
  :::column:::
    [Available on any rule](/azure/load-balancer/load-balancer-tcp-reset)
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[Multiple front ends](/azure/load-balancer/load-balancer-multivip-overview)**
  :::column-end:::
  :::column:::
    Inbound and [outbound](/azure/load-balancer/load-balancer-outbound-connections)
  :::column-end:::
  :::column:::
    Inbound only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Management operations**
  :::column-end:::
  :::column:::
    Most operations &lt; 30 seconds
  :::column-end:::
  :::column:::
    60-90+ seconds typical
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **SLA**
  :::column-end:::
  :::column:::
    [99.99%](https://azure.microsoft.com/support/legal/sla/load-balancer/v1_0/)
  :::column-end:::
  :::column:::
    Not available
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Global VNet Peering Support**
  :::column-end:::
  :::column:::
    Standard ILB is supported via Global VNet Peering
  :::column-end:::
  :::column:::
    Not supported
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[NAT Gateway Support](/azure/virtual-network/nat-gateway/nat-overview)**
  :::column-end:::
  :::column:::
    Both Standard ILB and Standard Public LB are supported via Nat Gateway
  :::column-end:::
  :::column:::
    Not supported
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[Private Link Support](/azure/private-link/private-link-overview)**
  :::column-end:::
  :::column:::
    Standard ILB is supported via Private Link
  :::column-end:::
  :::column:::
    Not supported
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **[Global tier (Preview)](/azure/load-balancer/cross-region-overview)**
  :::column-end:::
  :::column:::
    Standard LB supports the Global tier for Public LBs enabling cross-region load balancing
  :::column-end:::
  :::column:::
    Not supported
  :::column-end:::
:::row-end:::

## Limitations

- SKUs aren't mutable. You can't change the SKU of an existing resource.
- A standalone virtual machine resource, availability set resource, or virtual machine scale set resource can reference one SKU, never both.

## Optional demo

- [Demonstration: Explore Network Security Groups (NSGs) and service endpoints](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-explore-network-security-groups-service-endpoints.md)
