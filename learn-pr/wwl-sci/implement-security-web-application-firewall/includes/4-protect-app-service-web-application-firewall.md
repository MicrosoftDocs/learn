The App Service security controls and the Web Application Firewall (WAF) policy on Application Gateway work together—but only if the integration is configured correctly. For Contoso Retail, the penetration test showed that SQL injection bypassed application-layer protections. Closing that gap requires three things: admins deploying Application Gateway with WAF in front of App Service, routing all inbound traffic through the Application Gateway so the WAF inspects it, and restricting App Service to reject any traffic that doesn't arrive through the Application Gateway.

## Understand the integration architecture

Application Gateway acts as the single public entry point for all incoming traffic. It accepts requests on its public IP address, the WAF policy inspects each request against managed and custom rules, and approved requests are forwarded to App Service over the virtual network.

Two options prevent direct access to App Service:

- **Access restrictions**: Configure App Service to allow inbound traffic only from the Application Gateway subnet or the `AzureApplicationGateway` service tag. The App Service public endpoint remains active, but it accepts traffic only from the allowed source.
- **Private endpoint**: Deploy a private endpoint on App Service so it has no internet-facing endpoint. Application Gateway forwards traffic to the App Service private IP over the virtual network.

For most production deployments, the private endpoint model provides stronger isolation. Access restrictions are appropriate when private endpoint deployment isn't feasible due to existing virtual network architecture constraints.

## Deploy Application Gateway with WAF_v2

The WAF capability on Application Gateway requires the **WAF_v2 SKU**. The WAF_v1 SKU doesn't support WAF policy associations, which are required for per-site policies and rule exclusions.

To deploy an Application Gateway with WAF in the Azure portal:

1. Select **Create a resource** and search for **Application Gateway**.
2. On the **Basics** tab, set **Tier** to **WAF V2** and configure the subscription, resource group, and region.
3. On the **Frontends** tab, create a public IP address to serve as the Application Gateway's internet entry point.
4. On the **WAF** tab, create or associate a WAF policy. Set **Policy mode** to **Detection** for initial deployment.
5. On the **Backends** tab, add a backend pool. Enter the App Service default hostname—for example, `contoso-retail.azurewebsites.net` - as the backend target.
6. On the **Configuration** tab, create a routing rule that maps the frontend listener to the backend pool and backend HTTP settings.

> [!TIP]
> Select the WAF_v2 SKU even if you initially deploy without WAF enabled. Attaching a WAF policy to an existing WAF_v2 Application Gateway is straightforward, but migrating from Standard_v2 to WAF_v2 SKU requires redeployment.

## Route traffic through the WAF

When Application Gateway forwards traffic to App Service, the `Host` header in the forwarded request must match the App Service hostname. Without the correct host header, App Service returns a 404 error or an incorrect certificate error.

Configure the backend HTTP settings for the App Service backend pool with **Pick host name from backend target** enabled. This setting automatically sets the forwarded `Host` header to the App Service fully qualified domain name (FQDN), which is required for App Service to respond correctly.

For end-to-end TLS encryption between Application Gateway and App Service:

- On the frontend HTTPS listener, configure the listener with your domain certificate.
- On the backend HTTP settings, enable HTTPS and select **Use well-known CA certificate** to validate the App Service certificate. App Service includes a default TLS certificate for the `*.azurewebsites.net` domain that is trusted by Azure-recognized certificate authorities.

## Restrict App Service to accept traffic from Application Gateway only

After Application Gateway is deployed and routing traffic to App Service, restrict App Service to reject traffic from any other source. Without this restriction, an attacker who discovers the App Service hostname can send requests directly to App Service and bypass WAF inspection entirely.

**Option 1 - Access restrictions with a service tag rule:**

1. In App Service, navigate to **Settings** > **Networking** > **Public network access**.
2. Select **Add** to add a new access restriction rule.
3. Set **Action** to **Allow**, **Priority** to `100`, and **Type** to **Service Tag**.
4. Select `AzureApplicationGateway` as the service tag.
5. Add a second rule with **Action** set to **Deny**, **Priority** to `200`, **Type** set to **IPv4**, and IP address block `0.0.0.0/0` to deny all other traffic.
6. Select **Save**.

**Option 2 - Private endpoint:**

1. In App Service, navigate to **Settings** > **Networking** > **Private endpoints**.
2. Select **Add** to create a private endpoint in the subnet used by Application Gateway or a connected subnet.
3. After the private endpoint is created, navigate to **Public network access** and set it to **Disabled**.

Once either option is configured, requests not arriving through the Application Gateway's inspection path are rejected before reaching the application.

## Monitor WAF diagnostic logs

WAF diagnostic logs record every request the WAF evaluates, including rule matches, actions taken, and request details. Enable diagnostic logging on the Application Gateway to route these logs to Log Analytics for analysis.

In the Azure portal, navigate to your Application Gateway, select **Monitoring** > **Diagnostic settings**, and add a diagnostic setting that sends the `ApplicationGatewayFirewallLog` category to your Log Analytics workspace.

Once logs are flowing, use KQL to analyze WAF activity:

```kusto
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
| where Category == "ApplicationGatewayFirewallLog"
| where action_s == "Blocked"
| summarize count() by ruleId_s, requestUri_s
| order by count_ desc
```

This query returns the most frequently triggered blocking rules and the request URIs that triggered them. Use the results to identify legitimate traffic being blocked and create targeted exclusions.

## Tune exclusions and switch to Prevention mode

After collecting WAF logs in Detection mode, review the matched and blocked requests to identify false positives. For each confirmed false positive:

1. Note the rule ID from the WAF log entry.
2. Identify which request element triggered the rule—header name, cookie name, query string argument, or request body argument.
3. In the WAF policy, navigate to **Managed rules** > **Exclusions** and add a targeted exclusion scoped to that rule ID and request element.

Once legitimate traffic passes cleanly without false positives, switch the WAF policy to Prevention mode. Navigate to the WAF policy, select **Policy settings**, and change **Policy mode** to **Prevention**.

With Prevention mode active and App Service access restrictions in place, all web traffic to Contoso Retail's e-commerce application passes through WAF inspection before reaching the application—and App Service accepts only traffic that arrived through that inspection path.
