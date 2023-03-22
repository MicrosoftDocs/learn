Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. Traditional load balancers operate at the transport layer (OSI layer 4 - TCP and UDP) and route traffic based on source IP address and port, to a destination IP address and port.

:::image type="content" source="../media/azure-application-gateway-flow-699baa3e.png" alt-text="Azure Application Gateway traffic flow":::


Application Gateway can make routing decisions based on additional attributes of an HTTP request, for example URI path or host headers. For example, you can route traffic based on the incoming URL. So, if /images is in the incoming URL, you can route traffic to a specific set of servers (known as a pool) configured for images. If /video is in the URL, that traffic is routed to another pool that's optimized for videos.

This type of routing is known as application layer (OSI layer 7) load balancing. Azure Application Gateway can do URL-based routing and more.

:::image type="content" source="../media/azure-application-gateway-routing-9584563b.png" alt-text="Azure Application routing":::


## Application Gateway features

 -  Support for the HTTP, HTTPS, HTTP/2 and WebSocket protocols.
 -  A web application firewall to protect against web application vulnerabilities.
 -  End-to-end request encryption.
 -  Autoscaling, to dynamically adjust capacity as your web traffic load change.
 -  **Redirection**: Redirection can be used to another site, or from HTTP to HTTPS.
 -  **Rewrite HTTP headers**: HTTP headers allow the client and server to pass parameter information with the request or the response.
 -  **Custom error pages:** Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout using a custom error page.

## Determine Application Gateway routing

Clients send requests to your web apps to the IP address or DNS name of the gateway. The gateway routes requests to a selected web server in the back-end pool, using a set of rules configured for the gateway to determine where the request should go.

There are two primary methods of routing traffic, path-based routing, and multiple site routing.

### Path-based routing

Path-based routing sends requests with different URL paths different pools of back-end servers. For example, you could direct requests with the path /video/\* to a back-end pool containing servers that are optimized to handle video streaming, and direct /images/\* requests to a pool of servers that handle image retrieval.

:::image type="content" source="../media/app-gateway-path-4f0fdef3.png" alt-text="path based routing example":::


### Multiple site routing

Multiple site routing configures more than one web application on the same application gateway instance. In a multi-site configuration, you register multiple DNS names (CNAMEs) for the IP address of the Application Gateway, specifying the name of each site. Application Gateway uses separate listeners to wait for requests for each site. Each listener passes the request to a different rule, which can route the requests to servers in a different back-end pool. For example, you could direct all requests for `http://contoso.com` to servers in one back-end pool, and requests for `http://fabrikam.com` to another back-end pool. The following diagram shows this configuration.

:::image type="content" source="../media/app-gateway-site-0ea3f85a.png" alt-text="Multiple site routing example":::


Multi-site configurations are useful for supporting multi-tenant applications, where each tenant has its own set of virtual machines or other resources hosting a web application.

## Choosing an Azure Application Gateway SKU

Application Gateway is available under a Standard\_v2 SKU. Web Application Firewall (WAF) is available under a WAF\_v2 SKU. The v2 SKU offers performance enhancements and adds support for critical new features like autoscaling, zone redundancy, and support for static VIPs. Existing features under the Standard and WAF SKU continue to be supported in the new v2 SKU.

The new v2 SKU includes the following enhancements:

**Autoscaling**: Application Gateway or WAF deployments under the autoscaling SKU can scale out or in based on changing traffic load patterns. Autoscaling also removes the requirement to choose a deployment size or instance count during provisioning. This SKU offers true elasticity. In the Standard\_v2 and WAF\_v2 SKU, Application Gateway can operate both in fixed capacity (autoscaling disabled) and in autoscaling enabled mode. Fixed capacity mode is useful for scenarios with consistent and predictable workloads. Autoscaling mode is beneficial in applications that see variance in application traffic.

**Zone redundancy**: An Application Gateway or WAF deployment can span multiple Availability Zones, removing the need to provision separate Application Gateway instances in each zone with a Traffic Manager. You can choose a single zone or multiple zones where Application Gateway instances are deployed, which makes it more resilient to zone failure. The backend pool for applications can be similarly distributed across availability zones.

**Not all Azure regions support availability zones yet**.

**Static VIP**: Application Gateway v2 SKU supports the static VIP type exclusively. This ensures that the VIP associated with the application gateway doesn't change for the lifecycle of the deployment, even after a restart. There isn't a static VIP in v1, so you must use the application gateway URL instead of the IP address for domain name routing to App Services via the application gateway.

**Header Rewrite**: Application Gateway allows you to add, remove, or update HTTP request and response headers with v2 SKU.

**Key Vault Integration**: Application Gateway v2 supports integration with Key Vault for server certificates that are attached to HTTPS enabled listeners.

**Azure Kubernetes Service Ingress Controller**: The Application Gateway v2 Ingress Controller allows the Azure Application Gateway to be used as the ingress for an Azure Kubernetes Service (AKS) known as AKS Cluster.

**Performance enhancements**: The v2 SKU offers up to 5X better TLS offload performance as compared to the Standard/WAF SKU.

**Faster deployment and update time:** The v2 SKU provides faster deployment and update time as compared to Standard/WAF SKU. This also includes WAF configuration changes.

## Choosing between Azure Application Gateway v2 and Web Application Firewall V2 SKUs

When choosing whether to deploy an Application Gateway or a Web Application Firewall, there are several factors you must consider, including the scaling strategy you want to follow and the cost of the service.

### Scaling Application Gateway and WAF v2

Application Gateway and WAF can be configured to scale in two modes:

**Autoscaling:** With autoscaling enabled, the Application Gateway and WAF v2 SKUs scale up or down based on application traffic requirements. This mode offers better elasticity to your application and eliminates the need to guess the application gateway size or instance count. This mode also allows you to save cost by not requiring the gateway to run at peak provisioned capacity for anticipated maximum traffic load. You must specify a minimum and optionally maximum instance count. Minimum capacity ensures that Application Gateway and WAF v2 don't fall below the minimum instance count specified, even in the absence of traffic. Each instance is roughly equivalent to 10 additional reserved Capacity Units. Zero signifies no reserved capacity and is purely autoscaling in nature. You can also optionally specify a maximum instance count, which ensures that the Application Gateway doesn't scale beyond the specified number of instances. You will only be billed for traffic served by the Gateway. The instance counts can range from 0 to 125. The default value for maximum instance count is 20 if not specified.

**Manual:** You can alternatively choose Manual mode where the gateway won't autoscale. In this mode, if there is more traffic than the Application Gateway or WAF can handle, it could result in traffic loss. With manual mode, specifying instance count is mandatory. Instance count can vary from 1 to 125 instances.

### Pricing

With the v2 SKU, the pricing model is driven by consumption and is no longer attached to instance counts or sizes. The v2 SKU pricing has two components:

**Fixed price:** This is hourly (or partial hour) price to provision a Standard\_v2 or WAF\_v2 Gateway. Please note that 0 additional minimum instances still ensure high availability of the service which is always included with fixed price.

**Capacity Unit price:** This is a consumption-based cost that is charged in addition to the fixed cost. Capacity unit charge is also computed hourly or partial hourly. There are three dimensions to capacity unit - compute unit, persistent connections, and throughput. Compute unit is a measure of processor capacity consumed. Factors affecting compute unit are TLS connections/sec, URL Rewrite computations, and WAF rule processing. Persistent connection is a measure of established TCP connections to the application gateway in each billing interval. Throughput is average Megabits/sec processed by the system in each billing interval. The billing is done at a Capacity Unit level for anything above the reserved instance count.

Each capacity unit is composed of at most: 1 compute unit, 2500 persistent connections, and 2.22-Mbps throughput.
