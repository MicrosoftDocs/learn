Optimal API performance is essential to most organizations. By using a cache of compiled responses in Azure API Management, you can reduce the time an API takes to answer calls.

Suppose there's a need for the board gaming API to provide faster responses to requests. For example, users often request prices for various sizes of the board for games. API Management policies can accelerate responses by configuring a cache of prepared responses. When a request is received from a user, API Management checks to see if there's an appropriate response in the cache already. If there is, that response can be sent to the user without building it again from the data source.

Here, you'll learn how to configure such a cache.

## How to control the API Management cache

To set up a cache, you use an outbound policy named `cache-store` to store responses. You also use an inbound policy named `cache-lookup` to check if there's a cached response for the current request. You can see these two policies in the example below:

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

It's also possible to store individual values in the cache instead of a complete response. Use the `cache-store-value` policy to add the value, with an identifying key. Retrieve the value from the cache by using the `cache-lookup-value` policy. If you want to remove a value before it expires, use the `cache-remove-value` policy:

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

## Use vary-by tags

It's important to ensure that, if you serve a response from the cache, it's relevant to the original request. However, you also want to use the cache as much as possible. Suppose, for example, that the board games Stock Management API received a GET request to the following URL and cached the result:

`http://<boardgames.domain>/stock/api/product?partnumber=3416&customerid=1128`

This request is intended to check the stock levels for a product with part number 3416. The customer ID is used by a separate policy, and doesn't alter the response. Subsequent requests for the same part number can be served from the cache, as long as the record hasn't expired. So far, so good.

Now suppose that a different customer requests the same product:

`http://<boardgames.domain>/stock/api/product?partnumber=3416&customerid=5238`

By default, the response can't be served from the cache, because the customer ID is different.

However, the developers point out that the customer ID doesn't alter the response. It would be more efficient if requests for the same product from different customers could be returned from the cache. Customers would still see the correct information.

To modify this default behavior, use the `vary-by-query-parameter` element within the `<cache-lookup>` policy:

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

With this policy, the cache will store and separate responses for each product, because they have different part numbers. The cache won't store separate responses for each *customer*, because that query parameter isn't listed.

By default, Azure API Management doesn't examine HTTP headers to determine whether a cached response is suitable for a given request. If a header can make a significant difference to a response, use the `<vary-by-header>` tag. Work with your developer team to understand how each API uses query parameters and headers so you can decide which vary-by tags to use in your policy.

Within the `<cache-lookup>` tag, there's also the `vary-by-developer` attribute, which is required and set to *false* by default. When this attribute is set to *true*, API Management examines the subscription key supplied with each request. It serves a response from the cache only if the original request had the same subscription key. Set this attribute to *true* when each user should see a different response for the same URL. If each user group should see a different response for the same URL, set the `vary-by-developer-group` attribute to *true*.

## Use an external cache

API Management instances usually have an internal cache, which is used to store prepared responses to requests. However, if you prefer, you can use a Redis-compatible external cache instead. One possible external cache system that you can use is the Azure Cache for Redis service.

You might choose to use an external cache because:

- You want to avoid the cache being cleared when the API Management service is updated.
- You want to have greater control over the cache configuration than the internal cache allows.
- You want to cache more data than can be stored in the internal cache.

Another reason to configure an external cache is that you want to use caching with the Consumption pricing tier. This tier follows serverless design principles, and you should use it with serverless web APIs. For this reason, it has no internal cache. If you want to use caching with an API Management instance in the Consumption tier, you must use an external cache.
