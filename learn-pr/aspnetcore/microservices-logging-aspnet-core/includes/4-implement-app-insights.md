In this unit, you'll make some code changes to the catalog service to implement Application Insights. For the other three microservices, code changes are already implemented so you'll just have to handle the configuration.

In this exercise, you will:

- Create Application Insights resources for the app.
- Enable logging to Application Insights.
- Deploy the updated/reconfigured microservices.
- Monitor your app from the Azure portal.

## Create the Application Insights resources

1. Add the Application Insights extension to Azure CLI by running this command:

    ```azurecli
    az extension add --name application-insights
    ```

1. Run the following commands to create the Application Insights resources:

    ```azurecli
    az configure --defaults group=eshop-learn-rg location=centralus && \
        az monitor app-insights component create --app catalog \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app coupon \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app ordering \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app webshoppingagg \
            --query '{Name:name, Key:instrumentationKey}'
    ```

    The preceding commands create four Application Insights resources, in the resource group you created for this module. A variation of the following output appears:

    ```console
    {
      "Key": "037fb7a1-2eb5-45e8-9193-806becc426f9",
      "Name": "catalog"
    }
    {
      "Key": "726d19a4-2493-4c03-bdc5-817f2a7a3ffa",
      "Name": "coupon"
    }
    {
      "Key": "0ac4010c-9ac4-47ae-80b3-16c4d1a7889b",
      "Name": "ordering"
    }
    {
      "Key": "c0cde760-d563-4534-9b4f-0eac68763d40",
      "Name": "webshoppingagg"
    }
    ```

    In the preceding output, you can see four key-value pairs with the instrumentation keys, ready to be pasted into the configmaps for the catalog, coupon, ordering, and webshoppingagg Helm charts.

1. In the *deploy/k8s/helm-simple* directory, uncomment the `APPINSIGHTS_INSTRUMENTATIONKEY` environment variable in each of the following files. Replace the `<key>` placeholder with the appropriate Application Insights instrumentation key. Save your changes.
    - *catalog/templates/configmap.yaml*
    - *coupon/templates/configmap.yaml*
    - *ordering/templates/configmap.yaml*
    - *webshoppingagg/templates/configmap.yaml*

    For example, update the `catalog` chart as follows:

    :::code language="yml" source="../code/deploy/k8s/helm-simple/catalog/templates/configmap.yaml" highlight="9":::

    > [!IMPORTANT]
    > Each microservice requires a different instrumentation key.

## Enable logging to Application Insights

Logging to Application Insights has been enabled in all services except for the catalog service. Complete the following steps to implement Application Insights in the catalog service, found in the *src/Services/Catalog/Catalog.API* directory.

1. Install the supporting Application Insights NuGet packages:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API/ && \
        dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.12.1 && \
        dotnet add package Microsoft.ApplicationInsights.Kubernetes --version 1.1.1 && \
        dotnet add package Serilog.Sinks.ApplicationInsights --version 3.1.0 && \
        popd
    ```

1. In *Extensions/ServiceCollectionExtensions.cs*, replace the comment `// Add AddAppInsights extension method` with the following extension method. Save your changes.

    :::code language="csharp" source="../code/src/services/catalog/catalog.api/extensions/servicecollectionextensions.cs":::

1. In the *Startup.cs* file's `ConfigureServices` method, invoke the `AddAppInsights` extension method. Save your changes.

    :::code language="csharp" source="../code/src/services/catalog/catalog.api/startup.cs" highlight="3":::

    The preceding code registers the telemetry services in the dependency injection container.

1. In *Program.cs*, apply the following changes to add the Application Insights sink for Serilog to include log traces:
    1. Add the highlighted code to the `CreateSerilogLogger` method:

        :::code language="csharp" source="../code/src/services/catalog/catalog.api/program.cs" highlight="5,12":::

    1. Uncomment the `//using Microsoft.ApplicationInsights.Extensibility;` line. Save your changes.

        The preceding change resolves the `WriteTo.ApplicationInsights` method call in the previous step.

> [!NOTE]
> Startup logging with Application Insights [isn't directly supported](/aspnet/core/fundamentals/logging/#log-during-host-construction), so it must be accomplished by using another logger. This example uses Serilog with the Application Insights sink, passing the instrumentation key. Although this is the simplest way to enable logging to Application Insights during startup, it can lead to losing correlation between metrics and log traces.

## Build and deploy modified container images

In the previous section, you modified the catalog service to include Application Insights telemetry. The web aggregator service included in the sample code has already been modified to log telemetry. To update the production deployments of these services, the container images will be built and hosted on ACR.

1. Run this script to build the catalog and web aggregator images:

    ```bash
    deploy/k8s/build-to-acr.sh --services catalog-api,webshoppingagg
    ```

    The script starts [ACR quick tasks](/azure/container-registry/container-registry-tasks-overview#quick-task) for each service. Each service's container image is built independently. Variations of the following lines acknowledge that the catalog and web aggregator Docker images were pushed to ACR:

    ```console
    2020/09/30 20:51:57 Successfully pushed image: eshoplearn20200929194132362.azurecr.io/catalog.api:linux-latest
    ```

    ```console
    2020/09/30 20:54:15 Successfully pushed image: eshoplearn20200929194132362.azurecr.io/webshoppingagg:linux-latest
    ```

1. Deploy the updated catalog and web aggregator services from ACR by running this script:

    ```bash
    deploy/k8s/deploy-application.sh --charts catalog,webshoppingagg
    ```

    The preceding script deploys the container images from ACR to AKS.

1. Redeploy the coupon and ordering services configured with their new `APPINSIGHTS_INSTRUMENTATIONKEY` environment variables:

    ```bash
    deploy/k8s/deploy-application.sh --registry eshopdev --charts coupon,ordering
    ```

    The coupon and ordering services deployed by the setup script are already instrumented for telemetry. Since there were no code changes. The containers only need redeployment with the new configuration settings. The `--registry` parameter instructs the script to use the Docker Hub registry that hosts the unmodified images.

In the next unit, you'll examine the telemetry in Application Insights.
