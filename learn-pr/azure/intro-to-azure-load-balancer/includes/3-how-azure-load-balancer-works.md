Azure Load Balancer operates at the transport layer of the Open Systems Interconnection (OSI) model. This Layer 4 functionality allows traffic management based on specific properties of the traffic. Properties including source and destination address, TCP or UDP protocol type, and port number.

Load Balancer has several elements that work together to ensure an application's high availability and performance:

- Front-end IP
- Load balancer rules
- Back-end pool
- Health probes
- Inbound NAT rules
- High availability ports
- Outbound rules

## Front-end IP

The front-end IP address is the address clients use to connect to your web application. A front-end IP address can be either a public or a private IP address. Azure load balancers can have multiple front-end IPs. The selection of a public or a private IP address determines which type of load balancer to create:

- **Public IP address: A public load balancer**: A public load balancer maps the public IP and port of incoming traffic to the private IP and port of the virtual machine (VM). You can distribute specific types of traffic across multiple VMs or services by applying load-balancing rules. For example, you can spread the load of web request traffic across multiple web servers. The load balancer maps the response traffic from the private IP and port of the VM to the public IP and port of the load balancer. Then, it transmits the response back to the requesting client.
- **Private IP address: An internal load balancer**: An internal load balancer distributes traffic to resources that are inside a virtual network. Azure restricts access to the front-end IP addresses of a virtual network that are load balanced. Front-end IP addresses and virtual networks are never directly exposed to an internet endpoint. Internal line-of-business applications run in Azure and are accessed from within Azure or from on-premises resources through a VPN or ExpressRoute connection.

    :::image type="content" source="../images/load-balancer-types.png" alt-text="Diagram that depicts how public and internal load balancers work in Azure Load Balancer." border="false":::

Regional Standard Load Balancer supports IPv4 and IPv6. A dual-stack deployment uses separate IPv4 and IPv6 front-end configurations, matching back-end pools and rules, and VMs with both IPv4 and IPv6 NIC configurations in a dual-stack virtual network and subnet. Load Balancer doesn't translate an IPv6 connection into an IPv4 connection, so adding an IPv6 front end doesn't make an IPv4-only application reachable over IPv6. Confirm that the application listens on the required address family and that its routing, NSGs, and guest firewall permit that traffic.

## Load Balancer rules

A load balancer rule defines how traffic is distributed to the back-end pool. The rule maps a given front-end IP and port combination to a set of back-end IP addresses and port combination.  

> [!IMPORTANT]
> A load-balancing rule distributes traffic but doesn't grant network access. For a public Standard Load Balancer, configure network security groups (NSGs) on the back-end subnet or network interfaces to permit the required client traffic to the back-end service ports. Also permit that traffic through the VM's guest firewall. For private traffic, review the applicable virtual-network, NSG, and guest-firewall policies rather than assuming that a rule creates access.
>
> Load Balancer preserves the source IP address and source port of incoming application traffic. Back-end NSGs therefore evaluate the client source, not the load balancer's front-end address. Allow the intended client address ranges and client source ports, which are commonly ephemeral, while restricting destination ports to the required service ports. If an upstream NAT device or proxy changes the source, the back end sees that changed source. Health probes use their separate platform source, described in the Health probes section.

:::image type="content" source="../images/load-balancer-rules.png" alt-text="Diagram that depicts how load balancer rules work in Azure Load Balancer." border="false":::

By default, Load Balancer selects a healthy back-end instance for each flow by using a hash of five values:

- **Source IP**: The client's source IP address as received by the load balancer.
- **Source port**: The client's source port.
- **Destination IP**: The destination IP address.
- **Destination port**: The destination port.
- **Protocol**: TCP or UDP.

Session affinity isn't an extra field in this hash. It selects a different distribution mode, described in the Session persistence section.

Load Balancer allows you to load balance services on multiple ports, multiple IP addresses, or both. You can configure different load balancing rules for each front-end IP. Multiple front-end configurations are only supported with IaaS VMs.

> [!NOTE]
> If rules for different front-end IP addresses reuse the same back-end IP configuration, port, and protocol, enable Floating IP on those rules. Floating IP preserves the front-end destination IP address instead of translating it to the VM's private IP address. Configure each back-end VM's loopback interface with the relevant front-end IP address, the guest OS to accept that traffic, and the guest firewall to permit the service. Enabling the rule setting alone isn't sufficient. Rules that use different back-end ports don't require Floating IP just because they use multiple front ends. Applications that initiate outbound connections must use the NIC's primary IP configuration rather than the loopback front-end IP.

Load Balancer can't apply different rules based on internal traffic content because it operates at Layer 4 (transport layer) of the OSI model. If you need to manage traffic based on its Layer 7 (application layer) properties, you need to deploy a solution like Azure Application Gateway.

Load Balancer passes application traffic through rather than terminating Transport Layer Security (TLS) or inspecting HTTP paths and cookies. For an HTTPS service behind Load Balancer, the back-end application terminates TLS unless you add a separate proxy that performs that function.

## Back-end pool

The back-end pool is a group of VMs or instances in a Virtual Machine Scale Set that responds to the incoming request. To scale cost-effectively to meet high volumes of incoming traffic, computing guidelines generally recommend adding more instances to the back-end pool.  

Load Balancer automatically updates traffic distribution as you add or remove back-end pool members. For example, after you add two more VMs to the pool, they become eligible for new flows when they pass the configured health probe under the default probe-controlled behavior. Adding VMs doesn't move established TCP connections to the new instances.

Traffic distribution and compute scaling are separate. Load Balancer doesn't create, resize, or repair the VMs in its back-end pool. To change application capacity automatically, configure autoscale for a Virtual Machine Scale Set and associate its instances with the back-end pool. You can also manage capacity manually. Set appropriate scaling limits and allow time for new instances to start and become application-ready.

> [!NOTE]
> For the regional load balancers described here, back-end VMs belong to the same virtual network. Clients can connect from other networks when private connectivity, routing, and access controls permit it. Virtual network peering or a connection from on-premises doesn't make machines in those networks eligible for this back-end pool.

Don't rely on a back-end VM reaching its own application through the internal load balancer's front end. If the flow maps back to the same VM and network interface that originated it, the connection can fail. A flow mapped to a different VM can succeed, which can make the problem appear intermittent. For applications that call another service through an internal load balancer, keep the calling and target roles separate or use a supported proxy design rather than depending on this self-connection pattern.

## Health probes

A health probe checks whether a back-end instance can receive new flows. Configure its protocol, port, interval, and threshold, and associate it with the relevant load-balancing rule. Choose a check that reflects application readiness. A listening TCP port alone doesn't prove that every application operation is working.

The behavior described here assumes that each back-end instance has Admin State set to **None**, so health probes control its eligibility for new flows. It also assumes the default `NoHealthyBackendsBehavior` value of **AllProbedDown**, which doesn't send new flows to the pool when every instance is probed down. Configuring **AllProbedUp** changes that all-down behavior and can send new connections to instances whose probes failed. It doesn't make those applications healthy.

Standard Load Balancer supports these probe protocols:

- **TCP**: Attempts to establish a TCP connection to the configured port. Connection failures and timeouts contribute to the probe's failure behavior.
- **HTTP or HTTPS**: Sends an HTTP GET to the configured path. The endpoint must return HTTP 200 within the response window. Redirects and other status codes aren't successful probe responses.

> [!NOTE]
> HTTP probes don't support hostname-based probe configuration. HTTPS probes don't support client-certificate authentication, and certificates throughout the chain must use a signature hash of SHA256 or stronger. Configure a compatible readiness endpoint that returns HTTP 200 and reflects the application's health. If the client-facing listener can't meet those requirements, use a separate readiness listener on a different port. Restrict that probe port to the platform probe sources with NSGs and guest-firewall rules, without removing authentication from the application's client-facing endpoint.

The Azure portal defaults to a 5-second probe interval. The service documentation lists a 15-second default for ARM templates, the REST API, and Azure CLI. Don't assume that every configuration tool supplies this value automatically. For example, the Azure PowerShell `New-AzLoadBalancerProbeConfig` cmdlet requires `-IntervalInSeconds`. Set the interval explicitly when you need consistent configuration. HTTP/HTTPS probes wait for the shorter of the configured interval and 30 seconds when no response is received.

The threshold controls consecutive probe outcomes, but it isn't a universal retry count for every HTTP response. For HTTP probes, explicit HTTP 200 and non-200 responses immediately determine up or down status and reset the threshold. The threshold applies when HTTP probes time out without a response.

> [!NOTE]
> For consecutive probe-success and probe-failure thresholds, use the `probeThreshold` setting. In Azure PowerShell, this is `-ProbeThreshold`. Don't assume that a similarly named probe-count or unhealthy-threshold setting provides the same behavior. Explicit HTTP 200 and non-200 responses still determine probe status immediately, as described above.

When an instance is marked unhealthy, Load Balancer stops assigning new flows to it. Existing traffic behaves differently by protocol:

- **TCP**: When one instance's probe fails and other instances remain healthy, established connections to that instance can continue. If all probes are down, Standard Load Balancer can preserve established TCP flows when the pool has more than one back-end instance. In either case, preservation doesn't keep connections working after the application closes them, an idle timeout occurs, or the VM or network becomes unavailable.
- **UDP**: Existing flows move to another healthy instance when one instance becomes unhealthy. If all instances are unhealthy, existing UDP flows terminate.

A UDP application still needs a TCP, HTTP, or HTTPS health probe. Configure a corresponding listener whose response reflects the UDP service's health. Load Balancer doesn't offer a UDP health-probe protocol.

> [!NOTE]
> Permit probe traffic separately from application traffic. IPv4 health probes originate from `168.63.129.16`, represented by the `AzureLoadBalancer` service tag in NSGs. The default NSG probe-allow rule can be overridden by higher-priority rules, and the guest firewall must also permit the probe port. Allowing the probe source doesn't allow ordinary client traffic.
>
> IPv6 health probes use the link-local source address `fe80::1234:5678:9abc`. A dual-stack deployment needs an associated NSG configured to allow the IPv6 probe and guest-firewall rules that permit that probe source on the configured port. An IPv4-only guest-firewall allowance doesn't cover IPv6 probes.

### Administrative state and maintenance

Standard Load Balancer lets you override probe-driven eligibility for an instance in a back-end pool. Set Admin State to **Down** to stop assigning new connections to that instance during planned maintenance. Established TCP connections can continue, so allow the application to finish or close those connections before stopping the VM. Existing UDP flows move to another healthy instance when one is available.

Set Admin State back to **None** to restore probe-controlled behavior. Setting it to **Up** makes the instance eligible even when its probe fails, so don't use **Up** to hide an unhealthy application. An override applies to that instance in the selected pool and all probed load-balancing rules that use the pool. It doesn't change the same VM's state in other pools and doesn't control inbound NAT rules.

## Session persistence

Load Balancer distributes flows, not individual application requests. With the default five-tuple hash, traffic within a TCP connection stays on its selected back-end instance, while a new connection from the same client can be assigned to another healthy instance. Hash-based distribution doesn't guarantee equal request counts, bytes, or processing load across instances.

Session persistence, also called source IP affinity, changes which values are used to select an instance:

- **None (default)**: Uses source IP, source port, destination IP, destination port, and protocol.
- **Client IP (2-tuple)**: Uses source IP and destination IP.
- **Client IP and protocol (3-tuple)**: Uses source IP, destination IP, and protocol.

The affinity modes direct connections with the same selected tuple to the same instance while the relevant back-end membership and health remain unchanged. Clients behind a shared NAT address or proxy can appear to have the same source IP, which can concentrate traffic on one instance.

> [!NOTE]
> Session persistence isn't a guarantee that a client always reaches the same VM. Pool changes or an unhealthy instance can change where new connections go. Load Balancer doesn't store or replicate application session data, so applications must handle reconnection and any required shared session state.

## TCP idle timeout and reset

Ordinary TCP load-balancing rules and inbound NAT rules have a default idle timeout of four minutes, configurable from 4 to 100 minutes. For inbound connections, an applicable front-end IP idle-timeout setting takes precedence over the rule setting. Outbound rules have their own timeout configuration, with a four-minute default and a range of 4 to 120 minutes.

Without TCP reset, Load Balancer silently drops a flow that reaches its idle timeout. Enabling TCP reset on a supported rule sends TCP reset packets to both endpoints of an established TCP connection when its idle timeout expires. Endpoints that receive the reset can close the connection and reconnect when needed. If an otherwise idle connection must remain open, use appropriate keepalives at an interval shorter than the effective idle timeout. Session persistence and successful health probes don't keep an idle application connection alive.

> [!NOTE]
> Idle timeout is different from a failed health probe. These settings don't apply to UDP load-balancing rules. Internal load-balancer configurations that use high availability ports with network virtual appliances or user-defined routes have additional limitations and aren't covered by this ordinary TCP example.

## High availability ports

A load balancer rule configured with `protocol - all and port - 0` is known as a *high availability (HA) port rule*. This rule enables a single rule to load balance all TCP and UDP flows that arrive on all ports of an internal standard load balancer.

The load-balancing decision is made per flow. This action is based on the following five-tuple connection:

- Source IP address
- Source port
- Destination IP address
- Destination port
- Protocol

HA ports load-balancing rules help you with critical scenarios, such as high availability and scale for network virtual appliances (NVAs) inside virtual networks. The feature can help when a large number of ports must be load balanced.

Stateful NVAs can require both directions of a connection to pass through the same appliance instance. This requirement is called flow symmetry. HA ports support flow symmetry in supported single-internal-load-balancer, single-back-end-pool designs, with the required NIC and IP configuration. They don't guarantee symmetry across separate load balancers, multiple front-end configurations, or multiple back-end pools. Confirm the topology with the appliance vendor rather than assuming that HA ports alone provide symmetry.

For supported scenarios that insert NVAs into traffic arriving at or leaving a public endpoint, consider **Gateway Load Balancer**. It can chain to a Standard public load balancer and keep both directions of a flow on the same appliance path. It complements the application load balancer rather than replacing it. Gateway Load Balancer isn't a general-purpose next hop for user-defined routes and doesn't support combination with the Global Load Balancer tier. Internal HA ports remain appropriate for supported internal NVA scenarios.

:::image type="content" source="../images/high-availability-ports.png" alt-text="Diagram that shows how high availability ports work in Azure Load Balancer." border="false":::

## Inbound NAT rules

An inbound network address translation (NAT) rule forwards a front-end IP address and port to a specific VM and back-end port. For example, an administrator could use a dedicated front-end port that maps to TCP port 3389 for Remote Desktop Protocol (RDP) on one VM. This is port forwarding, not distribution of that connection across the pool.

For multiple VMs or virtual machine scale set instances, inbound NAT rules v2 target a back-end pool and allocate per-instance front-end port mappings from a configured range. Use a network interface card (NIC)-based back-end pool for the inbound NAT configuration described here. Size the front-end port range for the intended number of instances because insufficient available mappings can prevent scale-out. Inbound NAT rules don't require a health probe and don't by themselves configure outbound SNAT.

A back-end pool can identify instances through network interface configurations or IP addresses. The inbound NAT example in this module uses NIC-based pool membership. It doesn't demonstrate an IP-address-based inbound NAT deployment, and its configuration assumptions shouldn't be generalized to other pool-membership modes.

> [!IMPORTANT]
> Prefer Azure Bastion or private RDP/SSH connectivity instead of exposing management ports publicly. If you use public inbound NAT for management, restrict permitted source addresses and back-end management ports through NSGs and guest firewalls. The NAT mapping doesn't provide authentication or authorization.

:::image type="content" source="../images/inbound-nat-rules.png" alt-text="Diagram that shows how inbound NAT rules work in Azure Load Balancer." border="false":::

## Outbound rules

An outbound rule on a regional public Standard Load Balancer configures source network address translation (SNAT) for connections initiated by back-end instances. The rule uses the load balancer's front-end public IP addresses so those instances can reach internet services and other public endpoints.

Choose an explicit outbound method for workloads that need public connectivity. Azure NAT Gateway is the recommended option for most outbound scenarios and can provide subnet-level egress while Load Balancer handles inbound traffic. Load Balancer outbound rules remain an option when you want outbound connections to use its front-end public IP addresses. Plan SNAT-port allocation because exhausted SNAT ports can prevent new outbound connections.

An explicit outbound rule can still use default port allocation. For production workloads that use Load Balancer outbound rules, choose manual SNAT-port allocation instead. For a Virtual Machine Scale Set, size the allocation for the maximum planned number of back-end instances, not just the current count. An insufficient port budget can block scale-out or leave new instances without enough outbound ports.

Review the front-end public IP capacity and monitor **Used SNAT Ports**, **Allocated SNAT Ports**, and failed SNAT connections as demand changes. Manual allocation still needs capacity planning and doesn't guarantee that ports can't be exhausted.

> [!IMPORTANT]
> Private subnets don't provide default outbound access. For API versions released after March 31, 2026, subnets in new virtual networks default to private, and the Azure portal already uses this default. Existing virtual networks aren't automatically converted. Configure an explicit outbound method rather than relying on an implicit outbound IP address.

This outbound-rule example assumes NIC-based pool members using primary IPv4 configurations without instance-level public IP addresses. If an outbound rule shares a front end with a load-balancing rule, disable automatic outbound SNAT on that load-balancing rule. A NAT gateway on the subnet takes precedence for new outbound connections. Custom routes to an NVA or virtual network gateway can direct traffic through a different egress path. IP-based pools have different documented default-outbound behavior and need deliberate egress design.

Choose the egress service separately from the load balancer's front-end zone configuration. Standard NAT Gateway provides IPv4 egress from one availability zone. StandardV2 NAT Gateway is zone redundant and supports IPv4 and IPv6, but requires StandardV2 public IP addresses or prefixes, separate from the Standard public IP resources used by Standard Load Balancer.

As of November 2026, Microsoft documents that associating a StandardV2 NAT gateway with a subnet disrupts IPv6 outbound connections that use Load Balancer outbound rules. For that dual-stack combination, use Load Balancer outbound rules for both address families, or Standard NAT Gateway for IPv4 with Load Balancer outbound rules for IPv6. This limitation concerns outbound connectivity, not using Load Balancer for inbound traffic. Adding StandardV2 NAT Gateway can also interrupt existing outbound connections, so plan the change and application reconnection behavior.

:::image type="content" source="../images/outbound-rule.png" alt-text="Diagram that shows how outbound rules work in Azure Load Balancer." border="false":::

## Monitor availability and connectivity

Use Azure Monitor to understand both the load balancer and its back-end instances. **Health Probe Status** reflects the load balancer's view of instance eligibility and includes administrative-state overrides. It isn't independent proof that an application answered a probe successfully. In the Azure portal, open **Load balancing rules** and inspect the rule's **Health status** details to distinguish probe success from an administrative override or an all-backends-down policy override. **Data Path Availability** measures the load-balancer data path and isn't the same as application health.

For a public load balancer that provides outbound SNAT, compare **Used SNAT Ports** with **Allocated SNAT Ports**, and review **SNAT Connection Count** for failed connections. Configure alerts that reflect the application's availability requirements. Probe success only confirms the check you configured, so combine these metrics with application monitoring.

For event-based troubleshooting, configure a diagnostic setting on the load balancer to collect the `LoadBalancerHealthEvent` log category and send it to a Log Analytics workspace. These events identify conditions such as no healthy back ends, high SNAT-port usage, SNAT-port exhaustion, and platform data-path problems. Query the `ALBHealthEvent` table and configure log alerts alongside the existing metric alerts. Health event logs aren't HTTP access logs or a record of every connection. Log delivery can be delayed, and an empty log isn't proof that an application is healthy. Account for log ingestion and retention costs.

> [!NOTE]
> Check the application's configured protocol and front-end port from an allowed client that isn't a member of the target back-end pool. For an internal load balancer, that client also needs private connectivity and a valid route. A successful health probe doesn't prove that the client's application traffic passes its own NSG, firewall, and routing checks.
>
> Where public-front-end ping is supported, it tests reachability of the load balancer, not an end-to-end application exchange. Load Balancer handles those ICMP requests rather than forwarding them to a back-end VM. This is separate from the ICMP forwarding supported by an internal Standard Load Balancer with an HA ports rule.
