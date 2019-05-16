Optimal performance is essential to most organizations. By using a cache of compiled responses in Azure API Management, you can reduce the time an API takes to answer calls.

Suppose there is a need for the board gaming API to provide faster responses to requests. For example, users often request prices for various sizes of board for games. API Management policies can accelerate responses by configuring a cache of prepared responses. When a request is received from a user, API Management checks to see if there is an appropriate response in the cache already. If there is, that response can be sent to the user without building it again from the data source.

Here, you will learn how to configure such a cache.

## How to control the API Management cache

To set up a cache, you use an outbound policy named `cache-store` to store responses. You also use an inbound policy named `cache-lookup` to check if there is a cached response for the current request. You can see these two policies in the example below:

```xml
<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" must-revalidate="true" caching-type="internal" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <cache-store duration="60" />
        <base />
    </outbound>
    </on-error>
        <base />
    </on-error>
</policies>
```

It's also possible to store individual values in the cache, instead of a complete response. Use the `cache-store-value` policy to add the value, with an identifying key. Retrieve the value from the cache by using the `cache-lookup-value` policy. If you want to remove a value before it expires, use the `cache-remove-value` policy:

```xml
<policies>
    <inbound>
        <cache-lookup-value key="12345"
            default-value="$0.00"
            variable-name="boardPrice"
            caching-type="internal" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <cache-store-value key="12345"
            value="$3.60"
            duration="3600"
            caching-type="internal" />
        <base />
    </outbound>
    </on-error>
        <base />
    </on-error>
</policies>
```

## Using vary-by tags

It's important to ensure that, if you serve a response from the cache, it is relevant to the original request. Suppose, for example, that the board games Stock Management API received a GET request to the following URL and cached the result:

`http://<boardgames.domain>/stock/api/product/3416`

This request is intended to check the stock levels for a product with part number 3416. Subsequent requests for the same part number can be served from the cache, as long as the record has not expired. So far so good.

Now suppose that the developers alter the API to use a query parameter to specify the part number. The request for the same product is now:

`http://<boardgames.domain>/stock/api/product?partnumber=3416`

By default, cache entries are not recorded with their query parameters. <!-- REVIEW I experimented with this and this statement is not correct; it appears the default is to vary by *all* query parameters. If you start specifying vary-by-query-parameters modifiers, it only uses those. The scenario here should be a case where changes in some parameters should still use the cached value; you'd want to call out all the *other* parameters with vary-by-query-parameters elements --> Suppose a different product is requested:

`http://<boardgames.domain>/stock/api/product?partnumber=5484`

This request is to the same address, so API Management serves the cached response. However, this response is incorrect, because the cached response is for product 3416, not product 5484.

To modify this default behavior, use the &lt;vary-by-query-parameter&gt; element within the &lt;cache-lookup&gt; policy:

```xml
<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" must-revalidate="true" caching-type="internal">
            <vary-by-query-parameter>partnumber</vary-by-query-parameter>
        </cache-lookup>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <cache-store duration="60" />
        <base />
    </outbound>
    </on-error>
        <base />
    </on-error>
</policies>
```

With this policy, the cache will store separate responses for each product, because they have different part numbers, even though those numbers are specified in a query parameter.

Like query parameters, Azure does not examine HTTP headers to determine whether a cached response is suitable for a given request. <!-- REVIEW Please check on this relative to the above and confirm --> If a header can make a significant difference to a response, use the `<vary-by-header>` tag. Work with your developer team to understand how each API uses query parameters and headers. Then you can decide which vary-by tags to use in your policy.

Within the `<cache-lookup>` tag, there is also the `vary-by-developer` attribute, which is required to be present and set to false by default. When this attribute is set to true, API Management examines the subscription key supplied with each request. It serves a response from the cache only if it was originally requested with the same subscription key. Set this attribute to true when each user should see a different response for the same URL. If each user group should see a different response for the same URL, set the `vary-by-developer-group` attribute to true.

## Using an external cache

API Management instances usually have an internal cache, which is used to store prepared responses to requests. However, if you prefer, you can use an external cache instead. One possible external cache system that you can use is the Azure Cache for Redis service.

You might choose to use an external cache because:

- You want to avoid the cache being cleared when the API Management service is updated.
- You want to have greater control over the cache configuration than the internal cache allows.
- You want to cache more data than can be store in the internal cache.

Another reason to configure an external cache is that you want to use caching with the consumption pricing tier. This tier follows serverless design principal and you should use it  with serverless web APIs. For this reason, it has no internal cache. If you want to use caching with an API Management instance in the consumption tier, you must use an external cache.