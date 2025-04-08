The term load balancing refers to the even distribution of incoming network workloads to a group of backend computing resources or servers. Load balancing aims to optimize resource use, maximize throughput, minimize response time, and avoid overloading any single resource. Load balancing can also improve availability by sharing a workload across redundant computing resources.

## Load Balancing options for Azure

Azure provides various load balancing services that you can use to distribute your workloads across multiple computing resources, but the following are the main services:

 -  **Azure Load Balancer**. High-performance, ultra-low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. The load balancer can handle millions of requests per second ensuring your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across availability zones.
 -  **Traffic Manager**. DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load-balances only at the domain level. For that reason, it can't fail over as quickly as Front Door.
 -  **Azure Application Gateway**. Provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. Use it to optimize web farm productivity by offloading CPU-intensive SSL termination to the gateway.
 -  **Azure Front Door**. Application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application. Front Door includes SSL offload, path-based routing, fast failover, and caching. 

## Categorizing load balancing services

Load balancing services can be categorized in two ways: global versus regional, and HTTP(S) versus non-HTTP(S).

### Global versus regional

**Global** load-balancing services distribute traffic across regional backends, clouds, or hybrid on-premises services. These services route end-user traffic to the closest available backend. They also react to changes in service reliability or performance. You can think of them as systems that load balance between application stamps, endpoints, or scale-units hosted across different regions/geographies.

In contrast, **Regional** load-balancing services distribute traffic within virtual networks across virtual machines (VMs) or zonal and zone-redundant service endpoints within a region. You can think of them as systems that load balance between VMs, containers, or clusters within a region in a virtual network.

### HTTP(S) versus non-HTTP(S)

**HTTP(S)** load-balancing services are Layer 7 load balancers that only accept HTTP(S) traffic. They're intended for web applications or other HTTP(S) endpoints. They include features such as SSL offload, web application firewall, path-based load balancing, and session affinity.

In contrast, **non-HTTP(S)** load-balancing services can handle non-HTTP(S) traffic and are recommended for nonweb workloads.

> [!IMPORTANT]
> In this module, we're focusing on the non-HTTP(S) solutions.

This table summarizes these categorizations for each Azure load balancing service.

| Service             | Global/regional | Recommended traffic |
| ------------------- | --------------- | ------------------- |
| Azure Front Door    | Global          | HTTP(S)             |
| Traffic Manager     | Global          | non-HTTP(S)         |
| Application Gateway | Regional        | HTTP(S)             |
| Azure Load Balancer | Regional        | non-HTTP(S)         |



## Choosing a load balancing option for Azure

Here are the key factors to decide on a load balancing option.

 -  **Type of traffic** - is it for a web application? Is it a public-facing or private application?
 -  **Scope** - do you need to load balance virtual machines and containers within a virtual network, or load balance across regions, or both? 
 -  **Availability** - what is the Service Level Agreement (SLA) for the service?
 -  **Cost** - In addition to the cost of the actual service itself, consider the operational cost to manage and maintain a solution built on that service. See [Load balancing pricing](https://azure.microsoft.com/pricing/details/load-balancer/).
 -  **Features and limitations** - what features and benefits does each service provide, and what are its limitations? See [Load balancer limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

This [flowchart](/azure/architecture/guide/technology-choices/load-balancing-overview#decision-tree-for-load-balancing-in-azure) helps you select the most appropriate load-balancing solution for your application.

:::image type="content" source="../media/load-balancing-decision-tree-3f132096.png" alt-text="flow chart to help select a load-balancing solution for your application.":::

> [!TIP]
> You should use this flowchart and the suggested recommendation only as a starting point. A completed solution can incorporate two or more load-balancing solutions.

## How to select a non-HTTP(S) load balancing solution (video)

This video reviews how to select a load balancing solution. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=86a4202c-057d-4a20-ba74-50dc2c730b08]


## Selecting a load balancing solution by using the Azure portal

You can use the **Azure Load Balancing** page in the Azure portal to help guide you to a load-balancing solution. Search for and select **Load balancing - help me choose**. The wizard provides an interactive way to select a load balancing solution.
    
:::image type="content" source="../media/choosing-load-balancing-service-2-a7b58c9f.png" alt-text="Screenshot of Azure load balancing page 2 help.":::
  