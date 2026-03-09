Web applications are frequent targets for attacks that exploit common vulnerabilities like SQL injection and cross-site scripting (XSS). Preventing these attacks solely through application code is challenging and requires rigorous maintenance across multiple layers. Azure Web Application Firewall (WAF) provides centralized protection that complements your application-level security controls.

As a cybersecurity architect, you determine where to deploy WAF, which rule sets to apply, and how to integrate WAF into your overall application security architecture.

## What is Azure Web Application Firewall?

Azure WAF provides centralized, cloud-native protection of web applications from common exploits and vulnerabilities. It inspects incoming HTTP/HTTPS traffic against a set of rules and can block, log, or redirect malicious requests before they reach your application. A centralized WAF simplifies security management because you patch known vulnerabilities in one place rather than securing each web application individually. While WAF is an Azure-native security service, it doesn't operate as a standalone service. A WAF policy is its own Azure resource that you create independently, but it has no effect until you associate it with one of the supported hosting services listed below.

:::image type="content" source="../media/web-application-firewall-overview.png" alt-text="Diagram that shows Web application firewall." lightbox="../media/web-application-firewall-overview.png":::

Azure WAF can be deployed with the following services:

- **Azure Application Gateway:** a layer 7 load balancer for regional traffic.
- **Azure Front Door:** a global content delivery and application acceleration service.
- **Azure Application Gateway for Containers:** an application gateway that manages traffic to containerized workloads. WAF support for Application Gateway for Containers uses the DRS 2.1 managed rule set only and has some feature limitations compared to WAF on Azure Application Gateway.

> [!NOTE]
> WAF on Azure Content Delivery Network (CDN) is no longer accepting new customers. Use WAF on Azure Front Door for new deployments requiring global edge protection.

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

Key considerations for WAF on Azure Front Door vs. WAF on Azure Application Gateway:

- **Global vs. regional.** WAF on Azure Front Door operates at the edge, providing protection close to the source of traffic. WAF on Azure Application Gateway operates regionally, in the Azure region where your application runs. For globally distributed applications, WAF on Azure Front Door provides lower-latency protection. For regional applications, WAF on Azure Application Gateway provides greater integration with virtual network architectures.
- **DDoS protection.** Azure Front Door includes built-in platform-level DDoS protection at network layers 3 and 4. Combined with WAF's layer 7 protection, this provides defense-in-depth against volumetric and application-layer attacks. For origin servers with public IPs, also enable Azure DDoS Protection to guard against attacks that bypass the edge.
- **Rate limiting.** WAF on Azure Front Door supports rate limiting rules that restrict the number of requests from a single source within a time window, protecting against brute force attacks and API abuse.

> [!IMPORTANT]
> Managed rule sets are supported only on Azure Front Door Premium and Azure Front Door (classic). Front Door Standard supports custom rules only.

WAF on Azure Front Door policies combine custom rules and managed rule sets, processed in this order:

1. **Custom rules:** organization-specific allow or block logic, such as geo-filtering or IP restrictions. Custom rules act immediately on match—if a request matches a custom rule, no further rules are evaluated.
2. **Managed rule sets:** Azure-managed protection against common vulnerabilities, using the Default Rule Set (DRS). DRS versions 2.0 and later use **anomaly scoring**, where rule matches accumulate a severity-based score and the request is blocked only when the total exceeds a threshold. This reduces false positives for complex applications where a legitimate request might trigger a single low-severity rule. Earlier DRS versions (before 2.0) use per-rule blocking, where each rule match triggers immediate action.

Because custom rules are evaluated first, you can define organization-specific logic without disabling baseline protections in the managed rule sets. This layered approach lets you tailor protection to your application's requirements while maintaining the Azure-managed baseline.

## Comparing WAF across deployment options

All three deployment options share the same core WAF engine and inspect HTTP/HTTPS traffic against OWASP-based rule sets. The differences come down to where inspection happens, which rule sets are available, and what extra capabilities the hosting service adds.

- **WAF on Azure Application Gateway** inspects traffic regionally, inside your Azure virtual network. It supports the widest range of managed rule sets (CRS 3.x and DRS 2.x), rate-limit custom rules, bot protection, and per-site or per-URI policies. Choose Application Gateway when you need virtual network integration or when your application runs in a single region.
- **WAF on Azure Front Door** inspects traffic at global edge locations before it reaches your origin, providing lower-latency block decisions for distributed users. Managed rule sets and bot protection require the Premium tier; Standard supports custom rules only. Rate limiting is available on both tiers.
- **WAF on Application Gateway for Containers** targets containerized workloads managed through Kubernetes Gateway API. It supports DRS 2.1 and Bot Manager 1.0/1.1, but has feature limitations—no custom block responses, no X-Forwarded-For in custom rules, and no JavaScript/Captcha challenge actions for bot rules.

## Designing a WAF strategy

As an architect, consider these decisions when incorporating WAF into your application security architecture:

### Choose the deployment model

| Scenario | Recommended WAF service |
|---|---|
| Single-region web applications, or applications requiring virtual network integration at the WAF layer | WAF on Azure Application Gateway |
| Globally distributed web applications requiring edge acceleration | WAF on Azure Front Door |
| Containerized workloads using Kubernetes Gateway API | WAF on Application Gateway for Containers |
| Multi-region applications needing global failover and WAF | WAF on Azure Front Door with regional Application Gateways |

For high-security architectures, chain WAF on Azure Front Door (edge protection) with WAF on Azure Application Gateway (regional, VNet-integrated protection) for defense in depth.

### Tune before enforcing

Deploy WAF in Detection mode first to understand traffic patterns and identify false positives. Analyze WAF logs to create exclusions for legitimate traffic that triggers rules incorrectly. Only switch to Prevention mode after you're confident that the policy doesn't block legitimate requests.

### Integrate with broader security monitoring

Forward WAF logs to Microsoft Sentinel for correlation with other security signals, providing context for incident response.

### Complement application-level security

WAF isn't a substitute for secure coding practices. Input validation, parameterized queries, output encoding, and proper authentication remain essential. WAF provides defense in depth, catching threats that application-layer controls might miss.

### Consider compliance requirements

Several regulatory frameworks require WAF or equivalent application-layer protection for internet-facing applications. Document your WAF deployment as a security control in compliance evidence for PCI-DSS, SOC 2, and other frameworks.


