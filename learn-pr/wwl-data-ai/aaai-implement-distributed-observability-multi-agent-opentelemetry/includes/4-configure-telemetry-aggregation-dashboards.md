Azure Monitor workbooks aggregate OpenTelemetry telemetry from all agents into interactive dashboards, giving your operations team a unified view of multi-agent system health, cost trends, and error patterns.

Raw telemetry data from 14 agents requires aggregation to reveal system-level patterns. Individual trace viewing helps debug specific failures, but understanding overall system health demands aggregating metrics across dimensions: which agent, which model, which operation type, which customer tier, and which error classification. These aggregations power operational dashboards that answer questions about system performance, cost trends, and quality patterns.

| Aggregation Dimension | Example Query | Operational Value |
|----------------------|---------------|-------------------|
| Agent ID | P95 latency by agent | Identify bottleneck agents |
| Model ID | Token usage by model | Optimize model selection for cost |
| Operation type | Error rate by operation | Prioritize reliability improvements |
| Customer tier | Escalation rate by tier | Understand service quality gaps |
| Error type | Count by error classification | Target root cause investigations |

## Track key metrics for multi-agent systems

**End-to-end latency** measures the time from customer request entry to final response delivery. This metric spans all agents involved in the interaction. Track percentiles (P50, P95, P99) rather than averages—P95 latency reveals the experience for the slowest 5% of requests, often indicating problems invisible in average values.

**Per-agent latency** identifies bottlenecks within the multi-agent pipeline. If end-to-end P95 latency is 8 seconds and the product search agent's P95 latency is 6 seconds, you know where to focus optimization. Decompose per-agent latency into large language model (LLM) call latency, tool invocation latency, and processing latency to pinpoint the specific operation causing delays.

**LLM token usage** directly drives operational costs. Track input tokens and output tokens separately by agent and model. Daily and weekly trends reveal cost trajectory and identify agents that consume unexpectedly high token counts—potential indicators of prompt inefficiency or runaway context windows.

**Escalation rate** measures how often the automated multi-agent system hands off to human support. Low escalation rates indicate strong agent capability. Sudden increases signal model degradation or new customer needs the agents can't handle. Track escalation rate by customer tier and interaction type to identify specific scenarios requiring agent capability improvements.

**Error rate by type** categorizes failures into actionable groups: 4xx errors indicate bad input or policy violations, 5xx errors indicate service failures, model errors include content policy blocks and context length exceeded errors, and tool errors capture external API failures. Each error type requires different remediation approaches.

## Design Azure Monitor workbooks

Azure Monitor workbooks provide interactive dashboards combining metrics, logs, and trace data. Design a workbook hierarchy with four specialized tabs serving different operational needs.

The **Overview tab** displays end-to-end system health: current request rate, P95 end-to-end latency over the last 24 hours, overall error rate, and escalation rate. This tab provides a single-glance health check for the entire multi-agent system.

The **Agent Performance tab** breaks down metrics by agent: a table showing each agent's P95 latency, error rate, and request volume, with sparklines showing trends. Selecting an agent filters the page to show that agent's LLM call distribution, tool invocation success rates, and most common error types.

The **Cost Analytics tab** tracks token usage and estimated costs: daily token consumption by agent, cost per interaction by customer tier, and model selection distribution. This tab reveals optimization opportunities—switching specific agents from GPT-4o to GPT-4o-mini where quality differences are minimal but cost differences are substantial.

The **Incident Response tab** surfaces active problems: traces with errors in the last hour, anomaly detection alerts, and a drill-down interface for investigating specific trace IDs. This tab serves as the primary interface for on-call engineers responding to production incidents.

```kusto
// Query: Calculate P95 end-to-end latency by agent over last 24 hours
dependencies
| where timestamp > ago(24h)
| where customDimensions.agent_id != ""
| extend agent_id = tostring(customDimensions.agent_id)
| extend duration_ms = tolong(duration * 1000)
| summarize 
    p50_latency_ms = percentile(duration_ms, 50),
    p95_latency_ms = percentile(duration_ms, 95),
    p99_latency_ms = percentile(duration_ms, 99),
    request_count = count()
    by agent_id
| order by p95_latency_ms desc
```

This Kusto Query Language (KQL) query aggregates latency percentiles from the `dependencies` table (where OpenTelemetry spans export as dependency telemetry), grouping by the `agent_id` custom dimension. The workbook visualizes this data as a bar chart showing P95 latency with request count annotations.

## Configure operational alerts

Alert rules define thresholds that trigger on-call notifications when system health degrades. Effective alerting balances sensitivity (catching real problems) with specificity (avoiding false alarms that erode trust).

**P95 latency degradation alert**: Trigger when P95 end-to-end latency increases more than 50% from the 1-hour rolling baseline, sustained for 10 minutes. This detects gradual performance degradation while filtering transient spikes. Configure separate thresholds for different customer tiers—premium customers get a 30% threshold with 5-minute evaluation.

**Per-agent error rate alert**: Trigger when any single agent's error rate exceeds 5% in a 5-minute window. This catches agent-specific failures. Suppressions prevent alert flooding: if the orchestrator agent's error rate is high because a downstream agent is failing, suppress the orchestrator alert—the downstream failure is the root cause.

**Escalation rate spike alert**: Trigger when escalation rate triples from the daily average over a 1-hour window. Sudden escalation increases typically indicate model quality regression or a new customer need the agents can't handle. This alert enables rapid response to quality degradation.

**Token usage anomaly alert**: Trigger when total token usage doubles from the daily average over a 4-hour window. This detects runaway agents consuming excessive tokens due to prompt injection, context window issues, or infinite tool call loops.

```kusto
// Alert query: Per-agent error rate exceeds 5% in 5-minute window
dependencies
| where timestamp > ago(5m)
| where customDimensions.agent_id != ""
| extend agent_id = tostring(customDimensions.agent_id)
| extend is_error = tobool(success == false)
| summarize 
    total_requests = count(),
    error_requests = countif(is_error)
    by agent_id
| extend error_rate = todouble(error_requests) / todouble(total_requests)
| where error_rate > 0.05
| project agent_id, error_rate, total_requests, error_requests
```

Configure each alert with action groups that route notifications to appropriate channels: critical alerts (error rate, escalation spike) send SMS and phone call notifications to on-call engineers, warning alerts (latency degradation) post to Microsoft Teams channels, and informational alerts (token usage trends) create Azure DevOps work items for workday follow-up.

## Separate real-time and analytical views

Two distinct workbook types serve different needs. The **real-time operational view** refreshes every 2 minutes, displays current active sessions and error rates, uses short time windows (last 30 minutes to 4 hours), and focuses on immediate action: "What's failing right now?"

The **analytical view** refreshes daily via scheduled batch jobs, displays trends over weeks and months, uses long time windows (last 30 days to 1 year), and focuses on strategic improvement: "What patterns reveal optimization opportunities?"

The real-time view uses simple aggregations for fast query performance. The analytical view performs complex joins and calculations—correlating token usage with customer satisfaction scores, analyzing error patterns by time of day and day of week, and calculating cost per successfully resolved interaction. These expensive queries run as scheduled jobs during off-peak hours, storing results in pre-aggregated tables for fast dashboard loading.

## Key takeaways

- **Key metrics** include end-to-end latency percentiles, per-agent latency decomposition, LLM token usage, escalation rates, and error rates by type.
- **Azure Monitor workbooks** provide specialized tabs—Overview, Agent Performance, Cost Analytics, and Incident Response—serving different operational needs.
- **Operational alerts** use dynamic thresholds for latency degradation, per-agent error rates, escalation spikes, and token usage anomalies with appropriate routing per severity.
- **Dual views** separate real-time operational dashboards (2-minute refresh, short windows) from analytical views (daily refresh, long-term trends) to serve both immediate and strategic needs.
