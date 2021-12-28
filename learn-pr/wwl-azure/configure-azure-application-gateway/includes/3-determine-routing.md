Clients send requests to your web apps to the IP address or DNS name of the gateway. The gateway routes requests to a selected web server in the back-end pool, using a set of rules configured for the gateway to determine where the request should go.

There are two primary methods of routing traffic, path-based routing and multiple site routing.

## Path-based routing

Path-based routing sends requests with different URL paths to different pools of back-end servers. For example, you could direct requests with the path /video/\* to a back-end pool containing servers that are optimized to handle video streaming, and direct /images/\* requests to a pool of servers that handle image retrieval.

:::image type="content" source="../media/path-based-routing-15bcef5f.png" alt-text="Path-based routing.":::


## Multiple site routing

Multiple site routing configures more than one web application on the same application gateway instance. In a multi-site configuration, you register multiple DNS names (CNAMEs) for the IP address of the Application Gateway, specifying the name of each site. Application Gateway uses separate listeners to wait for requests for each site. Each listener passes the request to a different rule, which can route the requests to servers in a different back-end pool. For example, you could direct all requests for http://contoso.com to servers in one back-end pool, and requests for http://fabrikam.com to another back-end pool. The following diagram shows this configuration.

:::image type="content" source="../media/site-based-routing-e686b605.png" alt-text="Multiple site routing.":::


Multi-site configurations are useful for supporting multi-tenant applications, where each tenant has its own set of virtual machines or other resources hosting a web application.

## Other features

 -  **Redirection**. Redirection can be used to another site, or from HTTP to HTTPS.
 -  **Rewrite HTTP headers**. HTTP headers allow the client and server to pass parameter information with the request or the response.
 -  **Custom error pages**. Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout using a custom error page.
