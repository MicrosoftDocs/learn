## Configure public load balancer

As the solution architect for the healthcare portal. You would like to distribute the load from the client browsers over the VMs within your web farm. You will need to setup a load balancer and configure the VMs to be balanced

A public Load Balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of a VM in the backend pool. The responses from that VM are then returned to the client. You can distribute specific types of traffic across multiple VMs or services, by applying load-balancing rules.

### Distribution

By default, Azure Load Balancer distributes network traffic equally among VM instances. The following distribution modes are also possible if different behavior is required:

| Distribution Mode | Details |
|-------------------|---------|
| **Hash Based** |   |
| **Source IP Affinity** |   |