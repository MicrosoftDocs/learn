Controlling when content is refreshed is important for any caching mechanism. A cached resource might be out-of-date or stale (compared to the corresponding resource on the origin server).

## Controlling caching behavior

You can use content delivery network caching rules to set or modify default cache expiration behavior. These caching rules can either be global or with custom conditions. Azure Content Delivery Network offers two ways to control how your files get cached:

* **Caching rules:** Azure Content Delivery Network provides global and custom types of caching rules.

    * Global caching rules - You can set one global caching rule for each endpoint in your profile, which affects all requests to the endpoint. The global caching rule overrides any HTTP cache-directive headers, if set.

    * Custom caching rules - You can set one or more custom caching rules for each endpoint in your profile. Custom caching rules match specific paths and file extensions, get processed in order, and override the global caching rule, if set.

* **Query string caching:** You can adjust how the Azure content delivery network treats caching for requests with query strings. If the file isn't cacheable, the query string caching setting has no effect, based on caching rules and content delivery network default behaviors.

> [!NOTE]
> Caching rules are available only for **Azure CDN Standard from Edgio** profiles. For **Azure CDN from Microsoft** profiles, you must use the [Standard rules engine](/azure/cdn/cdn-standard-rules-engine-reference) For **Azure CDN Premium from Edgio** profiles, you must use the [Edgio Premium rules engine](/azure/cdn/cdn-verizon-premium-rules-engine) in the **Manage** portal for similar functionality.

## Standard rules engine

In the Standard rules engine for Azure Content Delivery Network, a rule consists of one or more match conditions and an action. The rules engine is designed to be the final authority on how specific types of requests get processed by Standard Azure Content Delivery Network.

Common uses for the rules:

* Override or define a custom cache policy.
* Redirect requests.
* Modify HTTP request and response headers.

A rule consists of one or more match conditions and an action. The first part of a rule is a match condition or set of match conditions. In the Standard rules engine for Azure Content Delivery Network, each rule can have up to four match conditions. A match condition identifies specific types of requests for which defined actions are performed. If you use multiple match conditions, the match conditions are grouped together by using `AND` logic. Following is a table highlighting a few of the available match options.

| Match condition | Description |
|--|--|
| Device type | Identifies requests made from a mobile device or desktop device. |
| HTTP version | Identifies requests based on the HTTP version of the request. |
| Request cookies | Identifies requests based on cookie information in the incoming request. |
| Post argument | Identifies requests based on arguments defined for the POST request method that's used in the request. |
| Query string | Identifies requests that contain a specific query string parameter. This parameter is set to a value that matches a specific pattern. |

For a complete list of match conditions, visit [Match conditions in the Standard rules engine for Azure Content Delivery Network](/azure/cdn/cdn-standard-rules-engine-match-conditions)

## Caching and time to live

Files from publicly accessible origin web servers can be cached in Azure Content Delivery Network until their time to live (TTL) elapses. The TTL gets determined by the `Cache-Control` header in the HTTP response from the origin server. This article describes how to set `Cache-Control` headers for the Web Apps feature of Microsoft Azure App Service, Azure Cloud Services, ASP.NET applications, and Internet Information Services (IIS) sites, all of which are configured similarly. You can set the `Cache-Control` header either by using configuration files or programmatically.

If you don't set a TTL on a file, Azure CDN sets a default value. However, this default might be overridden if you set up caching rules in Azure. Default TTL values are as follows:

* Generalized web delivery optimizations: seven days
* Large file optimizations: one day
* Media streaming optimizations: one year

## Content updating

Azure Content Delivery Network edge nodes cache contents until the content's time to live (TTL) expires. After the TTL expires, when a client makes a request for the content from the edge node, the edge node will retrieve a new updated copy of the content to serve to the client. Then the refreshed content in cache of the edge node.

The best practice to make sure your users always obtain the latest copy of your assets is to version your assets for each update and publish them as new URLs. Content delivery network will immediately retrieve the new assets for the next client requests. Sometimes you might wish to purge cached content from all edge nodes and force them all to retrieve new updated assets. The reason might be due to updates to your web application, or to quickly update assets that contain incorrect information.

You can purge content in several ways.

* On an endpoint by endpoint basis, or all endpoints simultaneously should you want to update everything on your CDN at once.
* Specify a file, by including the path to that file or all assets on the selected endpoint by checking the **Purge All** checkbox in the Azure portal.
* Based on wildcards (*) or using the root (/).

The Azure CLI provides a special purge verb that unpublishes cached assets from an endpoint. This is useful if you have an application scenario where a large amount of data is invalidated and should be updated in the cache. To unpublish assets, you must specify either a file path, a wildcard directory, or both:

```bash
az cdn endpoint purge \
    --content-paths '/css/*' '/js/app.js' \
    --name ContosoEndpoint \
    --profile-name DemoProfile \
    --resource-group ExampleGroup
```

You can also preload assets into an endpoint. This is useful for scenarios where your application creates a large number of assets, and you want to improve the user experience by prepopulating the cache before any actual requests occur:

```bash
az cdn endpoint load \
    --content-paths '/img/*' '/js/module.js' \
    --name ContosoEndpoint \
    --profile-name DemoProfile \
    --resource-group ExampleGroup
```

## Geo-filtering

Geo-filtering enables you to allow or block content in specific countries/regions, based on the country/region code. In the Azure CDN Standard for Microsoft Tier, you can only allow or block the entire site. 
