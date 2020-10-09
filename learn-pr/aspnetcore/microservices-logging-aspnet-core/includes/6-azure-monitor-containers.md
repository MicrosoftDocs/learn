In this exercise, you'll explore a cluster-level monitoring solution using Azure Monitor for containers. This monitoring solution, along with Application Insights, focuses on more application-level information. The solution gives you a more complete view of your app and its operational context.

In this exercise, you will:

- Enable Azure Monitor for containers for your AKS cluster.
- Create a metric for the Prometheus endpoint.
- Reconfigure and redeploy the updated application to AKS.
- Create a basic graph for your custom metric using Azure Monitor.

## Enable Azure Monitor for containers

Azure Monitor for containers helps you understand the performance and health of your AKS cluster. For example, you can view processor and memory usage of containers running on a specific node.

Run the following script from the *deploy/k8s* directory:

```azurecli
az aks enable-addons \
    --addons monitoring \
    --name eshop-learn-aks \
    --resource-group eshop-learn-rg \
    --query provisioningState
```

The preceding script may take a couple minutes to finish. It enables the monitor add-on for your AKS cluster, using the environment variables created by the AKS creation script. A variation of the following output appears:

```console
AAD role propagation done[############################################]  100.0000%"Succeeded"
```

You can monitor the cluster by navigating to the AKS resource in the Azure portal and then clicking the **Insights** option on the sidebar, under the **Monitoring** section:

:::image type="content" source="../media/aks-monitoring-insights.png" alt-text="AKS monitoring overview on Azure portal, showing CPU, memory utilization, and node & pod count" border="true" lightbox="../media/aks-monitoring-insights.png":::

Besides the general cluster dashboard, you can also explore any tab to view more cluster details, as shown in the following image:

:::image type="content" source="../media/media-aks-monitoring-containers.png" alt-text="AKS monitoring container details for the cluster" border="true" lightbox="../media/media-aks-monitoring-containers.png":::

## Create a metric for the Prometheus endpoint

Azure Monitor for containers can be integrated with Prometheus to view app and workload metrics. The metrics are collected from nodes and Kubernetes using Kusto queries to create custom alerts and dashboards.

Complete the following steps to implement a counter metric for the request count on the catalog service:

1. Run the following command to install the Prometheus NuGet package in the catalog service project:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API/ && \
      dotnet add package prometheus-net.AspNetCore && \
      popd
    ```

1. Apply the following changes in *src/Services/Catalog/Catalog.API/Startup.cs*:
    1. In the `Configure` method, replace the comment `// Add the counter code` with the following code:

        ```csharp
        var counter = Metrics.CreateCounter(
            "catalogapi_path_counter",
            "Counts requests to the Catalog API endpoints",
            new CounterConfiguration
            {
                LabelNames = new[] { "method", "endpoint" }
            });

        app.Use((context, next) =>
        {
            counter.WithLabels(context.Request.Method, context.Request.Path).Inc();
            return next();
        });
        ```

        The preceding code defines a custom metrics counter that tracks every request to the catalog service.

    1. Also in the `Configure` method, replace the comment `// Add the metrics server middleware` with the following code:

        ```csharp
        app.UseMetricServer();
        ```

        The preceding code adds the metric server middleware to the catalog service's request pipeline. The Prometheus metrics are made available at the default `/metrics` endpoint.

    1. Uncomment the `//using Prometheus;` line at the top of the file. Save your changes.

        The preceding code resolves the calls to `Metrics.CreateCounter` and `UseMetricServer`.

1. Run the following commands to build the catalog service:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API && \
        dotnet build && \
        popd
    ```

    The build succeeds with no warnings. If the build fails, check the output for troubleshooting information.

1. The updated catalog service must be built on ACR. Run this script to build the catalog image:

    ```bash
    deploy/k8s/build-to-acr.sh --services catalog-api
    ```

    The script starts an ACR quick task. A variation of the following line confirms that the catalog service's Docker image was pushed to ACR:

    ```console
    2020/09/30 20:51:57 Successfully pushed image: eshoplearn20200929194132362.azurecr.io/catalog.api:linux-latest
    ```

## Reconfigure and deploy the updated app to AKS

The Docker image in ACR has been updated. A configuration change to the Helm chart is required before the service is redeployed. Complete the following steps:

1. In *deploy/k8s/helm-simple/catalog/templates/deployment.yaml*, uncomment the metadata `annotations` block. Save your changes.

    After the change, your file will resemble the following YAML snippet:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/catalog/templates/deployment.yaml" highlight="15-18":::

    The preceding change configures the catalog service metadata to indicate that Azure Monitor for containers should scrape Prometheus metrics from the `/metrics` path on port 80.

1. Deploy the updated catalog service from ACR by running the following script:

    ```bash
    deploy/k8s/deploy-application.sh --charts catalog
    ```

    The preceding script deploys the container image from ACR to AKS. The script also runs the `kubectl get pods` command, whose output indicates the catalog service's pod is being created:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    catalog-ff5d8cbfc-69gxw           0/1     ContainerCreating   0          3s
    ```

## Enable Prometheus metrics scraping for Azure Monitor for containers

Before Azure Monitor for containers can scrape Prometheus metrics from the catalog service, the Prometheus scraping must be enabled in the AKS cluster. The [Azure Monitor Prometheus scraping configuration](/azure/azure-monitor/insights/container-insights-prometheus-integration) provides a Kubernetes ConfigMap YAML template. It enables users to apply Kubernetes configuration changes to AKS using the `kubectl` command.

For your convenience, the ConfigMap YAML template has been provided as *deploy/k8s/azure-monitor/container-azm-ms-agentconfig.yaml*.

1. Open the template in the Cloud Shell editor and set the value of the `monitor_kubernetes_pods` to `true`, as shown. Save your changes.

    ```yaml
    monitor_kubernetes_pods = true
    ```

1. Apply the ConfigMap to AKS with the following command:

    ```bash
    kubectl apply -f deploy/k8s/azure-monitor/container-azm-ms-agentconfig.yaml
    ```
  
    The preceding applies the ConfigMap to your AKS cluster. The AKS cluster will now scrape Prometheus metrics from any service configured with the Prometheus annotations.

## Create some log entries

Use the app to generate some log data to examine. Open another browser tab if needed to complete the following steps.

1. If needed, run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/5-monitor-app-insights/health-check.png" alt-text="Health check page" border="true" lightbox="../media/5-monitor-app-insights/health-check.png":::

    > [!NOTE]
    > While the app is starting, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

## View logs

1. If needed, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same subscription used in previous units.
1. Use the search box to find and open the Kubernetes service resource named *eshop-learn-aks*.
1. Select the **Logs** option in the **Monitoring** section on the left side panel.
1. Paste the following Kusto query into the query area:

    ```kusto
    InsightsMetrics
    | where Name == "catalogapi_path_counter"
    | where parse_json(Tags).endpoint == "/catalog-api/api/v1/catalog/items"
    | order by TimeGenerated desc
    ```

1. Select the **Run** button.

