

This diagram reviews how the Azure Application Gateway components work together.

:::image type="content" source="../media/application-gateway-components.png" alt-text="Diagram showing how Azure Application Gateway routes requests to a pool of web servers.":::


> [!VIDEO https://learn-video.azurefd.net/vod/player?id=cda9bcad-587b-4182-b8eb-3c1d66111dda]


## Routing configuration

One of the most important gateway configuration settings is the routing rules. The Azure Application Gateway has two primary methods of routing client requests: path-based  and multiple sites.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=d4048c34-14df-4c86-a217-daf80ca9ea8c]

### Path-based routing

[Path-based routing](/azure/application-gateway/url-route-overview) sends requests with different URL paths to different pools of back-end servers. For example, you could direct video requests to a back-end pool  optimized to handle video streaming. You could also direct image requests to a pool of servers that handles image retrieval.

:::image type="content" source="../media/path-based-routing.png" alt-text="Diagram that depicts path-based routing in Azure Application Gateway.":::

### Multiple site routing

[Multiple site routing](/azure/application-gateway/multiple-site-overview) configures more than one web application on the same Application Gateway instance. In a multiple site configuration, you register multiple DNS names (CNAMEs) for the IP address of the application gateway, specifying the name of each site. Application Gateway uses separate listeners to wait for requests for each site. Each listener passes the request to a different rule, which can route the requests to servers in a different back-end pool. For example, you could direct all requests for `http://contoso.com` to a specific backend pool.

:::image type="content" source="../media/multi-site-routing.png" alt-text="Diagram that depicts multi-site routing in Azure Application Gateway.":::

## Other routing capabilities
Along with path-based routing and multiple site hosting, there are a few other capabilities when routing with Application Gateway.

- [Redirection](/azure/application-gateway/redirect-overview). Redirection can be used to another site, or from HTTP to HTTPS. For example, redirecting HTTP requests to a secure HTTPS shopping site. 
- Rewrite HTTP headers. HTTP headers allow the client and server to pass additional information with the request or the response.
- Custom error pages. Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout using a custom error page.

> [!TIP]
> Learn more about Azure Application Gateway routing check out the [Load balance your web service traffic with Application Gateway](/training/modules/load-balance-web-traffic-with-application-gateway/) module.