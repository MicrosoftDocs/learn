In this exercise, with zero configuration, you'll effortlessly monitor data flows for your sample application.

## Monitor the Application with Application insights

Select you Azure Spring instance and in the left navigation pane, select Application Insights to jump to the Overview page of Application Insights.

![Open Application insights](../media/7-insights-start.jpg)

### Application Map

Application Map helps you spot performance bottlenecks or failure hotspots across all components of your distributed application. On the left, navigate to **Application Map** where you can see a view of your Azure Spring Cloud microservices:

![Application Map](../media/4-distributed-tracking-new-ai-agent.jpg)

Applications that are operating correctly (green) and those applications with bottlenecks (red).
In the Application Map above, each of the names in green boxes are different services of your Azure Spring Cloud.
You can easily identify issues in their applications and quickly troubleshoot and fix them. Each node on the map represents a MicroService or its dependencies with health KPI and alerts status. You can select from any component to more detailed diagnostics, such as Application Insights events.

### Performance

On the left, navigate to **Performance** where you can see response times and request counts for operations exposed by your applications.

![Performance](../media/4-petclinic-microservices-performance.jpg)

Next, on the right, navigate to **Dependencies** where you can see all your dependencies and their response times and request counts.
You can see the performance number for dependencies, particularly SQL calls:

![Dependenices](../media/4-petclinic-microservices-insights-on-dependencies.jpg)

You can select a SQL call or a dependency to see the transaction in context:

![end-to-end](../media/4-petclinic-microservices-end-to-end-transaction-details.jpg)

### Failures/Exceptions

Next, select **Failures** in the Application Insights resource menu located in the Investigate section. In this view, you'll see top three failure response codes, top three exception types, and top three failing dependency types.

![Exceptions](../media/7-petclinic-microservices-failures.jpg)

Select an exception and drill in for meaningful insights and actionable stack trace:

![end-to-end transaction and stacktrace in context](../media/4-end-to-end-exception-details.jpg)

### Metrics

Spring Boot registers many core metrics: JVM, CPU, Tomcat, Logback...
You can see metrics contributed by Spring Boot apps, Spring Cloud modules, and dependencies.
The chart below shows `gateway-requests` (Spring Cloud Gateway), `hikaricp_connections` (JDBC Connections), and `http_client_requests`.

![gateway-requests](../media/4-petclinic-microservices-metrics.jpg)

### Custom Metrics

To create a metric chart, open the Metrics tab and follow these steps:

1. Ensure your Azure Spring Cloud is selected in the resource scope picker. The resource should already be populated if you opened metrics explorer from the resource's menu.

2. Next, under **namespaces**, select the **azure.applicationinsights** namespace. The namespace is just a way to organize metrics so that you can easily find them.

![add metrics](../media/7-custom-namespace.jpg)

3. Next, under metrics, add the following custom metrics and aggregation:

* Metric `petclinic_pet`, Aggregation: `count`

![add metrics](../media/7-custom-metrics.jpg)

4. Add the metrics for the `owner` and `visit` services:

* Metric `petclinic_owner`, Aggregation: `count`
* Metric `petclinic_visit`, Aggregation: `count`

![add metrics](../media/7-custom-third.jpg)

5. Next, on the top right hand side, change the graph type to **Area Chart**

![add metrics](../media/7-custom-area.jpg)

6. Your final graph will show the counts in the last 24 hours for each of the pet, vet and owner microservices:

![custom metrics](../media/7-custom.jpg)

### Availability

You can use the Availability Test feature in Application Insights to monitor the availability of applications in Azure Spring Cloud. This is a recurring test to monitor the availability and responsiveness of applications at regular intervals from anywhere across the globe. It can proactively alert you if your applications are not responding or if they respond too slowly.

![availability](../media/4-petclinic-microservices-availability.jpg)

### Live Metrics

Navigate to the Live Metrics blade where you can see live metrics practically in real time, within only one second:

![Live Metrics](../media/4-petclinic-microservices-live-metrics.jpg)

## Next steps

In the next unit, we'll discuss monitoring your entire solution.
