Some applications have so much incoming traffic that the single server hosting them becomes overwhelmed and can't respond to client requests in a timely manner. Instead of continuously adding network capacity, processors, disk resources, and RAM, you can address this traffic by implementing load balancing. Load balancing distributes incoming network flows across multiple back-end instances. Azure Load Balancer uses hash-based distribution, so it doesn't guarantee equal request counts, data volumes, or processing load on every instance. A pool of computers that have lower levels of resources often responds to traffic more effectively than a single server with higher performance.

Azure Load Balancer distributes incoming network traffic across a group of Azure VMs or instances in a Virtual Machine Scale Set.

This module describes Standard Load Balancer for regional public and internal application load balancing. Public front ends use Standard public IP addresses. Select the load balancer type, front-end configuration, back-end pool, and network-access rules together.

Load Balancer delivers high availability and network performance in the following ways:

- Load-balancing rules determine how traffic is distributed to instances that comprise the back end.
- With the default probe-controlled behavior, health probes determine whether back-end instances can receive new flows.

You can deploy **public** load balancers and **internal** (or *private*) load balancers in Azure:  

- *Public load balancers* are used to load balance internet traffic to your virtual machines (VMs). A public load balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of the back-end pool VMs. For example, you can spread the load of incoming web-request traffic from the internet across multiple web servers. A public load balancer can also provide outbound connections for VMs inside your virtual network.  
- An *internal load balancer* directs traffic to resources that are inside a virtual network or that use a VPN to access Azure infrastructure. Internal load balancer front-end IP addresses and virtual networks are never directly exposed to an internet endpoint. Internal line-of-business (LOB) applications run in Azure and are accessed from within Azure or from on-premises resources. An internal load balancer is used where private IPs are needed at the front end only. Internal load balancers are often used to balance traffic from the front-end web tier infrastructure as a service (IaaS) VMs across a set of secondary VMs that perform tasks such as performing calculations or data processing.

An internal load balancer enables the following types of load balancing:

- **Within a virtual network**: Load balancing from VMs in the virtual network to a set of VMs that reside within the same virtual network.
- **For a cross-premises virtual network**: Load balancing from on-premises computers to a set of VMs that reside within the same virtual network.
- **For multi-tier applications**: Load balancing for internet-facing multi-tier applications where the back-end tiers aren't internet-facing. The back-end tiers require traffic load balancing from the internet-facing tier.
- **For LOB applications**: Load balance traffic to line-of-business applications hosted on Azure VMs. On-premises computers can access an internal load balancer through a VPN or ExpressRoute connection. These computers are clients of the application, not members of the load balancer's back-end pool.

Both public and internal load balancers distribute incoming traffic to back-end instances and can scale to millions of Transmission Control Protocol (TCP) and User Datagram Protocol (UDP) flows. A regional public Standard Load Balancer can also provide source network address translation (SNAT) for connections initiated by those instances. An internal load balancer doesn't itself provide public internet egress. Its back-end VMs need a separate explicit outbound method when they must reach public endpoints. Return traffic for an established inbound connection is different from a new connection initiated by a back-end VM.
