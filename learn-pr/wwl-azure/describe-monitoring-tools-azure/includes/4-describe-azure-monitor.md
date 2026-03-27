Azure Monitor is a platform for collecting, analyzing, and acting on data from your Azure resources and applications. It works with Azure, on-premises, and multicloud environments.

The following diagram illustrates the breadth of Azure Monitor:

:::image type="content" source="../media/azure-monitor-overview.svg" alt-text="An illustration showing the flow of information that Azure Monitor uses to provide monitoring and data visualization.":::

Azure Monitor gathers logs and metrics from your applications, operating systems, and network layers, stores that data centrally, and makes it available through dashboards, queries, and alerts.

## Azure Log Analytics

Log Analytics is the tool in the Azure portal where you write and run queries against the data Azure Monitor collects. You can do simple filtering, like finding all errors in the last hour, or run advanced analytics to visualize trends over time.

## Azure Monitor Alerts

Alerts notify you when Azure Monitor detects that a condition you defined has been met. You create an alert rule that specifies the condition, and an action group that controls who gets notified and what happens next.

:::image type="content" source="../media/azure-monitor-alerts.png" alt-text="Screenshot of Azure Monitor Alerts showing total alerts, and then the alerts grouped by severity.":::

Alerts can be metric-based or log-based. For example, a metric alert can send you an email when a VM's CPU stays above 80%, while a log alert can watch for a specific error pattern across multiple resources. Action groups are reusable across Azure Monitor, Service Health, and Azure Advisor.

## Application Insights

Application Insights is an Azure Monitor feature that monitors the performance and usage of your web applications, whether they run in Azure, on-premises, or in another cloud.

You can set up Application Insights by adding an SDK to your application code or by enabling the Application Insights agent without code changes.

Application Insights can monitor:

 -  Request rates, response times, and failure rates
 -  Dependency calls and their performance
 -  Page load times, user counts, and session trends
 -  Server performance counters such as CPU, memory, and network usage

You can also set up availability tests that send synthetic requests to your application so you know it's responding, even during low-traffic periods.

