In this exercise, with zero configuration, you'll effortlessly monitor data flows for your sample application.

## Monitor the Application with Application insights

Application Map helps you spot performance bottlenecks or failure hot-spots across all components of your distributed application.

1. Open the Azure portal
1. Select "Azure Spring Cloud" from the list of Azure services
1. Select your Azure Spring Cloud instance
1. Select **Application Insights** to jump to the Overview page of Application Insights.

:::image type="content" source="../media/7-insights-start.jpg" alt-text="screenshot showing Application insights for your spring cloud":::

5. On the left, navigate to **Application Map** where you can see a view of your Azure Spring Cloud microservices:

:::image type="content" source="../media/4-distributed-tracking-new-ai-agent.jpg" alt-text="Screenshot showing Application map with microservices":::

Applications that are operating correctly (green) and those applications with bottlenecks (red).
In the Application Map above, each of the names in green boxes are different services of your Azure Spring Cloud.
You can easily identify issues in their applications and quickly troubleshoot and fix them. Each node on the map represents a MicroService or its dependencies with health KPI and alerts status. You can select from any component to more detailed diagnostics, such as Application Insights events.

### Performance

On the left, navigate to **Performance** where you can see response times and request counts for operations exposed by your applications.

:::image type="content" source="../media/4-petclinic-microservices-performance.jpg" alt-text="Screenshot showing operation performance view for your Azure Spring Cloud instance":::

Next, on the right, navigate to **Dependencies** where you can see all your dependencies and their response times and request counts.
You can see the performance number for dependencies, particularly SQL calls:

:::image type="content" source="../media/4-petclinic-microservices-insights-on-dependencies.jpg" alt-text="Screenshot showing dependency performance view for your Azure Spring Cloud instance":::

You can select a SQL call or a dependency to see the transaction in context:

1. Select a SQL statement in the "Select operation tab":

:::image type="content" source="../media/4-performance-sql.jpg" alt-text="Screenshot showing single transaction for your Azure Spring Cloud instance":::

2. Next, on the Right tab, select "Drill into" and on the far right tab, and then select a SQL sample to open the transaction detail window:

:::image type="content" source="../media/4-performance-sql-details.jpg" alt-text="Screenshot showing single transaction for your Azure Spring Cloud instance":::

3. Finally, in the transaction details view, view the sample sql statement transaction by selecting the sql statement:

:::image type="content" source="../media/4-performance-sql-stack.jpg" alt-text="Screenshot showing single transaction for your Azure Spring Cloud instance":::

### Failures/Exceptions

Next, select **Failures** in the Application Insights resource menu located in the Investigate section. In this view, you'll see top three failure response codes, top three exception types, and top three failing dependency types.

:::image type="content" source="../media/7-petclinic-microservices-failures.jpg" alt-text="Screenshot showing Failures view for your Azure Spring Cloud instance":::

Select an exception and drill in for meaningful insights and actionable stack trace:

1. On the right-hand side, select an exception in the "Top 3 exception types":

:::image type="content" source="../media/4-exception.jpg" alt-text="Screenshot showing the exception screen":::

2. Next, on the Right tab, select the "Suggested" exception sample to open the transaction detail window:

:::image type="content" source="../media/4-exception-drill.jpg" alt-text="Screenshot showing the exception detail screen":::

3. Next, view the exception properties in the transaction detail window:

:::image type="content" source="../media/4-exception-details.jpg" alt-text="Screenshot showing the exception details screen":::

4. Finally, in the middle of the screen, in the end-to-end transaction tab, select an exception to view its details and stacktrace:

:::image type="content" source="../media/4-exception-stack.jpg" alt-text="Screenshot showing the exception stacktrace screen":::

### Metrics

Spring Boot registers many core metrics: JVM, CPU, Tomcat, Logback...
You can see metrics contributed by Spring Boot apps, Spring Cloud modules, and dependencies.

Next, under the Monitoring section, select **Metrics** in the Application Insights resource menu.

To create a standard metric chart, under the Monitoring section, open the Metrics tab and follow these steps:

1. Ensure your Azure Spring Cloud is selected under **Scope** and **Azure Spring Cloud** under **namespaces**. Both will already be populated if you opened metrics explorer from the resource's menu.

:::image type="content" source="../media/4-metrics.jpg" alt-text="Screenshot showing metrics":::

2. Next, under metrics, add the **App CPU Usage** and **Avg** aggregation:

:::image type="content" source="../media/4-metrics-cpu-first-add.jpg" alt-text="Screenshot showing adding app cpu metrics":::

3. Next, save the first metric by selecting the "Tick" icon on the right-hand metric bar.

:::image type="content" source="../media/4-metrics-cpu-first.jpg" alt-text="Screenshot showing metrics selection":::

4. Next, add another metric by selecting the "Add metric" action on the top left-hand toolbar" and add the "system.cpu.usage" metric

:::image type="content" source="../media/4-metrics-add-second.jpg" alt-text="Screenshot showing adding system cpu metrics":::

5. Next, save the second metric by selecting the "Tick" icon on the right-hand metric bar.

:::image type="content" source="../media/4-metrics-add.jpg" alt-text="Screenshot showing adding system cpu metrics":::

6. Finally, inspect your metrics graph with both the App and System CPU metrics
:::image type="content" source="../media/4-metrics-cpu-both.jpg" alt-text="Screenshot showing system and app cpu metrics":::

### Custom Metrics

As you deploy resources and applications in Azure, you'll want to start collecting telemetry to gain insights into their performance and health. Azure makes some metrics available to you out of the box. These metrics are called standard or platform. However, they're limited in nature.
You might want to collect some custom performance indicators or business-specific metrics to provide deeper insights.

Similarly to standard metrics, to create a custom metric chart, under the Monitoring section, open the Metrics tab and follow these steps:

1. Ensure your Azure Spring Cloud is selected in the resource scope picker. It will already be populated if you opened metrics explorer from the resource's menu.

2. Next, under **namespaces**, select the **azure.applicationinsights** namespace. The namespace is just a way to organize metrics so that you can easily find them.

:::image type="content" source="../media/7-custom-namespace.jpg" alt-text="Screenshot showing namespace selection for custom metrics":::

3. Next, under metrics, add the following custom metrics and aggregation:

* Metric `petclinic_pet`, Aggregation: `count`

:::image type="content" source="../media/7-custom-metrics.jpg" alt-text="Screenshot showing metric and aggregate selection for custom metrics":::

4. Add the metrics for the `owner` and `visit` services:

* Metric `petclinic_owner`, Aggregation: `count`
* Metric `petclinic_visit`, Aggregation: `count`

:::image type="content" source="../media/7-custom-third.jpg" alt-text="Screenshot showing finished custom metrics view":::

5. Next, on the top right-hand side, change the graph type to **Area Chart**

:::image type="content" source="../media/7-custom-area.jpg" alt-text="Screenshot showing graph type selection for custom metrics view":::

6. Your final graph will show the counts in the last 24 hours for each of the pet, vet, and owner microservices:

:::image type="content" source="../media/7-custom.jpg" alt-text="Screenshot showing final custom metrics view":::

### Live Metrics

Next, on the left, under the Investigate section, navigate to **Live Metrics** where you can see live metrics practically in real time, within only one second:

:::image type="content" source="../media/4-petclinic-microservices-live-metrics.jpg" alt-text="Screenshot showing live metrics view for your Azure Spring Cloud":::

When you deploy a new version of your web app, you want to know immediately its effect on performance. Have response times improved or worsened, or is it showing failures? Watch Live Metrics Stream in Application Insights while your deployment is happening, and you’ll see the effect immediately. If there are problems, you could back out the deployment before too many users are affected.
Live Metrics Stream enables you to probe the beating heart of your live applications. You can select and filter metrics and performance counters to watch in real time, without any disturbance to your service. You can also inspect stack traces from sample failed requests and exceptions.

Scroll down the metrics to see the metrics for each microservice:

:::image type="content" source="../media/7-live-metrics-servers.jpg" alt-text="Screenshot showing Service live metrics view for your Azure Spring Cloud":::

## Next steps

In the next unit, we'll discuss monitoring your entire solution.
