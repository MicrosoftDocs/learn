You need add some logging to the order process. You'll use the redaction features of .NET to ensure that the sensitive data isn't leaked into the logs.

In this exercise, you'll:

* Add the `Microsoft.Extensions.Compliance.Redaction` NuGet package to each project.
* Add the redaction service to the dependency injection container.
* Enable redaction in the logging framework.
* Call the logging framework during the order process.
* Add a custom redaction implementation for EUII data.
* Choose which redaction implementation to use for each type of classified data.

## Add the redaction service

You should still have the codespace or Visual Studio Code window open. If not, open it now.

1. In the **TERMINAL** window, enter this command:

    ```bash
    cd /workspaces/mslearn-dotnet-cloudnative/dotnet-compliance/eShopLite/Store/
    ```

1. Add the `Microsoft.Extensions.Compliance.Redaction` NuGet package to the project:

    ```bash
    dotnet add package Microsoft.Extensions.Compliance.Redaction
    ```

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/Store** folder, then select the **Program.cs** file.
1. In the editor, add the following dependencies:

    ```csharp
    using Microsoft.Extensions.Compliance.Classification;
    using Microsoft.Extensions.Compliance.Redaction;
    ```

1. Scroll down to line 19, under the `Add redaction` comment add the redaction service to the dependency injection container:

    ```csharp
    builder.Services.AddRedaction();
    ```

## Enabling redaction in the logging framework

1. In the editor, add this code below the `AddRedaction()` line:

    ```csharp
    builder.Services.AddLogging(logging => 
    {
        logging.EnableRedaction();
        logging.AddJsonConsole(); //Enable structure logs on the console to view the redacted data.
    });
    ```

    The above code enables redaction in the logging framework.

## Call the logging framework during the order process

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/Store/Services** folder, then select the **ProductService.cs** file.
1. In the editor, at the bottom of the file, add this code:

    ```csharp
    public static partial class Log
    {
        [LoggerMessage(1, LogLevel.Information, "Placed Order: {order}")]
        public static partial void LogOrders(this ILogger logger, [LogProperties] Order order);
    }
    ```

1. In the editor, in the `CreateOrder` task, call the `LogOrders` method:

    ```csharp
    public async Task<bool> CreateOrder(Order order)
    {
        try
        {
            _logger.LogOrders(order);
    ```

    The above code calls the `LogOrders` method and passes it the current order information.

## Test the new redacted logging

With all the above code in place, the app can use the default redaction implementation to redact the `Order` information. You'll now test this.

1. On the **TERMINAL** pane at the bottom, go to the *dotnet-compliance/eShopLite* folder.

    ```bash
    cd ..
    ```

1. Update the apps containers.

    ```dotnetcli
    dotnet publish /p:PublishProfile=DefaultContainer 
    ```

1. Go to the *dotnet-compliance* folder, and start the app with Docker:

    ```bash
    cd ..
    docker compose up
    ```

1. Select the **PORTS** tab, then select the **Open in Browser** globe icon for the **Front End (32000)** port.
1. Select the **Products** link. Add some products to your shopping basket.
1. Select the **Buy Basket** button.
1. In the **TERMINAL** window, press <kbd>Ctrl</kbd>+<kbd>F</kbd>, in the search field enter **"EventId":1,**.

    ```json
    frontend-1  | {"EventId":1,"LogLevel":"Information","Category":"Store.Services.ProductService","Message":"Placed Order: DataEntities.Order","State":{"Message":"Microsoft.Extensions.Logging.ExtendedLogger\u002BModernTagJoiner","{OriginalFormat}":"Placed Order: {order}","order.Total":209.94,"order.Products":"[\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022]","order":"DataEntities.Order","order.CustomerAddress":"","order.CustomerName":"","order.Id":""}}
    ```

    You should see this JSON formatted log entry. Notice that the **order.Total** value is in the logs, but the **CustomerName** and **CustomerAddress** values are empty strings.

    By default, if you don't specify a redaction implementation, the redaction engine will use the `ErasingRedactor` implementation to ensure no sensitive data is leaked into the logs.
1. In the **TERMINAL** window, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

## Add a custom redaction implementation

You'll now enhance the redaction implementation to use different redaction algorithms for different types of data. First you'll add a new custom redaction implementation that replaces the value with `*****`.

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/DataEntities** folder, then select the **Compliance.cs** file.
1. In the editor, at the bottom of the file, add this code:

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

    The above code makes an `EShopCustomRedactor` redaction method available to the redaction engine.

## Choose which redaction implementation to use

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/Store** folder, then select the **Program.cs** file.
1. Replace `builder.Services.AddRedaction();` code to provide configuration for the redaction engine:

    ```csharp
    builder.Services.AddRedaction(configure =>
    {
        configure.SetRedactor<ErasingRedactor>(new DataClassificationSet(DataClassifications.EUPDataClassification));
        configure.SetRedactor<EShopCustomRedactor>(new DataClassificationSet(DataClassifications.EUIIDataClassification));
    });
    ```

    The above code configures the redaction engine to specifically use the `ErasingRedactor` implementation for EUP data and the new custom `EShopCustomRedactor` implementation for EUII data.

## Test the new redaction implementation

1. In the **TERMINAL** window, build and run the app:

    ```bash
    docker-compose up --build
    ```

1. Select the **PORTS** tab, then select the **Open in Browser** globe icon for the **Front End (32000)** port.
1. Select the **Products** link. Add some products to your shopping basket.
1. Select the **Buy Basket** button.
1. In the **TERMINAL** window, press <kbd>Ctrl</kbd>+<kbd>F</kbd>, in the search field enter **"EventId":1,**.

    ```json
    frontend-1  | {"EventId":1,"LogLevel":"Information","Category":"Store.Services.ProductService","Message":"Placed Order: DataEntities.Order","State":{"Message":"Microsoft.Extensions.Logging.ExtendedLogger\u002BModernTagJoiner","{OriginalFormat}":"Placed Order: {order}","order.Total":269.88,"order.Products":"[\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022,\u0022DataEntities.Product\u0022]","order":"DataEntities.Order","order.CustomerAddress":"*****","order.CustomerName":"*****","order.Id":""}}
    ```

    You should see this JSON formatted log entry. Notice that the **order.Id** value is still an empty string, but the **CustomerName** and **CustomerAddress** values are now `*****.`

1. In the **TERMINAL** window, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.
