In this unit, we look at Monitoring Java Application concepts.

# Why Monitoring?

In a production environment, it's important to track the way in which users use your system, trace resource utilization, and generally monitor the health and performance of your system. You can use this information as a diagnostic aid to detect and correct issues, and also to help spot potential problems and prevent them from occurring.

## Monitoring forms

Monitoring generally takes on the three forms:

- **Logs** - Permanent, immutable records of events stored in a consistent, tabular format, if not in a full database. An *event* may be indicative of one of many conditions, including:

  - A change in the status of a monitored component (for example, from "busy" to "available")
  - The completion of a task or sequence of instructions
  - A milestone in the progression of data through a network, or the availability of units in a network
  - An error, which in this context is a behavior that the system or application has not been programmed to handle or mitigate

- **Metrics** - Values that represent the relative health, stability, and availability of a service or application or the infrastructure that hosts it

- **Traces** - Records of the paths of execution for programs and services, especially in a highly distributed system, indicating the sequence of instructions that may have triggered, either directly or indirectly, an event

## Azure Monitoring Platforms

Azure provides **Azure Monitor**, which includes a set of services that developers and administrators can use to collect, analyze, and act upon telemetry regarding the performance of applications and the infrastructure that hosts them.
Various services such as Azure Log Analytics and Microsoft Power BI can be connected to the data sources where logs and metrics are stored to generate actionable insights and create visual dashboards.

## Next steps

In the next exercise, we'll configure a Sample Spring application and set it up for monitoring.
