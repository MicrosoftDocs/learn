Running Data API Builder in production requires monitoring to understand performance, diagnose issues, and optimize resource usage. [Azure Monitor](/azure/azure-monitor/overview?azure-portal=true) provides the comprehensive observability platform that integrates with DAB through Application Insights and Log Analytics.

Effective monitoring goes beyond simple uptime checks. You need visibility into request latencies, error rates, database query performance, and resource consumption patterns. This type of data helps you identify bottlenecks before they affect users and provides data for capacity planning.

## Configure Application Insights integration

[Application Insights](/azure/azure-monitor/app/app-insights-overview?azure-portal=true) captures detailed information from your Data API Builder instance, including request traces, dependency calls to your database, and exception details.

Enable Application Insights by setting the connection string as an environment variable:

```bash
APPLICATIONINSIGHTS_CONNECTION_STRING="InstrumentationKey=your-key;IngestionEndpoint=https://region.in.applicationinsights.azure.com/"
```

For Azure Container Apps or App Service deployments, configure this through application settings. DAB automatically detects the connection string and begins sending telemetry.

Once enabled, Application Insights tracks:

- **Request telemetry** - Every REST and GraphQL request with timing, status code, and response size
- **Dependency telemetry** - Database queries with execution time and success/failure status
- **Exception telemetry** - Unhandled errors with stack traces
- **Custom metrics** - Cache hit rates, connection pool usage

> [!TIP]
> Set a sampling rate for high-volume production deployments to control costs while maintaining visibility. Application Insights adaptive sampling automatically adjusts based on traffic volume.

## Create custom dashboards for API monitoring

Application Insights data powers custom Azure dashboards that display key performance indicators for your API.

Create a dashboard with these essential visualizations:

**Request metrics:**

```kusto
requests
| where timestamp > ago(24h)
| summarize 
    RequestCount = count(),
    AvgDuration = avg(duration),
    P95Duration = percentile(duration, 95),
    FailureRate = countif(success == false) * 100.0 / count()
| project RequestCount, AvgDuration, P95Duration, FailureRate
```

This query summarizes 24-hour request volume, average response time, 95th percentile latency, and failure rate. These metrics quickly indicate API health.

**Top slow endpoints:**

```kusto
requests
| where timestamp > ago(1h)
| summarize 
    AvgDuration = avg(duration),
    RequestCount = count()
    by name
| top 10 by AvgDuration desc
| project name, AvgDuration, RequestCount
```

Identifying slow endpoints helps prioritize optimization efforts. Slow queries might indicate missing indexes, inefficient entity configurations, or database contention.

## Set up Log Analytics for detailed diagnostics

[Log Analytics](/azure/azure-monitor/logs/log-analytics-overview?azure-portal=true) provides a central repository for logs from all Azure resources. Configure your DAB deployment to send logs to a Log Analytics workspace.

For Container Apps, enable logging through the environment configuration:

```bash
az containerapp env update \
  --name myContainerAppEnv \
  --resource-group myResourceGroup \
  --logs-workspace-id <workspace-id>
```

Query DAB container logs to investigate issues:

```kusto
ContainerAppConsoleLogs_CL
| where ContainerName_s == "dab-api"
| where Log_s contains "error" or Log_s contains "exception"
| project TimeGenerated, Log_s
| order by TimeGenerated desc
```

Combine container logs with Application Insights telemetry for complete request traces. Correlate errors with specific requests using operation IDs that flow through both data sources.

## Configure alert rules for proactive monitoring

Alert rules notify your team when API behavior deviates from normal patterns. Set up alerts for critical conditions that require immediate attention.

**High error rate alert:**

```bash
az monitor metrics alert create \
  --name "DAB-HighErrorRate" \
  --resource-group myResourceGroup \
  --scopes "/subscriptions/.../components/myAppInsights" \
  --condition "avg requests/failed > 5" \
  --window-size 5m \
  --evaluation-frequency 1m \
  --action-group myActionGroup
```

This alert triggers when the failure rate exceeds 5% over a 5-minute window. Action groups define notification channels like email, SMS, or webhooks to your incident management system.

**Response time degradation alert:**

```kusto
requests
| where timestamp > ago(5m)
| summarize P95 = percentile(duration, 95) by bin(timestamp, 1m)
| where P95 > 2000
```

Create a log-based alert that fires when 95th percentile latency exceeds 2 seconds. This catches performance degradation even when requests technically succeed.

> [!IMPORTANT]
> Configure alerts thoughtfully to avoid alert fatigue. Start with high-severity conditions and refine thresholds based on normal operating patterns.

## Monitor database query performance

Application Insights dependency tracking captures database queries issued by DAB. Use this telemetry to identify slow or frequently executed queries.

```kusto
dependencies
| where timestamp > ago(1h)
| where type == "SQL"
| summarize 
    CallCount = count(),
    AvgDuration = avg(duration),
    FailureCount = countif(success == false)
    by data
| top 20 by AvgDuration desc
```

The `data` field contains the SQL query text. Review slow queries to determine if indexes would help, if entity configurations need optimization, or if certain operations should use stored procedures instead.

Compare database metrics across time periods to identify trends:

```kusto
dependencies
| where type == "SQL"
| summarize 
    AvgDuration = avg(duration)
    by bin(timestamp, 1h)
| render timechart
```

Gradual increases in query duration might indicate growing data volumes, index fragmentation, or changing query patterns that need attention.

## Implement distributed tracing

When DAB serves requests from multiple client applications, distributed tracing connects the complete request flow from client through API to database.

Enable correlation by including trace context headers in client requests:

```http
GET /api/Product HTTP/1.1
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-01
```

Application Insights correlates these traces, allowing you to see end-to-end latency breakdown in the Transaction Search view. This visibility is valuable for diagnosing intermittent issues that span multiple services.

For GraphQL queries that resolve multiple entities, traces show the timing of each database call, helping identify which relationships or entities contribute most to response time.

## Review resource utilization metrics

Beyond application telemetry, monitor the underlying compute resources running DAB. Container Apps and App Service provide resource metrics through Azure Monitor.

Key metrics to track:

- **CPU percentage** - Sustained high CPU indicates compute-bound operations or need for scaling
- **Memory percentage** - Memory pressure can cause container restarts or degraded performance
- **Network bytes in/out** - Unusual network patterns might indicate large result sets or denial-of-service attempts
- **Replica count** - For scaled deployments, verify autoscaling responds appropriately to load

Set up autoscaling rules based on these metrics to maintain responsive APIs during traffic spikes while controlling costs during quiet periods.
