With Azure Load Balancer, you can spread user requests across multiple Virtual Machines (VMs) or other services. That way, you can scale the app to larger sizes than a single VM could support and you ensure that users get service even when a VM has failed.

In your health care organization, you can expect large user demand. It's of vital importance to each user that they can book an appointment, even at times of peak demand or when VMs have failed.

Here, you will learn how the features of Load Balancer help you to create robust app architectures.

## Distributing traffic with Azure Load Balancer

Use Azure Load Balancer to scale applications and create high availability for your VMs and services. Load balancers use a hash-based distribution algorithm. By default, a 5-tuple hash is used to map traffic to available servers. The hash is made from the following elements:

- **Source IP** – the IP address of the requesting client.
- **Source port** – the port of the requesting client.
- **Destination IP** – the destination IP of the request.
- **Destination port** – the destination port of the request.
- **Protocol type** – the specified protocol type, For example, HTTP, HTTPS, HTTP/2.

<!-- TODO: Create a graphic based on this image. Source URL: https://docs.microsoft.com/azure/load-balancer/media/load-balancer-overview/load-balancer-distribution.png -->

![Overview of Load Balancer](../media/2-load-balancer-distribution.png)

Azure Load Balancer supports inbound and outbound scenarios, provides low latency and high throughput, and scales up to millions of flows for all TCP and UDP applications.

Load balancers aren't physical instances. Load balancer objects are used to express how Azure configures its infrastructure to meet your requirements. You can use the following two types of configuration groups to set up the load balancer:

| Configuration | SLA | Information |
| ------------- | --- | ----------- |
| **Availability set** |  99.95% | Protect from hardware failures within data centers |
| **Availability zone** |  99.99% | Protect from entire data center failure |
| | |

### Availability sets

An availability set is a logical grouping that you use to isolate VM resources from each other when they're deployed. Azure ensures that the VMs you put in an availability set run across multiple physical servers, compute racks, storage units, and network switches. If there's a hardware or software failure, only a subset of your VMs are affected – your overall solution stays operational. Availability sets are essential for building reliable cloud solutions.

<!-- TODO: Create an image similar to the one below, taken from: https://thebackroomtech.com/wp-content/uploads/azure-availability-sets.png -->

![Overview of Availability Sets](../media/2-availability-sets.png)

### Availability zones

An availability zone offers groups of one or more data centers that have independent power, cooling, and networking.

<!-- TODO: Create an image similar to the one below. Source URL: https://docs.microsoft.com/azure/availability-zones/media/az-overview/az-graphic-two.png -->

![Overview of Availability Zones](../media/2-az-graphic-two.png)

> [!NOTE]
> Availability zones don't support all VM sizes.

## Selecting the right SKU

Two SKUs are available when you create a load balancer:

### 1. Basic

Basic SKU load balancers allow:

- Port forwarding
- Automatic reconfiguration
- Health probes
- Outbound connections through Secure Network Address Translation (SNAT)
- Diagnostics through Azure Log Analytics for public-facing load balancers

These load balancers are agnostic of, and transparent to, the application that uses them. They can only be used with availability sets.

### 2. Standard

Standard SKU load balancers support all of the basic features. They also allow:

- HTTPS health probes
- Availability zones
- Diagnostics through Azure Monitor supporting multi-dimensional metrics
- High Availability (HA) ports
- Outbound rules
- A guaranteed Service Level Agreement (SLA) (99.99% for two or more virtual machines)

These load balancers can be used with availability sets and availability zones

## Internal and external load balancers

An external load balancer operates by distributing client traffic across multiple front end VMs. Client traffic may come from browsers, module apps, or other sources. In the healthcare organization, the balancer distributes the load of all the browsers that run the client healthcare application.

An internal load balancer distributes load across the backend tiers. In the healthcare organization, the balancer would distribute load across the internal application tier.
