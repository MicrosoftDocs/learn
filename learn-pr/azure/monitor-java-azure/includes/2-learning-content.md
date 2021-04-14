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

With this feature you can:

* Search tracing data with different filters.
* View dependency map of microservices.
* Check request performance.
* Monitor real-time live metrics.
* Check request failures.
* Check application metrics.

Application Insights provide many observable perspectives, including:

* Application map
* Performance
* Failures
* Metrics
* Live Metrics
* Availability

## enable the Java in-process monitoring agent with Azure Spring Cloud

```bash
az spring-cloud create --name ${SPRING_CLOUD_SERVICE} \
--sku standard --enable-java-agent \
--resource-group ${RESOURCE_GROUP} \
--location ${REGION}
```

## Enable Java In-Process Agent for Application Insights Manually

Enable Java In-Process Agent preview feature using the following procedure.

1. Go to service overview page of your service instance.
2. Click **Application Insights** entry under monitoring blade.
3. Click **Enable Application Insights** button to enable **Application Insights** integration.
4. Select an existing instance of Application Insights or create a new one.
5. Chick **Enable Java in-process agent** to enable preview Java in-process agent feature. Here you can also customize sampling rate from 0 to 100.
6. Click **Save** to save the change.

## Portal

1. Go to the **service | Overview** page and select **Application Insights** in the **Monitoring** section. 
2. Click **Enable Application Insights** to enable Application Insights in Azure Spring Cloud.
3. Click **Enable Java in-process agent** to enable Java IPA preview feature. When an IPA preview feature is enabled, you can configure one optional sampling rate (default 10.0%).

## Next steps

In the next exercise, we'll use an existing application set it up for monitoring
