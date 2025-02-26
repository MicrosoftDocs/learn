Before you dive into the code, let's take a step back and talk about observability. You need to have tools that help you understand the internal state of a system based on what's visible externally.

## Why implement observability?

There are several reasons why observability is a crucial aspect of developing and improving cloud-native applications:

- **Understanding system behavior**: Observability provides insights into how your application is performing and where bottlenecks or errors occur.
- **Debugging and troubleshooting**: When issues arise, observability tools can provide detailed information about what was happening in the system at the time of the issue.
- **Continuous improvement**: Observability isn't just for identifying and resolving issues&mdash;it's also used for continuous improvement. By monitoring system performance over time, you can identify opportunities to optimize your code, improve system performance, and quantitatively improve the experience to your users.
- **Proactive issue detection**: With the right observability tools in place, you can often detect issues before your users even see them.

Implementing observability in cloud-native applications isn't just a best practice, it's a necessity for maintaining, optimizing, and continuously improving your applications. It empowers developers to deliver reliable, high-performing applications and provides the insights needed to drive informed decision-making.

### The three pillars of observability

There are three main pillars of observability:

- **Logs**: Logs provide detailed records of events that occur within an application or system. In your app, you can use `Microsoft.Extensions.Logging` infrastructure to log events.
- **Metrics**: Metrics refer to numerical measurements and counters that provide insight into a system's performance and health. Examples include request rates, response times, CPU/memory usage, and error rates. In your app, you might have specific measurements that you need to track.
- **Distributed tracing**: This process involves tracing a request as it propagates through all the microservices in your cloud-native app. Each service logs tracing data like request IDs that allow you to correlate events across services. Distributed tracing is also useful for debugging performance issues and errors in complex systems.

Together, these three pillars provide comprehensive observability into a system.

### Sources of data for telemetry

In your company's cloud-native app, there are several sources of telemetry you could choose to collect:

- **Application logs**: Applications generate logs that provide detailed information about its operation and errors if they occur. Logging is a rich source of telemetry data.
- **Databases**: Databases can provide telemetry data about the queries they process, execution times, and any errors that occur.
- **HTTP requests and responses**: The HTTP requests and responses between your microservices provide rich and valuable telemetry data. This data includes the request and response headers, body content, status codes, and timing information.
- **Client-side performance data**: In cloud-native apps with a front end, you can collect the client-side performance data. This data might include page hits, load times, and UI interaction times.
- **Infrastructure metrics**: If your application is hosted in a cloud environment, you can collect infrastructure metrics like CPU usage, memory usage, network traffic, and disk I/O operations.

By collecting and analyzing this telemetry data, you can gain valuable insights into the performance and health of your application.

### Implement observability

To add observability to your cloud-native application, you take these steps:

- Add logging.
- Enable metrics and define custom metrics to capture.
- Enable distributed tracing with OpenTelemetry and Zipkin.
- Instrument your app, again with OpenTelemetry and by adding telemetry to your code.
- Analyze the telemetry data with Prometheus, Grafana, or Application Insights.

### Introduction to OpenTelemetry

How does OpenTelemetry help add observability to your app, and why is there such deep support for it in .NET? OpenTelemetry is an open-source observability framework. It provides a standard, vendor-agnostic way to generate telemetry data.

OpenTelemetry standardizes the way telemetry data is collected and transmitted to back-end platforms. It bridges visibility gaps by providing a common format of instrumentation across all your microservices. You don't have to reinstrument code or install different proprietary agents every time a back-end platform changes.

Because it's an open standard, it supports many other tools outside of .NET. OpenTelemetry is configured to use extensions that allow for exporters to create telemetry data to all the different tools. This means you can use the same tools to monitor microservices regardless of the language they're written in.

OpenTelemetry helps you collect and monitor all three pillars of observability: logs, metrics, and traces. You'll see how to do these tasks in the following units.
