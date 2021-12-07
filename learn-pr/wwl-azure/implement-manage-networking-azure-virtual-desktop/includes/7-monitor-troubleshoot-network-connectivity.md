[Azure Network Watcher](/azure/network-watcher/) provides tools to monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network.

Network Watcher is designed to monitor and repair the network health of IaaS (Infrastructure-as-a-Service) including virtual machines, virtual networks, application gateways, and load balancers.

## Monitor communication between a virtual machine and an endpoint

Endpoints can be another virtual machine (VM), a fully qualified domain name (FQDN), a uniform resource identifier (URI), or IPv4 address.

**Connection Monitor 2.0** monitors for availability, latency, and network topology changes between the virtual machine and the endpoint.

If an endpoint becomes unreachable, Connection Monitor informs you. Potential issues are DNS name resolution problems, CPU, memory, or firewall within the operating system of a virtual machine.

:::image type="content" source="../media/connection-manager-endpoint-83032ed1.png" alt-text="Image of Connection Monitor for endpoint troubleshooting.":::


Connection monitor also provides the minimum, average, and maximum latency observed over time. After learning the latency for a connection, you may find that you're able to decrease the latency by moving your Azure resources to a different Azure region.

## View resources in a virtual network and their relationships

The *topology* capability enables you to generate a visual diagram of the resources in a virtual network, and the relationships between the resources.

The picture below is a topology diagram for a virtual network with:

 -  Three subnets
 -  Two virtual machines
 -  Network interfaces
 -  Public IP addresses
 -  Network security groups
 -  Route table

:::image type="content" source="../media/network-watcher-virtual-networks-3ee99b12.png" alt-text="Network Watcher topology view.":::


## Diagnose network traffic-filtering problems to or from a virtual machine

When you deploy a virtual machine, Azure applies several default security rules to the virtual machine that allow or deny traffic to or from the virtual machine. You might override Azure's default rules, or create other rules. At some point, a virtual machine may become unable to communicate with other resources, because of a security rule. The *IP flow verify* capability enables you to specify a source and destination IPv4 address, port, protocol (TCP or UDP), and traffic direction (inbound or outbound). *IP flow verify* then tests the communication and informs you if the connection succeeds or fails. If the connection fails, *IP flow verify* tells you which security rule allowed or denied the communication, so that you can resolve the problem.

:::image type="content" source="../media/network-watcher-ip-flow-d02820e1.png" alt-text="Screenshot of Network Watcher IP Flow.":::


### Diagnose network routing problems from a virtual machine

When you create a virtual network, Azure creates several default outbound routes for network traffic. The outbound traffic from all resources, such as virtual machines, deployed in a virtual network, are routed based on Azure's default routes. You might override Azure's default routes, or create other routes. You may find that a virtual machine can no longer communicate with other resources because of a specific route. The *next hop* capability enables you to specify a source and destination IPv4 address. Next hop then tests the communication and informs you what type of next hop is used to route the traffic. You can then remove, change, or add a route, to resolve a routing problem.

:::image type="content" source="../media/network-watcher-next-hop-9c0905a8.png" alt-text="Screenshot of Network Watcher Next Hop.":::


## Diagnose outbound connections from a virtual machine

The *connection troubleshoots* capability enables you to test a connection between a virtual machine and another virtual machine, an FQDN, a URI, or an IPv4 address. The test returns similar information returned when using the connection monitor capability, but tests the connection at a point in time, rather than monitoring it over time, as connection monitor does.

### Capture packets to and from a virtual machine

Advanced filtering options and fine-tuned controls, such as the ability to set time and size limitations, provide versatility. The capture can be stored in Azure Storage, on the virtual machine's disk, or both. You can then analyze the capture file using several standard network capture analysis tools.

### Diagnose problems with an Azure Virtual network gateway and connections

Virtual network gateways provide connectivity between on-premises resources and Azure virtual networks. Monitoring gateways and their connections are critical to ensuring communication is not broken. The *VPN diagnostics* capability provides a way to diagnose gateways and connections. VPN diagnostics diagnoses the health of the gateway, or gateway connection, and informs you whether a gateway and gateway connections, are available. If the gateway or connection is not available, VPN diagnostics tells you why, so you can resolve the problem.

:::image type="content" source="../media/network-watcher-vpn-diagnostics-65309703.png" alt-text="Screenshot of Network Watcher VPN Diagnostics.":::
