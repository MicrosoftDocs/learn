In a distributed app, it's important to ensure that components can communicate reliably and that, when there's a failure, requests can always be routed to a different component or region.

You've decided to rearchitect your shipping portal in Azure to reduce its vulnerability to regional failures. You want to ensure that, when the primary region is unavailable, the application fails over onto components in the secondary region with minimal disruption in the service to users.  

Here, you'll learn how Azure DNS, Traffic Manager, Front Door, and Azure CDN can support the shipping company's app architecture.

## Azure DNS

You'll host the domains and name records needed by your app by using Azure DNS, a first-party Azure service provides name resolution entirely through the Azure infrastructure. Because it's inherently multi-regional, the SLA for the Azure DNS guarantees that valid DNS requests receive a response from at least one Azure DNS name server all the time, even when your primary region is unavailable.

One advantage of Azure DNS for our app is that we can manage and program against it using all the standard Azure tools – the portal, PowerShell, and the CLI – without needing to deal with an external site or third-party tools. 

You don't need to modify your Azure DNS configuration to support the multi-region version of your shipping portal architecture.

## Choose a traffic router 

Azure provides several different services that can route traffic between front-end components. In the original, single-region architecture, you used Application Gateway to balance traffic between multiple instances of the front-end App Service. You can't use Application Gateway in a mult-region architecture, because each gateway is contained within a single region. If that region fails, there is nothing to perform the routing.

There are two traffic routers in Azure that can perform global routing between multiple regions and are not vulnerable to a single region outage:

- Azure Traffic Manager
- Azure Front Door

Let's examine these services in more detail, so you can choose the right router for your application.

### Azure Traffic Manager

Azure Traffic Manager is a global load balancer that uses DNS records to route traffic to destinations in multiple Azure regions. 

You can configure Traffic Manager to route all requests to your primary region and to monitor the responsiveness of the App Service in that region. If the App Service in the primary region fails, Traffic Manager automatically reroutes user requests to the App Service in the secondary region. This reroute executes the failover that ensures continuous service. This arrangement is called the **priority routing mode**. 

Because Traffic Manager uses the DNS system to route traffic, it can route any protocol, not just HTTP traffic. However, Traffic Manager can't route or filter traffic based on HTTP properties, such as client country codes or user agent headers. It also can't do Transport Layer Security (TLS) protocol termination, where the router decrypts requests and encrypts responses to take that load off the App Service virtual servers. If you need either of these features, you'll have to use Azure Front Door.

Traffic Manager uses highly configurable endpoint monitoring. You define the protocol, port, path, custom header settings, expected status code ranges, tolerated number of failures, and so on. You'll get a continuous idea of the overall health of all parts of your application. 

<!-- TODO: This diagram is taken from the following location. A Learn version should be created by the design team: https://docs.microsoft.com/en-gb/azure/traffic-manager/traffic-manager-routing-methods#priority-traffic-routing-method -->

![Azure Traffic Manager priority mode](../media/3-traffic-manager-priority-mode.png)

### Azure Front Door

Like Traffic Manager, Azure Front Door is a global load balancer. Unlike Traffic Manager, it works at Layer 7 and uses HTTP and HTTPS properties to perform filtering and routing. 

Because Front Door can examine HTTP and HTTPS properties, such as the user agent header, you can perform may types of routing that Traffic Manager doesn't support. For example, you can route traffic based on the browser's country code. Front Door also supports TLS protocol termination. However, if you want to route traffic for any protocol other than HTTP and HTTPS, you'll have to use Traffic Manager instead. 

The priority routing mode and endpoint monitoring in Front Door is similar to those features in Traffic Manager, except that health probes always work over HTTP.

For the shipping portal, because all traffic is over HTTPS, for both the web user interface and the web APIs, you decide to use Front End. This choice gives you the option to use TLS protocol termination if the App Service becomes overloaded.

## Azure CDN

In your original, single-region architecture, you used Azure CDN to cache static content from Azure Blob Storage. The Azure CDN service is a global network of servers that caches static content close to users. You don't need to modify this service for the multi-region architecture, although you should consider the Azure Storage account itself. We'll cover storage accounts in the next unit.