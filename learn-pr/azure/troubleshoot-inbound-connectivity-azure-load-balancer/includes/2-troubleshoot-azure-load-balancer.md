Azure Load Balancer operates at the transport layer of the network stack. Load Balancer advertises a single public IP address to which all clients connect. Load Balancer then uses its own routing and address translation rules to direct incoming TCP requests to one of a set of outbound addresses. Typically, each outbound address is associated with a different virtual machine, each running an instance of your application. 

Load Balancer uses a health probe to determine the availability of each virtual machine that's referenced by addresses in the back-end pool. Load Balancer only sends requests to virtual machines that indicate they're healthy.

In the example scenario, you've been receiving alerts indicating that Load Balancer can't direct requests to virtual machines in the back-end pool. You suspect a recent change in network configuration might be causing the problem, but you need to understand how network changes affect the operation of Load Balancer.

By the end of this unit, you'll be able to:

- Describe a typical configuration of Load Balancer, and the various components involved in routing requests to virtual machines.
- Explain common problems that can cause Load Balancer to fail to distribute requests to virtual machines.

## How does Load Balancer work?

Azure Load Balancer comprises a number of components:

- A front-end IP address
- A backend pool of virtual machine addresses
- One or more routing rules
- A health probe
- A collection of virtual machines, typically in a virtual network

The diagram below shows how the various elements used by Load Balancer operate together.

![Diagram showing the components of Azure Load Balancer](../media/2-LoadBalancer.png)

### The front-end IP address and backend pool

The purpose of Load Balancer is to provide a transparent, end-to-end connection from a client to an application that runs on a collection of virtual machines. Load Balancer stores the IP addresses of these virtual machines in a repository commonly referred to as a *back-end pool*. Load Balancer exposes its own *front-end* IP address to clients. When a client sends a request to this address, Load Balancer takes responsibility for selecting the IP address of a virtual machine from the back-end pool. Load Balancer then routes the request through this back-end IP address to the virtual machine.

The client isn't aware of Load Balancer. The client sees an IP address or DNS name, and sends requests to this destination. This process is the same as if the client was communicating directly with the virtual machine. When the request arrives on the virtual machine, the address of the original client is preserved.

Additionally, the payload of messages sent from the client to the virtual machine are opaque to Load Balancer. Load Balancer doesn't examine the contents of any messages or manipulate them, other than readdressing them so that they're sent to the selected virtual machine.

Load Balancer selects the IP address of a virtual machine from the backend pool using an algorithm designed to distribute requests evenly. Load Balancer generates a hash using the source IP and port address of the client, the destination IP address and port, and the network protocol. The hashed value is used as a key into a table holding the IP addresses in the back-end pool.

### Scalability

Load Balancer scales automatically. You can start additional virtual machine instances and add their IP addresses to the back-end pool at any time. Load Balancer will include these new instances when it distributes user requests.

Load Balancer can expose more than one public front-end IP address, and might have multiple back-end pools. This scheme enables you to reuse the same instance of Load Balancer to handle requests for different systems.

### Routing rules

You define load-balancing rules to specify how requests directed towards each front-end IP address are mapped to a back-end pool. A load-balancing rule also specifies the protocol to match against, and optionally the source (client) and destination ports. Incoming requests arriving on a front-end IP address that don't match the protocol and port requirements will be discarded by Load Balancer. A load-balancing rule can also configure session persistence, so that a given client is likely to have its requests routed to the same virtual machine. In this way, applications running on a virtual machine take advantage of caching to hold session-specific information.

### Health probes

Load Balancer needs to determine whether each virtual machine referenced by the back-end pool is available for handling requests; you add a health probe to do this. A health probe sends regular *ping* messages to a port that you specify for the virtual machines in the back-end pool. You provide a service on the virtual machines that responds to these ping messages, with an HTTP 200 (OK) message.

When the virtual machine fails to respond after a specified number of attempts, Load Balancer assumes it's unhealthy and removes it from the list of virtual machines that can accept user requests. The workload is then distributed among the remaining healthy virtual machines. Load Balancer continues to ping an unresponsive virtual machine. If the virtual machine starts to reply, it's added back into the list of healthy virtual machines and starts receiving user requests again.

Note that if you don't provide a health probe, Load Balancer has no way of knowing whether a virtual machine is healthy. Instead, it will assume that all virtual machines are responsive.

### The virtual network

The virtual machines referenced by the back-end pool are typically in a virtual network subnet, hosted by Azure. You protect the virtual machines in this network by configuring a network security group (NSG). An NSG implements inbound and outbound security rules that can limit the traffic entering and exiting the virtual network to a set of well-defined endpoints.

For example, the virtual machines in the back-end pool of Load Balancer would typically allow inbound traffic on port 80 (HTTP), and port 443 (HTTPS) that arrives from outside of the virtual network, but might block traffic that appears on other ports.

## Symptoms and causes of failure with Load Balancer

Problems arise when Load Balancer loses connectivity with one or more virtual machines in the back-end pool. Typical symptoms include:

- The application is unreachable.
- The virtual machines running the application are unreachable.
- Slow response times.
- User requests timing out.

There can be many reasons for these failures, most commonly associated with probing issues and data path issues.

### Probing issues

Probing issues result when one or more virtual machines in the backend pool fail to respond to health probe requests. These could be a result of:

- A network security group rule in the virtual network housing the virtual machines blocking the IP addresses or ports used by probe requests.
- An incorrect probe configuration, such as the wrong URL or port.
- A virtual machine failing to respond to the probe because of an application issue, or the required port not being open.
- A failure of one or more virtual machines in the backend pool, leading to possible overloading, slow responses, and timeouts.

### Data path issues

Data path issues occur when a Load Balancer is unable to route a client request to the application running on a virtual machine in the backend pool. Possible causes include:

- A network security group rule or firewall blocking the ports used by the application.
- A virtual machine is down or not responding. This could be due to the virtual machine being turned off or failing, or a security issue such as an expired certificate on the server.
- The application is not responding. This could be the result of the virtual machines being overloaded, the application listening on an incorrect port, or the application crashing.
