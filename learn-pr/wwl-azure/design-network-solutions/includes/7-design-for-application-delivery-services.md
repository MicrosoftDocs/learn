
Azure offers several AI-ready networking services to help deliver applications. In this unit, we examine Front Door, Traffic Manager, Load Balancer, and Application Gateway. Here's a high-level comparison table.

| Feature/Service | Azure Front Door | Application Gateway | Traffic Manager | Load Balancer  |
| --- |--- | ---| --- | --- |
| Type | Global | Regional | Global | Regional/Global |
| Layer	| Layer 7 (HTTP/HTTPS) | Layer 7 (HTTP/HTTPS) | DNS-based | Layer 4 (TCP/UDP) |
| Primary Use Case | Web traffic load balancing, application acceleration, and global routing | Web application firewall, TSL/SSL termination, and HTTP load balancing | DNS-based traffic routing for high availability and performance | Internal and external load balancing for non-HTTP(S) traffic |
| Key Features | Path-based routing, TSL/SSL offload, Web Application Firewall (WAF), URL-based routing | Path-based routing, TSL/SSL offload, Web Application Firewall (WAF), URL-based routing | DNS-based routing, geographic routing, priority routing, weighted routing | High availability, low latency, zonal and zone-redundant endpoints |
| Scalability | High | High | High | High |
| Cost | Based on data processed and rules applied | Based on data processed, rules applied, and SKU | Based on DNS queries, health checks, and data points processed | Based on rules and data processed |


The different load balancers can work together in your networking architecture. 

:::image type="content" source="../media/front-door-application-gateway.png" alt-text="Diagram showing an architecture with the different load balancers." border="false":::

### Azure Front Door

[Azure Front Door](/azure/frontdoor/front-door-overview) lets you define, manage, and monitor the global routing for your web traffic by optimizing for best performance and instant global failover for high availability. With Front Door, you can transform your global (multi-region) consumer and enterprise applications into robust, high-performance personalized modern applications, APIs, and content that reaches a global audience with Azure.
 
#### Business scenarios

- Low latency: Ensure requests are sent to the lowest latency backends.
- Priority: Support primary and secondary backends.
- Weighted: Distribute traffic by using weight coefficients.
- Affinity: Ensure requests from the same end user are sent to the same backend.
- Support WAF and CDN integration for HTTP(S) traffic.
- Support for content delivery services. 

> [!Tip]
> Learn more with the [Introduction to Azure Front Door](/training/modules/intro-to-azure-front-door/) training module. 

### Azure Traffic Manager

[Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Traffic Manager provides a range of traffic-routing methods to distribute traffic such as priority, weighted, performance, geographic, multi-value, and subnet. 

#### Business scenarios

- Increase application availability.
- Improve application performance.
- Combine hybrid applications.
- Distribute traffic for complex deployments.

> [!Tip]
> Learn more with the [Enhance your service availability and data locality by using Azure Traffic Manager](/training/modules/distribute-load-with-traffic-manager/) training module. 


### Azure Load Balancer

[Azure Load Balancer](/azure/load-balancer/load-balancer-overview) provides high-performance, low-latency Layer 4 load-balancing for all UDP and TCP protocols.

#### Business scenarios

- Manage inbound and outbound connections.
- Configure public and internal load-balanced endpoints.
- Manage service availability by mapping inbound connections to back-end pool destinations (via TCP and HTTP health-probe rules).

> [!Tip]
> Learn more with the [Introduction to Azure Load Balancer](/training/modules/intro-to-azure-load-balancer/) training module.


### Azure Application Gateway 

[Azure Application Gateway](/azure/application-gateway/overview) is a web traffic load balancer that enables you to manage traffic to your web applications. Application Gateway is an Application Delivery Controller (ADC) as a service, offering various layer 7 load-balancing capabilities for your applications. There are two primary methods of routing traffic: path-based routing and multiple-site routing.

#### Business scenarios

- Path-based routing: Send requests with different URL paths to a different pool of back-end servers.
- Multiple-site routing: Support tenants with virtual machines or other resources that host a web application.

> [!Tip]
> Learn more with the [Introduction to Azure Application Gateway](/training/modules/intro-to-azure-application-gateway/) training module.