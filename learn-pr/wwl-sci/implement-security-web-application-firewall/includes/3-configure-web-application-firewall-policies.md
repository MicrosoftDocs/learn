A Web Application Firewall (WAF) inspects HTTP and HTTPS traffic and blocks requests matching patterns associated with known attacks. Unlike network-layer controls that filter on IP addresses and ports, a WAF understands application-layer request structure—query strings, headers, cookies, and request bodies. For Contoso Retail, deploying a WAF policy on Application Gateway is the primary defense against the SQL injection attack the penetration test demonstrated.

## Choose between Application Gateway WAF and Azure Front Door WAF

Azure provides two deployment models for WAF, and the right choice depends on where your workloads are distributed.

**Application Gateway WAF** is a regional application delivery controller with integrated WAF. It deploys within your virtual network and protects workloads in a single Azure region. Application Gateway WAF is the right choice when your application is hosted in one region and your security boundary is at the regional edge. For Contoso Retail's single-region e-commerce application on App Service, this is the appropriate model.

**Azure Front Door WAF** operates at the global edge and applies WAF inspection at Microsoft's global points of presence. It's the right choice for globally distributed applications where inspection needs to happen close to end users across multiple regions.

This module focuses on Application Gateway WAF.

## Select a managed rule set

Application Gateway WAF includes managed rule sets maintained by Microsoft. These rule sets are based on the OWASP Core Rule Set (CRS) and group detection logic into rule groups, each targeting a specific attack category.

The current recommended version is **CRS 3.2**, which includes improvements in false positive reduction compared to earlier versions. Application Gateway also supports the **Default Rule Set (DRS)**, which tracks newer CRS versions with Microsoft-managed updates and is recommended for new deployments.

The CRS includes the following rule groups:

- **SQL injection (SQLI)**: Detects attempts to inject SQL statements into input fields, headers, cookies, and request bodies.
- **Cross-site scripting (XSS)**: Detects attempts to inject client-side scripts into pages viewed by other users.
- **Remote file inclusion (RFI) and local file inclusion (LFI)**: Detects attempts to include files from remote servers or traverse the local file system.
- **PHP injection**: Detects PHP-specific attack patterns targeting PHP-based applications.
- **Protocol enforcement**: Detects HTTP protocol violations, anomalies, and missing required headers.

For the Contoso Retail scenario, the SQL injection rule group in CRS 3.2 covers the attack the penetration test identified. The full rule set provides defense-in-depth across the OWASP Top 10 attack categories.

## Set WAF modes: Detection and Prevention

A WAF policy operates in one of two modes, and the mode determines what the WAF does when a request matches a rule.

**Detection mode** logs rule matches but doesn't block any requests. Every request—including those that trigger rules—passes through to the back-end application. Detection mode is the right starting point when you first deploy a WAF against existing production traffic. It lets you observe which rules trigger against real application requests, identify false positives before any traffic is affected, and tune exclusions without disrupting users.

**Prevention mode** both logs and blocks requests that match rules. A blocked request returns an HTTP 403 response and never reaches the back-end application. Prevention mode is the production configuration once you completed tuning.

The recommended practice is:

1. Deploy the WAF policy in **Detection** mode.
2. Allow the WAF to observe one to two weeks of representative production traffic.
3. Analyze the WAF logs and identify any false positives.
4. Configure targeted exclusions for confirmed false positives.
5. Switch the policy to **Prevention** mode.

To change the mode in the Azure portal, navigate to your WAF policy, select **Policy settings**, and set **Policy mode** to **Prevention**.

> [!IMPORTANT]
> Deploying directly in Prevention mode without a Detection phase risks blocking legitimate application traffic. Always use Detection mode first when deploying a WAF against an existing application.

## Reduce false positives with rule exclusions

Some legitimate application requests trigger WAF rules because the request data matches patterns the rules are designed to detect. A common example is an authentication token in a request header that contains characters resembling a SQL injection pattern. Blocking this request in Prevention mode would break authentication for all users.

Rule exclusions suppress a specific rule for a specific request element—a header name, cookie name, query string argument name, or request body argument name—without disabling the rule globally for all request types.

When you configure exclusions:

1. Find the rule ID that generated the false positive in the WAF logs.
2. Identify which request element triggered the rule—for example, the `Authorization` request header.
3. In the WAF policy, navigate to **Managed rules** > **Exclusions**.
4. Select **Add exclusion**.
5. Set **Match variable** to the request element type (request header name, cookie name, query string argument name, or request body argument name).
6. Set **Operator** and **Selector** to match the specific header, cookie, or argument name—for example, operator **Equals** and selector `Authorization`.
7. Select the rule or rule group to exclude and select **Save**.

> [!IMPORTANT]
> Create exclusions as narrowly as possible. A global exclusion that disables a rule for all request elements removes protection for every request, not just the one causing the false positive. Target exclusions to the smallest scope that resolves the issue.

## Create custom WAF rules

Managed rule sets cover the OWASP Top 10 attack categories, but your application can need other protections beyond what the built-in rules provide. Custom rules let you define match conditions and actions specific to your workload.

A custom rule consists of:

- **Match conditions**: The criteria the WAF evaluates—request URI, HTTP method, request header value, query string value, request body content, client IP address, or client geographic location.
- **Operator**: The comparison applied to the match condition—equals, contains, starts with, ends with, regex match, IP match, or geo match.
- **Action**: The response when the match condition is true—Allow, Block, or Log.
- **Priority**: An integer that determines evaluation order. Lower numbers are evaluated first. All custom rules are evaluated before any managed rule set rules.

For Contoso Retail, you might add custom rules to:

- Block requests originating from geographic regions where the business has no customers.
- Allow a specific IP range used by your authorized penetration testing firm to bypass WAF inspection during scheduled testing windows.
- Block requests with suspicious query string patterns specific to your application's endpoints.

Configure custom rules in the WAF policy under **Custom rules** > **Add custom rule**.

## Associate WAF policies at the right level

A single Application Gateway can serve multiple applications through separate listeners—one listener per hostname or IP address. WAF policies can be associated at two levels.

**Gateway-level association** applies the policy to all listeners on the Application Gateway. Every application behind the gateway shares the same WAF configuration, including all managed rules, exclusions, and custom rules.

**Per-listener or per-site association** applies a distinct WAF policy to a specific listener. Different applications behind the same gateway can have different rule sets, exclusions, and custom rules. This requires the **WAF_v2 SKU** and is the recommended configuration for production environments where multiple applications with different security requirements share a gateway.

Use per-site policies when one application's legitimate traffic would cause false positives for another application's WAF configuration, or when different applications have different compliance requirements for which rules must be enabled.
