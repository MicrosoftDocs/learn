In this exercise, you'll configure an the sample Application for Monitoring.

## Monitor the Application

We will illustrate this using a distributed version of Spring Petclinic. Navigate to the Application Map blade where you can see an incredible, holistic view of microservices that shows applications that are operating correctly (green) and those with bottlenecks (red) [Figure 1]. Developers can easily identify issues in their applications and quickly troubleshoot and fix them.

## Performance of application dependencies

Navigate to the Performance blade where you can see response times and request counts for operations exposed by your applications [Figure 2].
Navigate to the Dependencies tab in the Performance blade where you can see all your dependencies and their response times and request counts [Figure 3].
You can click a SQL call or a dependency to see the full end-to-end transaction in context [Figure 4].

## Exceptions thrown by applications

Navigate to the Exceptions tab in the Failures blade to see a collection of exceptions thrown by applications [Figure 5].

## Microservice failures exceptions

Simply select an exception and drill in for meaningful insights and actionable stack trace [Figure 6].

## End-to-End transaction details

Navigate to the Metrics blade to see all the metrics contributed by Spring Boot applications, Spring Cloud modules, and their dependencies. The chart below showcases gateway-requests contributed by Spring Cloud Gateway and hikaricp_connections contributed by JDBC [Figure 7]. Similarly, you can aggregate Spring Cloud Resilience4J metrics and visualize them.

## custom metrics

Spring Boot applications register a lot of core metrics – JVM, CPU, Tomcat, Logback, etc. You can use Micrometer to contribute your own custom metrics, say using the @Timed Micrometer annotation at a class level. You can then visualize those custom metrics in Application Insights. As an example, see how pet owners, pets, and their clinical visits are tracked by custom metrics below –you can also see how the pattern changes at 9 PM because applications are driving higher utilization when autoscaling kicked in [Figure 8].

## Microservice availability

You can use the Availability Test feature in Application Insights to monitor the availability of applications in Azure Spring Cloud. This is a recurring test to monitor the availability and responsiveness of applications at regular intervals from anywhere across the globe. It can proactively alert you if your applications are not responding or if they respond too slowly. The chart below shows availability tests from across North America – West US, South Central, Central US, and East US [Figure 9].

## Real-time metrics

Navigate to the Live Metrics blade where you can see live metrics practically in real-time, within only one second [Figure 10].

When the **Application Insights** feature is enabled, you can:

In the left navigation pane, click **Application Insights** to jump to the **Overview** page of Application Insights. 

* Click **Application Map** to see the status of calls between applications.

* Click the link between customers-service and `petclinic` to see more details such as a query from SQL.

* In the left navigation pane, click **Performance** to see the performance data of all applications' operations, as well as dependencies and roles.

* In the left navigation pane, click **Failures** to see if something unexpected from your applications.

* In the left navigation pane, click **Metrics** and select the namespace, you will see both Spring Boot metrics and custom metrics, if any.

* In the left navigation pane, click **Live Metrics** to see the real time metrics for different dimensions.

* In the left navigation pane, click **Availability** to monitor the availability and responsiveness of Web apps by creating Availability tests in Application Insights

## Next steps

The next unit is a knowledge check to see what you've learned in this module.
