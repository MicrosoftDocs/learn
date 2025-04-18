

[Azure Front Door](/azure/frontdoor/front-door-overview) is Microsoft’s modern cloud Content Delivery Network (CDN) that provides fast, reliable, and secure access between your users and your applications. Azure Front Door delivers your content using the Microsoft’s global edge network with hundreds of global and local POPs distributed around the world close to both your enterprise and consumer end users.

## Azure Front Door tiers

Azure Front Door provides both content delivery and security features. **Azure Front Door Standard** is content-delivery optimized.

- Provide for both static and dynamic content acceleration.
- Support global load balancing.
- Implement SSL offload.
- Implement domain and certificate management.
- Benefit from enhanced traffic analytics.
- Benefit from basic security capabilities.

**Azure Front Door Premium** is security optimized.

- Extensive security capabilities across Web Application Firewall.
- BOT protection.
- Private Link support.
- Integration with Microsoft Threat Intelligence and security analytics.

## Azure Front Door usage cases

:::image type="content" source="../media/front-door-visual-diagram-d5870052.png" alt-text="Diagram of the Azure Front Door architecture.":::

This diagram shows a user request processed by Azure Front Door. 

1. A user is requesting `www.contoso.com`. This request is routed from the client to Azure Front Door. Azure Front Door resides at the edge of the Microsoft Global Network. In Azure, an edge location is a data center that's geographically closer to end-users than traditional Azure regions. These locations are designed to cache content and deliver services with lower latency, improving the speed and responsiveness of applications for users worldwide.
1. Azure Front Door determines where to direct the client request. The routing process includes the web application firewall, routing rules, rules engine, and caching configuration.  
1. A nonspecific request can be routed to any one of the three regions.
1. A search request can be routed to a specific region optimized for search. 
1. A request can even be routed to a region with another cloud service. 


## Other things to know

- **Routing algorithm**. The Azure Front Door routing algorithm first matches based on HTTP protocol, then frontend host, then the Path.
    -  HTTP Protocols (HTTP/HTTPS)
    -  Hosts (for example, www.foo.com, \*.bar.com)
    -  Paths (for example, /*, /users/*, /file.gif)
- **Response codes**. Azure Front Door response codes help clients understand the purpose of the redirect. You can set the protocol used for redirection. The most common use case of the redirect feature is to set HTTP to HTTPS redirection.
- **Health probes**. Front Door periodically sends a synthetic HTTP/HTTPS request to each of your configured backends. Front Door then uses these responses from the probe to determine the "best" backend resources to route your client requests.

> [!TIP]
> Learn more about Azure Front Door check out the [Introduction to Azure Front Door](/training/modules/intro-to-azure-front-door/) module.