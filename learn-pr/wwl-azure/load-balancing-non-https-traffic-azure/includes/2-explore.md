The term load balancing refers to the even distribution of workloads (that is, incoming network traffic), across a group of backend computing resources or servers. Load balancing aims to optimize resource use, maximize throughput, minimize response time, and avoid overloading any single resource. It can also improve availability by sharing a workload across redundant computing resources.

## Load Balancing options for Azure

Azure provides various load balancing services that you can use to distribute your workloads across multiple computing resources, but the following are the main services:

 -  **Azure Load Balancer** - high-performance, ultra-low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It is built to handle millions of requests per second while ensuring your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across Availability Zones.
 -  **Traffic Manager** - DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load-balances only at the domain level. For that reason, it can't fail over as quickly as Front Door, because of common challenges around DNS caching and systems not honoring DNS time-to-live values (TTLs).
 -  **Azure Application Gateway** - provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. Use it to optimize web farm productivity by offloading CPU-intensive SSL termination to the gateway.
 -  **Azure Front Door** - application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, caching, etc. to improve performance and high-availability of your applications.

## Categorizing load balancing services

The above load balancing services can be categorized in two ways: global versus regional, and HTTP(S) versus non-HTTP(S).

### Global versus regional

**Global** load-balancing services distribute traffic across regional backends, clouds, or hybrid on-premises services. These services route end-user traffic to the closest available backend. They also react to changes in service reliability or performance, in order to maximize availability and performance. You can think of them as systems that load balance between application stamps, endpoints, or scale-units hosted across different regions/geographies.

In contrast, **Regional** load-balancing services distribute traffic within virtual networks across virtual machines (VMs) or zonal and zone-redundant service endpoints within a region. You can think of them as systems that load balance between VMs, containers, or clusters within a region in a virtual network.

### HTTP(S) versus non-HTTP(S)

**HTTP(S)** load-balancing services are Layer 7 load balancers that only accept HTTP(S) traffic. They are intended for web applications or other HTTP(S) endpoints. They include features such as SSL offload, web application firewall, path-based load balancing, and session affinity.

In contrast, **non-HTTP(S)** load-balancing services can handle non-HTTP(S) traffic and are recommended for non-web workloads.

The table below summarizes these categorizations for each Azure load balancing service.

| Service             | Global/regional | Recommended traffic |
| ------------------- | --------------- | ------------------- |
| Azure Front Door    | Global          | HTTP(S)             |
| Traffic Manager     | Global          | non-HTTP(S)         |
| Application Gateway | Regional        | HTTP(S)             |
| Azure Load Balancer | Regional or Global        | non-HTTP(S)         |


## Choosing a load balancing option for Azure

When choosing an appropriate load balancing option, there are some key factors to consider:

 -  **Type of traffic** - is it for a web application? Is it a public-facing or private application?
 -  **Scope** - do you need to load balance virtual machines and containers within a virtual network, or load balance across regions, or both? (see 'Global versus regional' above)
 -  **Availability** - what is the Service Level Agreement (SLA) for the service?
 -  **Cost** - In addition to the cost of the actual service itself, consider the operational cost to manage and maintain a solution built on that service. See [Load balancing pricing](https://azure.microsoft.com/pricing/details/load-balancer/).
 -  **Features and limitations** - what features and benefits does each service provide, and what are its limitations? See [Load balancer limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

The flowchart below will help you to select the most appropriate load-balancing solution for your application, by guiding you through a set of key decision criteria in order to reach a recommendation.

:::image type="content" source="../media/load-balancing-decision-tree-3f132096.png" alt-text="flow chart to help select a load-balancing solution for your application":::


**As every application will have its own unique requirements, you should only use this flowchart and the suggested recommendation as a starting point, and then perform a more detailed evaluation yourself in order to select the best option for your environment.**

**If your application consists of multiple workloads, evaluate each workload separately. A complete solution may incorporate two or more load-balancing solutions.**

## Selecting a load balancing solution by using the Azure portal

You can use the **Azure Load Balancing** page in the Azure portal to help you guide to the right load-balancing solution for your business need. Azure Load Balancing includes the decision-making queries described in the workflow diagram above.

 -  Sign into the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
 -  In the search box at the top of the page, type load balancing. When **Load balancing - help me choose (Preview)** appears in the search results, click it.
    
    :::image type="content" source="../media/choosing-load-balancing-service-1-b14cd6e9.png" alt-text="Azure portal screenshot of Load balancing - help me choose":::
    
 -  Answer the Yes or No questions on this page to get a recommended solution. Note, that the final recommended solution may be a combination of multiple load balancing services. 

    :::image type="content" source="../media/choosing-load-balancing-service-2-a7b58c9f.png" alt-text="Azure portal screenshot load balancing help me choose":::
    
 -  Depending on what answers you give, the list of potential load balancing services will change.

    :::image type="content" source="../media/choosing-load-balancing-service-3-936f9c14.png" alt-text="Azure portal screenshot Load balancing help me choose":::
    
 -  Optionally, you can also click the **Service comparison** or **Tutorial** tabs for more information and training on the different load balancing services.

Now let's look at each of the main Azure load balancing services in more detail.