Redaction within applications is most commonly done on log messages and telemetry. It can also be used in other scenarios like redacting dimensions in Metrics, or header data in middleware.

The .NET logging framework provides a simple way to redact data in log messages. The `Microsoft.Extensions.Compliance.Abstractions` package enhances logging to include a `Redactor` class that redacts data.

## What is redaction?

Redaction is the process of removing sensitive information from a message. For example, you might want to redact a user's name from a log message. Or you might want to redact a user's IP address from a telemetry event.

The most simple redaction is to erase the value, and return an empty string for a variable. This behavior happens by default because the `ErasingRedactor` is default fallback redactor. Microsoft includes a `HMACSHA256Redactor` class that can be used to redact data using a hash function. The HMAC redaction is useful if you want to redact data, but still be able to correlate log messages across multiple log statements. The last option is to provide your own redaction function, which is useful if you want to redact data using a custom algorithm.

For example, you want to make it clearer in the logs that a value is redacted by replacing it with `*****`.

## How to redact data in a cloud-native application

Your organizations cloud-native app could be writing logs and creating telemetry in multiple projects. For example, it could be writing logs from the database service, the web app, or any other API's it uses. Depending on the type of logging, you'll need to add the redaction service to each one.

There are four steps you need to take to enable redaction in your app:

1. Add the `Microsoft.Extensions.Compliance.Redaction` NuGet package to each project.
1. Add the redaction service to the dependency injection container.
1. Choose which redaction implementation to use for each type of classified data.
1. Enable redaction in the logging framework.

### Add the redaction service to the Dependency Injection container

The following example is for a Blazor WebAssembly app. The process is similar for other types of apps, but the code is slightly different depending on how the dependency injection container is configured.

In the **program.cs** file, add the following dependencies:

```csharp
using Microsoft.Extensions.Compliance.Classification;
using Microsoft.Extensions.Compliance.Redaction;
```

The above packages allow you to then add the redaction service to the dependency injection container with this code:

```csharp
builder.Services.AddRedaction();
```

### Choose which redaction implementation to use for each type of classified data

The `AddRedactor` method can include a `RedactorOptions` parameter. The parameter allows you to specify which redaction implementation to use for each data taxonomy.

For example, the following code specifies that the `HMACSHA256Redactor` should be used for `EUII` data.

```csharp
builder.Services.AddRedaction(configure =>
{
    // Configure to use the HMAC redactor
    configure.SetHmacRedactor(configureHmac =>
    {
        // This key should be fetched from keyvault or some other secure store.
        configureHmac.Key = "thisisadummykeythatshouldbereplacedwithakeyfromakeystore";
        // Some discriminator to differentiate between different deployments of a service.
        configureHmac.KeyId = 1;

    }, new DataClassificationSet(DataClassifications.EUIIDataClassification));
});
```

> [!NOTE]
> The HMAC redactor algorithm is experimental so you need to disable the compiler warning if you use it. Surrounding the above code with `#pragma warning disable EXTEXP0002` and `#pragma warning restore EXTEXP0002` would enable you to compile your project.

You can add multiple redaction implementations to the `RedactorOptions` parameter. For example, the following code adds a custom redactor for `EUPI` data.

```csharp
builder.Services.AddRedaction(configure =>
{
    // Configure to use the HMAC redactor for EUII data
    configure.SetHmacRedactor(configureHmac =>
    {
        // This key should be fetched from keyvault or some other secure store.
        configureHmac.Key = "thisisadummykeythatshouldbereplacedwithakeyfromakeystore";
        // Some discriminator to differentiate between different deployments of a service.
        configureHmac.KeyId = 1;

    }, new DataClassificationSet(DataClassifications.EUIIDataClassification));

    // Configure a custom redactor for EUPI data
    configure.SetRedactor<EShopCustomRedactor>(new DataClassificationSet(DataClassifications.EUPIDataClassification));
});
```

### Enable redaction in the logging framework

The next step is to enable redaction in the logging framework. This is done by setting the `.EnableRedaction` property to your applications logging generator. For the example app, the code is:

```csharp
builder.Services.AddLogging(logging => 
{
    logging.EnableRedaction();
    logging.AddJsonConsole(); //Enable structure logs on the console to view the redacted data.
});
```

With the above code in place, you can create a new logger that uses the redaction service. Implement a new `LogOrders` logger wherever you want to write order information to the logs.

```csharp
public static partial class Log
{
    [LoggerMessage(1, LogLevel.Information, "Write the Order data formatted as JSON: {order}")]
    public static partial void LogOrders(this ILogger logger, [LogProperties] Order order);
}
```

## Create a custom redaction implementation

Microsoft allows you to create a custom redaction implementation. You'll use a custom redaction when you want to redact data using your own algorithm. Let's implement a custom redactor that replaces sensitive data with `*****`.

Custom redactors need to implement the `Redactor` class. The class needs two methods implemented:

```csharp
public class EShopCustomRedactor : Redactor
{
    private const string Stars = "*****";

    public override int GetRedactedLength(ReadOnlySpan<char> input) => Stars.Length;

    public override int Redact(ReadOnlySpan<char> source, Span<char> destination)
    {
        Stars.CopyTo(destination);
        return Stars.Length;
    }
}
```

In our example **:::no-loc text="eShopLite":::** architecture, you can add this class into the **DataEntities** project, in **Compliance.cs** below the data classification code.
