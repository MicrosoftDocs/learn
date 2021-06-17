In this unit, we look at Application Performance Monitoring (APM) concepts.

## Continuous Monitoring

Continuous monitoring of applications in any environments is typically implemented with Application Performance Management (APM) solutions that intelligently monitor, analyze, and manage cloud, on-premise, and hybrid applications and IT infrastructure. APM solutions enable you to monitor your users' experience and improve the stability of your application infrastructure. It helps identify the root cause of issues quickly to proactively prevent outages and keep users satisfied.

APM provides visibility into all your applications with the following features:

- Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
- Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux and so on.
- Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
- Custom metrics, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
- Ability to browse, query, and alert on application metrics and logs.

## Application insights

Application Insights, a feature of Azure Monitor, is an extensible Application Performance Management (APM) service for developers and DevOps professionals to monitor your live applications.
Developers can instrument their applications with Azure Application Insights to generate custom telemetry. This telemetry provides an extra layer of monitoring that can be beneficial in diagnosing errors and their root causes - often without having to dive into the source code.

## How does Application Insights work?

You install a small instrumentation package (SDK) in your application or enable Application Insights using the Application Insights Agent when supported. The instrumentation monitors your app and directs the telemetry data to an Azure Application Insights Resource using a unique GUID that we refer to as an Instrumentation Key.

You can instrument not only the web service application, but also any background components, and the JavaScript in the web pages themselves. The application and its components can run anywhere - it doesn't have to be hosted in Azure.

![Application Insights](../media/6-application-insights.png)

## Enable the Java in-process monitoring agent with Azure Spring Cloud

In this module, you'll use APM with Azure Spring Cloud as it offers in-depth performance monitoring without requiring code changes, recompiling, retesting, or redeployment.
In the upcoming exercise, we'll activate APM on creation of our Azure Spring Cloud instance with the `--enable-java-agent` CLI option:

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```

In the next exercise, we'll explore Application Performance Monitoring for your sample Spring application.
