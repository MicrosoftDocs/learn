Having a general view of your cluster topology and state, and being able to drill into the details when needed, is a key feature to ensure your application supports the business in the best possible way.

In this exercise you'll explore a cluster-level monitoring solution using Azure Monitor for containers. This monitoring solution, along with Application Insights, focused on more application-level information, gives  you a much more complete view of your application and it's operational context.

In this exercise you will:

- Enable Azure Monitor for containers for your AKS cluster.
- Create a simple metric for the Prometheus endpoint.
- Reconfigure and redeploy the updated application to AKS.
- Create a basic graph for your custom metric using Azure Monitor.

## Enable Azure Monitor for containers

Just run the following script from the `deploy/k8s` folder:

```bash
./enable-azure-monitor-for-containers.sh
```

The above script enables the monitor addon for your AKS cluster, using the environment variables created by the AKS creation script. You should get an output like this:

:::image type="content" source="../media/enable-azure-monitor-for-containers.png" alt-text="Output from the enable-azure-monitor-for-containers script, showing the provisioning state as successful" border="true" lightbox="../media/enable-azure-monitor-for-containers.png":::

When the scripts finishes, usually in less than a couple of minutes, you should be able to monitor the cluster by navigating to the AKS resource in the Azure portal and then clicking the **Insights** option on the sidebar, under the **Monitoring** section:

:::image type="content" source="../media/aks-monitoring-insights.png" alt-text="AKS monitoring overview on Azure portal, showing CPU, memory utilization, and node & pod count" border="true" lightbox="../media/aks-monitoring-insights.png":::

Besides the general cluster dashboard, You can also explore any of the tabs to zoom in more details for the cluster, as shown in the next image:

:::image type="content" source="../media/media-aks-monitoring-containers.png" alt-text="AKS monitoring container details for the cluster" border="true" lightbox="../media/media-aks-monitoring-containers.png":::

## Create a simple metric for the Prometheus endpoint

For this exercise you'll implement a simple counter metric, for the request count on the Catalog microservice. To do so you will:

1. Install the Prometheus package
2. Add the custom metrics counter and the Prometheus middleware to the request pipeline.
3. Build the updated image to ACR

So let's get into the details:

### 1. Install the Prometheus package in the Catalog.API project

Run the following command from the `src/Services/Catalog/Catalog.API` folder:

```dotnetcli
dotnet add package prometheus-net.AspNetCore
```

### 2. Add the custom metrics counter and the Prometheus middleware to the request pipeline

You'll add some code here to:

- Generate the metric you want to get and
- The Prometheus middleware to expose the metrics.

Add the following to `Configure()` method in `Startup.cs`:

```csharp
using Prometheus;

namespace Microsoft.eShopOnContainers.Services.Catalog.API
{
    public class Startup
    {
        //...
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILoggerFactory loggerFactory)
        {
            // Create counter metric
            var counter = Metrics.CreateCounter("catalogapi_path_counter", "Counts requests to the Catalog API endpoints", new CounterConfiguration
            {
                LabelNames = new[] { "method", "endpoint" }
            });

            // Add middleware to track the counter
            app.Use((context, next) =>
            {
                counter.WithLabels(context.Request.Method, context.Request.Path).Inc();
                return next();
            });

            var pathBase = Configuration["PATH_BASE"];

            //...

            app.UseRouting();

            // Add Prometheus metrics server endpoint
            app.UseMetricServer();

            app.UseEndpoints(endpoints =>
            {
                //...
            });
            //...
        }
        //..
    }
}
```

The lines you have to add are commented out in the code, so they'll be easy to spot.

### 3. Build the image to ACR

Update your environment with the environment variables from the initial deployment, by running the following command:

```bash
eval $(cat ~/clouddrive/source/deploy-application-exports.txt)
```

Build the image of the updated microservice to ACR by running the following script:

```bash
./build-to-acr.sh --services catalog-api
```

You should see something like this:

:::image type="content" source="../media/build-to-acr-catalog-api.png" alt-text="Initial output from the build-to-acr script" border="true" lightbox="../media/build-to-acr-catalog-api.png":::

After two or three minutes you should get the confirmation that the image was built and pushed:

:::image type="content" source="../media/build-to-acr-catalog-api-end.png" alt-text="Final output from the build-to-acr script, showing the catalog.api image was built and pushed" border="true" lightbox="../media/build-to-acr-catalog-api-end.png":::

## Reconfigure and redeploy the updated application to AKS

Having finished the code changes, you just have to reconfigure and redeploy the Catalog microservice. To do that you will:

- Add the Prometheus annotations to the Catalog's pods.
- Redeploy the Catalog microservice.
- Enable Prometheus scraping in Azure Monitor for containers.

### 1. Add the Prometheus annotations

Prometheus has to be informed about the pods it's going to scrape looking for metrics. To do this you have to add the Prometheus annotations to the pods, by updating the Deployment Helm chart as shown next:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: catalog
  labels:
    app: eshop
    service: catalog
spec:
  replicas: 1
  selector:
    matchLabels:
      service: catalog
  template:
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/path: /metrics
        prometheus.io/port: "80"
      labels:
        app: eshop
        service: catalog
    spec:
      #...
```

You have to add the three annotations that begin with `prometheus.io`

### 2. Redeploy the updated and reconfigured Catalog microservice

You just need to run the following script:

```bash
./deploy-application.sh --charts catalog
```

### 3. Enable Prometheus metrics scraping for Azure Monitor for containers

As per the [Azure Monitor Prometheus scraping configuration](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-prometheus-integration), you have to:

Download the [`container-azm-ms-agentconfig.yaml`](https://github.com/microsoft/Docker-Provider/blob/ci_dev/kubernetes/container-azm-ms-agentconfig.yaml) configuration file and update line 71 to:

```yaml
monitor_kubernetes_pods = true
```

Then you have to apply it to the cluster.

The file has been already downloaded and updated, so you just have to run the following command from the `deploy/k8s` folder:

```bash
kubectl apply -f azure-monitor/container-azm-ms-agentconfig.yaml
```

From now on, all Prometheus metrics are being scraped by Azure Monitor.

## Create a graph for your custom metric

The implemented custom metric is counting all requests received by the Catalog microservice, even the health check requests. Because of this, you don't have to do anything to get values for this metric, just let the application be there for a few minutes. After about five minutes you can refresh several times the home page, to generate a few additional requests to the Catalog microservice.

You should now be ready to generate a graph for your custom metric.

To generate a custom graph for your metric, you have to:

- Create a query to get the required metrics.
- Generate a graph with the query data.

### 1. Create a query for the metric

Copy the [Kusto query](https://docs.microsoft.com/azure/data-explorer/kusto/query/) below because you'll use in just a few seconds:

```kusto
InsightsMetrics
| where Name == "catalogapi_path_counter"
```

Now in the Azure Portal, go to the resource group you created for this module and click on the AKS resource and then:

1. Click on the **Logs** option in the Monitoring section on the left side panel.
2. Paste the Kusto query above in the query area
3. Click the **Run** button

You should see something like the image below:

:::image type="content" source="../media/azure-monitor-for-containers-prometheus-metric-query.png" alt-text="Logs view showing the detailed sequence and the metric values output from the query" border="true" lightbox="../media/azure-monitor-for-containers-prometheus-metric-query.png":::

### 2. Generate a graph with the query data

To generate a graph from the above data you just have to:

1. Click on the **Chart** tab, just above the query result data.
2. Select the **Line** graph type.

You should something similar to the image below:

:::image type="content" source="../media/azure-monitor-for-containers-prometheus-metric-graph.png" alt-text="Graph tab from the query data" border="true" lightbox="../media/azure-monitor-for-containers-prometheus-metric-graph.png":::

In the image above you can see a straight ascending line, that corresponds to the health checks requests, that are received at a constant rate, hence the straight line. You can also see a sudden rise in the graph and then the straight raising line continuing at another level.

You don't get to see the spike you might have expected, because out custom metric is a counter, so it's always increasing.

Now that you have a graph for your metric, you could use the "**Pin to dashboard**" button in the top right, to include the graph in any dashboard you have write access to.

## Resources

- <https://medium.com/@dale.bingham_30375/net-core-web-api-metrics-with-prometheus-and-grafana-fe84a52d9843>
- <https://medium.com/@aevitas/expose-asp-net-core-metrics-with-prometheus-15e3356415f4>
- <https://prometheus.io/>
- <https://azure.microsoft.com/en-us/blog/azure-monitor-for-containers-with-prometheus-now-in-preview/>
