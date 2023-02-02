Azure Application Gateway has a series of components that combine to route requests to a pool of web servers and to check the health of these web servers. These components include the frontend IP address, back-end pools, routing rules, health probes, and listeners. As an option, the gateway can also implement a firewall.

### Things to know about Application Gateway components

Let's explore how the components of an application gateway work together.

- The **front-end IP address** receives the client requests. 

- An optional **firewall** checks incoming traffic for common threats before the requests reach the listeners.

- One or more **listeners** receive the traffic and route the requests to the back-end pool.

- **Routing rules** define how to analyze the request to direct the request to the appropriate back-end pool. 

- A **back-end pool** contains web servers for resources like virtual machines or Virtual Machine Scale Sets. Each pool has a load balancer to distribute the workload across the resources.

- **Health probes** determine which back-end pool servers are available for load-balancing.

The following flowchart demonstrates how the Application Gateway components work together to direct traffic requests between the frontend and back-end pools in your configuration.

:::image type="content" source="../media/configure-app-gateway-0193dbd6.png" alt-text="Flowchart that demonstrates how Application Gateway components direct traffic requests between the frontend and back-end pools." border="false":::

#### Front-end IP address

Client requests are received through your front-end IP address. Your application gateway can have a public or private IP address, or both. You can have only one public IP address and only one private IP address.

#### Listeners

Listeners accept traffic arriving on a specified combination of protocol, port, host, and IP address. Each listener routes requests to a back-end pool of servers according to your routing rules. A listener can be _Basic_ or _Multi-site_. A Basic listener only routes a request based on the path in the URL. A Multi-site listener can also route requests by using the hostname element of the URL. Listeners also handle TLS/SSL certificates for securing your application between the user and Application Gateway.

#### Routing rules

A routing rule binds your listeners to the back-end pools. A rule specifies how to interpret the hostname and path elements in the URL of a request, and then direct the request to the appropriate back-end pool. A routing rule also has an associated set of HTTP settings. These HTTP settings indicate whether (and how) traffic is encrypted between Application Gateway and the back-end servers. Other configuration information includes protocol, session stickiness, connection draining, request timeout period, and health probes.

#### Back-end pools

A back-end pool references a collection of web servers. You provide the IP address of each web server and the port on which it listens for requests when configuring the pool. Each pool can specify a fixed set of virtual machines, Virtual Machine Scale Sets, an app hosted by Azure App Services, or a collection of on-premises servers. Each back-end pool has an associated load balancer that distributes work across the pool.

#### Health probes

Health probes determine which servers in your back-end pool are available for load-balancing. Application Gateway uses a health probe to send a request to a server. When the server returns an HTTP response with a status code between 200 and 399, the server is considered healthy. If you don't configure a health probe, Application Gateway creates a default probe that waits for 30 seconds before identifying a server as unavailable (unhealthy).

#### Firewall (optional)

You can enable Azure Web Application Firewall for Azure Application Gateway to handle incoming requests before they reach your listener. The firewall checks each request for threats based on the Open Web Application Security Project (OWASP). Common threats include SQL-injection, cross-site scripting, command injection, HTTP request smuggling and response splitting, and remote file inclusion. Other threats can come from bots, crawlers, scanners, and HTTP protocol violations and anomalies.

OWASP defines a set of generic rules for detecting attacks. These rules are referred to as the Core Rule Set (CRS). The rule sets are under continuous review as attacks evolve in sophistication. Azure Web Application Firewall supports two rule sets: CRS 2.2.9 and CRS 3.0. CRS 3.0 is the default and more recent of these rule sets. If necessary, you can opt to select only specific rules in a rule set to target certain threats. Additionally, you can customize the firewall to specify which elements in a request to examine, and limit the size of messages to prevent massive uploads from overwhelming your servers.