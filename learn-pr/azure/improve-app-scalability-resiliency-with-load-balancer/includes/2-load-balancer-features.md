With Azure Load Balancer, you can spread user requests across multiple virtual machines or other services. That way, you can scale the app to larger sizes than a single virtual machine could support and you ensure that users get service even when a virtual machine has failed.

In your health care organization, you can expect large user demand. It's of vital importance to each user that they can book an appointment, even at times of peak demand or when virtual machines have failed. If you use multiple virtual servers for your front-end and a load balancer to distribute traffic between them, you achieve a high capacity, because all the virtual servers collaborate to satisfy requests. You also improve resilience, because the load balancer can automatically route traffic away when a virtual server fails.

Here, you will learn how the features of Load Balancer help you to create robust app architectures.

## Distributing traffic with Azure Load Balancer

Azure Load Balancer is a service you can use to distribute traffic across multiple virtual machines. Use Azure Load Balancer to scale applications and create high availability for your virtual machines and services. Load balancers use a hash-based distribution algorithm. By default, a five-tuple hash is used to map traffic to available servers. The hash is made from the following elements:

- **Source IP** – the IP address of the requesting client.
- **Source port** – the port of the requesting client.
- **Destination IP** – the destination IP of the request.
- **Destination port** – the destination port of the request.
- **Protocol type** – the specified protocol type, For example, HTTP, HTTPS, HTTP/2.

![Overview of Load Balancer](../media/2-load-balancer-distribution.svg)

Azure Load Balancer supports inbound and outbound scenarios, provides low latency and high throughput, and scales up to millions of flows for all TCP and UDP applications.

Load balancers aren't physical instances. Load balancer objects are used to express how Azure configures its infrastructure to meet your requirements.

To achieve high availability with load balancer, you can choose to use availability sets and availability zones to ensure that virtual machines are always available:

| Configuration | Service Level Agreement (SLA) | Information |
| ------------- | --- | ----------- |
| **Availability set** |  99.95% | Protect from hardware failures within data centers |
| **Availability zone** |  99.99% | Protect from entire data center failure |
| | |

### Availability sets

An availability set is a logical grouping that you use to isolate virtual machine resources from each other when they're deployed. Azure ensures that the virtual machines you put in an availability set run across multiple physical servers, compute racks, storage units, and network switches. If there's a hardware or software failure, only a subset of your virtual machines is affected – your overall solution stays operational. Availability sets are essential for building reliable cloud solutions.

![Overview of Availability Sets](../media/2-availability-sets.svg)

### Availability zones

An availability zone offers groups of one or more data centers that have independent power, cooling, and networking. The virtual machines in an availability zone are placed in different physical locations within the same region. Use this architecture when you want to ensure that, when an entire data center fails, you can continue to serve users.

![Overview of Availability Zones](../media/2-az-graphic-two.svg)

Availability zones don't support all virtual machine sizes and are not available in all Azure regions. Check that they are supported in your region before you use them in your architecture.

## Selecting the right load balancer product

Two products are available when you create a load balancer: basic load balancers and standard load balancers.

Basic load balancers allow:

- Port forwarding
- Automatic reconfiguration
- Health probes
- Outbound connections through source network address translation (SNAT)
- Diagnostics through Azure Log Analytics for public-facing load balancers

Basic load balancers can only be used with availability sets.

Standard load balancers support all of the basic features. They also allow:

- HTTPS health probes
- Availability zones
- Diagnostics through Azure Monitor supporting multidimensional metrics
- High availability (HA) ports
- Outbound rules
- A guaranteed service level agreement (SLA) (99.99% for two or more virtual machines)

## Internal and external load balancers

An external load balancer operates by distributing client traffic across multiple virtual machines. An external load balancer permits traffic from the internet. The traffic may come from browsers, module apps, or other sources. In the healthcare organization, the balancer distributes the load of all the browsers that run the client healthcare application.

An internal load balancer distributes load from internal Azure resources to other Azure resources. For example, if you have front-end web servers that need to call business logic hosted on multiple middle-tier servers, you can distribute that load evenly by using an internal load balancer. No traffic is allowed from internet sources. In the healthcare organization, the balancer would distribute load across the internal application tier.
