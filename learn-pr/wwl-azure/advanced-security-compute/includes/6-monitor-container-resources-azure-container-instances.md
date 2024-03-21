Azure Monitor provides insight into the compute resources used by your containers instances. This resource usage data helps you determine the best resource settings for your container groups. Azure Monitor also provides metrics that track network activity in your container instances.

## Preview limitations

At this time, Azure Monitor metrics are only available for Linux containers.

## Available metrics

Azure Monitor provides the following metrics for Azure Container Instances. These metrics are available for a container group and individual containers. By default, the metrics are aggregated as averages.

 -  CPU Usage measured in millicores.<br>
     -  One millicore is 1/1000th of a CPU core, so 500 millicores represents usage of 0.5 CPU core.
 -  Memory Usage in bytes.
 -  Network bytes received per second.
 -  Network bytes transmitted per second.

## Get metrics - Azure portal

When a container group is created, Azure Monitor data is available in the Azure portal. To see metrics for a container group, go to the Overview page for the container group. Here you can see pre-created charts for each of the available metrics.

In a container group that contains multiple containers, use a dimension to display metrics by container. To create a chart with individual container metrics, perform the following steps:<br>

1. In the **Overview** page, select one of the metric charts, such as **CPU**.<br>

2. Select the **Apply splitting** button, and select **Container Name**.
