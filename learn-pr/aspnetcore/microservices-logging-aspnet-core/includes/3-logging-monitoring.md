Logging refers to application level diagnostic traces that programmers include in the application code to help troubleshoot issues when the app doesn't behaves as expected. This is specially true in production, when you don't have the luxury of spinning up the app with the Visual Studio debugger.

Monitoring refers to gathering platform and application metrics that area meaningful to keep track of the application health. On another level, when using custom metrics, monitoring can also be more business-oriented.

## Logging

Logging in a microservices application can become complicated when you  get log streams from multiple microservices and you have to correlate somehow what's happening along several of those microservices.

The typical solution to send logs to a file in the host filesystem is just not valid anymore. Basically because the "host" is something ephemeral from the application's point of view. Not to mention that you usually have multiple instances of a microservice, typically in multiple "hosts", or what the microservices see as the host.

In the microservices context you need a solution that's able to aggregate log traces from several microservices and that conveys additional context information such as the "computer" name, application name and some transaction ID that allows you to correlate event happening in different services but somehow "connected" during some specific operation.

In this unit we'll review some important concepts and details about logging and then we'll go on exploring some logging samples to help getting a better idea on the subject.

The eShopOnContainer application uses [Serilog](https://serilog.net/) to create application traces using structured logging, that we'll review below in just a moment, and [Seq](https://datalust.co/seq) to centralize all log traces.

Serilog is an [open source project in GitHub](https://github.com/serilog/serilog) and even though Seq is not, it's possible to [use it for free in development and small projects](https://datalust.co/pricing), so it fits nicely for eShopOnContainers.

### Logging samples in eShopOnContainers

These are just a few samples of what you can get when you combine proper structured logging with filtering by some convenient properties, as seen from **Seq**.

The filter expression is highlighted on the top of each image.

#### Application startup

Get the details of application startup:

:::image type="content" source="../media/application-startup-logging-traces.png" alt-text="Filtered application startup log traces, description follows" border="true" lightbox="../media/application-startup-logging-traces.png":::

When filtering by `ApplicationContext = 'Ordering.API'` you get all events from the application, in this sample we also added a `DateTime` limit to show only the initial traces.

The "level" of the events shown, such as `Debug`, `Information`, `Warning`, can be configured as explained in the [setup and configuration section](#setup-and-configuration) below.

#### Close in on a specific type of trace

You can focus on a specific type of trace by finding an event type as shown in the next image:

:::image type="content" source="../media/event-traces-filtered-by-type.png" alt-text="Filtering by type" border="true" lightbox="../media/event-traces-filtered-by-type.png":::

1. Click on any trace to expand it.
2. Click on the Type link.
3. Click on the Find option.

You should get an output similar to this:

<!-- add alt text for image -->
:::image type="content" source="../media/traces-for-one-event-type-for-all-applications.png" alt-text="TODO" border="true" lightbox="../media/traces-for-one-event-type-for-all-applications.png":::

You can see the "Configuring web host" traces (`type = 0x10E11058`) for all applications.

You can easily filter by any of the properties of any trace.

#### Integration event handling

In the next image you can see an example of the handling of an integration event in the Ordering.API microservice:

<!-- add alt text for image -->
:::image type="content" source="../media/integration-event-handling.png" alt-text="TODO" border="true" lightbox="../media/integration-event-handling.png":::

In the image above you can see:

1. When the `UserCheckoutAcceptedIntegrationEvent` is being handled.
2. A database transaction begins
3. The order is created.
4. An integration event is enqueued for publishing later.
5. The database transaction is committed.
6. The integration events are published.

Worth noting here is that integration events are enqueued while in the scope of the transaction, but published after the transaction is committed.

### Structured logging

This section explores the code-related aspects of logging, beginning with the "structured logging" concept that makes it possible to get the samples show above.

In a few words, **structured logging** can be thought of as a stream of key-value pairs for every event logged, instead of just the plain text line of conventional logging.

The key-value pairs are then the base to query the events, as was shown in the samples above.

#### Get the logger

The logging infrastructure of .NET supports structured logging when used with a `LoggerFactory`, such as **Serilog**, that supports it, and the simplest way to use is by requesting an `ILogger<T>` through Dependency Injection (DI) in the class constructor as shown here:

```csharp
public class WorkerClass
{
    private readonly ILogger<WorkerClass> _logger;

    public WorkerClass(ILogger<WorkerClass> logger) =>
        _logger = logger;

    // If you have to use ILoggerFactory, change the constructor like this:
    public WorkerClass(ILoggerFactory loggerFactory) =>
        _logger = loggerFactory.CreateLogger<WorkerClass>();
}
```

The nice part of using the `ILogger<T>` is that you get a nice `SourceContext` property as shown here:

:::image type="content" source="../media/source-context-from-ilogger.png" alt-text="Log traces view, highlighting the SourceContext" border="true" lightbox="../media/source-context-from-ilogger.png":::

#### Logging events

Logging events is pretty simple, as shown in the following code that produces the trace shown in image above:

```csharp
_logger.LogInformation(
    "----- Begin transaction {TransactionId} for {CommandName} ({@Command})",
    transaction.TransactionId, typeName, request);
```

The code above is similar to what you've seen in the `string.format()` method, with three very important differences:

1. The first string defines a **type of event** or **template** property that can also be queried, along with any other of the event properties. It's what defines an `event type` in Seq.

2. Every name in curly braces in the **template** defines a **property** that gets it's value from a parameter after the template, just as in `string.Format()`.

3. If a property name begins with `@` then the whole object graph is stored in the event log and can be viewed in a structured way (beware the size of the object). If the property name doesn't have the `@` then the `.ToString()` method is used to get the value.

#### Logging contexts and correlation IDs

Logging context allows you to define a scope, so you can trace and correlate a set of events, even across the boundaries of the applications involved.

Correlation Ids are a mean to establish a link between two or more contexts or applications, for example, every incoming request is assigned a unique Id (like a Guid or similar).  At some point it might be better to handle a more informative correlation ID, such as an **OrderId**, that can be easily identified across different applications, even when using different technologies.

These are some of the context properties used in eShopOnContainers:

- **ApplicationContext** Is defined on application startup and adds the `ApplicationContext` property to all events.
- **SourceContext** Identifies the full name of the class where the event is logged, it's usually defined when creating or injecting the logger.
- **RequestId** Is a typical context that covers all events while serving a request. It's defined by the ASP.NET Core request pipeline.
- **Transaction context** Covers the events from the beginning of the database transaction up to it's commit.
- **IntegrationEventContext** - Identifies all events that occur while handling an integration event in an application.

Logging contexts can be created as shown in the following code:

```csharp
public class OrderStartedIntegrationEventHandler : IIntegrationEventHandler<OrderStartedIntegrationEvent>
{
    //...
    public OrderStartedIntegrationEventHandler(
        IBasketRepository repository,
        ILogger<OrderStartedIntegrationEventHandler> logger)
    {
        //...
    }

    public async Task Handle(OrderStartedIntegrationEvent @event)
    {
        using (LogContext.PushProperty("IntegrationEventContext", $"{@event.Id}-{Program.AppName}"))
        {
            _logger.LogInformation(
                "----- Handling integration event: {IntegrationEventId} at {AppName} - ({@IntegrationEvent})",
                @event.Id, Program.AppName, @event);

            await _repository.DeleteBasketAsync(@event.UserId.ToString());
        }
    }
}
```

The code above adds the property `IntegrationEventContext` with the defined value to all log events generated within the `using` statement, including any method being invoked from the `DeleteBasketAsync()` method.

#### Important logging rules

There a just a few simple rules to get the most from structured logging:

1. NEVER use string interpolation with variables as the template.

   If you use interpolation, then the "template" will lose it's meaning as an event type, you will also lose the key-value pairs and the trace will become a plain old simple text trace.

2. Log exceptions with the proper overload as shown in the following code fragments:

   ```csharp
   catch (Exception ex)
   {
       _logger.LogWarning(ex, "Could not publish event: {EventId} after {Timeout}s ({ExceptionMessage})", @event.Id, $"{time.TotalSeconds:n1}", ex.Message);
   }

   .../...

   catch (Exception ex)
   {
       _logger.LogError(ex, "Program terminated unexpectedly ({Application})!", AppName);
       return 1;
   }

   ```

   Don't log only the exception message, because it would be like violating rule #1.

### Setup and configuration

The logging setup used in eShopOnContainers is somewhat different from the usual samples in ASP.NET Core and it's taken mostly from <https://github.com/serilog/serilog-aspnetcore>. The main reason is to have logging services available as soon as possible during application startup.

As for Seq configuration, it's just another deployment, created with a standard image from DockerHub.

To enable Serilog you have to install the following packages in each application:

- Serilog.AspNetCore
- Serilog.Enrichers.Environment
- Serilog.Settings.Configuration
- Serilog.Sinks.Console
- Serilog.Sinks.Seq

Logger configuration is done in `Program.cs` as shown here:

```csharp
private static Serilog.ILogger CreateSerilogLogger(IConfiguration configuration)
{
    var seqServerUrl = configuration["Serilog:SeqServerUrl"];

    return new LoggerConfiguration()
        .MinimumLevel.Verbose()
        .Enrich.WithProperty("ApplicationContext", AppName)
        .Enrich.FromLogContext()
        .WriteTo.Console()
        .WriteTo.Seq(string.IsNullOrWhiteSpace(seqServerUrl) ? "http://seq" : seqServerUrl)
        .ReadFrom.Configuration(configuration)
        .CreateLogger();
}
```

The following aspects can be highlighted from the code above:

- `.Enrich.WithProperty("ApplicationContext", AppName)` defines the `ApplicationContext` for all traces in the application.
- `.Enrich.FromLogContext()` allows you to define a log context anywhere you need it.
- `.ReadFrom.Configuration(configuration)` allows you to override the configuration from values in `appsettings.json`, or environment variables, which becomes very handy for containers.

The next JSON fragment shows the typical default configuration for `appsettings.json` eShopOnContainers microservices:

```json
"Serilog": {
    "SeqServerUrl": null,
    "MinimumLevel": {
        "Default": "Information",
        "Override": {
            "Microsoft": "Warning",
            "Microsoft.eShopOnContainers": "Information",
            "System": "Warning"
        }
    }
},
```

The previous JSON fragment shows how to configure the MinimumLevel for traces, according to the Namespace of the `SourceContext`, such that the default is **Information**, except for namespaces `Microsoft.*` and `System.*`, except again for `Microsoft.eShopOnContainers`, that's also **Information**.

### Additional resources

- [Logging in ASP.NET Core](/aspnet/core/fundamentals/logging)
- [Serilog — simple .NET logging with fully-structured events](https://serilog.net/)
- [Seq — structured logs for .NET apps](https://datalust.co/seq)
- [Structured logging concepts in .NET Series (1)](https://nblumhardt.com/2016/06/structured-logging-concepts-in-net-series-1/)
- [Events and levels - structured logging concepts in .NET (2)](https://nblumhardt.com/2016/06/events-and-levels-structured-logging-concepts-in-net-2/)
- [Smart Logging Middleware for ASP.NET Core](https://blog.getseq.net/smart-logging-middleware-for-asp-net-core/)
- [Tagging log events for effective correlation](https://nblumhardt.com/2015/01/designing-log-events-for-effective-correlation/)

## Monitoring

Application Insights is an extensible Application Performance Management (APM) service for developers and DevOps professionals. You can use it to monitor your applications in any environment, from development to production.

It'll automatically detect performance anomalies, and includes powerful analytics tools to help you diagnose issues and to understand what users actually do with your app.

Application Insights is part of Azure Monitor and gives you an easy-to-implement starting point for monitoring you application.

### How to implement Application Insights

To implement Application Insights you have to create an Application Insight resource in Azure and then add a small instrumentation package and configure it in your application.

You can instrument not only the web applications, but also any background components, and even the JavaScript in the web pages themselves. Application Insights can even keep log traces to get powerful correlations. The application don't need to be hosted in Azure, they can be anywhere. You can get metrics even from your dev machine.

An Application Insights resource is intended to be associated with a single app, so in the case of eShopOnContainers, you'd have to create as many resources as services you'd want to monitor. Each Application Insights resource is identified with a GUID, known as the "Instrumentation Key".

All telemetry and log streams are integrated in Azure Monitor. In the Azure portal, you can make queries, display charts, and generate alerts, that allow you to effectively manage your application.

### Application Insights telemetry

Application Insights can get an extensive set of metrics from your application, ranging from the typical request rates and response times, to dependencies calls. You can also track custom events in your views and analyze conversion funnels and cohorts for user retention.

You can se more about the wide range of metrics you can monitor with Application Insights in the [documentation overview](/azure/azure-monitor/app/app-insights-overview#what-does-application-insights-monitor).

### Dashboards an alerts

Telemetry is used to drive [Smart Detection](/azure/azure-monitor/app/proactive-diagnostics) that warns about potential problems automatically. You get this kind of alerts without having to set up anything special, just by instrumenting your applications with Application Insights.

Application Insights also makes a map of all components and dependencies of your application, that gives you a high level overview of the state of the components and the communications between them.

In the next exercise we'll explore some of the key features you can get from Application Insights.
