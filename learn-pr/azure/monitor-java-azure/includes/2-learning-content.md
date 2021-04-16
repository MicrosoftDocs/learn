In this unit, we look at Monitoring Java Application concepts.

# Why Monitoring?

APM provides Visibility into all your applications with the following features:

- Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
- Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux and so on.
- Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
- Custom metrics, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
- Ability to browse, query, and alert on application metrics and logs.

## enable the Java in-process monitoring agent with Azure Spring Cloud

We'll illustrate APM by using a distributed version of the Spring Pet clinic reference application.
In the following example, we'll activate APM on creation of our Azure Spring instance with the "--enable-java-agent" CLI option:

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```

## Next steps

In the next exercise, we'll configure a Sample Spring application and set it up for monitoring.
