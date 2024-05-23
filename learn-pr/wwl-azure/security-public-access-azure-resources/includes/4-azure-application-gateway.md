Azure Application Gateway is a web traffic (OSI layer 7) load balancer that enables you to manage traffic to your web applications. Traditional load balancers operate at the transport layer (OSI layer 4 - TCP and UDP) and route traffic based on source IP address and port, to a destination IP address and port.

Application Gateway can make routing decisions based on additional attributes of an HTTP request, for example URI path or host headers. For example, you can route traffic based on the incoming URL. So if /images is in the incoming URL, you can route traffic to a specific set of servers (known as a pool) configured for images. If /video is in the URL, that traffic is routed to another pool that's optimized for videos.

:::image type="content" source="../media/azure-application-gateway-ebcc99aa.png" alt-text="Diagram showing an example an Azure Application Gateway.":::


This type of routing is known as application layer (OSI layer 7) load balancing. Azure Application Gateway can do URL-based routing and more.

## Application gateway components

An application gateway serves as the single point of contact for clients. It distributes incoming application traffic across multiple backend pools, which include Azure VMs, virtual machine scale sets, Azure App Service, and on-premises/external servers.

:::image type="content" source="../media/application-gateway-configuration-c1d7e5a6.png" alt-text="Diagram showing Azure application gateway components.":::


## Infrastructure

The Application Gateway infrastructure includes the virtual network, subnets, network security groups, and user defined routes.

## Frontend IP address

You can configure the application gateway to have a public IP address, a private IP address, or both. A public IP is required when you host a back end that clients must access over the Internet via an Internet-facing virtual IP (VIP).

A public IP address isn't required for an internal endpoint that's not exposed to the internet. A private frontend configuration is useful for internal line-of-business applications that aren't exposed to the internet. It's also useful for services and tiers in a multitier application within a security boundary that aren't exposed to the internet but that require round-robin load distribution, session stickiness, or TLS termination.

Only one public IP address and one private IP address are supported. You choose the frontend IP when you create the application gateway.

> [!NOTE]
> The Application Gateway front end supports dual-stack IP addresses (public preview). You can create up to four frontend IPs. Two are IPv4 addresses (public and private) and two are IPv6 addresses (public and private).

 -  For a public IP address, you can create a new public IP address or use an existing public IP in the same location as the application gateway. For more information, see Static versus dynamic public IP address.
 -  For a private IP address, you can specify a private IP address from the subnet where the application gateway is created. For Application Gateway v2 SKU deployments, a static IP address must be defined when you add a private IP address to the gateway. For Application Gateway v1 SKU deployments, if you don't specify an IP address, an available IP address is automatically selected from the subnet. The IP address type that you select (static or dynamic) can't be changed later.

A frontend IP address is associated to a *listener*, which checks for incoming requests on the frontend IP.

You can create private and public listeners with the same port number. However, be aware of any network security group (NSG) associated with the Application Gateway subnet. Depending on your NSG's configuration, you might need an allow-inbound rule with Destination IP addresses as your application gateway's public and private frontend IPs. When you use the same port, your application gateway changes the **Destination** of the inbound flow to the frontend IPs of your gateway.<br>

**Inbound rule**:<br>

 -  Source: According to your requirement<br>
 -  Destination: Public and private frontend IPs of your application gateway.
 -  Destination port: According to configured listeners
 -  Protocol: TCP

**Outbound rule**: No specific requirement

## Listeners

A listener is a logical entity that checks for incoming connection requests by using the port, protocol, host, and IP address. When you configure the listener, you must enter values for these that match the corresponding values in the incoming request on the gateway.

When you create an application gateway by using the Azure portal, you also create a default listener by choosing the protocol and port for the listener. You can choose whether to enable HTTP2 support on the listener. After you create the application gateway, you can edit the settings of that default listener (appGatewayHttpListener) or create new listeners.

## **Listener type**

A listener is a logical entity that checks for incoming connection requests. A listener accepts a request if the protocol, port, hostname, and IP address associated with the request match the same elements associated with the listener configuration.

Before you use an application gateway, you must add at least one listener. There can be multiple listeners attached to an application gateway, and they can be used for the same protocol.<br>

After a listener detects incoming requests from clients, the application gateway routes these requests to members in the backend pool configured in the rule.<br>

Listeners support the following ports and protocols.<br>

## Ports

A port is where a listener listens for the client request. You can configure ports for v1 and v2 SKUs as per below.

| **SKU** | **Supported port range** | **Exception(s)** |
| ------- | ------------------------ | ---------------- |
| V2      | 1 to 64999               | 22               |
| V1      | 1 to 65502               | 3389             |

## Protocols

Application Gateway supports four protocols: HTTP, HTTPS, HTTP/2, and WebSocket:

> [!NOTE]
> HTTP/2 protocol support is available to clients connecting to application gateway listeners only. The communication to backend server pools is always over HTTP/1.1. By default, HTTP/2 support is disabled. You can choose to enable it.

 -  Specify between the HTTP and HTTPS protocols in the listener configuration.
 -  Support for WebSockets and HTTP/2 protocols is provided natively, and WebSocket support is enabled by default. There's no user-configurable setting to selectively enable or disable WebSocket support. Use WebSockets with both HTTP and HTTPS listeners.

Use an HTTPS listener for TLS termination. An HTTPS listener offloads the encryption and decryption work to your application gateway, so your web servers aren't burdened by the overhead.

## Request routing rules

When you create an application gateway using the Azure portal, you create a default rule (*rule1*). This rule binds the default listener (*appGatewayHttpListener*) with the default backend pool (*appGatewayBackendPool*) and the default backend HTTP settings (*appGatewayBackendHttpSettings*). After you create the gateway, you can edit the settings of the default rule or create new rules.

## Rule type

When you create a rule, you choose between basic and path-based.

 -  Choose basic if you want to forward all requests on the associated listener (for example, blog.contoso.com/\*) to a single backend pool.<br>
 -  Choose path-based if you want to route requests from specific URL paths to specific backend pools. The path pattern is applied only to the path of the URL, not to its query parameters.

## Associated listener

Associate a listener to the rule so that the *request-routing rule* that's associated with the listener is evaluated to determine the backend pool to route the request to.

## Associated backend pool

Associate to the rule the backend pool that contains the backend targets that serve requests that the listener receives.

 -  For a basic rule, only one backend pool is allowed. All requests on the associated listener are forwarded to that backend pool.<br>
 -  For a path-based rule, add multiple backend pools that correspond to each URL path. The requests that match the URL path that's entered are forwarded to the corresponding backend pool. Also, add a default backend pool. Requests that don't match any URL path in the rule are forwarded to that pool.<br>

## Associated backend HTTP setting

Add a backend HTTP setting for each rule. Requests are routed from the application gateway to the backend targets by using the port number, protocol, and other information that's specified in this setting.

For a basic rule, only one backend HTTP setting is allowed. All requests on the associated listener are forwarded to the corresponding backend targets by using this HTTP setting.

For a path-based rule, add multiple backend HTTP settings that correspond to each URL path. Requests that match the URL path in this setting are forwarded to the corresponding backend targets by using the HTTP settings that correspond to each URL path. Also, add a default HTTP setting. Requests that don't match any URL path in this rule are forwarded to the default backend pool by using the default HTTP setting.

## Redirection setting

If redirection is configured for a basic rule, all requests on the associated listener are redirected to the target. This is *global* redirection. If redirection is configured for a path-based rule, only requests in a specific site area are redirected. An example is a shopping cart area that's denoted by */cart/\**. This is *path-based* redirection.

## Listener

Choose listener as the redirection target to redirect traffic from one listener to another on the gateway. This setting is required when you want to enable HTTP-to-HTTPS redirection. It redirects traffic from the source listener that checks for incoming HTTP requests to the destination listener that checks for incoming HTTPS requests. You can also choose to include the query string and path from the original request in the request that's forwarded to the redirection target.

:::image type="content" source="../media/configure-redirection-ff199fb9.png" alt-text="Screenshot showing an example of the redirection configuration settings page.":::


## External site

Choose external site when you want to redirect the traffic on the listener that's associated with this rule to an external site. You can choose to include the query string from the original request in the request that's forwarded to the redirection target. You can't forward the path to the external site that was in the original request.

## Rewrite HTTP headers and URL

By using rewrite rules, you can add, remove, or update HTTP(S) request and response headers as well as URL path and query string parameters as the request and response packets move between the client and backend pools via the application gateway.

The headers and URL parameters can be set to static values or to other headers and server variables. This helps with important use cases, such as extracting client IP addresses, removing sensitive information about the backend, adding more security, and so on.

## HTTP settings

The application gateway routes traffic to the backend servers by using the configuration that you specify here. After you create an HTTP setting, you must associate it with one or more request-routing rules.

### Cookie-based affinity

Azure Application Gateway uses gateway-managed cookies for maintaining user sessions. When a user sends the first request to Application Gateway, it sets an affinity cookie in the response with a hash value which contains the session details, so that the subsequent requests carrying the affinity cookie will be routed to the same backend server for maintaining stickiness.

This feature is useful when you want to keep a user session on the same server and when session state is saved locally on the server for a user session. If the application can't handle cookie-based affinity, you can't use this feature. To use it, make sure that the clients support cookies.

> [!NOTE]
> Some vulnerability scans may flag the Application Gateway affinity cookie because the Secure or HttpOnly flags are not set. These scans do not take into account that the data in the cookie is generated using a one-way hash. The cookie doesn't contain any user information and is used purely for routing.

### Connection draining

Connection draining helps you gracefully remove backend pool members during planned service updates. It applies to backend instances that are

 -  explicitly removed from the backend pool,<br>
 -  removed during scale-in operations, or
 -  reported as unhealthy by the health probes.

You can apply this setting to all backend pool members by enabling Connection Draining in the Backend Setting. It ensures that all deregistering instances in a backend pool don't receive any new requests/connections while maintaining the existing connections until the configured timeout value. This is also true for WebSocket connections.

| **Configuration Type**                                                    | **Value**         |
| ------------------------------------------------------------------------- | ----------------- |
| Default value when Connection Draining is not enabled in Backend Setting  | 30 seconds        |
| User-defined value when Connection Draining is enabled in Backend Setting | 1 to 3600 seconds |

The only exception to this are requests bound for deregistering instances because of gateway-managed session affinity and will continue to be forwarded to the deregistering instances.

## Protocol

Application Gateway supports both HTTP and HTTPS for routing requests to the backend servers. If you choose HTTP, traffic to the backend servers is unencrypted. If unencrypted communication isn't acceptable, choose HTTPS.

This setting combined with HTTPS in the listener supports end-to-end TLS. This allows you to securely transmit sensitive data encrypted to the back end. Each backend server in the backend pool that has end-to-end TLS enabled must be configured with a certificate to allow secure communication.<br>

## Port

This setting specifies the port where the backend servers listen to traffic from the application gateway. You can configure ports ranging from 1 to 65535.

## Trusted root certificate

If you select HTTPS as the backend protocol, the Application Gateway requires a trusted root certificate to trust the backend pool for end-to-end SSL. By default, the Use well known CA certificate option is set to No. If you plan to use a self-signed certificate, or a certificate signed by an internal Certificate Authority, then you must provide the Application Gateway the matching public certificate that the backend pool will be using. This certificate must be uploaded directly to the Application Gateway in .CER format.

If you plan to use a certificate on the backend pool that is signed by a trusted public Certificate Authority, then you can set the Use well known CA certificate option to Yes and skip uploading a public certificate.<br>

## Request timeout

This setting is the number of seconds that the application gateway waits to receive a response from the backend server.

## Override backend path

This setting lets you configure an optional custom forwarding path to use when the request is forwarded to the back end. Any part of the incoming path that matches the custom path in the override backend path field is copied to the forwarded path. The following table shows how this feature works:

When the HTTP setting is attached to a basic request-routing rule:

| **Original request** | **Override backend path** | **Request forwarded to back end** |
| -------------------- | ------------------------- | --------------------------------- |
| /home/               | /override/                | /override/home/                   |
| /home/secondhome/    | /override/                | /override/home/secondhome/        |

When the HTTP setting is attached to a path-based request-routing rule:

| **Original request**       | **Path rule**    | **Override backend path** | **Request forwarded to back end** |
| -------------------------- | ---------------- | ------------------------- | --------------------------------- |
| /pathrule/home/            | /pathrule\*      | /override/                | /override/home/                   |
| /pathrule/home/secondhome/ | /pathrule\*      | /override/                | /override/home/secondhome/        |
| /home/                     | /pathrule\*      | /override/                | /override/home/                   |
| /home/secondhome/          | /pathrule\*      | /override/                | /override/home/secondhome/        |
| /pathrule/home/            | /pathrule/home\* | /override/                | /override/                        |
| /pathrule/home/secondhome/ | /pathrule/home\* | /override/                | /override/secondhome/             |
| /pathrule/                 | /pathrule/       | /override/                | /override/                        |

## Use custom probe

This setting associates a custom probe with an HTTP setting. You can associate only one custom probe with an HTTP setting. If you don't explicitly associate a custom probe, the default probe is used to monitor the health of the back end. We recommend that you create a custom probe for greater control over the health monitoring of your back ends.

> [!NOTE]
> The custom probe doesn't monitor the health of the backend pool unless the corresponding HTTP setting is explicitly associated with a listener.

## Configuring the host name

Application Gateway allows for the connection established to the backend to use a *different* hostname than the one used by the client to connect to Application Gateway. While this configuration can be useful in some cases, overriding the hostname to be different between the client and application gateway and application gateway to backend target, should be done with care.

In production, it is recommended to keep the hostname used by the client towards the application gateway as the same hostname used by the application gateway to the backend target. This avoids potential issues with absolute URLs, redirect URLs, and host-bound cookies.<br>

Before setting up Application Gateway that deviates from this, please review the implications of such configuration as discussed in more detail in Architecture Center: *Preserve the original HTTP host name between a reverse proxy and its backend web application.*<br>

There are two aspects of an HTTP setting that influence the Host HTTP header that is used by Application Gateway to connect to the backend:<br>

 -  Pick host name from backend-address<br>
 -  Host name override

## Pick host name from backend address

This capability dynamically sets the *host* header in the request to the host name of the backend pool. It uses an IP address or FQDN.

This feature helps when the domain name of the back end is different from the DNS name of the application gateway, and the back end relies on a specific host header to resolve to the correct endpoint.

An example case is multitenant services as the back end. An app service is a multitenant service that uses a shared space with a single IP address. So, an app service can only be accessed through the hostnames that are configured in the custom domain settings.

By default, the custom domain name is *example.azurewebsites.net*. To access your app service by using an application gateway through a hostname that's not explicitly registered in the app service or through the application gateway's FQDN, you can override the hostname in the original request to the app service's hostname. To do this, enable the **pick host name from backend address setting**.

For a custom domain whose existing custom DNS name is mapped to the app service, the recommended configuration is not to enable the **pick host name from backend address**.

## Host name override

This capability replaces the *host* header in the incoming request on the application gateway with the host name that you specify.

For example, if *www.contoso.com* is specified in the **Host name** setting, the original request \*`https://appgw.eastus.cloudapp.azure.com/path1`is changed to \*`https://www.contoso.com/path1` when the request is forwarded to the backend server.<br>

## Backend pool

You can point a backend pool to four types of backend members: a specific virtual machine, a virtual machine scale set, an IP address/FQDN, or an app service.

After you create a backend pool, you must associate it with one or more request-routing rules. You must also configure health probes for each backend pool on your application gateway. When a request-routing rule condition is met, the application gateway forwards the traffic to the healthy servers (as determined by the health probes) in the corresponding backend pool.

## Health probes

Azure Application Gateway monitors the health of all the servers in its backend pool and automatically stops sending traffic to any server it considers unhealthy. The probes continue to monitor such an unhealthy server, and the gateway starts routing the traffic to it once again as soon as the probes detect it as healthy.

The default probe uses the port number from the associated Backend Setting and other preset configurations. You can use Custom Probes to configure them your way.

## Probes behavior

### Source IP address

The source IP address of the probes depends on the backend server type:

 -  If the server in the backend pool is a public endpoint, the source address will be your application gateway's frontend public IP address.<br>
 -  If the server in the backend pool is a private endpoint, the source IP address will be from your application gateway subnet's address space.

## Probe operations

A gateway starts firing probes immediately after you configure a Rule by associating it with a Backend Setting and Backend Pool (and the Listener, of course). The illustration shows that the gateway independently probes all the backend pool servers. The incoming requests that start arriving are sent only to the healthy servers. A backend server is marked as unhealthy by default until a successful probe response is received.

:::image type="content" source="../media/application-gateway-health-probe-1d3b7656.png" alt-text="Diagram showing an example of Azure application gateway health probe operations.":::


The required probes are determined based on the unique combination of the Backend Server and Backend Setting. For example, consider a gateway with a single backend pool with two servers and two backend settings, each having different port numbers. When these distinct backend settings are associated with the same backend pool using their respective rules, the gateway creates probes for each server and the combination of the backend setting. You can view this on the Backend health page.

:::image type="content" source="../media/multiple-backend-settings-505f3620.png" alt-text="Screenshot showing an example of the backend health settings.":::


Moreover, all instances of the application gateway probe the backend servers independently of each other.

> [!NOTE]
> The Backend health report is updated based on the respective probe's refresh interval and doesn't depend on the user's request.

## Default health probe

An application gateway automatically configures a default health probe when you don't set up any custom probe configuration. The monitoring behavior works by making an HTTP GET request to the IP addresses or FQDN configured in the backend pool. For default probes if the backend http settings are configured for HTTPS, the probe uses HTTPS to test health of the backend servers.

For example: You configure your application gateway to use backend servers A, B, and C to receive HTTP network traffic on port 80. The default health monitoring tests the three servers every 30 seconds for a healthy HTTP response with a 30-second-timeout for each request. A healthy HTTP response has a status code between 200 and 399. In this case, the HTTP GET request for the health probe looks like http://127.0.0.1/. Also see HTTP response codes in Application Gateway.<br>

If the default probe check fails for server A, the application gateway stops forwarding requests to this server. The default probe still continues to check for server A every 30 seconds. When server A responds successfully to one request from a default health probe, application gateway starts forwarding the requests to the server again.<br>

## Default health probe settings

| **Probe property**  | **Value**                                                                        | **Description**                                                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Probe URL           | &lt;protocol&gt;://127.0.0.1:&lt;port&gt;/ | The protocol and port are inherited from the backend HTTP settings to which the probe is associated                                                                                                                                                                                                                                                                                                               |
| Interval            | 30                                                                               | The amount of time in seconds to wait before the next health probe is sent.                                                                                                                                                                                                                                                                                                                                       |
| Time-out            | 30                                                                               | The amount of time in seconds the application gateway waits for a probe response before marking the probe as unhealthy. If a probe returns as healthy, the corresponding backend is immediately marked as healthy.                                                                                                                                                                                                |
| Unhealthy threshold | 3                                                                                | Governs how many probes to send in case there's a failure of the regular health probe. In v1 SKU, these additional health probes are sent in quick succession to determine the health of the backend quickly and don't wait for the probe interval. For v2 SKU, the health probes wait the interval. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

The default probe looks only at &lt;protocol&gt;://127.0.0.1:&lt;port&gt; to determine health status. If you need to configure the health probe to go to a custom URL or modify any other settings, you must use custom probes.

## Custom health probe

Custom probes allow you to have more granular control over the health monitoring. When using custom probes, you can configure a custom hostname, URL path, probe interval, and how many failed responses to accept before marking the backend pool instance as unhealthy, etc.

## Custom health probe settings

The following table provides definitions for the properties of a custom health probe.

| **Probe property**  | **Description**                                                                                                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Name                | Name of the probe. This name is used to identify and refer to the probe in backend HTTP settings.                                                                              |
| Protocol            | Protocol used to send the probe. This has to match with the protocol defined in the backend HTTP settings it's associated to                                                   |
| Host                | Host name to send the probe with. In v1 SKU, this value is used only for the host header of the probe request. In v2 SKU, it is used both as host header and SNI               |
| Path                | Relative path of the probe. A valid path starts with '/'                                                                                                                       |
| Port                | If defined, this is used as the destination port. Otherwise, it uses the same port as the HTTP settings that it's associated to. This property is only available in the v2 SKU |
| Interval            | Probe interval in seconds. This value is the time interval between two consecutive probes                                                                                      |
| Time-out            | Probe time-out in seconds. If a valid response isn't received within this time-out period, the probe is marked as failed                                                       |
| Unhealthy threshold | Probe retry count. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold                                                 |

## Probe matching

By default, an HTTP(S) response with status code between 200 and 399 is considered healthy. Custom health probes additionally support two matching criteria. Matching criteria can be used to optionally modify the default interpretation of what makes a healthy response.

The following are matching criteria:<br>

 -  HTTP response status code match - Probe matching criterion for accepting user specified http response code or response code ranges. Individual comma-separated response status codes or a range of status code is supported.<br>
 -  HTTP response body match - Probe matching criterion that looks at HTTP response body and matches with a user specified string. The match only looks for presence of user specified string in response body and isn't a full regular expression match. The specified match must be 4090 characters or less.

Match criteria can be specified using the `New-AzApplicationGatewayProbeHealthResponseMatch` cmdlet.

**For example:**

Azure PowerShell

```powershell
$match = New-AzApplicationGatewayProbeHealthResponseMatch -StatusCode 200-399
```

```powershell
$match = New-AzApplicationGatewayProbeHealthResponseMatch -Body "Healthy"
```

Match criteria can be attached to probe configuration using a `-Match` operator in PowerShell.

## Custom probe use cases

 -  If a backend server allows access to only authenticated users, the application gateway probes will receive a 403 response code instead of 200. As the clients (users) are bound to authenticate themselves for the live traffic, you can configure the probe traffic to accept 403 as an expected response.
 -  When a backend server has a wildcard certificate (\*.contoso.com) installed to serve different sub-domains, you can use a Custom probe with a specific hostname (required for SNI) that is accepted to establish a successful TLS probe and report that server as healthy. With "override hostname" in the Backend Setting set to NO, the different incoming hostnames (subdomains) will be passed as is to the backend.

## Network security group (NSG) considerations

Fine grain control over the Application Gateway subnet via NSG rules is possible in public preview. More details can be found here.

With current functionality there are some restrictions:<br>

You must allow incoming Internet traffic on TCP ports 65503-65534 for the Application Gateway v1 SKU, and TCP ports 65200-65535 for the v2 SKU with the destination subnet as Any and source as GatewayManager service tag. This port range is required for Azure infrastructure communication.<br>

Additionally, outbound Internet connectivity can't be blocked, and inbound traffic coming from the AzureLoadBalancer tag must be allowed.<br>

## How an application gateway works<br>

:::image type="content" source="../media/how-application-gateway-works-61b33891.png" alt-text="Diagram showing an example of how an Azure application gateway works.":::
<br>

## How an application gateway accepts a request

1.  Before a client sends a request to an application gateway, it resolves the domain name of the application gateway by using a Domain Name System (DNS) server. Azure controls the DNS entry because all application gateways are in the azure.com domain.
2.  The Azure DNS returns the IP address to the client, which is the frontend IP address of the application gateway.<br>
3.  The application gateway accepts incoming traffic on one or more listeners. A listener is a logical entity that checks for connection requests. It's configured with a frontend IP address, protocol, and port number for connections from clients to the application gateway.<br>
4.  If a web application firewall (WAF) is in use, the application gateway checks the request headers and the body, if present, against WAF rules. This action determines if the request is valid request or a security threat. If the request is valid, it's routed to the backend. If the request isn't valid and WAF is in Prevention mode, it's blocked as a security threat. If it's in Detection mode, the request is evaluated and logged, but still forwarded to the backend server.<br>

Azure Application Gateway can be used as an internal application load balancer or as an internet-facing application load balancer. An internet-facing application gateway uses public IP addresses. The DNS name of an internet-facing application gateway is publicly resolvable to its public IP address. As a result, internet-facing application gateways can route client requests from the internet.<br>

Internal application gateways use only private IP addresses. If you're using a Custom or Private DNS zone, the domain name should be internally resolvable to the private IP address of the Application Gateway. Therefore, internal load-balancers can only route requests from clients with access to a virtual network for the application gateway.

## How an application gateway routes a request

If a request is valid and not blocked by WAF, the application gateway evaluates the request routing rule that's associated with the listener. This action determines which backend pool to route the request to.

Based on the request routing rule, the application gateway determines whether to route all requests on the listener to a specific backend pool, route requests to different backend pools based on the URL path, or redirect requests to another port or external site.

When the application gateway selects the backend pool, it sends the request to one of the healthy backend servers in the pool (y.y.y.y). The health of the server is determined by a health probe. If the backend pool contains multiple servers, the application gateway uses a round-robin algorithm to route the requests between healthy servers. This load balances the requests on the servers.

After the application gateway determines the backend server, it opens a new TCP session with the backend server based on HTTP settings. HTTP settings specify the protocol, port, and other routing-related settings that are required to establish a new session with the backend server.<br>

The port and protocol used in HTTP settings determine whether the traffic between the application gateway and backend servers is encrypted (thus accomplishing end-to-end TLS) or is unencrypted.

> [!NOTE]
> Rules are processed in the order they're listed in the portal for v1 SKU.

When an application gateway sends the original request to the backend server, it honors any custom configuration made in the HTTP settings related to overriding the hostname, path, and protocol. This action maintains cookie-based session affinity, connection draining, host-name selection from the backend, and so on.

If the backend pool:

 -  Is a public endpoint, the application gateway uses its frontend public IP to reach the server. If there isn't a frontend public IP address, one is assigned for the outbound external connectivity.
 -  Contains an internally resolvable FQDN or a private IP address, the application gateway routes the request to the backend server by using its instance private IP addresses.
 -  Contains an external endpoint or an externally resolvable FQDN, the application gateway routes the request to the backend server by using its frontend public IP address. If the subnet contains service endpoints, the application gateway will route the request to the service via its private IP address. DNS resolution is based on a private DNS zone or custom DNS server, if configured, or it uses the default Azure-provided DNS. If there isn't a frontend public IP address, one is assigned for the outbound external connectivity.

## Backend server DNS resolution

When a backend pool's server is configured with a Fully Qualified Domain Name (FQDN), Application Gateway performs a DNS lookup to get the domain name's IP address(es). The IP value is stored in your application gateway's cache to enable it to reach the targets faster when serving incoming requests.

The Application Gateway retains this cached information for the period equivalent to that DNS record's TTL (time to live) and performs a fresh DNS lookup once the TTL expires. If a gateway detects a change in IP address for its subsequent DNS query, it will start routing the traffic to this updated destination. In case of problems such as the DNS lookup failing to receive a response or the record no longer exists, the gateway continues to use the last-known-good IP address(es). This ensures minimal impact on the data path.

 -  When using custom DNS servers with Application Gateway's Virtual Network, it is crucial that all servers are identical and respond consistently with the same DNS values.
 -  Users of on-premises custom DNS servers must ensure connectivity to Azure DNS through Azure DNS Private Resolver (recommended) or DNS forwarder VM when using a Private DNS zone for Private endpoint.

## Modifications to the request

Application gateway inserts six additional headers to all requests before it forwards the requests to the backend. These headers are x-forwarded-for, x-forwarded-port, x-forwarded-proto, x-original-host, x-original-url, and x-appgw-trace-id. The format for x-forwarded-for header is a comma-separated list of IP:**port**.

The valid values for x-forwarded-proto are HTTP or HTTPS. X-forwarded-port specifies the port where the request reached the application gateway. X-original-host header contains the original host header with which the request arrived. This header is useful in Azure website integration, where the incoming host header is modified before traffic is routed to the backend. If session affinity is enabled as an option, then it adds a gateway-managed affinity cookie.<br>

X-appgw-trace-id is a unique guid generated by application gateway for each client request and presented in the forwarded request to the backend pool member. The guid consists of 32 alphanumeric characters presented without dashes (for example: ac882cd65a2712a0fe1289ec2bb6aee7). This guid can be used to correlate a request received by application gateway and initiated to a backend pool member via the transactionId property in Diagnostic Logs.<br>

You can configure application gateway to modify request and response headers and URL by using Rewrite HTTP headers and URL or to modify the URI path by using a path-override setting. However, unless configured to do so, all incoming requests are proxied to the backend.
