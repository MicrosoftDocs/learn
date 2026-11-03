Azure Application Gateway manages the requests that client applications send to web apps that are hosted on a pool of web servers. The pool of web servers can be Azure virtual machines, Azure Virtual Machine Scale Sets, Azure App Service, and even on-premises servers. 

> [!IMPORTANT]
> This module covers HTTP(S) application delivery with Application Gateway [Standard_v2 and WAF_v2](/azure/application-gateway/overview-v2#sku-types). Application Gateway v1, including the Standard and WAF SKUs, retired on April 28, 2026 and isn't supported anymore. [Migrate remaining v1 deployments to v2](/azure/application-gateway/v1-retirement). The separate [Basic SKU](/azure/application-gateway/overview) is a preview offering with a different feature set.

Application Gateway load balances HTTP traffic and can provide web application firewall (WAF) protection when configured with WAF_v2 and an enabled WAF policy. It supports TLS encryption between users and an application gateway when the listener uses HTTPS, and between the gateway and application servers when the backend HTTP settings use HTTPS.

:::image type="content" source="../images/application-gateway-topology.png" alt-text="Diagram that shows Application Gateway routing requests to a backend pool." border="false":::

Application Gateway normally distributes requests among healthy servers in the selected backend pool using round robin. When [cookie-based affinity](/azure/application-gateway/configuration-http-settings#cookie-based-affinity) is enabled, subsequent requests that return the gateway's affinity cookie can be routed to the same healthy backend server. This can help applications that keep session state locally, but it doesn't replicate that state or guarantee that a transaction survives a backend failure.

Azure Application Gateway includes the following features:

- Support for HTTP and HTTPS, client-facing HTTP/2 over HTTPS, and WebSocket traffic.
- WAF protection with WAF_v2 and an enabled [WAF policy](/azure/web-application-firewall/ag/create-waf-policy-ag). Detection mode logs rule matches without blocking requests; Prevention mode blocks requests according to the configured rules and anomaly-scoring decisions. Standard_v2 doesn't provide WAF inspection.
- End-to-end TLS when both the listener and backend HTTP settings use HTTPS.
- Autoscaling to dynamically adjust capacity as your web traffic load change.
- [Connection draining](/azure/application-gateway/configuration-http-settings#connection-draining) supports planned removal of backend servers by stopping new requests from being assigned to them and allowing existing connections to finish within a configured timeout. Requests bound to a deregistering server by gateway-managed affinity are an exception to the no-new-requests behavior.

Application Gateway also provides a [TCP/TLS proxy](/azure/application-gateway/tcp-tls-proxy-overview) for other workloads. This module focuses on its Layer 7 HTTP(S) capabilities.
