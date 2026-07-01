Monitoring is the process of collecting data about your system's activities so you can determine whether those activities succeed, fail, or degrade over time. In Microsoft Fabric, monitoring gives you visibility into data pipelines, dataflows, Spark notebooks, semantic model refreshes, and other scheduled work. Without monitoring, failures go undetected, reports show stale data, and troubleshooting becomes guesswork.

## Why monitoring matters

A typical Fabric workspace contains activities that depend on each other. A Dataflow Gen2 loads raw data into a lakehouse, a Spark notebook transforms that data, and a semantic model refresh makes it available for Power BI reports. If any step in this chain fails or runs longer than expected, every downstream step is affected.

Consider what happens when you don't monitor:

- A dataflow fails because the source schema changed, but no one notices until an analyst reports missing data the next day.
- A Spark notebook runs three times longer than usual due to a data volume spike, consuming capacity and delaying other jobs.
- A semantic model refresh quietly retries multiple times before succeeding, masking a transient connectivity issue that eventually becomes a full failure.

Monitoring exposes these problems early. When you can see that a job failed, how long it ran, and what error it produced, you can fix the root cause before it affects users.

## Types of Fabric activities to monitor

Microsoft Fabric runs many types of scheduled and on-demand activities. Each type has specific metrics and failure modes worth tracking.

### Data pipelines

A data pipeline groups multiple activities — like copying data, running a dataflow, and refreshing a semantic model — into a single orchestrated workflow. Pipelines can contain dozens of activities with dependencies between them. When you monitor a pipeline, you track the overall pipeline status and the status of each individual activity within it. A pipeline might show as succeeded even if an optional activity failed, so review individual activity statuses to get the full picture.

### Dataflow Gen2

Dataflow Gen2 provides a low-code interface for ingesting and transforming data. Dataflows can run on a schedule, manually, or as a step within a pipeline. Key metrics to monitor include start time, end time, duration, and status. If a dataflow fails, you can drill into the activity details to see which table load step produced the error — for example, a column type mismatch or a source timeout.

### Semantic model refreshes

Semantic models power Power BI reports. When the underlying data changes, the model needs to refresh. Refreshes can be triggered from a pipeline, scheduled directly, or started manually. Watch for refresh retries: a model that retries three times before succeeding might indicate a transient issue. If the retry count increases over time, investigate the underlying data source connection before the refresh starts failing entirely.

### Spark jobs and notebooks

Notebooks provide an interactive interface for running Apache Spark code. When a notebook runs — either interactively or as a scheduled job — Fabric tracks the Spark application, its tasks, and resource usage. Monitor job progress, execution duration, and Spark logs. Long-running Spark jobs might indicate a data skew problem or an inefficient transformation.

### Eventstreams

Eventstreams ingest real-time data from sources like IoT devices, Azure Event Hubs, and custom applications. Unlike batch activities that run and complete, eventstreams are designed to run continuously. Monitor ingestion throughput, latency, and error rates to ensure real-time data reaches its destinations without delay.

## Establish a monitoring baseline

Effective monitoring requires understanding what "normal" looks like. If you don't know that a dataflow typically finishes in four minutes, you can't tell when a 20-minute run indicates a problem. Follow these practices to build a reliable monitoring baseline:

- **Track metrics consistently** — Record duration, status, and error rates for each activity over time. Use historical run data to identify trends.
- **Define normal behavior** — After collecting a few weeks of data, establish expected ranges for duration and resource consumption. A dataflow that usually takes 3–5 minutes but suddenly takes 15 is worth investigating.
- **Set up notifications** — Don't rely on manually checking the monitoring hub. Configure failure notifications so the right people know about problems immediately.
- **Investigate anomalies promptly** — When an activity deviates from its baseline, diagnose the cause. Even if the activity eventually succeeds, repeated anomalies often signal an emerging issue.
- **Review and adjust** — As your data volumes and pipelines evolve, your baselines change too. Revisit your monitoring thresholds periodically to keep them relevant.
