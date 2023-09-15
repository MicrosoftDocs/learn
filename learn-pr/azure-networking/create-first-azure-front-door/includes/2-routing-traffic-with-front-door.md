Front Door manages the delivery of web application contents using the Microsoft's global edge network. With over 150 global and local edge locations distributed around the world, client applications are brought closer to end users. Front Door routes traffic to origins in an origin group based on the URL of a request. Origins can be web servers or contents hosted on an Azure virtual machine, App Services, Storage accounts, or on-premises. 

:::image type="content" source="../media/2-overview.png" alt-text="Diagram of Azure Front Door traffic flow.":::

## How Front Door routes requests

Front Door traffic routing takes place over multiple stages. Traffic is first routed from the client to the Front Door profile at an edge location nearest to the user. Front Door then processes the request to determine which origin is best to respond to the request. Configurations such as routing rules, Rules engine rules, Web Application Firewall (WAF) policy, and caching configuration can affect the routing process.

:::image type="content" source="../media/2-edge-location-routing.png" alt-text="Diagram of TCP connection between end users, edge locations and origin.":::

### Match request to Front Door profile

When Front Door receives an HTTP/HTTPS request, it uses the request's host header to match the request to the correct Front Door profile. If the request is to a custom domain name, the domain name has to be registered with the Front Door to correctly route traffic to your web applications. A TLS handshake happens between the client and server using the certificate configured for your custom domain.

### WAF rules evaluation

If you configure Web Application Firewall (WAF) policy for your Front Door, WAF rules are evaluated. If a rule has been violated, then Front Door returns an error to the client and stops processing the request any further.

### Route matching

When a request passes any configured WAF policy, the request gets matched to a route. A route determines how the request is processed. A route can be broken down into two parts. The left-hand side where the properties of the request can be used to match a routing rule and the right-hand side, which determines how to further process the request. Within a routing rule, rule sets can be configured to customize how requests get processed at the Front Door before being forwarded to the origin. A use case for rule sets is to route users to the mobile or desktop version of an application based on the client device type. Rule sets can also be used to redirect responses without ever forwarding to the origin. If a routing rule has caching enabled, Front Door attempts to respond to the request from cache. If the cached response isn't available, then the request is forwarded to the appropriate origin that can respond.

## Traffic routing methods

Front Door selects an origin from an origin group that can best respond to the client's request. When Front Door is trying to determine the best origin to service the request the following factors are used:

* **Health of origin** - Front Door monitors the health of each origin in the origin group by sending a health probe based on the path, protocol, interval and probe method configured.
* **Routing method** - By default, origins are selected by lowest latency. A priority or weight value can be defined to prefer one origin over another.
* **Session Affinity** - If session affinity is enabled, requests from the same end user are sent to the same origin.

### Routing for motor vehicle department

Let's revisit our scenario of the motor vehicle department. Front Door can be used to address the problem of a possible regional failure and at the same time improve the overall experience for their end users globally. With route matching, users are directed to the correct motor vehicle website with the lowest latency when requesting resources from the origin. Caching is also enabled to help accelerate the response time for frequently requested content by users. With 150 edge locations around the world, users can access the motor vehicle website from anywhere without fear of availability.
