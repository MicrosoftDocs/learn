After Contoso configures AI Gateway authentication and rate limits, applying network access controls and diagnostic logging completes your security posture. Contoso is restricting who can reach the gateway and capturing detailed audit trails of all model requests. Contoso Financial Services needs visibility into model usage patterns to detect anomalies like off-hours requests or sudden token consumption spikes that could indicate credential theft or application errors. Here, you learn how to restrict gateway network exposure, enable diagnostic logging, monitor usage with Azure Monitor, and detect suspicious activity.

| Security Control | Purpose |
|------------------|---------|
| **Network access restriction** | Limit gateway endpoint exposure to specific networks or IP ranges |
| **Managed identity for gateway** | Authenticate the gateway to backend resources without stored credentials |
| **Diagnostic logging** | Capture request metadata for audit trails and compliance |
| **Azure Monitor metrics** | Track request volume, token consumption, and error rates |
| **Anomaly detection** | Identify unusual usage patterns that indicate security or operational issues |

## Restrict network access to the gateway

By default, AI Gateway endpoint accessibility depends on the Azure API Management tier and networking configuration of your AI Policy Manager (APIM) instance. For production environments, restrict gateway access to specific Azure Virtual Networks or IP address ranges.

In the gateway's networking settings, configure network access rules that limit inbound connections. If the calling applications run within Azure, restrict access to the Virtual Network where those applications operate. Add the gateway to a private endpoint configuration so that traffic between applications and the gateway never traverses the public internet.

For applications running outside Azure or in hybrid environments, configure IP allowlisting to permit connections only from known source addresses. Combine IP restrictions with Microsoft Entra token authentication to enforce both network-level and identity-level access controls.

Contoso's three applications all run in Azure App Service within the same Virtual Network. The AI Gateway is configured with a private endpoint accessible only from that Virtual Network, eliminating public internet exposure entirely.

## Use managed identities for gateway authentication

The AI Gateway itself requires authentication to access backend resources like model deployments and diagnostic storage. Rather than storing credentials for the gateway, assign a system-assigned or user-assigned managed identity to the gateway resource.

In the gateway's identity settings, enable the system-assigned managed identity. Grant this identity the necessary permissions to invoke model deployments—typically a role like **Cognitive Services User** or a custom role scoped to the specific deployments the gateway routes to.

Using managed identities eliminates the need to rotate credentials or secure connection strings for backend access. The gateway automatically obtains tokens as needed using its Azure-managed identity, and access is governed through Azure role assignments you control centrally.

## Enable diagnostic logging

Diagnostic logging captures metadata for every request that passes through the gateway, creating a complete audit trail of model access. Logs include the timestamp, caller identity, token count, HTTP response code, and request latency. Prompt content and response content aren't logged by default—APIM diagnostic logging captures request metadata only.

In the gateway's diagnostic settings, create a new diagnostic configuration. Select the log categories you want to capture—typically **Request Logs** and **Authentication Logs**. Choose a destination for the logs: a Log Analytics workspace for querying and alerting, a Storage Account for long-term retention, or an Event Hubs for streaming to external systems.

For compliance and incident response, route logs to a Log Analytics workspace. This destination supports rich querying with Kusto Query Language (KQL) and integrates with Azure Monitor alerts for real-time detection of suspicious patterns.

Contoso configures the gateway to send diagnostic logs to its central Log Analytics workspace, where security operations teams already monitor other Azure resources. Retention is set to 90 days to meet regulatory compliance requirements.

## Monitor usage with Azure Monitor

After enabling diagnostic logging, use Azure Monitor to track gateway metrics and query log data for insights into model usage patterns. Key metrics to monitor include request volume, token consumption per caller, rate limit rejections, and error rates.

In Azure Monitor, create a dashboard that displays these metrics over time. Add charts showing total requests per hour, token consumption by caller identity, and the percentage of requests rejected due to rate limits or authentication failures. This visibility helps you detect capacity issues, misconfigured rate limits, or authentication problems.

Use KQL queries to analyze log data for specific insights. The following query summarizes successful request volume by API route over the past 24 hours, grouped by hour—helping you identify which model deployments are most heavily used and detect sudden changes in traffic patterns:

```kusto
GatewayLogs
| where TimeGenerated > ago(24h)
| where ResponseCode == 200
| summarize TotalRequests = count() by ApiName, bin(TimeGenerated, 1h)
| order by TotalRequests desc
```

This query uses the **GatewayLogs** table in the Log Analytics workspace connected to your Azure API Management instance. It surfaces successful request volume by API name over the past 24 hours, helping you identify which model deployments are most heavily used and detect sudden changes in traffic patterns. If request volume for a specific API spikes unexpectedly, investigate for application errors or unauthorized access.

:::image type="content" source="../media/gateway-monitoring-pipeline.png" alt-text="Diagram showing the monitoring pipeline: AI Gateway logs flow through diagnostic settings to Log Analytics, triggering Azure Monitor alerts to the security team." lightbox="../media/gateway-monitoring-pipeline.png":::

## Detect anomalies and respond to alerts

After the admin establishes a baseline of normal usage—typical request volume, token consumption rates, and access patterns—configure alerts to detect deviations that indicate problems. Create Azure Monitor alert rules for conditions like:

- A caller exceeds 80% of its token rate limit, suggesting the limit is too low or the application is making excessive requests
- Request error rates exceed 5%, indicating authentication issues or backend model problems
- Requests occur outside normal business hours from applications that should only operate during specific times
- A caller that typically consumes 10,000 tokens per day suddenly consumes 100,000 tokens
- A Foundry-deployed agent generates far more model calls than its expected task frequency—for example, a document summarization agent that normally completes a task in 5–10 model calls suddenly makes hundreds of calls for a single document, suggesting a retry loop or prompt injection attack causing the agent to behave unexpectedly

When an alert fires, Azure Monitor sends notifications to your security or operations team via email, SMS, or integration with incident management systems. Investigate alerts promptly to determine whether the activity represents a genuine issue or an expected change in usage patterns.

One week after enabling alerts, Contoso's security team receives a notification: the document analysis application sent 300% more requests than usual at 2 AM on a Sunday. Investigation reveals a loop in the application code that retries failed requests indefinitely. The issue isn't a security breach, but without gateway monitoring, the problem would consume all available model capacity before anyone noticed during Monday morning business hours.

By combining network access restrictions, managed identities, diagnostic logging, and proactive monitoring, you create a comprehensive security and observability layer around your AI model deployments. You're ensuring that only authorized callers can access models, all activity is audited, and anomalies are detected quickly.
