troubleshooting an application's performance requires monitoring and reliable investigation. Issues in performance can arise from database queries, connectivity between services, under-provision resources, or memory leaks in code.

 

Continuously monitoring services and checking the health state of current workloads is key in maintaining the overall performance of the workload. An overall monitoring strategy consider these factors:

- Scalability

- Resiliency of the infrastructure, application, and dependent services

- Application and infrastructure performance

 

## What to consider when defining a monitoring strategy 

 

Here is a list to consider ensuring you are monitoring your workloads with performance and scalability in mind:

- Enable and capture telemetry throughout your application to build and visualize end-to-end transaction flows for the application.

- Explore metrics from Azure services such as CPU and memory utilization, bandwidth information, current storage utilization, and more.

- Use resource and platform logs to get information about what events occur and under which conditions.

- For scalability, examine the metrics to determine how to provision resources dynamically and scale with demand.

- In the collected logs and metrics identify signs that make a system or its components suddenly become unavailable.

- Use log aggregation technology to gather information across all application components.

- Store logs and key metrics of critical components for statistical evaluation and predicting trends.

- Identify antipatterns in the code.

 

Follow these questions to assess the workload at a deeper level.

| **Assessment**| **Description** |
| - | - |
| [**Are application logs and events correlated across all application components?**](/azure/architecture/framework/scalability/monitor-application)| Correlate logs and events for subsequent interpretation. This will give you visibility into end-to-end transaction flows. |
| [**Are you collecting Azure Activity Logs within the log aggregation tool?**](/azure/architecture/framework/scalability/monitor-infrastructure)| Collect platform metrics and logs to get visibility into the health and performance of services that are part of the architecture. |
| [**Are application and resource level logs aggregated in a single data sink, or is it possible to cross-query events at both levels?**](/azure/architecture/framework/scalability/monitor-analyze)| Implement a unified solution to aggregate and query application and resource level logs, such as Azure Log Analytics. |
