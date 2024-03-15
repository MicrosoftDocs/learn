As mentioned earlier in this module, observability is one of the fundamental aspects of operational excellence. Its purpose is to provide insights into the operational status of systems and applications. It involves continuous monitoring and evaluating of that operational status. One of the primary targets of observability is performance. Performance monitoring-based observability could yield significant benefits to any organization that depends on technology for its revenue, including the one described in the sample scenario. In this unit, learn about how these benefits can be realized.

## What is the role of performance monitoring in observability?

In the context of observability, performance monitoring relies on collecting real-time telemetry, such as metrics, logs, and traces to evaluate the overall health of your workloads. Metrics contain quantitative data, logs offer detailed information about events, and traces enable data correlation across distributed systems. To perform the evaluation, you also need to develop a health model, representing the operational status of the workloads under normal working conditions. Performance monitoring uses the health model to detect anomalies, performance bottlenecks, and performance-related issues as soon as they occur.

Data collected through performance monitoring is also essential in incident response. It provides a detailed status of the affected workloads prior to, during, and after the incident, which simplifies troubleshooting and helps minimize *mean time to resolution (MTTR)*. Other metrics that help assess effectiveness of performance monitoring include:

- **Time to detect (TTD)**: measures the time it takes for the diagnostic data about an incident to reach development and operations teams.
- **Time to mitigate (TTM)**: measures the time it takes development and operations teams to act on the monitoring information and mitigate the impact of the incident.
- **Time to remediate (TTR)**: measures the time it takes development and operations teams to resolve the root cause of the incident.

In addition, continuous monitoring drives continuous improvement by providing data for post-incident reviews and root cause analysis. It also helps transition from the reactive to proactive remediation approach.

Lastly, monitoring is commonly used for shift-right testing. By combining it with a continuous delivery workflow, you'll be able to detect any anomalies introduced by new software releases and facilitate their swift mitigation. This includes the ability to discover issues that are overlooked in preproduction environments.
