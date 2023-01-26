In this unit, we look at application performance monitoring (APM) concepts.

## Continuous Monitoring

Application performance management (APM) solutions enable you to monitor your users' experience and improve the stability of your application infrastructure. It helps identify the root cause of issues quickly to proactively prevent outages and keep users satisfied.

APM in Azure Spring Apps offers in-depth performance monitoring for your Spring applications without requiring ANY code changes, recompiling, retesting, or redeployment. You don't have to do ANYTHING – just deploy your applications and the monitoring data starts flowing. The benefits you get with application monitoring are:

- Visibility into all your applications with distributed tracing, including paths of operation requests from origins to destinations and insights into applications that are operating correctly and those applications with bottlenecks.
- Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
- Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux, and so on.
- Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
- Custom metrics conveniently autocollected through Micrometer, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
- Ability to browse, query, and alert on application metrics and logs.

## Application insights

Application Insights, a feature of Azure Monitor, is an extensible application performance management (APM) service to monitor your live applications.
You can instrument your applications with Azure Application Insights to generate custom telemetry. This telemetry provides an extra layer of monitoring that can be beneficial in diagnosing errors and their root causes - often without having to dive into the source code.

## Enable the Java in-process monitoring agent with Azure Spring Apps

In this module, you'll use APM with Azure Spring Apps as it offers in-depth performance monitoring without requiring code changes, recompiling, retesting, or redeployment.
It is activated by default on creation of our Azure Spring Apps instance.