Azure Monitor helps you maximize the availability and performance of your applications and services.

## Overview
The following diagram is a high-level view of Azure Monitor.

- At the center of the diagram, you'll find the data stores for metrics and logs and changes. These data stores are the fundamental types of data used by Azure Monitor.
- On the left are the sources of monitoring data that populate the data stores.
- On the right are the different functions that Azure Monitor performs with this collected data. This diagram includes such actions as analysis, alerting, and integration such as streaming to external systems.

:::image type="content" source="https://learn.microsoft.com/azure/azure-monitor/media/overview/azure-monitor-overview-2022-08-25-change-analysis-opt.svg" alt-text="Diagram that shows an overview of Azure Monitor." border="false" lightbox="https://learn.microsoft.com/azure/azure-monitor/media/overview/azure-monitor-overview-2022-08-25-change-analysis-opt.svg":::

## What data does Azure Monitor collect?

Metrics, logs, and distributed traces are commonly referred to as the three pillars of observability.

| Pillar | Description |
|:---|:---|
| Metrics | Metrics are numerical values that describe some aspect of a system at a particular point in time. They're collected at regular intervals and are identified with a timestamp, a name, a value, and one or more defining labels. |
| Logs    | Logs are events that occurred within the system. They can contain different kinds of data and may be structured or free-form text with a timestamp. |
| Distributed traces | Traces are series of related events that follow a user request through a distributed system. |
| Changes | Changes are a series of events that occur in your Azure application and resources. Change Analysis tracks changes and is a subscription-level observability tool that's built on the power of Azure Resource Graph. |

## Insights and curated visualizations

Some Azure resource providers have a "curated visualization", which provide a customized monitoring experience for that particular service or set of services.

Larger, scalable, curated visualizations are known as "insights" and marked with that name in the documentation and the Azure portal. Examples of insights include Application Insights, Container Insights, and VM Insights.