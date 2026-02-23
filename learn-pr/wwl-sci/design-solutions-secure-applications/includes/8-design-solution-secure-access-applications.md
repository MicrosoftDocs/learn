Web applications are frequent targets for attacks that exploit common vulnerabilities like SQL injection and cross-site scripting (XSS). Preventing these attacks solely through application code is challenging and requires rigorous maintenance across multiple layers. Azure Web Application Firewall (WAF) provides centralized protection that complements your application-level security controls.

As a cybersecurity architect, you determine where to deploy WAF, which rule sets to apply, and how to integrate WAF into your overall application security architecture.

## What is Azure Web Application Firewall?

Azure WAF provides centralized, cloud-native protection of web applications from common exploits and vulnerabilities. It inspects incoming HTTP/HTTPS traffic against a set of rules and can block, log, or redirect malicious requests before they reach your application. A centralized WAF simplifies security management because you patch known vulnerabilities in one place rather than securing each web application individually.

:::image type="content" source="../media/web-application-firewall-overview.png" alt-text="Diagram that shows Web application firewall." lightbox="../media/web-application-firewall-overview.png":::

Azure WAF can be deployed with the following services:

- **Azure Application Gateway:** a layer 7 load balancer for regional traffic.
- **Azure Front Door:** a global content delivery and application acceleration service.
- **Azure Application Gateway for Containers:** an application gateway that manages traffic to containerized workloads.
- **Azure Content Delivery Network (CDN):** Content Delivery Network from Azure.

Each deployment option shares the same core WAF engine but offers service-specific capabilities that influence your architectural decisions.

## WAF on Azure Application Gateway

Azure Application Gateway is a regional, layer 7 load balancer. When you enable WAF on Application Gateway, it inspects every inbound HTTP/HTTPS request to protect against web application attacks.

:::image type="content" source="../media/application-gateway.png" alt-text="Diagram that illustrates how a web application firewall works with Azure Application Gateway." lightbox="../media/application-gateway.png":::

Key capabilities include:

- **Managed rule sets.** WAF uses rule sets based on the Open Worldwide Application Security Project (OWASP) Core Rule Set (CRS) to protect against SQL injection, XSS, file inclusion, command injection, HTTP request smuggling, and other OWASP Top 10 vulnerabilities. The Default Rule Set (DRS) and Bot Manager rule set are maintained by Azure and updated as new attack patterns emerge.
- **Custom rules.** Create rules that evaluate requests based on IP address, geo-location, URI path, request headers, query strings, or request body content. Custom rules take priority over managed rules, allowing you to tailor protection to your application's specific requirements.
- **WAF modes.** Run WAF in Detection mode (logs requests that match rules but doesn't block them) to tune policies before switching to Prevention mode (blocks requests matching rules). Start with Detection mode to identify false positives and create exclusions before enforcing.
- **Per-site and per-URI policies.** Apply different WAF policies to different sites or URI paths hosted behind the same Application Gateway. For example, apply stricter rules to authentication endpoints and relaxed rules to a static content path.
- **Bot protection.** The Bot Manager rule set classifies traffic as good bots (search engine crawlers), bad bots (scrapers, vulnerability scanners), and unknown bots, allowing you to block or challenge malicious automated traffic.

WAF logs integrate with Azure Monitor and can be forwarded to Microsoft Sentinel for correlation with other security events. Microsoft Defender for Cloud can also assess your WAF configuration and generate recommendations for improvements.

## WAF on Azure Front Door

Azure Front Door is a global service that accelerates application delivery and provides global load balancing. WAF on Front Door inspects traffic at Azure edge locations before it reaches your origin servers, reducing latency for block decisions and protecting against geographically distributed attacks.

Key considerations for Front Door WAF vs. Application Gateway WAF:

- **Global vs. regional.** Front Door WAF operates at the edge, providing protection close to the source of traffic. Application Gateway WAF operates regionally, in the Azure region where your application runs. For globally distributed applications, Front Door WAF provides lower-latency protection. For regional applications, Application Gateway WAF provides greater integration with virtual network architectures.
- **DDoS protection.** Azure Front Door includes built-in DDoS layer 3 and 4 protection. Combined with WAF's layer 7 protection, this provides defense-in-depth against volumetric and application-layer attacks.
- **Rate limiting.** Front Door WAF supports rate limiting rules that restrict the number of requests from a single source within a time window. This protects against brute force attacks and API abuse.
- **Geo-filtering.** Block or allow traffic from specific countries/regions. This reduces attack surface for applications that only serve specific geographic markets.

Front Door WAF policies combine custom rules and Azure-managed rule sets, processed in this order:

1. **Custom rules:** organization-specific allow or block logic, such as geo-filtering or IP restrictions. Custom rules act immediately on match.
2. **Managed rule sets:** Azure-managed protection against common vulnerabilities, using the Default Rule Set (DRS). For managed rules, you choose between **anomaly scoring** (rule matches accumulate a score, and the request is blocked only when the total exceeds a threshold) or **per-rule blocking** (each rule match triggers immediate action). Anomaly scoring reduces false positives for complex applications where legitimate requests may trigger a single rule but not multiple rules. Per-rule blocking provides stricter enforcement but requires more tuning. Choose based on your organization's tolerance for false positives versus the sensitivity of the application.
3. **Default rules:** catch-all rules for traffic not matching other rules.

Because custom rules are evaluated first, you can define organization-specific logic without disabling baseline protections in the managed rule sets. This layered approach lets you tailor protection to your application's requirements while maintaining the Azure-managed baseline.

## Designing a WAF strategy

As an architect, consider these design decisions when incorporating WAF into your application security architecture:

### Choose the deployment model

| Scenario | Recommended WAF service |
|---|---|
| Single-region web applications behind a load balancer | Application Gateway WAF |
| Globally distributed web applications requiring edge acceleration | Front Door WAF |
| Applications requiring virtual network integration at the WAF layer | Application Gateway WAF (with virtual network integration) |
| Multi-region applications needing global failover and WAF | Front Door WAF with regional Application Gateways |

For high-security architectures, you can chain Front Door WAF (for edge protection) with Application Gateway WAF (for regional, virtual network-integrated protection), applying defense in depth at both the global and regional layers.

### Tune before enforcing

Deploy WAF in Detection mode first to understand traffic patterns and identify false positives. Analyze WAF logs to create exclusions for legitimate traffic that triggers rules incorrectly. Only switch to Prevention mode after you're confident that the policy doesn't block legitimate requests.

### Integrate with broader security monitoring

Forward WAF logs to Microsoft Sentinel for correlation with other security signals. A spike in blocked SQL injection attempts at the WAF layer may correlate with reconnaissance activity detected by Microsoft Defender for Cloud, providing context for incident response.

### Complement application-level security

WAF protects against known attack patterns but isn't a substitute for secure coding practices. Application-level input validation, parameterized queries, output encoding, and proper authentication remain essential. WAF provides defense in depth, catching threats that application-layer controls might miss.

### Consider compliance requirements

Several regulatory frameworks require WAF or equivalent application-layer protection for internet-facing applications. Document your WAF deployment as a security control in compliance evidence for PCI-DSS, SOC 2, and other standards.


