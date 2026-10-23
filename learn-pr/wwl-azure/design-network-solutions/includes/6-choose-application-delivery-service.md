Azure offers several AI-ready load-balancing services for distributing your workloads across multiple computing resources. As you review the options, there are several factors to consider in your planning.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=51df5643-ed38-4257-b585-14ff9eccdafc]

### Things to know about load balancing

When selecting an Azure load-balancing service, consider these configuration characteristics.

- **Traffic type**: Are you designing a web (HTTP/HTTPS) application? Is the app public facing or is it private?

- **Global versus regional**: Do you need to load balance virtual machines or containers within a virtual network, or load balance scale unit/deployments across regions, or both?

- **Availability**: Does the service [SLA](https://azure.microsoft.com/support/legal/sla/) meet your requirements?

- **Cost**: What are your cost expectations? You can review the [Azure pricing](https://azure.microsoft.com/pricing/) options. In addition to the cost of the service itself, consider the operations cost for managing a solution built on that service.

- **Features and limits**: What are the overall limitations of each service? You can review the [service limits](/azure/azure-subscription-service-limits).

In the next unit, we examine features of several load-balancing services, including Azure Front Door, Traffic Manager, Load Balancer, and Application Gateway. 

### Things to consider when choosing load balancing

Use the traffic type, application scope, and required routing features to identify candidate services. The following table summarizes common starting points.

| Service | When to consider it |
| --- | --- |
| Azure Front Door | Global HTTP(S) delivery with edge acceleration, TLS termination, and application-layer routing. |
| Application Gateway | Regional HTTP(S) routing, TLS termination, and web application firewall capabilities for public or private applications. |
| Regional Azure Load Balancer | TCP or UDP load balancing within a region when application-layer routing isn't required. |
| Global Azure Load Balancer | Public TCP or UDP traffic distributed across regional Standard Load Balancers through a single global public IP address. |
| Traffic Manager | DNS-based endpoint selection across regions or clouds when DNS-based routing and failover meet your requirements. |
| Application Gateway for Containers | Managed application-layer ingress for Azure Kubernetes Service (AKS). Evaluate it alongside other supported Kubernetes ingress options. |

> [!Tip]
> **Treat these recommendations as a starting point.**
> Every application has unique requirements, so use these recommendations as a starting point in your planning.

After you identify possible solutions for your requirements, apply the options to your scenarios and do a detailed evaluation. If your application consists of multiple workloads, evaluate each workload separately. A complete solution might incorporate two or more load-balancing solutions.

Azure Front Door provides TLS termination and application-layer routing without requiring Application Gateway. Combine the services when your design also needs Application Gateway's regional capabilities, not solely because the application requires TLS offload.

For the current service comparison and design considerations, see [Load balancing options](/azure/architecture/guide/technology-choices/load-balancing-overview).