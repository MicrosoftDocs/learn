In this exercise, you'll configure the sample application for monitoring using an APM solution.

## Monitor the Application

Open the Application Insights created by Azure Spring Cloud and start monitoring microservice applications.

Navigate to the `Application Map` blade:

![Application Map](../media/4-distributed-tracking-new-ai-agent.jpg)

Navigate to the `Performance` blade:

![Performance](../media/4-petclinic-microservices-performance.jpg)

Navigate to the `Performance/Dependencies` blade - you can see the performance number for dependencies,
particularly SQL calls:

![Dependenices](../media/4-petclinic-microservices-insights-on-dependencies.jpg)

Click on a SQL call to see the end-to-end transaction in context:

![end-to-end](../media/4-petclinic-microservices-end-to-end-transaction-details.jpg)

Navigate to the `Failures/Exceptions` blade - you can see a collection of exceptions:

![Exceptions](../media/4-petclinic-microservices-failures-exceptions.jpg)

Click on an exception to see the end-to-end transaction and stacktrace in context:

![end-to-end transaction and stacktrace in context](../media/4-end-to-end-exception-details.jpg)

Navigate to the `Metrics` blade - you can see metrics contributed by Spring Boot apps, Spring Cloud modules, and dependencies.
The chart below shows `gateway-requests` (Spring Cloud Gateway), `hikaricp_connections` (JDBC Connections) and `http_client_requests`.

![gateway-requests](../media/4-petclinic-microservices-metrics.jpg)

Spring Boot registers a number of core metrics: JVM, CPU, Tomcat, Logback...
The Spring Boot auto-configuration enables the instrumentation of requests handled by Spring MVC.
All those three REST controllers `OwnerResource`, `PetResource` and `VisitResource` have been instrumented by the `@Timed` Micrometer annotation at class level.

* `customers-service` application has the following custom metrics enabled:
  * @Timed: `petclinic.owner`
  * @Timed: `petclinic.pet`
* `visits-service` application has the following custom metrics enabled:
  * @Timed: `petclinic.visit`

You can see these custom metrics in the `Metrics` blade:

![custom metrics](../media/4-petclinic-microservices-custom-metrics.jpg)

You can use the Availability Test feature in Application Insights and monitor
the availability of applications:

![availability](../media/4-petclinic-microservices-availability.jpg)

Navigate to the `Live Metrics` blade - you can see live metrics on screen with low latencies < 1 second:

![Live Metrics](../media/4-petclinic-microservices-live-metrics.jpg)

## Next steps

In the next unit, we'll discuss monitoring your entire solution.
