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

When a container group is created, Azure Monitor data is available in the Azure portal. To see metrics for a container group, go to the **Overview** page for the container group. Here you can see pre-created charts for each of the available metrics.

:::image type="content" source="../media/azure-portal-container-image-metrics-example-fecb0bd4.png" alt-text="Screenshot showing an example of how to view container metrics in the Azure portal.":::
<br>

In a container group that contains multiple containers, use a dimension to display metrics by container. To create a chart with individual container metrics, perform the following steps:<br>

1. In the **Overview** page, select one of the metric charts, such as **CPU**.<br>

2. Select the **Apply splitting** button, and select **Container Name**.

:::image type="content" source="../media/azure-monitoring-metrics-dimension-41c30912.png" alt-text="Screenshot showing an example of how to create a chart with individual container metrics.":::


## Get metrics - Azure CLI

Metrics for container instances can also be gathered using the Azure CLI. First, get the ID of the container group using the following command. Replace `<resource-group>` with your resource group name and `<container-group>` with the name of your container group.

```azurecli
CONTAINER_GROUP=$(az container show --resource-group <resource-group> --name <container-group> --query id --output tsv)
```

Use the following command to get **CPU** usage metrics.

```azurecli
az monitor metrics list --resource $CONTAINER_GROUP --metric CPUUsage --output table
```

**Output**

```azurecli
Timestamp            Name      Average
-------------------  ---------  ---------
2020-12-17 23:34:00  CPU Usage
. . .
2020-12-18 00:25:00  CPU Usage
2020-12-18 00:26:00  CPU Usage  0.4
2020-12-18 00:27:00  CPU Usage  0.0
```

Change the value of the `--metric` parameter in the command to get other supported metrics. For example, use the following command to get **memory** usage metrics.

```azurecli
az monitor metrics list --resource $CONTAINER_GROUP --metric MemoryUsage --output table
```

**Output**

```azurecli
Timestamp            Name          Average
-------------------  ------------  ----------
2019-04-23 22:59:00  Memory Usage
2019-04-23 23:00:00  Memory Usage
2019-04-23 23:01:00  Memory Usage  0.0
2019-04-23 23:02:00  Memory Usage  8859648.0
2019-04-23 23:03:00  Memory Usage  9181184.0
2019-04-23 23:04:00  Memory Usage  9580544.0
2019-04-23 23:05:00  Memory Usage  10280960.0
2019-04-23 23:06:00  Memory Usage  7815168.0
2019-04-23 23:07:00  Memory Usage  7739392.0
2019-04-23 23:08:00  Memory Usage  8212480.0
2019-04-23 23:09:00  Memory Usage  8159232.0
2019-04-23 23:10:00  Memory Usage  8093696.0
```

For a multi-container group, the `containerName` dimension can be added to return metrics per container.

```azurecli
az monitor metrics list --resource $CONTAINER_GROUP --metric MemoryUsage --dimension containerName --output table
```

**Output**

```azurecli
Timestamp            Name          Containername            Average
-------------------  ------------  --------------------  -----------
2019-04-23 22:59:00  Memory Usage  aci-tutorial-app
2019-04-23 23:00:00  Memory Usage  aci-tutorial-app
2019-04-23 23:01:00  Memory Usage  aci-tutorial-app      0.0
2019-04-23 23:02:00  Memory Usage  aci-tutorial-app      16834560.0
2019-04-23 23:03:00  Memory Usage  aci-tutorial-app      17534976.0
2019-04-23 23:04:00  Memory Usage  aci-tutorial-app      18329600.0
2019-04-23 23:05:00  Memory Usage  aci-tutorial-app      19742720.0
2019-04-23 23:06:00  Memory Usage  aci-tutorial-app      14786560.0
2019-04-23 23:07:00  Memory Usage  aci-tutorial-app      14651392.0
2019-04-23 23:08:00  Memory Usage  aci-tutorial-app      15470592.0
2019-04-23 23:09:00  Memory Usage  aci-tutorial-app      15450112.0
2019-04-23 23:10:00  Memory Usage  aci-tutorial-app      15339520.0
2019-04-23 22:59:00  Memory Usage  aci-tutorial-sidecar
2019-04-23 23:00:00  Memory Usage  aci-tutorial-sidecar
2019-04-23 23:01:00  Memory Usage  aci-tutorial-sidecar  0.0
2019-04-23 23:02:00  Memory Usage  aci-tutorial-sidecar  884736.0
2019-04-23 23:03:00  Memory Usage  aci-tutorial-sidecar  827392.0
2019-04-23 23:04:00  Memory Usage  aci-tutorial-sidecar  831488.0
2019-04-23 23:05:00  Memory Usage  aci-tutorial-sidecar  819200.0
2019-04-23 23:06:00  Memory Usage  aci-tutorial-sidecar  843776.0
2019-04-23 23:07:00  Memory Usage  aci-tutorial-sidecar  827392.0
2019-04-23 23:08:00  Memory Usage  aci-tutorial-sidecar  954368.0
2019-04-23 23:09:00  Memory Usage  aci-tutorial-sidecar  868352.0
2019-04-23 23:10:00  Memory Usage  aci-tutorial-sidecar  847872.0
```
