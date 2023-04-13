Administrators use Azure Application Gateway to manage requests from client applications to their web apps. An application gateway listens for incoming traffic to web apps and checks for messages sent via protocols like HTTP. Gateway rules direct the traffic to resources in a back-end pool.

#### Business scenario

Consider a scenario where internet client applications request access to resources in a load-balanced back-end pool. The requests can be managed by implementing Azure Application Gateway to listen for HTTP(S) messages. Messages can be handled by load-balancing rules to direct client request traffic to the appropriate resources in the pool. The following diagram illustrates this scenario:

:::image type="content" source="../media/application-gateway-cb3392f4.png" alt-text="Diagram that illustrates how Azure Application Gateway manages requests from client applications to resources in a back-end pool, as described in the text." border="false":::

### Things to know about Azure Application Gateway

Let's examine some of the benefits of using Azure Application Gateway to manage internet traffic to your web applications.

| Benefit | Description |
| --- | --- |
| **Application layer routing** | Use application layer routing to direct traffic to a back-end pool of web servers based on the URL of a request. The back-end pool can include Azure virtual machines, Azure Virtual Machine Scale Sets, Azure App Service, and even on-premises servers. |
| **Round-robin load balancing** | Employ round-robin load balancing to distribute incoming traffic across multiple servers. Send load-balance requests to the servers in each back-end pool. Client requests are forwarded in a cycle through a group of servers to create an effective balance for the server load. |
| **Session stickiness** | Apply session stickiness to your application gateway to ensure client requests in the same session are routed to the same back-end server. |
| **Supported protocols** | Build an application gateway to support the HTTP, HTTPS, HTTP/2, or WebSocket protocols. |
| **Firewall protection** | Implement a web application firewall to protect against web application vulnerabilities. |
| **Encryption** | Support end-to-end request encryption for your web applications. |
| **Load autoscaling** | Dynamically adjust capacity as your web traffic load changes. |