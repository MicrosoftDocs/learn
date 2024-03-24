The current **:::no-loc text="eShopLite":::** app is using the default telemetry provided by OpenTelemetry. You can extend the telemetry by adding custom metrics and custom attributes to the telemetry data. This capability allows you to add more context to the telemetry data and to create more powerful queries in Application Insights.

In this exercise, you add new metrics to apps and see how to view them in your observability apps.

## Create a custom metric

You want to have greater visibility of how a stock changes over time, so you create a custom metric.

1. In Visual Studio Code, on the **EXPLORER** pane, right-click the *Products* folder and then select **New File**.

1. In the **File name** field, enter **ProductsMetrics.cs**.

1. In the text editor, replace the code with this example:

    ```csharp
    using System;
    using System.Diagnostics.Metrics;
    
    public class ProductsMetrics
    {
        private readonly Counter<int> _serviceCalls;
        private readonly Counter<int> _stockChange;
    
        public ProductsMetrics(IMeterFactory meterFactory)
        {
            var meter = meterFactory.Create("eShopLite.Products");
            _stockChange = meter.CreateCounter<int>("eshoplite.products.stock_change", unit: "{stock}", description: "Amount of stock being changed through the product service.");
        }
  
        public void StockChange(int quantity)
        {
            _stockChange.Add(quantity);
        }
    }
    ```

    The preceding code creates a new metric called `eshoplite.products.stock_change`. This metric tracks the amount of stock being changed through the product service.

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file.
1. On the **EXPLORER** pane, in the *Products* folder, select **Program.cs**.
1. Replace the `AddObservability` code with this code:

    ```csharp
    builder.Services.AddObservability("Products", builder.Configuration, ["eShopLite.Products"]);
    
    // Register the metrics service.
    builder.Services.AddSingleton<ProductsMetrics>();
    ```

    This code adds the `ProductsMetrics` class to the dependency injection container.

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file.
1. On the **EXPLORER** pane, in the *Products* folder, expand the *Endpoint* folder and then select **ProductEndpoints.cs**.
1. Replace the existing stock update `MapPut` endpoint with this code:

      ```csharp
      stock.MapPut("/{id}", async  (int id, int stockAmount, ProductDataContext db, ProductsMetrics metrics) =>
      {
          // Increment the stock change metric.
          metrics.StockChange(stockAmount);

          var affected = await db.Product
              .Where(model => model.Id == id)
              .ExecuteUpdateAsync(setters => setters
                .SetProperty(m => m.Stock, stockAmount)
              );

          return affected == 1 ? Results.Ok() : Results.NotFound();
      })      
      ```

      You use dependency injection to add the `ProductsMetrics` class to the endpoint. You're then calling the `StockChange` method to increment the metric with the new stock amount.

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file.

## Add the metric to OpenTelemetry

You now add the metric to OpenTelemetry so that it can be exported to your observability tools.

1. On the **EXPLORER** pane, in the *Diagnostics* folder, select **DiagnosticServiceCollectionExtensions**.
1. Change the `AddObservability` method to accept a new parameter:

    ```csharp
    public static IServiceCollection AddObservability(this IServiceCollection services,
        string serviceName,
        IConfiguration configuration,
        string[]? meeterNames = null)
    ```

1. Below the Prometheus exporter line, add this code:

    ```csharp
    .AddPrometheusExporter();

    // add any additional meters provided by the caller
    if (meeterNames != null)
    {
      foreach (var name in meeterNames)
      {
        metrics.AddMeter(name);
      }
    }
    ```

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file.

## View the new metric in Prometheus

1. On the **TERMINAL** pane at the bottom, go to the *dotnet-observability/eShopLite* folder.

    ```bash
    cd ..
    ```

1. Update the apps containers.

    ```dotnetcli
    dotnet publish /p:PublishProfile=DefaultContainer 
    ```

1. Go to the *dotnet-observability* folder, and start the app with Docker:

    ```bash
    cd ..
    docker compose up
    ```

1. Open the **:::no-loc text="eShopLite":::** app in a browser at `http://localhost:32000`.
1. Go to the **Products** page and change the stock amount on several products.
1. Open the **Prometheus** dashboard at `http://localhost:9090`.
1. In the search box, enter the`eshoplite_products_stock_change_total` metric and then select **Execute**.

    You should see it listed in a table.

1. Select the **Graph** tab. You should see the stock amount change over time.

    :::image type="content" source="../media/new-metric.png" alt-text="Screenshot that shows Prometheus showing the new custom metric on a graph."  lightbox="../media/new-metric.png":::

1. On the **TERMINAL** pane, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.