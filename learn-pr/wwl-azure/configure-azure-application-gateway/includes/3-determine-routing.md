Clients send requests to your web apps by specifying the IP address or DNS name of your application gateway. Your gateway directs the requests to a selected web server in your back-end pool according to a set of rules. You define the rules for your gateway to identify the allowable routes for the request traffic.

### Things to know about traffic routing

Let's take a closer look at your routing options for Azure Application Gateway.

- Azure Application Gateway offers two primary methods for routing traffic:

   - **Path-based routing** sends requests with different URL paths to different pools of back-end servers. 

   - **Multi-site routing** configures more than one web application on the same application gateway instance. 

- You can configure your application gateway to **redirect** traffic.

   Application Gateway can redirect traffic received at one listener to another listener, or to an external site. This approach is commonly used by web apps to automatically redirect HTTP requests to communicate via HTTPS. The redirection ensures all communication between your web app and clients occurs over an encrypted path. 

- You can implement Application Gateway to **rewrite HTTP headers**.

   HTTP headers allow the client and server to pass parameter information with the request or the response. In this scenario, you can translate URLs or query string parameters, and modify request and response headers. Add conditions to ensure URLs or headers are rewritten only for certain conditions.

- Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout by using a custom error page.

#### Path-based routing

You can implement path-based routing to direct requests for specific URL paths to the appropriate back-end pool. Consider a scenario where your web app receives requests for videos or images. You can use path-based routing to direct requests for the `/video/\*` path to a back-end pool of servers that are optimized to handle video streaming. Image requests for the `/images/\*` path can be directed to a pool of servers that handle image retrieval. The following illustration demonstrates this routing method:

:::image type="content" source="../media/path-based-routing-15bcef5f.png" alt-text="Diagram that shows a path-based routing approach." border="false":::

#### Multi-site routing

When you need to support multiple web apps on the same application gateway instance, multi-site routing is the best option. Multi-site configurations are useful for supporting multi-tenant applications, where each tenant has its own set of virtual machines or other resources hosting a web application.

In this configuration, you register multiple DNS names (CNAMEs) for the IP address of your application gateway and specify the name of each site. Application Gateway uses separate listeners to wait for requests for each site. Each listener passes the request to a different rule, which can route the requests to servers in a different back-end pool. 

Consider a scenario where you need to support traffic to two sites on the same gateway. You can direct all requests for the `http://contoso.com` site to servers in one back-end pool, and requests for the `http://fabrikam.com` site to another back-end pool. The following illustration demonstrates this routing method.

:::image type="content" source="../media/site-based-routing-e686b605.png" alt-text="Diagram that shows a multiple site routing approach." border="false":::