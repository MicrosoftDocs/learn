In this unit, we look at Application performance monitoring concepts.

# Enable the Java in-process monitoring agent with Azure Spring Cloud

In this module, you'll use APM with Azure Spring Cloud as it offers in-depth performance monitoring without requiring code changes, recompiling, retesting, or redeployment.
APM provides Visibility into all your applications with the following features:

- Logs, exceptions, and metrics in the context of call paths offer meaningful insights and actionable information to speed root cause analysis.
- Insights into application dependencies – SQL Database, MySQL, PostgreSQL, MariaDB, JDBC, MongoDB, Cassandra, Redis, JMS, Kafka, Netty / WebFlux and so on.
- Performance data for every call into operations exposed by applications, including data-like request counts, response times, CPU usage, and memory.
- Custom metrics, allowing you to publish custom performance indicators or business-specific metrics and visualize deeper application and business insights.
- Ability to browse, query, and alert on application metrics and logs.

We'll illustrate APM by using a distributed reference application.
In the upcoming exercise, we'll activate APM on creation of our Azure Spring Cloud instance with the "--enable-java-agent" CLI option:

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```
