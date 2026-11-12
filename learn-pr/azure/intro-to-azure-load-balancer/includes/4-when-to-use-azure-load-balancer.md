Azure Load Balancer is best suited for applications that require ultra-low latency and high performance. Load Balancer is suitable for your organization's needs because you're replacing existing network hardware devices that load balance traffic across applications. The applications used multiple virtual machine (VM) tiers when the applications were on-premises with an Azure service that has the same functionality.

Because Load Balancer operates at Layer 4 like hardware devices that were used on-premises before the organization migrated to Azure, you can use Load Balancer to replicate that hardware device functionality. This functionality includes using health probes to stop assigning new flows to unhealthy VM nodes. It also includes source IP affinity, which can direct related client connections to the same healthy back-end instance. This affinity doesn't guarantee that the same VM remains selected after back-end membership or health changes.

> [!NOTE]
> Matching the OSI layer doesn't guarantee identical support for every packet type. Azure Load Balancer load-balancing rules don't forward fragmented IP packets, including fragmented TCP and UDP traffic. HA ports have the same limitation. Before migrating an application, check its packet-size and path-MTU requirements. Applications that depend on IP fragmentation need changes or a different network design.

You can configure public load balancers for front-end traffic to web tiers of applications. You can also configure internal load balancers to balance traffic between the web tier and the tier that performs data analysis and transformation tasks.

Inbound NAT rules can provide per-VM administrative port mappings. For routine administration, prefer Azure Bastion or private connectivity. If public NAT is required, restrict access to approved management sources.

## When not to use Azure Load Balancer

For a low-traffic web application on a single IaaS VM, Load Balancer is usually unnecessary if you don't need traffic distribution or another capability it provides. A single-VM configuration can still be useful when you specifically need a front-end port mapping or Load Balancer outbound rules. It doesn't make that single VM redundant. For outbound-only requirements, prefer Azure NAT Gateway when it's suitable. For routine VM administration, prefer Azure Bastion or private connectivity rather than public management-port mappings.

Azure provides other load-balancing solutions as alternatives to Azure Load Balancer, including Azure Front Door, Azure Traffic Manager, and Azure Application Gateway:

- **Azure Front Door Standard or Premium**: Provides global HTTP/HTTPS delivery, acceleration, caching, TLS termination, and application-layer routing. Web application firewall (WAF) capabilities depend on the selected tier and policy.
- **Azure Traffic Manager**: Uses DNS responses to direct clients to endpoints. It doesn't proxy application traffic, and failover depends partly on DNS caching and client behavior.
- **Azure Application Gateway Standard_v2 or WAF_v2**: Provides regional HTTP-aware routing and TLS termination. It also supports TCP/TLS proxying for non-HTTP workloads. Unlike pass-through Load Balancer, Application Gateway terminates the client connection and creates a separate connection to a back-end server. Choose WAF_v2 for WAF capabilities on HTTP(S) listeners. WAF doesn't inspect traffic on TCP/TLS listeners, and the TCP/TLS proxy doesn't support UDP.

In comparison to these solutions:

- **Azure Load Balancer**: A high-performance, low-latency Layer 4 service for TCP and UDP flows. It supports zone-redundant front ends in regions with availability zones. For application resilience, use an appropriate front-end configuration and distribute back-end instances across zones with enough capacity to serve traffic after a failure. Load Balancer alone doesn't provide a web application firewall.

> [!NOTE]
> A public load balancer inherits the zone configuration of its front-end public IP address. An internal load balancer has a zone configuration on its private front end. Zonal configurations are also possible. A zone-redundant front end doesn't keep an application available if all of its back-end instances are unavailable in the same failed zone.

## Protect internet-facing workloads

Azure provides infrastructure-level distributed denial-of-service (DDoS) protection for public IP addresses at no additional cost. For internet-facing workloads, evaluate Azure DDoS Network Protection or DDoS IP Protection for enhanced protection of eligible public IP resources, including a public load balancer's front-end IP.

These offerings add workload-tuned network-layer mitigation and monitoring at an additional cost. They complement NSGs and application-layer WAF protection. Load balancing and zone redundancy don't replace a DDoS protection strategy.

## Availability and cost considerations

Evaluate availability requirements and cost as well as traffic type. The Load Balancer service-level agreement (SLA) requires at least two healthy VMs configured as back-end instances. It doesn't guarantee your application's availability, and the documented SLA excludes downtime caused by SNAT-port exhaustion or NSGs that block traffic. Continue to design for back-end failures and sufficient remaining capacity.

Load Balancer pricing depends on configured rules and processed data. Account for related public IP charges separately when estimating the solution's cost.

## Regional or global load balancing

Use a regional Standard Load Balancer to distribute traffic to VMs or virtual machine scale set instances in a virtual network. For global Layer 4 distribution, Standard Load Balancer also has a Global tier. Its public front end distributes traffic to regional public Standard load balancers, whose back-end pools contain the application instances.

The Global tier doesn't provide an internal front end, and its back-end pool doesn't accept internal load balancers. It doesn't replace the application-layer features of Front Door or Application Gateway. Choose based on protocol requirements, pass-through versus proxy behavior, HTTP-aware routing, TLS termination, and WAF protection.

> [!NOTE]
> A Global-tier load balancer and its Global-tier public IP must be created in a supported **home region**. The home region is the resource's deployment location and doesn't determine how application traffic is routed. Regional back-end load balancers can be deployed in any publicly available Azure region, and participating regions are the locations that advertise the global front-end address.
>
> For an Australian deployment, don't assume the Global resource can be created in the application's region. As of November 2026, Australia East and Australia Southeast are participating regions but aren't listed as home regions. Australian regional back ends can still be used with a Global resource created in a supported home region. Confirm the current home-region list before deployment.
