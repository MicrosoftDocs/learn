Azure Application Gateway can meet your organization’s needs for the following reasons: 

- Azure Application Gateway routing allows traffic to be directed from an endpoint in Azure to a back-end pool made up of servers running in Adatum’s on-premises datacenter. The health-probe functionality of Azure Application Gateway ensures that traffic isn't being directed to any server that may have become unavailable.
- Azure Application Gateway TLS termination functionality reduces the amount of CPU capacity that servers in the back-end pool allocate to encryption and decryption operations.
- Azure Application Gateway allows Adatum to use a web application firewall to block cross-site scripting and SQL injection traffic before it reaches servers in the back-end pool.
- Azure Application Gateway supports session affinity, required because the several web applications deployed by Adatum use user session state information stored locally on individual servers in the back-end pool.

## When not to use Azure Application Gateway

Azure Application Gateway isn’t appropriate if you have a web application that doesn’t require load balancing. For example, if you have a web application that only receives a small amount of traffic and the existing infrastructure already competently deals with the existing load, there's no need to deploy a back-end pool of web apps or virtual machines and no need for Application Gateway.

Azure provides other load balancing solutions, including Azure Front Door, Azure Traffic Manager, and Azure Load Balancer. The following list describes the differences between these services:

- **Front Door** is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like TLS/SSL offload, path-based routing, fast failover, web application firewall, and caching to improve performance and high-availability of your applications. You'd choose this option in scenarios such load balancing a web app deployed across multiple Azure regions.
- **Traffic Manager** is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load-balances only at the domain level. For that reason, it can't fail over as quickly as Front Door because of common challenges around DNS caching and systems not honoring DNS TTLs.
- **Azure Load Balancer** is a high-performance, ultra low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It's built to handle millions of requests per second while ensuring that your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across availability zones. Azure Load Balancer works within a region rather than globally.
- **Application Gateway** provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. You can use it to optimize web-farm productivity by offloading CPU-intensive TLS/SSL termination to the gateway. Application Gateway works within a region rather than globally.
