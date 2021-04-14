In this unit, we look at Monitoring Java Application concepts.

# Why Monitoring?

## Agent Monitoring in Azure Spring Cloud

Visibility into all your applications with distributed tracing, including paths of operation requests from origins to destinations and insights into applications that are operating correctly and those with bottlenecks.
Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux, etc.
Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
Custom metrics conveniently auto-collected through Micrometer, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
Ability to browse, query, and alert on application metrics and logs.
While both Azure Spring Cloud and Application Insights Java agent are generally available, their integration for out of the box monitoring is in preview.

You can enable the Java in-process monitoring agent when you create or update Azure Spring Cloud:

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```

## Next steps

In the next exercise, we'll use an existing application set it up for monitoring
