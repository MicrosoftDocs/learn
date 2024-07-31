You can use the platform-provided Azure load balancer to enhance availability and scalability of virtual machines by configuring them as a load-balanced set. Azure load balancer provides functionality similar to hardware load balancers by eliminating single points of failure (application or hardware), increasing uptime during planned maintenance or upgrades, and distributing workloads across multiple, identically configured compute nodes.

Azure load balancer can handle traffic originating from within the same Azure virtual network, from any directly connected network, or from the internet. In addition, you can configure it to implement the network address translation (NAT) capability, providing connections to individual virtual machines in the load-balanced set.

Azure load balancer is available in two SKUs: Basic and Standard.

| Scenario | Standard load balancer | Basic load balancer |
|---|---|---|
| | Equipped for load-balancing network layer traffic when high performance and ultra-low latency is needed. Routes traffic within and across regions, and to availability zones for high resiliency. | Equipped for small-scale applications that don't need high availability or redundancy. Not compatible with availability zones. |
| **Backend type** | IP based, NIC based | NIC based |
| **Protocol** | TCP, UDP | TCP, UDP |
| **Backend pool endpoints** | Any virtual machines or virtual machine scale sets in a single virtual network. | Virtual machines in a single availability set or virtual machine scale set. |
| **[Health probes](/azure/load-balancer/load-balancer-custom-probe-overview#types)** | TCP, HTTP, HTTPS | TCP, HTTP |
| **[Health probe down behavior](/azure/load-balancer/load-balancer-custom-probe-overview#probedown)** | TCP connections stay alive on an instance probe down **and** on all probes down. | TCP connections stay alive on an instance probe down. All TCP connections end when all probes are down. |
| **Availability zones** | Zone-redundant and zonal frontends for inbound and outbound traffic. | Not available |
| **Diagnostics** | [Azure Monitor multidimensional metrics](/azure/load-balancer/load-balancer-standard-diagnostics) | Not supported |
| **HA ports** | [Available for Internal load balancer](/azure/load-balancer/load-balancer-ha-ports-overview) | Not available |
| **Secure by default** | Closed to inbound flows unless allowed by a network security group. Internal traffic from the virtual network to the internal load balancer is allowed. | Open by default. Network security group optional. |
| **Outbound rules** | [Declarative outbound NAT configuration](/azure/load-balancer/load-balancer-outbound-connections#outboundrules) | Not available |
| **TCP reset on idle** | [Available on any rule](/azure/load-balancer/load-balancer-tcp-reset) | Not available |
| **[Multiple front ends](/azure/load-balancer/load-balancer-multivip-overview)** | Inbound and [outbound](/azure/load-balancer/load-balancer-outbound-connections) | Inbound only |
| **Management operations** | Most operations &lt; 30 seconds | 60-90+ seconds typical |
| **SLA** | [99.99 percent](https://azure.microsoft.com/support/legal/sla/load-balancer/v1_0/) | Not available |
| **Global virtual network Peering Support** | Standard ILB is supported via Global virtual network Peering | Not supported |
| **[NAT Gateway Support](/azure/virtual-network/nat-gateway/nat-overview)** | Both Standard ILB and Standard Public LB are supported via Nat Gateway | Not supported |
| **[Private Link Support](/azure/private-link/private-link-overview)** | Standard ILB is supported via Private Link | Not supported |
| **[Global tier](/azure/load-balancer/cross-region-overview)** | Standard LB supports the Global tier for Public LBs enabling cross-region load balancing | Not supported |

## Limitations

- SKUs aren't mutable. You can't change the SKU of an existing resource.
- A standalone virtual machine resource, availability set resource, or virtual machine scale set resource can reference one SKU, never both.

## Optional demo

- [Demonstration: Explore Network Security Groups (NSGs) and service endpoints](https://go.microsoft.com/fwlink/?linkid=2260474&clcid=0x409)
