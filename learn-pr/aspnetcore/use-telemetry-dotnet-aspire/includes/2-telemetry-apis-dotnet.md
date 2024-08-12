How can you investigate the behavior of an app for troubleshooting or performance optimization? The more data you have about what the app did, the easier it is to diagnose problems.

Imagine you work for an outdoor equipment retailer. Your teams are building their microservices, ready for the testing phase. You want to ensure that your cloud-native app emits telemetry about its behavior so that you can diagnose problems during testing, staging, and production.

In this unit, you'll learn about telemetry and the different kinds of data you can record with it.

## What is telemetry?

In engineering, telemetry is the measurement of data and its automatic transmission to a central system for monitoring. For example, a racing car may record data about its performance and send it back to the paddock where engineers analyze it. Similarly a space capsule might record information about conditions in the capsule and send it back to mission control. In recent years, it's become common to record and analyze telemetry data in more common systems. For example, your central heating may send telemetry to the manufacturer to assist in troubleshooting.

If you're writing cloud-native apps, telemetry is helpful when:

- You're developing microservices and want to know if they're behaving as expected.
- You're testing your app and want to know what happens when they fail a test.
- You're staging your app and want to know how they're performing.
- You're supporting your app in production and want to troubleshoot an exception or optimize performance.

We can describe a system that emits rich telemetry as:

- **Observable**: An observable system is one that enables you to understand its behavior from outside it.
- **Instrumented**: An instrumented system is one that emits all the data developers need to troubleshoot an issue.

**OpenTelemetry** is an observability framework and toolkit that you can use in your app to create, process, and emit telemetry data. You can easily add it to any .NET application, including microservices in a cloud-native app. It emits data in forms that common observability tools like Jaeger and Prometheus can use and analyze.

## Pillars of observability

The nature of cloud-native apps, which consist of distributed microservices that use disparate technologies, can make it difficult to build observable and properly instrumented code. All teams must integrate observability into their microservices, otherwise you may find that part of your app is difficult to monitor and troubleshoot.

> [!IMPORTANT]
> To ensure that your entire app is observable, you should ensure that all development teams consider the three pillars of observability in their microservices: **Logging**, **Metrics**, and **Tracing**.

The three pillars of observability are three different types of records that store the behavior of software components for later analysis:

- **Log**: a timestamped text record of what happened during the processing of a request.
- **Metric**: a measurement of a service captured at runtime. Metric values can be aggregated into statistics about a process, including:
  - .NET Runtime statistics such as the memory used, or the number of garbage collections that occurred.
  - ASP.NET or NuGet package statistics such as the number of completed requests, request durations, or error counts.
  - Custom statistics that are specific to your app, such as the number of orders placed.
- **Distributed Trace**: a record of all the units of work, often referred to as **Spans**, needed to handle an individual request. In a cloud-native app, many microservices and backing services may be involved in a single request and a distributed trace would show all of them as they collaborate to prepare the response.

> [!NOTE]
> In OpenTelemetry, any data that is not part of a distributed trace or a metric is considered to be a log, for example, events.

## Using telemetry in .NET

.NET has built-in types to represent the three pillars:

- **ILogger**: This interface provides a standard interface you can use when you what to log events from any .NET code.
- **Meter**: You can use this class to create a group of instruments, each of which measures a value associated with the performance or behavior of your code. For example, you could add an instrument that counts the sales of a product, or another that measures the length of time a message waited in a queue. .NET also provides many built-in metrics.
- **Activity**: You can use this class to record the tracing information. Start by creating an `ActivitySource` object for your namespace. Then call the `StartActivity` method to begin recording data.

You can use these classes in any .NET code. In the next unit you'll see how .NET Aspire makes it easier to use OpenTelemetry classes in cloud-native apps.

## Learn more

- [.NET Aspire telemetry](/dotnet/aspire/fundamentals/telemetry)
- [.NET observability with OpenTelemetry](/dotnet/core/diagnostics/observability-with-otel)
- [What diagnostic tools are available in .NET Core?](/dotnet/core/diagnostics/)
