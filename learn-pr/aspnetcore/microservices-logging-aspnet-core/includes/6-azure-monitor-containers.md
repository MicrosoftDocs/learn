In this exercise, you'll explore a cluster-level monitoring solution using Azure Monitor for Containers. This monitoring solution, along with Application Insights, focuses on more application-level information. The solution gives you a more complete view of your app and its operational context.

In this unit, you will:

- Enable Azure Monitor for Containers for your AKS cluster.
- Create a metric for the Prometheus endpoint.
- Reconfigure and redeploy the updated application to AKS.
- Create a basic graph for your custom metric using Azure Monitor.

## Enable Azure Monitor for Containers

Azure Monitor for Containers helps you understand the performance and health of your AKS cluster. For example, you can view the memory consumption of containers running on a specific node.

Run the following command in the command shell:

```azurecli
az aks enable-addons \
    --addons monitoring \
    --name eshop-learn-aks \
    --resource-group eshop-learn-rg \
    --query provisioningState
```

The preceding command may take a couple minutes to finish. It enables the monitor add-on for your AKS cluster, using the environment variables created by the AKS creation script. A variation of the following output appears:

```console
AAD role propagation done[############################################]  100.0000%"Succeeded"
```

## Monitor health of the AKS cluster

Monitor the AKS cluster's health by following these steps:

1. If needed, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same subscription used in previous units.
1. Use the search box to find and open the Kubernetes service resource named *:::no-loc text="eshop-learn-aks":::*.
1. Select the **Insights** option from the **Monitoring** section in the left side panel.

    The **Insights** panel defaults to the **Cluster** tab, which shows the overall health of the cluster. The other tabs provide more granular health statuses for the individual nodes and containers.

1. Select the **Live** toggle button to enable live monitoring.
1. After waiting about 30 seconds, hover over the horizontal **Running** line in the **Active pod count** chart.

    :::image type="content" source="../media/6-azure-monitor-containers/active-pod-count.png" alt-text="Active pod count chart for the AKS cluster" border="true" lightbox="../media/6-azure-monitor-containers/active-pod-count.png":::

    In the preceding screenshot, notice there are 27 pods in a running state.
1. Back in the command shell, run the following command to list all running pods:

    ```bash
    kubectl get pods -A
    ```

    The preceding command's output displays all 27 running pods in the AKS cluster.

## Implement a Prometheus metric

Prometheus is an open-source systems monitoring and alerting toolkit. Azure Monitor for Containers can be integrated with Prometheus to view app and workload metrics. The metrics are collected from nodes and Kubernetes using a query language called Kusto. Custom alerts and dashboards can be created to analyze performance details.

Complete the following steps to implement a counter metric for the request count on the catalog service:

1. Run the following command to install the Prometheus NuGet package in the catalog service project:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API/ && \
      dotnet add package prometheus-net.AspNetCore && \
      popd
    ```

1. Apply the following changes in *:::no-loc text="src/Services/Catalog/Catalog.API/Startup.cs":::*:
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

1. Run the following commands to build the catalog service and its dependencies:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API && \
        dotnet build --no-restore && \
        popd
    ```

    The build process bypasses restoration of NuGet packages and succeeds with no warnings. If the build fails, check the output for troubleshooting information.

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

1. In *:::no-loc text="deploy/k8s/helm-simple/catalog/templates/deployment.yaml":::*, uncomment the metadata `annotations` block. Save your changes.

    After the change, your file will resemble the following YAML snippet:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/catalog/templates/deployment.yaml" highlight="15-18":::

    The preceding change configures the catalog service metadata to indicate that Azure Monitor for Containers should scrape Prometheus metrics from the `/metrics` path on port 80.

1. Deploy the updated catalog service from ACR by running the following script:

    ```bash
    deploy/k8s/deploy-application.sh --charts catalog
    ```

    The preceding script deploys the container image from ACR to AKS. The script also runs the `kubectl get pods` command, whose output indicates the catalog service's pod is being created:

    ```console
    NAME                              READY   STATUS              RESTARTS   AGE
    catalog-ff5d8cbfc-69gxw           0/1     ContainerCreating   0          3s
    ```

## Enable Prometheus metrics scraping in the AKS cluster

Before Azure Monitor for Containers can scrape Prometheus metrics from the catalog service, Prometheus metrics scraping must be enabled in the AKS cluster. The [Azure Monitor Prometheus scraping configuration documentation](/azure/azure-monitor/insights/container-insights-prometheus-integration) provides a Kubernetes ConfigMap YAML template. The ConfigMap contains non-confidential data in key-value pairs and is used to apply Kubernetes configuration changes to AKS using the `kubectl` command.

For your convenience, the ConfigMap YAML template has been provided in *:::no-loc text="deploy/k8s/azure-monitor/container-azm-ms-agentconfig.yaml":::*.

1. Open the *ConfigMap* template in the Cloud Shell editor. Change the value of `monitor_kubernetes_pods` from `false` to `true`, as shown. Save your changes.

    ```yaml
    monitor_kubernetes_pods = true
    ```

1. Apply the ConfigMap to AKS with the following command:

    ```bash
    kubectl apply -f deploy/k8s/azure-monitor/container-azm-ms-agentconfig.yaml
    ```
  
    The preceding command applies the ConfigMap to your AKS cluster. The AKS cluster will now scrape Prometheus metrics from any service configured with the Prometheus annotations. Upon completion of the command, the following output appears:

    ```console
    configmap/container-azm-ms-agentconfig created
    ```

## Create some telemetry

Use the app to generate some requests to the catalog service. Open another browser tab if needed to complete the following steps.

1. If needed, run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

1. Verify the deployment has finished and the app is healthy using the **:::no-loc text="General application status":::** page.
1. When the app is healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app.
1. Navigate to the products catalog page, and refresh the page a few times.

## View the telemetry

With the changes you made in the previous section, the catalog service will create a counter that counts each incoming request. A separate count is maintained for each endpoint.

To troubleshoot a production issue, you've been asked to monitor requests for the full list of catalog items. The list of catalog items is retrieved from the catalog service via an HTTP GET request to the `/catalog-api/api/v1/catalog/items` endpoint. To view the current count of requests to that endpoint, complete the following steps:

1. In the Azure portal, use the search box at the top to find and open the Kubernetes service resource named *:::no-loc text="eshop-learn-aks":::*.
1. Select the **Logs** option in the **Monitoring** section on the left side panel.

    > [!NOTE]
    > If presented with a **Get Started** button, select it. If presented with an **Example queries** dialog, close it.

1. Paste the following Kusto query into the query area:

    ```kusto
    InsightsMetrics
    | where Name == "catalogapi_path_counter"
    | where parse_json(Tags).endpoint == "/catalog-api/api/v1/catalog/items"
    | top 1 by TimeGenerated desc
    | project TimeGenerated, Name, Val, Tags
    ```

    The preceding Kusto query retrieves the most recent row from the `InsightsMetrics` table where:

    - The `Name` column is `catalogapi_path_counter`.
    - The `endpoint` property stored in the `Tags` column is `/catalog-api/api/v1/catalog/items`.

1. Select the **Run** button.
1. In the **Results** panel, note the value of the `Val` column. This value represents the number of requests to `/catalog-api/api/v1/catalog/items`.
1. Select the chevron to expand the row. Select the chevron next to **Tags** to expand the `Tags` column. Notice the `endpoint` and `method` tags that were added by your changes in the previous section.

    :::image type="content" source="../media/6-azure-monitor-containers/expanded-log.png" alt-text="The expanded log entry" border="true" lightbox="../media/6-azure-monitor-containers/expanded-log.png":::

1. In the storefront app, browse the catalog items. Refresh the page to force a request to the catalog service.
1. Return to the Azure portal. After a couple minutes, select the **Run** button. Notice the count in the `Val` column reflects your activity browsing the catalog items.

    > [!NOTE]
    > The Prometheus metrics are scraped once per minute. Expect a delay before the new count is reflected in the logs.

In this unit, you enabled Azure Monitor for Containers in an existing AKS cluster. Next, you added Prometheus performance metric code to the catalog service and redeployed the service to AKS. To integrate Azure Monitor for Containers with Prometheus, you enabled Prometheus metrics scraping in the AKS cluster. Using a Kusto query in the Azure portal, you retrieved the Prometheus performance metric data&mdash;the number of requests to a specific catalog service endpoint.
