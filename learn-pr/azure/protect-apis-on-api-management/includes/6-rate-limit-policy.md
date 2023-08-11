It's common to find that a few users overuse an API. Sometimes, an API is overused to such an extent that you incur extra costs or that responsiveness to other users is reduced. You can use throttling (rate limiting) to help protect API endpoints by restricting the number of times an API can be called within a specified period of time.

The Census API, for example, is distributed to lots of government agencies, so the number of calls to the API may become significant. By applying a rate limit policy, we can enable a quick response to all requests so that it isn't possible for a single client to use all the resources for the Census API.

In this unit, you learn how to use API Management policies to impose two types of throttling.

## Limit by subscription throttling

Subscription throttling allows you to set the rate limits by a specific API operation. It doesn't discriminate by the client. Instead, every request to the API or the specified operation is throttled in the same way. Using our Census API example, we could use subscription throttling to limit the number of times any of the APIs are called within a certain period. This configuration would result in clients receiving a 429 error when that limit was reached. The problem with this type of throttling is that it allows one client to use up all the requests before another client can use it.

For example, the following code demonstrates an example configuration that applies to all API operations:

```XML
<rate-limit calls="3" renewal-period="15" />
```

Alternatively, this configuration can be used to target a particular API operation:

```XML
<rate-limit calls="number" renewal-period="seconds">
    <api name="API name" id="API id" calls="number" renewal-period="seconds" />
        <operation name="operation name" id="operation id" calls="number" renewal-period="seconds" />
    </api>
</rate-limit>
```

## Limit by key throttling

Key throttling allows you to configure different rate limits by any client request value. This type of throttling offers a better way of managing the rate limits as it applies the limit to a specified request key - often the client IP address. It gives every client equal bandwidth for calling the API:

```XML
<rate-limit-by-key calls="number"
                   renewal-period="seconds"
                   increment-condition="condition"
                   counter-key="key value" />
```

The following example configuration limits the rate limit by the IP address of a request:

```XML
<rate-limit-by-key calls="10"
              renewal-period="60"
              increment-condition="@(context.Response.StatusCode == 200)"
              counter-key="@(context.Request.IpAddress)"/>
```

When you choose to throttle by key, you need to decide on specific requirements for rate limiting. For example, the following table lists three common ways of specifying the **counter-key**:

| Value | Description |
| ----- | ------ |
| **context.Request.IpAddress** | Rates limited by client IP address |
| **context.Subscription.Id** | Rates limited by subscription ID |
| **context.Request.Headers.GetValue("My-Custom-Header-Value")** | Rates limited by a specified client request header value |
| | |

You may decide that you want each individual client IP to have its own bandwidth set, in which case you would use the **context.Request.IpAddress**. Alternatively, it could be that you want all requests from a particular domain name to be throttled as certain domains have many calls to the API. In that case, you would specify **context.Request.Headers.GetValue("host")** which would rate limit by the domains from which the call was made.

> [!NOTE]
> The `<rate-limit-by-key>` policy isn't available when your API Management gateway is in the Consumption tier. You can use `<rate-limit>`instead.