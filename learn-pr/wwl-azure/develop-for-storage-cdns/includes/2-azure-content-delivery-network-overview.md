Azure Content Delivery Network (CDN) offers developers a global solution for rapidly delivering high-bandwidth content to users. It caches content at strategically placed physical nodes across the world. Azure CDN can also accelerate dynamic content, which can't be cached, by using various network optimizations using CDN POPs. For example, route optimization to bypass Border Gateway Protocol (BGP).

The benefits of using Azure CDN to deliver web site assets include:

* Better performance and improved user experience for end users, especially when using applications in which multiple round-trips are required to load content.
* Large scaling to better handle instantaneous high loads, such as the start of a product launch event.
* Distribution of user requests and serving of content directly from edge servers so that less traffic is sent to the origin server.

## How Azure Content Delivery Network works

:::image type="content" source="../media/azure-content-delivery-network.png" alt-text="Image showing how Azure CDN operates, the steps shown in the image are explained next.":::

1.  A user (Alice) requests a file (also called an asset) by using a URL with a special domain name, such as `<endpoint name>.azureedge.net`. This name can be an endpoint hostname or a custom domain. The DNS routes the request to the best performing POP location, which is usually the POP that is geographically closest to the user.

2.  If no edge servers in the POP have the file in their cache, the POP requests the file from the origin server. The origin server can be an Azure Web App, Azure Cloud Service, Azure Storage account, or any publicly accessible web server.

3.  The origin server returns the file to an edge server in the POP.

4.  An edge server in the POP caches the file and returns the file to the original requestor (Alice). The file remains cached on the edge server in the POP until the time-to-live (TTL) specified by its HTTP headers expires. If the origin server didn't specify a TTL, the default TTL is seven days.

5.  Other users can then request the same file by using the same URL that Alice used, and can also be directed to the same POP.

6.  If the TTL for the file hasn't expired, the POP edge server returns the file directly from the cache. This process results in a faster, more responsive user experience.

## Requirements

*   To use Azure Content Delivery Network, you must own at least one Azure subscription.
*   You also need to create a content delivery network profile, which is a collection of content delivery network endpoints. Every content delivery network endpoint is a specific configuration which users can customize with required content delivery behavior and access. To organize your content delivery network endpoints by internet domain, web application, or some other criteria, you can use multiple profiles.
*   Since [Azure Content Delivery Network pricing](https://azure.microsoft.com/pricing/details/cdn/) gets applied at the content delivery network profile level. If you want to use a mix of pricing tiers you must create multiple content delivery network profiles.

### Limitations

Each Azure subscription has default limits for the following resources:

* The number of CDN profiles that can be created.
* The number of endpoints that can be created in a CDN profile.
* The number of custom domains that can be mapped to an endpoint.

For more information about CDN subscription limits, visit [CDN limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

## Azure CDN features

Azure CDN offers the following key features:

* Dynamic site acceleration
* CDN caching rules
* HTTPS custom domain support
* Azure diagnostics logs
* File compression
* Geo-filtering

For a complete list of features that each Azure CDN product supports, visit [Compare Azure CDN product features](/azure/cdn/cdn-features).
