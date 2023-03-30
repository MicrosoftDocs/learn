In this exercise, you’ll walk through different features of Container insights to view the performance and status of different components of your monitored cluster. This is just a sample of the different options that are available to give you a complete picture of the health and performance of your cluster.

1. Select **Containers** and then **Monitored clusters.** Your cluster appears in the list with the health status of the cluster, its nodes and pods.  

    :::image type="content" source="../media/4-monitored-clusters.png" lightbox="../media/monitored-clusters.png" alt-text="Screenshot showing monitored clusters tab in Container insights.":::

1. Select your cluster to view its performance in more detail. Start with the **Cluster** page, which shows you performance graphs for the cluster itself. This page has a high-level view with key cluster resources such as CPU and Memory utilization to help you gauge whether you are using too much or too little, and need to scale up or down.
1. Change the **Time range** at the top of the screen to change the time window for the displayed data. You may want to view data older than the default or target the graph to a smaller time window.
1. Select **Live** to change from a past time interval to live data being collected every few seconds. This data is being stored by Container insights as it’s being collected.

     :::image type="content" source="../media/5-container-insights-cluster.png" lightbox="../media/5-container-insights-cluster.png" alt-text="Screenshot showing the cluster tab in Container insights.":::

1. Select the **Nodes** tab to view each of the nodes for the cluster. The row hierarchy follows the Kubernetes object model, which starts with a node in your cluster.

     The icons in the **Status** column indicate the online statuses of the pods.
1. From the **Metric** dropdown field at the top of the page and select **Memory working set (computed from Capacity)**.

1. Hover over one of the metric trend charts to show the detailed memory working set in use, compared to the defined limit. This helps you gauge how efficiently the nodes resources are being used, which highlights underutilized or overutilized nodes.

    :::image type="content" source="../media/5-container-insights-node.png" lightbox="../media/5-container-insights-node.png" alt-text="A screenshot showing the node tab in Container insights.":::  

1. Expand a node to view the pods running on that node. 

1. Exapnd a pod to see the containers grouped into the pod, they're displayed as the last row in the hierarchy.  

    Use this page to drill into a specific node to see what's running on that node and consuming Node CPU and Memory resources.

    :::image type="content" source="../media/5-container-insights-node-expanded.png" lightbox="../media/5-container-insights-node-expanded.png" alt-text="Screenshot of cluster tab in Container insights.":::

1. Go to the **Containers** tab and then search for *contoso-website*. This is the container for the application workload in the sample application. This page shows you an individual pod and the resources it is using, along with the container logs.

1. Select the **contoso-website** container to view its properties pane.

1. Select **Live Logs**  to display the real time log data for the container. You may need to generate some traffic to generate log data to view.

    :::image type="content" source="../media/5-containers-live-logs.png" lightbox="../media/5-containers-live-logs.png" alt-text="Screenshot of live log data on Containers tab in Container insights.":::
