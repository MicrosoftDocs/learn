IP subnets often are separated by a router. The router address typically is configured as the default gateway in the IP settings. The router is responsible for:

- Routing incoming and outgoing IP traffic

- Delivering the IP traffic to its intended destination

In many cases, organizations separate their local network from the public Internet by using a perimeter network (also known as a screened subnet). The perimeter network contains IP endpoints that must be reachable from the public Internet, but that should not be located on the local network for functional or security reasons.

## What do routers do?

When a router receives traffic destined for an endpoint outside of the local network, it:

1. Checks to determine whether it has a route to the destination network. Then:

   1. If the route exists, the router forwards the packet to the destination network router address.

   1. If a route does not exist, the router sends the traffic to the router's default gateway or default route.

Traffic travel between routers and IP endpoints is often described in hops. One hop represents the traffic between two individual routers, or between a router and an IP endpoint. When a router forwards IP traffic, it does so in a way that will minimize the number of hops between IP endpoints. Routers send traffic to destinations based on a set of data called routing tables. Routing tables contain:

- All routes of which the router is aware.

- Information on which connections lead to different IP address ranges.

- Priorities for connections to be used.

- Rules for routing both typical and special cases of traffic.

## What are routing tables?

Usually, the data stored in routing tables is dynamic. These tables are updated by using routing protocols, such as RIP or OSPF. Routing tables contain the following information about a route for a specific interface:

- Network destination. The destination host where the traffic is to be transmitted.

- Netmask. The subnet mask for the route.

- Gateway. The gateway address to be used for IPv4 traffic using the route.

- Interface. The IP interface address number for the route.

- Metric. The relative cost for the route. Lower values represent less cost.

Since IP network connectivity depends on routing, if you experience problems that relate to routing, you must investigate and resolve those problems quickly.

## Review and modify routing tables

There are several ways you can view or modify the routing table for a computer running Windows Server.

### Use Windows PowerShell

You can use Windows PowerShell cmdlets to review and modify routing tables.

For example, to view the IPv4 routing table, run the following command at the Windows PowerShell command line:

`Get-NetRoute –AddressFamily IPv4`

To create a new route in the routing table, use the `New-NetRoute` cmdlet. For example, the following command adds a new route on the network adapter with the interface index of 10 for the 10.0.0.0/8 network, and direct it to the gateway at 192.168.0.1:

`New-NetRoute –InterfaceIndex 10 –DestinationPrefix 10.0.0.0/8 –NextHop 192.168.0.1`

You also can change route settings with the `Set-NetRoute` cmdlet. Typically, you use `Set-NetRoute` to adjust metric values for existing routes.

> [!WARNING]
> You cannot modify the DestinationPrefix or NextHop properties of an existing route by using `Set-NetRoute`.
### Use the route command

You can also use the Route command-lint tool. To view the routing table, run the following command in a Command Prompt window:

`route print`

This command will output a text-based table displaying the following information:

- Network destination. The destination host where the traffic is to be transmitted.

- Netmask. The subnet mask for the route.

- Gateway. The gateway address to be used for IPv4 traffic using the route.

- Interface. The IPv4 interface address number for the route.

- Metric. The relative cost for the route. Lower values represent less cost, which typically means a shorter round trip for the packets.

To modify the routing table, you can use the route command with either the Add, Delete, or Change commands, specifying the preceding parameters. For example, the following command will add a new route for the 10.0.0.0/8 network, and direct it to the gateway at 192.168.0.1 with a relatively low metric of 2:

`Route add 10.0.0.0 netmask 255.0.0.0 192.168.0.1 metric 2`

