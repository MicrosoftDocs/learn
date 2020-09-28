For this exercise you'll make some code changes to the Catalog microservice to implement Application Insights. For some  other three microservices code changes are already implemented so you'll just have to handle the configuration.

In this exercise you will:

- Create an Azure Container Registry (ACR) instance in your subscription.
- Create Application Insights resources for the application.
- Enable logging to Application Insights.
- Deploy the updated/reconfigured microservices.
- Monitor your application from the Azure Portal.

## Create an ACR instance

We'll begin by setting up an ACR instance to build the images that AKS will use when deploying the updated microservice(s). That is, for this exercise AKS will pull the initial application images from the initial repository and the updated images from the ACR.

To create the ACR just run the following script from folder `deploy/k8s`:

```bash
./create-acr.sh
```

The script above creates the ACR and grants permission to AKS to pull images from the ACR.

You should get an output similar to this:

:::image type="content" source="../media/create-acr.png" alt-text="Output from the create-acr script" border="true" lightbox="../media/create-acr.png":::

## Create the Application Insights resources

Add the Application Insights extension to Azure CLI by running this command:

```azurecli
az extension add -n application-insights
```

Run the following script to create the Application Insights resources:

```bash
./create-application-insights.sh
```

The script above creates four Application Insights resources, in the resource group you created for this module.

You should get an output similar to this:

:::image type="content" source="../media/create-application-insights.png" alt-text="Output from the create-application-insights script" border="true" lightbox="../media/create-application-insights.png":::

In the image above you can see four key-value pairs with the instrumentation keys, ready to be pasted into the configmaps for the catalog, coupon, ordering, and webshoppingagg Helm charts..

All four configmap files:

- catalog/templates/configmap.yaml
- coupon/templates/configmap.yaml
- ordering/templates/configmap.yaml
- webshoppingagg/templates/configmap.yaml

should be changed as shown in this sample for the `catalog` chart:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: catalog-cm
  labels:
    app: eshop
    service: catalog
data:
  APPINSIGHTS_INSTRUMENTATIONKEY: dc8dd6fe-033d-4be9-ad89-3c208af91f12
  #...
```

>[!IMPORTANT]
>
> Keep in mind that you have to use a different instrumentation key for each microservice.

## Enable logging to Application Insights

To implement Application Insights in an application you have to:

1. Add the supporting packages
2. Register the Application Insights telemetry services in the DI container.
3. Add the Application Insights sink for Serilog to include log traces.
4. Build the new image for the updated microservice.

As mentioned you'll only have to do some of those in the Catalog microservice so let's get rolling on the `src/Services/Catalog/Catalog.API` folder:

1. **Add the Application Insights supporting packages**

   You'll need these three packages:

   - Microsoft.ApplicationInsights.AspNetCore - 2.12.1
   - Microsoft.ApplicationInsights.Kubernetes - 1.1.1
   - Serilog.Sinks.ApplicationInsights - 3.1.0

   You can install them with the Visual Studio UI or using the following commands on each of the projects:

   ```dotnetcli
   dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.12.1
   dotnet add package Microsoft.ApplicationInsights.Kubernetes --version 1.1.1
   dotnet add package Serilog.Sinks.ApplicationInsights --version 3.1.0
   ```

   The packages are already installed in the projects so you can skip this step.

2. **Register the telemetry services in the DI container**

    You have to register the following two services in `Startup.cs`:

    ```csharp
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddApplicationInsightsTelemetry(Configuration);
        services.AddApplicationInsightsKubernetesEnricher();
    }
    ```

    For the Catalog microservice that's already done in the `AddAppInsights()` extension method:

    ```csharp
    public static class CustomExtensionMethods
    {
        public static IServiceCollection AddAppInsight(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddApplicationInsightsTelemetry(configuration);
            services.AddApplicationInsightsKubernetesEnricher();

            return services;
        }
    }
    ```

3. **Add the Application Insights sink for Serilog**

    Open up Program.cs and make it like this:

    ```csharp
    using Microsoft.ApplicationInsights.Extensibility;
    //...

    namespace Microsoft.eShopOnContainers.Services.Catalog.API
    {
        public class Program
        {
            //...
            public static int Main(string[] args)
            {
              //...
            }

            private static IWebHost CreateHostBuilder(IConfiguration configuration, string[] args) =>
                //..

            private static Serilog.ILogger CreateSerilogLogger(IConfiguration configuration)
            {
                var seqServerUrl = configuration["Serilog:SeqServerUrl"];
                var logstashUrl = configuration["Serilog:LogstashgUrl"];
                var instrumentationKey = configuration["APPINSIGHTS_INSTRUMENTATIONKEY"];

                return new LoggerConfiguration()
                    .MinimumLevel.Verbose()
                    .Enrich.WithProperty("ApplicationContext", AppName)
                    .Enrich.FromLogContext()
                    .WriteTo.Console()
                    .WriteTo.ApplicationInsights(instrumentationKey, TelemetryConverter.Traces)
                    .WriteTo.Seq(string.IsNullOrWhiteSpace(seqServerUrl) ? "http://seq" : seqServerUrl)
                    .WriteTo.Http(string.IsNullOrWhiteSpace(logstashUrl) ? "http://logstash:8080" : logstashUrl)
                    .ReadFrom.Configuration(configuration)
                    .CreateLogger();
            }

            //...
        }
    }
    ```

    The lines you have to add are commented out so they'll be easy to spot.

>[!NOTE]
>
> Startup logging with Application Insights [isn't directly supported](https://docs.microsoft.com/aspnet/core/fundamentals/logging/#log-during-host-construction), so it must be accomplished by using other logger. For this example we're using Serilog with the Application Insights sink, passing the instrumentation key. Although this is the simplest way to enable logging to Application Insights during startup, it can lead to losing correlation between metrics and log traces.

1. **Build the new image for the Catalog microservice**

    You have to create a new image for the updated microservice, and you'll use the ACR instance you created at the beginning of the exercise for this.

    Begin by running this command to update your environment:

    ```bash
    eval $(cat ~/clouddrive/source/create-aks-exports.txt)
    ```

    Then run this script to build the Catalog microservice:

    ```bash
    ./build-to-acr.sh --services catalog-api
    ```

    The script starts an [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) and will take a little while to run. When it finishes you should see something like this:

    :::image type="content" source="../media/build-to-acr.png" alt-text="Output from the build-to-acr script" border="true" lightbox="../media/build-to-acr.png":::

    That shows the image was created successfully in the ACR.

2. **Build the WebAggregator microservice**

    The `WebAggregator` microservice has also been updated to include the Application Insights telemetry, but the changes are already implemented, so you just have to build the image to ACR, just like you did in the previous step, by running the following script:

    ```bash
    ./build-to-acr.sh --services webshoppingagg
    ```

3. **Redeploy the microservices**

    Since you updated the Catalog and the WebAggregatyor microservices and reconfigured the other two when updating their ConfigMaps, you'll now redeploy the Catalog and WebAggregator microservices using the images from ACR and the other two from the initial repository, **eshopdev**.

    Update the environment with the relevant environment variables from the initial deployment, by running this command.

    ```bash
    eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
    ```

    Deploy the updated Catalog microservice from the ACR by running this script:

    ```bash
    ./deploy-application.sh --charts catalog,webshoppingagg
    ```

    The above script takes the image repository from the `ESHOP_REGISTRY` variable, and you should see a message informing the image is being taken from a registry named like `eshoplearn20200717170233865.azurecr.io`.

    Now redeploy the other two microservices from the initial repository. Since they were just reconfigued, you can still use the original images.

    So just run this script:

    ```bash
    ./deploy-application.sh --registry eshopdev --charts coupon,ordering
    ```

    This time you should be informed that images are being taken from the `eshopdev` registry.

## Monitor your application from the Azure Portal

Once the deployment is complete and all services are up and available, as per the `webstatus` page, begin working with the application. Log out, log in, create something between five and ten orders, using discount coupons and without using them, and so on.

Now head to the Azure Portal and search for the resource group `eshop-learn-rg` or the name you used when beginning this module, and click on the `webshoppingagg-appinsights` resource and the click on the Live Metrics link.

You should see something like this:

:::image type="content" source="../media/webshoppingagg-live-metrics.png" alt-text="Azure portal showing the live metrics dashboard for the webshoppingagg-appinsights resource" border="true" lightbox="../media/webshoppingagg-live-metrics.png":::

In the image above you can see some sampled logging traces to the right, as well as some Incoming Request real-time graphics, showing the request rate, request duration and request failure rate. There's also information for outgoing request, that is, calling the dependencies. You can also see the overall health, with memory consumption, CPU utilization and exceptions rate.

The information above is overall, for all instances running the microservice, if you reconfigure the deployments to use more than one instance you'll be able to select one specific server from the list in the bottom of the dashboard, you'll see the server-specific metrics (There's only on server in this exercise).

Application Insights starts tracing all calls between the services and their dependencies, but it needs some minutes to show more information, that's the reason for asking you to use the application.

If you click on the `Application map` option in the left sidebar, you should see something like this:

:::image type="content" source="../media/application-insights-application-map.png" alt-text="Application map" border="true" lightbox="../media/application-insights-application-map.png":::

In the graph you can see that the services with Application Insights instrumentation are shown as green-circled nodes. The diagram shows the calls traced between the four microservices and other dependencies such as databases and other microservices that don't have Application Insights instrumentation, along with some information on the call volumes and response times.

You can also look at the log traces, with the Search option in the sidebar:

:::image type="content" source="../media/application-insights-search-log-traces.png" alt-text="Application Insights log traces search view" lightbox="../media/application-insights-search-log-traces.png":::

And can peek into the details of any trace:

:::image type="content" source="../media/application-insights-end-to-end-transaction-details.png" alt-text="TODO" border="true" lightbox="../media/application-insights-end-to-end-transaction-details.png":::
