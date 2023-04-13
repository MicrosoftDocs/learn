Azure Application Gateway manages the requests that client applications send to web apps that are hosted on a pool of web servers. The pool of web servers can be Azure virtual machines, Azure Virtual Machine Scale Sets, Azure App Service, and even on-premises servers. 

Application Gateway provides features such as load balancing HTTP traffic, web application firewall, and support for TLS/SSL encryption of traffic between users and an application gateway and between application servers and an application gateway.

:::image type="content" source="../images/application-gateway-topology.png" alt-text="Diagram that depicts the Azure Application Gateway topology." border="false":::

Application Gateway uses a round-robin process to load balance requests to the servers in each back-end pool. Session stickiness ensures client requests in the same session are routed to the same back-end server. Session stickiness is particularly important with e-commerce applications where you don’t want a transaction to be disrupted because the load balancer bounces it around between back-end servers.

Azure Application Gateway includes the following features:

- Support for the HTTP, HTTPS, HTTP/2, and WebSocket protocols
- A web application firewall to protect against web application vulnerabilities
- End-to-end request encryption
- Autoscaling to dynamically adjust capacity as your web traffic load change
- Connection draining allowing graceful removal of back-end pool members during planned service updates
