A content delivery network is a distributed network of servers that can efficiently deliver web content to users. Azure Content Delivery Network works in the following manner:

:::image type="content" source="../images/azure-content-delivery-network-overview.png" alt-text="Diagram that shows how Azure Content Delivery Network works." lightbox="../images/azure-content-delivery-network-overview.png" border="false":::

1. A user, Alice, requests a file (also called an asset) by using a URL with a special domain name, such as `<endpoint name>.azureedge.net`. This domain name can be an endpoint host name or a custom domain. The DNS routes the request to the best performing POP location, which is usually the POP geographically closest to the user.
1. If no edge servers in the POP have the file in their cache, the POP requests the file from the origin server. The origin server can be an Azure web app, Azure Cloud Service, Azure Storage account, Azure IaaS virtual machine, or any publicly accessible web server.
1. The origin server returns the file to an edge server in the POP.
1. An edge server in the POP caches the file and returns the file to the original requestor (Alice). The file remains cached on the edge server in the POP until the time-to-live (TTL) specified by its HTTP headers expires. If the origin server didn't specify a TTL, the default TTL is seven days.
1. More users can request the same file by using the same URL that Alice used, and can also be directed to the same POP.
1. If the TTL for the file hasn't expired, the POP edge server returns the file directly from the cache. This process results in a faster, more responsive user experience.

## Azure Content Delivery Network origin servers

Azure Content Delivery Network supports web servers running on Azure IaaS virtual machines, Azure web apps, and serverless apps as origin servers. When you connect your website to Azure Content Delivery Network and propagate the files, you end up with an identical file structure in Azure Content Delivery Network.

Creating a content delivery network requires specifying a new content delivery network in Azure. Then, you configure an endpoint that points to the origin server or Blob Storage account. Azure requires unique names for the content delivery network path and the origin server URL.

A serverless web app in Azure requires no deployment, configuration, or management of servers. A serverless web app can contain the following components that can be used with Azure Content Delivery Network:

- **Blob Storage**: Static web files (HTML, CSS, and JavaScript) are stored in Azure Blob Storage, which implements static website hosting. Any dynamic interaction is through JavaScript calls to back-end APIs. No server-side code is needed to render the webpage.
- **Function apps**: Function apps use an event-driven model to invoke functions (pieces of code) by using triggers (events). With a serverless app, the trigger might be an HTTP GET request.
- **API Management**: The API Management component provides an API gateway that publishes and manages the APIs that client functions use. The gateway also helps to decouple the front-end applications from the APIs. API Management can translate URLs, apply transforms to data requests between front and back ends, and configure response headers.

Azure Content Delivery Network caches the serverless web app content, providing lower latency and faster content delivery to users. Azure Content Delivery Network can also provide an endpoint for encrypted HTTPS connections.  

> [!NOTE]
> When you create an endpoint, you must ensure that the endpoint type matches the origin source correctly. For example, static websites in Azure require an endpoint set to `custom origin` with storage accounts, where you can create a content delivery network matched to that account.

## Azure Content Delivery Network profiles  

An Azure Content Delivery Network profile is a container for one or more Content Delivery Network endpoints. Each Content Delivery Network endpoint specifies a pricing tier and provides a link to the cached content on the POP. The pricing tier determines what features are available for that Content Delivery Network profile. When you create a profile, you can specify to create a Content Delivery Network endpoint, or you can create and add endpoints later.  

## Azure Content Delivery Network cache behavior

If you publish a website through Azure Content Delivery Network, the files on that site are cached until their TTL expires. The Cache-Control header contained in the HTTP response from the origin server determines the TTL duration.

If you don't set a TTL on a file, Azure Content Delivery Network sets a default value. However, this default can be overridden if you have set up caching rules in Azure. Following are the default TTL values:

- Generalized web delivery optimizations: seven days
- Large file optimizations: one day
- Media streaming optimizations: one year

In normal operation, an Azure Content Delivery Network edge node will serve an asset until the asset's TTL expires. The edge node reconnects to the origin server when an asset's TTL expires if a client makes a request to the same asset. The edge node fetches another copy of the asset, setting a new TTL in the process.

Because a cached resource can potentially be out of date or stale (compared to the corresponding resource on the origin server), it's important for any caching mechanism to control when content is refreshed. To save time and bandwidth consumption, a cached resource isn't compared to the version on the origin server every time the resource is accessed. Instead, as long as a cached resource is considered to be fresh, the resource is assumed to be the most current version and is sent directly to the client.  

Azure Content Delivery Network provides two mechanisms for caching files. However, these configuration settings depend on the tier you select. Caching rules in the Azure Content Delivery Network Standard for Microsoft tier are set at the endpoint level and provide three configuration options. Other tiers provide more configuration options, which include the following:

- **Caching rules**: Caching rules can be either global (apply to all content from a specified endpoint) or custom. Custom caching rules apply to specific paths and file extensions.
- **Query string caching**: Query string caching allows you to configure how Azure Content Delivery Network responds to a query string. Query string caching has no effect on files that can't be cached.

With the Azure Content Delivery Network Standard for Microsoft tier, caching rules are the following three options:

- **Ignore query strings**: This option is the default mode. A content delivery network POP passes the request and any query strings directly to the origin server on the first request and caches the asset. New requests for the same asset will ignore any query strings until that asset's TTL expires.
- **Bypass caching for query strings**: Each query request from the client is passed directly to the origin server with no caching.
- **Cache every unique URL**: Every time a requesting client generates a unique URL, that URL is passed back to the origin server and the response is cached with its own TTL. This method is inefficient where each request is a unique URL, as the cache-hit ratio becomes low.

## File compression

Azure Content Delivery Network can improve performance by compressing files before they're delivered. The receiving browser then decompresses the files. Azure Content Delivery Network passes along the compressed files unaltered if you enable compression on files hosted on your origin server.  

Azure Content Delivery Network dynamically compresses uncompressed files on the origin server (if the files are a type that can be compressed). Azure Content Delivery Network then stores the compressed files on the POP. This process improves the client experience and website performance.

## Geo-filtering

Geo-filtering lets you allow or block content in specific countries or regions based on the country code. In the Azure Content Delivery Network Standard for Microsoft tier, you can only allow or block an entire website. With the Verizon and Akamai tiers, you can also set up restrictions on directory paths. For more information, see the resource list in the **Summary** unit of this module.

To configure geo-filtering, complete the following steps.

1. In the properties of the respective endpoint, select **Geo-filtering**.
1. On the **Geo-filtering** pane, select either **Allow** or **Block**.
1. In the **Country codes** list, select the countries or regions you want to allow or block.

The **Allow** setting is more restrictive than the **Block** setting. **Allow** gives access only for the selected countries or regions. **Block** allows access from all countries and regions except for those countries or regions that are blocked.
