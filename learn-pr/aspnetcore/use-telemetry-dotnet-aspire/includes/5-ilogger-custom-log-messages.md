.NET provides APIs that you can use to log customized telemetry data. OpenTelemetry can export that data.

In this unit, you'll learn how to write efficient code that sends events to structured logs.

## ILogger objects

A .NET Aspire app sets up the OpenTelemetry API automatically when you create a project based on the templates or add an existing project to .NET Aspire orchestration. When you want to record telemetry, you don't need to create your own logging, metrics, or tracing objects. Instead you can retrieve them by using dependency injection in your microservices.

For example, in the following `BasketService` class, an `ILogger` object is included in the class declaration. You can use that logger anywhere in the class to write events:

```csharp
public class BasketService(
    IBasketRepository repository,
    ILogger<BasketService> logger) : Basket.BasketBase
{
    [AllowAnonymous]
    public override async Task<CustomerBasketResponse> GetBasket(
	    GetBasketRequest request, ServerCallContext context)
    {
        var userId = context.GetUserIdentity();

        // Use the logger to write events
        if (logger.IsEnabled(LogLevel.Debug))
        {
            logger.LogDebug("Begin GetBasketById call from method {Method} for basket id {userId}", context.Method, userId);
        }

        var data = await repository.GetBasketAsync(userId);

        return new();
    }
}
```

## Efficient logging

Logging helps to make your microservice observable. When the app is tested, staged, and deployed to production, a thorough log code may enable rapid diagnosis of faults or bottlenecks. It's therefore tempting to log everything. However, although logging is rapid it doesn't have zero cost and you should be careful to log efficiently.

Vendors commonly bill Application Performance Management (APMs) systems based on the volume of data they ingest. Selecting the appropriate log level for your messages and the default collection levels can have a big effect on the monthly bill. Log collection levels can be set on per-provider basis, which is typically the type name used in `ILogger<T>`.

Use the following techniques every time you log:

- Check that the logging level you want to use is enabled. Available levels include information, warning, error, and critical. Adminstrators can enable different levels when testing, staging, and deploying to production. Log output is controlled through `IConfiguration`, typically using `appsettings.json` or environment variables.
- Avoid string interpolation in your logged message. Interpolated strings are defined with the `$` symbol and are evaluated even if your chosen logging level is not enabled. Instead, use a log method such as `LogInformation()` or `LogDebug()` and pass parameters in the argument list.
- Use the compile-time source generation to further optimize the logging performance and create a unique identifier for each log message, which is useful when querying for log messages in an APM.

## Compile time source generation

Compile time source generation with `ILogger` objects reduces the cost of logging by doing the string analysis once, rather than on each logging request. It also includes an ID for each type of log message. To use this technique, define partial logging methods with the logging parameters and apply the `LoggerMessageAttribute` to them. .NET automatically generates the complete logging method when the code is compiled.

Remember that in .NET Aspire, you don't need to create an ILogger but instead you can get it from dependency injection:

```csharp
public partial class BasketService(
    IBasketRepository repository,
    ILogger<BasketService> logger) : Basket.BasketBase
{
    [LoggerMessage(
        EventId = 0,
        Level = LogLevel.Information,
        Message = "Obtaining a basket from method {Method} for basket {basketId}")]
    public partial void LogGetBasket(string Method, int basketId);
}
```

## Learn more

- [Logging guidance for .NET library authors](/dotnet/core/extensions/logging-library-authors)
- [Compile-time logging source generation](/dotnet/core/extensions/logger-message-generator)
