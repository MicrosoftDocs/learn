You need visibility into infrastructure performance before problems escalate into outages. Consider a scenario where your virtual machine's CPU usage climbs steadily over several days. Without metric tracking, you discover the capacity issue only after the VM becomes unresponsive and training jobs fail. Azure Monitor metrics solve this problem by collecting performance data automatically from every Azure resource you deploy.

## How Azure Monitor collects metrics

Azure Monitor captures three types of metrics that provide different layers of visibility into your infrastructure. Platform metrics are collected automatically the moment you create a resource—no configuration required. When you deploy a virtual machine, Azure Monitor immediately begins tracking CPU percentage, network throughput, and disk operations per second. These metrics flow into Azure Monitor's time-series database every 60 seconds, giving you near real-time visibility into resource behavior.

Platform metrics cover the fundamentals, but they don't reveal everything happening inside your virtual machine's operating system. For guest performance data, install Azure Monitor Agent (AMA) and associate the VM with a data collection rule (DCR). The DCR specifies the supported performance counters, sampling intervals, and destinations. For example, collect available memory to identify memory pressure during training. Collect process-level counters explicitly when you need to investigate individual processes. Installing the agent alone doesn't select all the counters your workload requires.

For the logs-based collection path used in this module, select an **Azure Monitor Logs** destination in the DCR. The selected performance counters are stored in the workspace's `Perf` table and queried with Kusto Query Language (KQL). Sending counters to Log Analytics doesn't automatically make them available in Metrics Explorer. The performance-counter DCR also supports an **Azure Monitor Metrics (preview)** destination for Metrics Explorer, using the guest metric namespace rather than the platform metric namespace. Check the destination and collection configuration before building a visualization. See [Collect performance counters from virtual machines](/azure/azure-monitor/vm/data-collection-performance).

Custom metrics extend monitoring beyond infrastructure to capture business-specific indicators. Using the Application Insights SDK or Azure Monitor REST API, you send metrics that matter to your organization—such as the number of AI model predictions completed per minute, queue processing latency, or user session duration. This becomes especially important when your operations team needs to correlate infrastructure performance with business outcomes and demonstrate how resource optimization improves application responsiveness.

:::image type="content" source="../media/custom-metrics-extend-monitoring-infrastructure.png" alt-text="Diagram showing how custom metrics extend monitoring beyond infrastructure to capture business-specific indicators.":::

## Visualizing metrics for operations teams

Collecting metrics delivers value only when your team can interpret trends and act on anomalies. Azure Monitor provides two primary visualization tools that serve different operational needs. Metrics Explorer offers ad-hoc analysis when you investigate a specific performance question or troubleshoot an active incident. You select a resource, choose one or more metrics, apply time range filters, and view trend charts that reveal patterns like CPU spikes during batch processing or gradual memory leaks over multiple days.

With Metrics Explorer, you answer immediate questions: Did CPU usage exceed 80% during last night's training run? How does network throughput compare between this week and last week? However, ad-hoc analysis doesn't provide continuous monitoring. Your operations team needs persistent visibility into critical metrics without repeatedly building the same charts. Azure dashboards solve this by pinning Metrics Explorer visualizations to a shared view that displays real-time data from multiple resources simultaneously.

:::image type="content" source="../media/temporary-analysis-continuous-monitor.png" alt-text="Diagram Azure dashboards showing how to pin Metrics Explorer visualizations to a shared view.":::

A well-designed dashboard shows your team the health of compute, storage, and networking resources at a glance. You create separate panels for CPU utilization across all virtual machines, storage account transaction rates, and network gateway bandwidth consumption. This consolidated view enables your operations team to detect cross-resource patterns—such as high CPU correlating with increased storage I/O—and prioritize investigation efforts based on severity and business impact. For AI workloads that span multiple services, this holistic visibility reduces the time spent switching between resource pages and accelerates root cause analysis during incidents.

## Business impact of continuous metric monitoring

Proactive metric tracking transforms infrastructure management from reactive firefighting to preventive maintenance. When you visualize CPU trends over weeks instead of responding to individual spikes, you identify capacity planning opportunities before resources become bottlenecks. Your finance team benefits from this visibility through more accurate cost forecasting, because metric data reveals when to scale resources up or down based on actual usage patterns rather than guesswork.

For teams managing AI infrastructure, continuous monitoring delivers measurable operational improvements. Organizations that implement metric dashboards report 40-60% reductions in mean time to detection (MTTD) for performance issues, because anomalies become visible immediately rather than surfacing only after user complaints. This early detection prevents cascading failures—such as a memory leak in one VM causing downstream service timeouts—and reduces the business impact of infrastructure incidents by enabling faster, more targeted remediation efforts.

## More resources

- [Azure Monitor Metrics overview](/azure/azure-monitor/essentials/data-platform-metrics) - Comprehensive guide to metric types, collection methods, and retention policies
- [Metrics Explorer documentation](/azure/azure-monitor/essentials/metrics-getting-started) - Step-by-step instructions for creating charts and analyzing metric data
- [Azure dashboards best practices](/azure/azure-portal/azure-portal-dashboards) - Design patterns for effective operational dashboards
