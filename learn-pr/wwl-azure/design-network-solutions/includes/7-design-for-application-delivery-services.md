Azure offers several networking services to help deliver applications. In this unit, we examine Azure Content Delivery Network, Front Door, Traffic Manager, Load Balancer, and Application Gateway. 

### Azure Content Delivery Network

Azure Content Delivery Network offers a global solution for rapidly delivering high-bandwidth content to users. Content Delivery Network lets you cache your content at strategically placed physical nodes across the world.

#### Business scenarios

- Implement point-of-presence locations that are close to large clusters of users
- Reduce latency, both the transmission delay and the number of router hops
- Support Microsoft, Akamai, and Verizon content delivery networks
- Use custom domains, file compression, caching, and geo-filtering

### Azure Front Door

Azure Front Door lets you define, manage, and monitor the global routing for your web traffic by optimizing for best performance and instant global failover for high availability. With Front Door, you can transform your global (multi-region) consumer and enterprise applications into robust, high-performance personalized modern applications, APIs, and content that reaches a global audience with Azure.
 
#### Business scenarios

- Low latency: Ensure requests are sent to the lowest latency backends
- Priority: Support primary and secondary backends
- Weighted: Distribute traffic by using weight coefficients
- Affinity: Ensure requests from the same end user are sent to the same backend
- Support WAF and CDN integration for HTTP(S) traffic

### Azure Traffic Manager

Azure Traffic Manager is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Traffic Manager provides a range of traffic-routing methods to distribute traffic such as priority, weighted, performance, geographic, multi-value, and subnet. 

#### Business scenarios

- Increase application availability
- Improve application performance
- Combine hybrid applications
- Distribute traffic for complex deployments

### Azure Load Balancer

Azure Load Balancer provides high-performance, low-latency Layer 4 load-balancing for all UDP and TCP protocols.

#### Business scenarios

- Manage inbound and outbound connections 
- Configure public and internal load-balanced endpoints
- Manage service availability by mapping inbound connections to back-end pool destinations (via TCP and HTTP health-probe rules)

### Azure Application Gateway 

Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. Application Gateway is an Application Delivery Controller (ADC) as a service, offering various layer 7 load-balancing capabilities for your applications. There are two primary methods of routing traffic: path-based routing and multiple-site routing.

#### Business scenarios

- Path-based routing: Send requests with different URL paths to a different pool of back-end servers
- Multiple-site routing: Support tenants with virtual machines or other resources that host a web application
