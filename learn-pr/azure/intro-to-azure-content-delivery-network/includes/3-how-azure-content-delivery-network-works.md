A CDN is a distributed network of servers that can efficiently deliver web content to users. Azure CDN works in the following manner:

:::image type="content" source="../images/azure-content-delivery-network-overview.png" alt-text="Diagram that shows how Azure Content Delivery Network works." border="false":::

1. A user (Alice) requests a file (also called an asset) by using a URL with a special domain name, such as `<endpoint name>.azureedge.net`. This name can be an endpoint hostname or a custom domain. The DNS routes the request to the best performing POP location, which is usually the POP that is geographically closest to the user.
1. If no edge servers in the POP have the file in their cache, the POP requests the file from the origin server. The origin server can be an Azure web app, Azure Cloud Service, Azure Storage account, Azure IaaS virtual machine, or any publicly accessible web server.
1. The origin server returns the file to an edge server in the POP.
1. An edge server in the POP caches the file and returns the file to the original requestor (Alice). The file remains cached on the edge server in the POP until the time-to-live (TTL) specified by its HTTP headers expires. If the origin server didn't specify a TTL, the default TTL is seven days.
1. More users can then request the same file by using the same URL that Alice used, and can also be directed to the same POP.
1. If the TTL for the file hasn't expired, the POP edge server returns the file directly from the cache. This process results in a faster, more responsive user experience.

## Azure CDN origin servers

Azure CDN supports web servers running on Azure IaaS virtual machines, Azure web apps, and serverless apps as origin servers. When you connect your website to Azure CDN and propagate the files, you end up with an identical file structure in Azure CDN.

Creating a CDN requires specifying a new CDN in Azure. Then, you configure an endpoint that points to the origin server or Blob Storage account. Azure requires unique names for the CDN path and the origin server URL.

A serverless web app in Azure requires no deployment, configuration, or management of servers. A serverless web app can contains the following components that can be used with Azure CDN:

- **Blob storage**: Static web files (HTML, CSS, and JavaScript) are stored in Azure Blob storage, which implements static website hosting. Any dynamic interaction is through JavaScript calls to back-end APIs. In consequence, there's no server-side code to render the webpage.
- **Function apps**: Uses an event-driven model to invoke functions (pieces of code) by using triggers (events). With a serverless app, the trigger might be an HTTP GET request.
- **API Management**: Provides an API gateway that publishes and manages the APIs that client functions use. The gateway also helps to decouple the front-end applications from the APIs. API management can translate URLs, apply transforms to data requests between front and back ends, and configure response headers.

Azure CDN caches the serverless web app content, providing lower latency and faster content delivery to users. Azure CDN can also provide an endpoint for encrypted HTTPS connections.  

> [!NOTE]
> When you create an endpoint, you must ensure that the endpoint type matches the origin source correctly. For example, static websites in Azure require an endpoint set to `custom origin` with storage accounts, where you can create a CDN matched to that account.

## CDN profiles  

A CDN profile is a container for one or more CDN endpoints. Each CDN endpoint specifies a pricing tier and provides a link to the cached content on the POP. The pricing tier determines what features are available for that CDN profile. When you create a profile, you can specify to create a CDN endpoint, or you can create and add endpoints later.  

## Azure CDN cache behavior

If you publish a website through Azure CDN, the files on that site are cached until their TTL expires. The Cache-Control header contained in the HTTP response from origin server determines the TTL duration.

If you don't set a TTL on a file, Azure CDN sets a default value. However, this default can be overridden if you have set up caching rules in Azure. Here are the default TTL values:

- Generalized web delivery optimizations: seven days
- Large file optimizations: one day
- Media streaming optimizations: one year

In normal operation, an Azure CDN edge node will serve an asset until its TTL expires. The edge node reconnects to the origin server when the TTL expires and a client makes a request to the same asset. The node will fetch another copy of the asset, resetting the TTL in the process.

Because a cached resource can potentially be out of date or stale (compared to the corresponding resource on the origin server), it's important for any caching mechanism to control when content is refreshed. To save time and bandwidth consumption, a cached resource isn't compared to the version on the origin server every time it's accessed. Instead, as long as a cached resource is considered to be fresh, it's assumed to be the most current version and is sent directly to the client.  

Azure CDNs provide two mechanisms for caching files. However, these configuration settings depend on the tier you've selected. Caching rules in Azure CDN Standard for Microsoft are set at the endpoint level and provide three configuration options. Other tiers provide more configuration options, which include:

- **Caching rules**: Caching rules can be either global (apply to all content from a specified endpoint) or custom. Custom rules apply to specific paths and file extensions.
- **Query string caching**: Query string caching allows you to configure how Azure CDN responds to a query string. Query string caching has no effect on files that can't be cached.

With the Azure CDN Standard for Microsoft tier, caching rules are as simple as the following three options:

- **Ignore query strings**: This option is the default mode. A CDN POP simply passes the request and any query strings directly to the origin server on the first request and caches the asset. New requests for the same asset will ignore any query strings until the TTL expires.
- **Bypass caching for query strings**: Each query request from the client is passed directly to the origin server with no caching.
- **Cache every unique URL**: Every time a requesting client generates a unique URL, that URL is passed back to the origin server and the response cached with its own TTL. This final method is inefficient where each request is a unique URL, as the cache-hit ratio becomes low.

## Compressing files

Azure CDN can improve performance by compressing the files before they're delivered. Files are decompressed by the receiving browser. Azure CDN passes along the compressed files unaltered if you enable compression on files hosted on your origin server.  

Azure CDN dynamically compresses uncompressed files on the origin server (if they're of a type that can be compressed). It then stores the compressed files on the POP. This process improves the client experience and site performance.

## Geo-filtering

Geo-filtering lets you allow or block content in specific countries/regions based on the country code. In the Azure CDN Standard for Microsoft tier, you can only allow or block the entire site. With the Verizon and Akamai tiers, you can also set up restrictions on directory paths. For more information, see the further reading section in the **Summary** unit.

To configure geo-filtering, in the properties of the respective endpoint, select **Geo-filtering**. On the **Geo-filtering** pane, select either **Allow** or **Block**. In the **Country codes** list, select which countries/regions you want to allow or block.

The **Allow** setting is more restrictive than **Block**. **Allow** allows access only for the selected countries/regions. The logic for **Block** is to allow access from all countries/regions except for those countries/regions that are blocked.
