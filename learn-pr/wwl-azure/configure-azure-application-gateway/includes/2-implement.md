Application Gateway manages the requests that client applications send to a web app.

The Application Gateway uses application layer routing. Application layer routing routes traffic to a pool of web servers based on the URL of a request. The back-end pool can include Azure virtual machines, Azure virtual machine scale sets, Azure App Service, and even on-premises servers.

:::image type="content" source="../media/application-gateway-cb3392f4.png" alt-text="A browser using the app gateway to access the backend pool.":::


The Application Gateway uses round robin to send load balance requests to the servers in each back-end pool. The Application Gateway provides session stickiness. Use session stickiness to ensure client requests in the same session are routed to the same back-end server.

Load-balancing works in the OSI Layer 7. Load-balancing requests use the routing parameters (host names and paths) in the Application Gateway rules. In comparison, the Azure Load Balancer, functions at the OSI Layer 4 level. This means the Azure Load Balancer distributes traffic based on the IP address of the target of a request.

## Additional features

 -  Support for the HTTP, HTTPS, HTTP/2 and WebSocket protocols.
 -  A web application firewall to protect against web application vulnerabilities.
 -  End-to-end request encryption.
 -  Autoscaling, to dynamically adjust capacity as your web traffic load change.
