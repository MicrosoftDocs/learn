Before the load balancer will function correctly, you must configure settings that control the load balancer's behavior. Here, you will look at configuring the network, health probe, security rules, load-balancing rules, and server pool.

## Steps for configuring a basic public load balancer

The following is an overview of the main configuration steps for a basic public load balancer. The steps for a standard load balancer and for an internal load balancer will be similar. There are essentially four things we need to setup:

- Backend servers to process requests
- Public IP address
- Health probe
- Load balancer rules

### Backend servers

First, you need to configure your backend VM pool. The VMs should be in the same availability set and have their own public IP address (although this will not actually be used by your public endpoints).

You must create a new virtual network and define a subnet for the VM pool to use.

 When you have multiple VMs providing the same services, you should use a **network security group (NSG)** to ensure that the same firewall rules are in place across the VM pool (although this is not part of the actual load-balancing process). For example, for VMs hosting web applications, you will need to create inbound security rules on port 80 for HTTP or port 8080 for HTTPS.

### Public IP address

When you create a public basic load balancer using the portal, the **public IP address** is automatically configured as the load balancer front end.

Part of the configuration of the load balancer is the **backend address pool**, containing the IP addresses of each VM's virtual NICs that are connected to the load balancer and used to distribute traffic to the VMs.

### Health probe

The health probe dynamically adds or removes VMs from the load balancer rotation based on their response to health checks. By default, there are 15 seconds between probe attempts. After two consecutive probe failures, a VM is considered unhealthy and traffic won't be routed there until the server comes back online.

### Rules

The load balancer rules identify the port(s) that the load balancer is listening on, and the port(s) used to send traffic to the back end set of VMs. You need at least one rule to route traffic.
