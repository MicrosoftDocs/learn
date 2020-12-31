This module introduced the concept of using application performance monitoring (APM) platforms to continuously monitor cloud-based solutions for availability and performance. Here are some of the key takeaways:

- IT systems must be monitored in order to be managed effectively. Without monitoring, administrators don't know whether a solution is performing as intended, or potentially whether it is running at all.

- Monitoring relies on instrumentation, which comes in three forms: logs, metrics, and traces.

- Logs record events that take place within a system and may be used to diagnose the health of a system, analyze failures and problem conditions, and warn of impending problems.

- Metrics are quantitative values used to determine the health or state of a system. Common metrics include request-queue volumes, request wait times, error rates, and session length.

- Traces collect data about the low-level service calls between highly distributed services and functions, especially in containerized solutions.

- APM platforms fall into two broad categories: agent-based and agentless.

- Agent-based APM platforms use software components known as *agents* to actively monitor the health of a system.

- Agentless APM platforms rely on logs and other passive data sources to determine the health of a system.

- Microservice-based solutions place special demands on APM platforms. Some APM tools such as Prometheus are engineered with these demands in mind.

- Many cloud service providers offer monitoring services that are integrated into their cloud platforms. Examples include Amazon CloudWatch and Azure Monitor.

- APM platforms typically offer interactive dashboards that are updated in real time (or near real time) to reflect the state of a system. Dashboards are driven by *telemetry* -- stream of data that indicate what is happening in a system and when.

- Dashboards frequently surface performance metrics such as the number of requests processed per minute, response times, CPU utilization, and error rate.

- More complex performance indicators include request saturation point and application performance index. The latter was defined by a coalition of APM vendors seeking to provide a standard performance metric that could be used across systems and across platforms.

- Correlations provide deeper insights into performance and availability by comparing two or more sets of metrics. Two common correlation methodologies are Utilization-Saturation-Errors (USE) and Rate-Errors-Duration (RED).

- Remediation planning defines how problems uncovered by monitoring are mitigated and resolved. Ticketing is a common element in many remediation plans.

- Remediation can be responsive, in which case it is triggered by events surfaced by an APM.

- Remediation can also be proactive, in which case the goal is to continually make improvements to a system even in the absence of errors of other critical events. A common term for this concept is *everyday remediation*.
