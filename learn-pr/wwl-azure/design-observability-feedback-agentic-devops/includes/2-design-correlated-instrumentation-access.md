Before asking an assistant why a release became slow, establish how a user request can be connected to the deployed change. Without that contract, an agent can correlate events from different environments or attribute an old failure to a new release.

## Refresh the evidence layers

Logs record events, metrics describe behavior across a population, and traces connect operations across services. For the search correction, a request trace can show time spent in a catalog dependency, while request metrics establish whether that behavior is widespread. Neither proves that the stock-filter requirement is satisfied; retain the relevant functional-check results too.

Keep these layers distinct:

| Evidence layer | GitHub or Azure DevOps | Azure workload |
| --- | --- | --- |
| Delivery | PR, integrated commit, workflow/pipeline run, accepted artifact, environment approval | Deployment marker identifying what actually became active |
| Runtime | Links to the release and its operational evidence | Requests, dependencies, logs, traces, platform metrics and functional checks |
| Agent activity | Available Copilot/session records and independently captured automation events | Instrumented agent/tool runs only where the application or host supplies them |

A pipeline run ID isn't a distributed trace ID. Connect delivery to runtime through an explicitly recorded release identity, not an assumption that all events happened close together.

## Use OpenTelemetry as the instrumentation contract

**OpenTelemetry (OTel)** supplies vendor-neutral APIs, SDKs, instrumentation, semantic conventions, and a protocol for exporting telemetry. It is not a dashboard, a storage service, or an AI diagnosis engine.

For an Azure-deployed application, use supported instrumentation to capture requests and dependencies, propagate trace context between participating services, and attach stable service/environment attributes. Choose an approved Azure Monitor integration path:

- A supported Microsoft/Azure Monitor OpenTelemetry distribution simplifies application instrumentation and Azure Monitor integration.
- Open-source SDKs and an OpenTelemetry Collector support a vendor-neutral pipeline using supported OTLP ingestion paths. A collector can receive, process, and export telemetry; it isn't mandatory for every application.

The choice affects exporter configuration, available capabilities, and query schemas. The distro-based Application Insights model and newer native OTLP ingestion paths don't necessarily expose identical tables or attribute mappings. Verify the actual path before asking Copilot to generate queries. Don't enable overlapping auto-instrumentation without checking for duplicate records.

### Relate OTel to GitHub and Azure DevOps

GitHub Actions and Azure Pipelines can configure instrumentation, deploy its configuration, and record the accepted artifact and release marker. They don't automatically turn all job logs or Copilot sessions into OTel spans.

If you need pipeline spans, deliberately instrument approved scripts or use a reviewed integration that exports them. Give each run and retry an identity, flush telemetry before an ephemeral worker exits, and measure export failures. Keep the platform's original logs and test results as evidence; exported spans complement them.

For workload correlation, an illustrative mapping might contain:

| Field | Purpose |
| --- | --- |
| Service and environment | Separate production search traffic from staging or another service |
| Release ID and artifact digest/version | Attribute runtime behavior to accepted output rather than a mutable tag |
| Source commit and workflow/pipeline run URL | Trace the release back to its contribution and producer |
| Trace/span identifiers | Follow one request through instrumented dependencies |
| Agent task and attempt identifiers, where available | Relate a diagnostic recommendation to its actual tool activity |

Standard OTel attributes describe service identity and runtime context. Delivery fields such as `release.id` are **illustrative custom attributes**, not guaranteed built-in fields. Agree their names and mapping with the application/platform owners. Record high-cardinality run IDs in suitable events or trace attributes rather than indiscriminately making them metric dimensions.

## Keep Azure services in their proper roles

**Azure Monitor** provides the broader collection, analysis, and alerting capabilities. **Application Insights** provides application-performance and distributed-tracing experiences. **Log Analytics** provides workspace-based log analysis with KQL. An Azure Monitor workspace used for Prometheus metrics is a different resource from a Log Analytics workspace.

The DevOps engineer's responsibility is to identify the data path, ownership, schema, and operational constraints, not to administer every monitoring feature. Check:

- Whether sampling or dropped exports make counts or latency distributions incomplete.
- Event time versus ingestion time, clock alignment, and acceptable freshness.
- Trace-context propagation through the dependencies you intend to investigate.
- Access scope, retention, and query-cost limits for the approved analysis.
- Whether telemetry payloads include customer data, credentials, or unnecessary prompt content.

Ask Copilot to review the proposed correlation contract for missing identifiers, duplicate instrumentation, and ambiguous field mappings. Supply the actual exporter configuration and sanitized schema; don't ask it to infer your infrastructure from an application name.

The result is a documented route from accepted change to attributable operational evidence, including where that route is incomplete.

Learn more about [OpenTelemetry with Azure Monitor](/azure/azure-monitor/containers/opentelemetry-options) and [Application Insights OpenTelemetry enablement](/azure/azure-monitor/app/opentelemetry-enable).
