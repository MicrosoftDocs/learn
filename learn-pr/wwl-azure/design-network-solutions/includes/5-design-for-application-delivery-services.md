This section describes networking services in Azure that help deliver applications - Content Delivery Network, Azure Front Door Service, Traffic Manager, Load Balancer, and Application Gateway. 

## Content Delivery Network (CDN)

Azure Content Delivery Network (CDN) offers developers a global solution for rapidly delivering high-bandwidth content to users by caching their content at strategically placed physical nodes across the world.

When to use a CDN: 

- You want point-of-presence locations that are close to large clusters of users.

- You want to reduce latency - both the transmission delay and the number of router hops.

- You have networks in Microsoft, Akamai, or Verizon

- You want custom domains, file compression, caching, and geo-filtering

    :::image type="content" source="../media/content-delivery-network.png" alt-text="Content Delivery Network diagram":::


## Azure Front Door Service

Azure Front Door Service enables you to define, manage, and monitor the global routing for your web traffic by optimizing for best performance and instant global failover for high availability. With Front Door, you can transform your global (multi-region) consumer and enterprise applications into robust, high-performance personalized modern applications, APIs, and content that reaches a global audience with Azure.

:::image type="content" source="../media/front-door.png" alt-text="Azure Front Door Diagram.":::



Choose front door when: 

- You need to ensure that requests are sent to the lowest latency backends (low latency)

- You have primary and secondary backends (priority)

- You want to distribute traffic using weight coefficients (weighted)

- You want to ensure requests from the same end user gets sent to the same backend (affinity)

- Your traffic is HTTP(s) based and you need WAF and/or CDN integration

## Traffic Manager

Azure Traffic Manager is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Traffic Manager provides a range of traffic-routing methods to distribute traffic such as priority, weighted, performance, geographic, multi-value, or subnet. 

The following diagram shows endpoint priority-based routing with Traffic Manager:

:::image type="content" source="../media/traffic-manager-priority.png" alt-text="diagram shows endpoint priority-based routing with Traffic Manager.":::

Choose Traffic Manager when:
- You need to increase application availability 
- You need to improve application performance 
- You need to combine hybrid applications
- You need to distribute traffic for complex deployments 

## Load balancer

The Azure Load Balancer provides high-performance, low-latency Layer 4 load-balancing for all UDP and TCP protocols. It manages inbound and outbound connections. You can configure public and internal load-balanced endpoints. You can define rules to map inbound connections to back-end pool destinations by using TCP and HTTP health-probing options to manage service availability.

The following picture shows an Internet-facing multi-tier application that utilizes both external and internal load balancers:

:::image type="content" source="../media/load-balancer.png" alt-text="Diagram of an Internet-facing multi-tier application that utilizes both external and internal load balancers.":::

 

## Application Gateway 

Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. It is an Application Delivery Controller (ADC) as a service, offering various layer 7 load-balancing capabilities for your applications. 

There are two primary methods of routing traffic, path-based routing, and multiple site routing.

### Path-based routing

:::image type="content" source="../media/path-based.png" alt-text="Diagram of path-based routing in Azure.":::



Use path-based routing to send requests with different URL paths to a different pool of backend servers

### Multiple site routing

:::image type="content" source="../media/multiple-site.png" alt-text="Diagram of multi-site based routing.":::



Use multiple-site routing for tenants with virtual machines or other resources hosting a web application

## Choosing a load balancer solution 

Azure provides various load-balancing services that you can use to distribute your workloads across multiple computing resources – Azure Front Door, Traffic Manager, Load Balancer, and Application Gateway.

This section describes how you can determine an appropriate load-balancing solution for your business needs.

Azure load-balancing services can be categorized along two dimensions: global versus regional, and HTTP(S) versus non-HTTP(S).

When selecting the load-balancing options, here are some factors that are considered when you select the **Help me choose** default tab in Azure load balancing:

**Traffic type**. Is it a web (HTTP/HTTPS) application? Is it public facing or a private application?

**Global versus. regional**. Do you need to load balance VMs or containers within a virtual network, or load balance scale unit/deployments across regions, or both?

**Availability**. What is the service [SLA](https://azure.microsoft.com/support/legal/sla/)?

**Cost**. See [Azure pricing](https://azure.microsoft.com/pricing/). In addition to the cost of the service itself, consider the operations cost for managing a solution built on that service.

**Features and limits**. What are the overall limitations of each service? See [Service limits](/azure/azure-subscription-service-limits).

The following flowchart will help you to choose a load-balancing solution for your application. The flowchart guides you through a set of key decision criteria to reach a recommendation.

**Treat this flowchart as a starting point.** Every application has unique requirements, so use the recommendation as a starting point. Then perform a more detailed evaluation.

If your application consists of multiple workloads, evaluate each workload separately. A complete solution may incorporate two or more load-balancing solutions.

:::image type="content" source="../media/load-balancer-decision-tree.png" alt-text="Load balancer decision tree.":::