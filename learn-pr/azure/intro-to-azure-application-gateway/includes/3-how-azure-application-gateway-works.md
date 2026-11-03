Azure Application Gateway has a series of components that combine to securely route and load balance requests across a pool of web servers. Application Gateway includes the following components: 

:::image type="content" source="../images/application-gateway-components.png" alt-text="Diagram that shows Azure Application Gateway components." border="false":::

- **Frontend IP addresses**: Clients connect through the gateway's frontend addresses. Application Gateway v2 supports public-only, private-only, or combined public and private frontends. The limit is one public and one private address per IP family. An IPv4-only gateway can have two frontend addresses, while a dual-stack gateway can have up to four: public and private IPv4, and public and private IPv6.
- **Listeners**: A listener accepts connections that match its frontend IP address, port, and protocol. A Basic HTTP(S) listener accepts requests without filtering by hostname. A Multi-site HTTP(S) listener also matches one or more configured hostnames. An HTTPS listener uses a TLS certificate to secure the client connection.
- **Routing rules**: A request-routing rule connects a listener to backend targets and backend HTTP settings. A basic rule sends requests to one backend pool. A path-based rule selects a pool according to the URL path and uses a default target when no path matches. Backend HTTP settings control the backend protocol, port, cookie-based affinity, connection draining, request timeout, and probe association.

> [!NOTE]
> IPv6 requires a [dual-stack gateway and virtual network](/azure/application-gateway/ipv6-application-gateway-portal). IPv6-only gateways and IPv6 backend targets aren't supported. An existing IPv4-only gateway can't be converted in place to dual stack. For private-only v2 deployment, follow the network-isolation registration and subnet-delegation requirements in the [private deployment guidance](/azure/application-gateway/application-gateway-private-deployment).

## Load balancing in Application Gateway

For HTTP(S) traffic, Application Gateway selects a backend pool using Layer 7 information such as the hostname and URL path, then normally distributes requests among the pool's healthy servers using round robin. Azure Load Balancer operates at Layer 4 instead. Its regional backend distribution uses a five-tuple hash by default: source IP, source port, destination IP, destination port, and protocol.

Enable cookie-based affinity in the backend HTTP settings when a session needs to remain on the same healthy backend server. Clients must retain and return the gateway-managed cookie. If the target becomes unavailable, affinity doesn't preserve that server's local session state.

## Web application firewall

Web Application Firewall (WAF) inspects HTTP requests before Application Gateway forwards them to backend servers. The matching listener first accepts the connection. For HTTPS traffic, the gateway terminates TLS so WAF can inspect the decrypted request. WAF rules help detect threats such as SQL injection and cross-site scripting.

> [!IMPORTANT]
> For a new WAF deployment, use WAF_v2 and associate an [enabled WAF policy](/azure/web-application-firewall/ag/create-waf-policy-ag) with the gateway or the relevant listener or path. Detection mode logs rule matches without blocking requests. Prevention mode blocks requests according to the configured rules and anomaly-scoring decisions. Standard_v2 doesn't provide WAF inspection.

Application Gateway WAF supports managed rule sets that are updated as threats evolve. Microsoft Default Rule Sets (DRS) combine OWASP Core Rule Set (CRS) protections with additional Microsoft protections. Microsoft currently recommends DRS 2.2, which is based on OWASP CRS 3.3.4. You can configure exclusions and rule overrides to reduce false positives, and use request-body inspection settings and size limits appropriate to your application.

> [!NOTE]
> Recommended rule sets and creation defaults aren't necessarily the same. Explicitly select and verify the rule-set type and version in your WAF policy, and review the [current supported rules](/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules) before upgrading an existing policy.

## Back-end pools  

A back-end pool is a collection of web servers that can be made up of: a fixed set of virtual machines, a virtual machine scale-set, an app hosted by Azure App Services, or a collection of on-premises servers.

Application Gateway itself distributes requests among healthy servers in the selected backend pool. A pool doesn't require a separate Azure Load Balancer. Configure the pool with the appropriate backend targets, such as IP addresses or fully qualified domain names, and ensure the targets can serve the requests using the associated backend HTTP settings.

To encrypt the connection to a backend, select HTTPS in the [backend HTTP settings](/azure/application-gateway/configuration-http-settings) referenced by the routing rule. The backend presents its server certificate during the TLS handshake. Application Gateway v2 normally validates publicly trusted certificates using its built-in trusted-root store. For a private-CA or self-signed certificate, configure the appropriate trusted-root certificate in the backend HTTP settings.

For an Azure App Service backend, configure HTTPS in the backend HTTP settings, normally on port 443, to encrypt traffic from Application Gateway to the app. A normal publicly trusted App Service certificate doesn't require an additional trusted-root upload. Azure management of the app doesn't automatically enable backend HTTPS. Configure the backend hostname and TLS server name to match the app's domain and certificate.

> [!NOTE]
> When using the app's default `azurewebsites.net` domain, the [App Service integration guidance](/azure/application-gateway/configure-web-app) uses the backend target's hostname. If you use a custom domain, configure that domain and its certificate on the backend and preserve the original hostname where possible. Don't apply a hostname override indiscriminately.

For an HTTPS backend connection, configure:

- The HTTPS protocol and the port on which the backend accepts TLS connections.
- A backend hostname and TLS server name that the application and certificate accept.
- Any trusted-root certificate needed for a private certificate chain.

Keep certificate-chain, expiry, and server-name validation enabled for production traffic.

## Application Gateway routing

For HTTP(S) applications, hostname-based listener selection and URL path-based routing can work together. For example, a Multi-site listener can select `shop.contoso.com`, and its path-based rule can send `/images/*` and `/video/*` requests to different backend pools.

> [!NOTE]
> On Application Gateway v2, [request-routing rule priority](/azure/application-gateway/multiple-site-overview#request-routing-rules-evaluation-order) determines listener evaluation order. Give site-specific rules a higher priority (a lower number) than overlapping wildcard or Basic-listener rules. Path patterns within a path-based rule are evaluated in their listed order, so put more specific paths before broader wildcard paths.

### Path-based routing

Path-based routing sends requests with different URL paths to different pools of back-end servers. For example, you could direct requests with the path \/video\/\* to a back-end pool containing servers that are optimized to handle video streaming, and direct \/images\/\* requests to a pool of servers that handle image retrieval.

:::image type="content" source="../images/path-based-routing.png" alt-text="Diagram that shows path-based routing to image and video backend pools." border="false":::

### Multiple-site routing

Multi-site hosting lets more than one web application share an Application Gateway. Configure DNS so each site's hostname resolves to the gateway frontend. Use an A record for an IPv4 address, an AAAA record for an IPv6 address when supported, or a CNAME from a subdomain to the gateway's DNS name. A CNAME doesn't point directly to an IP address and can't be an ordinary zone-apex record.

For example, configure A records for `contoso.com` and `fabrikam.com` that point to the same public IPv4 frontend. Create Multi-site listeners that match those hostnames and associate them with rules that select the corresponding backend pools. For HTTPS, provide a listener certificate valid for each site's hostname. The following diagram shows host-based selection of the two pools:

:::image type="content" source="../images/multi-site-routing.png" alt-text="Diagram that shows hostname-based routing to separate backend pools." border="false":::

Multi-site configurations are useful for supporting multitenant applications, where each tenant has its own set of virtual machines or other resources hosting a web application.

Application Gateway routing also includes these features:

- **Redirection**. Redirection can be used to another site, or from HTTP to HTTPS.
- **Rewrite HTTP headers**. HTTP headers allow the client and server to pass parameter information with the request or the response.
- **Custom error pages**. Application Gateway allows you to create custom error pages instead of displaying default error pages. You can use your own branding and layout using a custom error page.

## TLS termination

TLS termination at Application Gateway centralizes management of the client-facing certificate. If the gateway forwards requests to the backend over HTTP, it also removes the backend TLS workload, but that hop is unencrypted.

For end-to-end TLS, use HTTPS on both the listener and the backend HTTP settings. Application Gateway terminates the client TLS connection, processes the decrypted HTTP request, and establishes a separate TLS connection to the backend. The backend still needs a valid server certificate and performs TLS processing. Certificates authenticate the endpoints, while the TLS connections use negotiated keys to protect application data.

> [!NOTE]
> Application Gateway requires TLS 1.2 or higher for supported TLS connections. Support for TLS 1.0 and TLS 1.1 ended on August 31, 2025. Confirm that clients and backend servers support the required versions. Some Azure settings and API identifiers still use the legacy term "SSL". For more information, see [TLS version retirement](/azure/application-gateway/application-gateway-tls-version-retirement).

Client traffic arrives on a configured frontend IP address and port. The matching listener accepts the connection and, for HTTPS, terminates TLS. A Multi-site listener also matches the requested hostname. The associated request-routing rule determines whether to forward the HTTP request to a backend target or redirect it.

:::image type="content" source="../images/application-gateway-end-to-end-tls.svg" alt-text="Diagram that shows two TLS connections, server certificate locations, and backend trust validation in Application Gateway." border="false":::

Application Gateway can be the public entry point for an application, but adding it doesn't automatically prevent clients from reaching a backend directly. Configure backend network access so application traffic can arrive only through the intended gateway path. Frontend listeners commonly use ports 80 and 443, but can use other supported ports. The backend protocol and port are configured separately.

> [!IMPORTANT]
> Prevent direct access that bypasses the gateway and WAF. For private VM backends, avoid public ingress and use appropriate network security group or firewall rules. For App Service, use [private endpoints with suitable public-access restrictions, or service endpoints together with app access restrictions](/azure/app-service/overview-app-gateway-integration). Preserve the access required for health probes and authorized administration.

## Health probes

Health probes determine which backend servers are eligible to receive requests. If you don't associate a custom probe, Application Gateway uses a default probe. Its interval is 30 seconds, its response timeout is 30 seconds, and its unhealthy threshold is three consecutive failures. On v2, probes continue at the configured interval, so a backend isn't necessarily declared unhealthy 30 seconds after a failure.

By default, an HTTP status code from 200 through 399 indicates a healthy response. Custom probes let you configure the hostname, path, timing, unhealthy threshold, and response-matching criteria. Use a probe appropriate to the application, especially when it requires a specific hostname or health endpoint.

## Autoscaling

Application Gateway Standard_v2 and WAF_v2 can automatically adjust the number of instances as traffic demand changes. Instead of choosing a fixed running instance count, configure a minimum instance count and, optionally, a maximum. Choose these bounds for expected demand and cost, and allow for the time required to provision additional instances.

## WebSocket and HTTP/2 traffic

Application Gateway natively supports WebSocket connections through HTTP and HTTPS listeners. A WebSocket connection starts with an HTTP upgrade handshake and then carries bidirectional messages over the established connection. WebSocket support doesn't require a separate enable setting.

HTTP/2 is an HTTP protocol version that multiplexes request and response streams over a connection. Application Gateway's HTTP(S) proxy supports HTTP/2 on the client-facing HTTPS connection, but uses HTTP/1.1 for backend connections. Check the gateway's HTTP/2 setting when configuring client support. Enabling HTTP/2 doesn't disable HTTP/1.1.

> [!NOTE]
> [HTTP/3 over QUIC](/azure/application-gateway/http3-quic-support) is also available in public preview for client connections on Basic listeners. Backend communication remains HTTP/1.1. Basic here refers to the listener type, not the Basic SKU. The preview is provided without an SLA and isn't recommended for production workloads.
