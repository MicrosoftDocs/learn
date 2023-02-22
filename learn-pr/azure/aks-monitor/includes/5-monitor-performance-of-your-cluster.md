In this exercise, you’ll walk through different features of Container insights to view the performance and status of different components of your monitored cluster. This is just a sample of the different options that are available to give you a complete picture of the health and performance of your cluster.

1. Click on **Containers** and then **Monitored clusters.** Your cluster should now appear in this list with a health status of the cluster and its nodes and pods. 

    :::image type="content" source="../media/image5.png" lightbox="../media/image5.png" alt-text="Screenshot of monitored clusters tab in Container insights." border="true":::

2. Click on your cluster to view its performance in more detail. Start with the **Cluster** page, which shows you performance graphs for the cluster itself. This page has a high-level view with key cluster resources such as CPU and Memory utilization to help you gauge whether you are using too much or too little, and need to scale up or down. 
1. Change the **Time range** at the top of the screen to change the time window for the displayed data. You may want to view data older than the default or target the graph to a smaller time window.

    :::image type="content" source="../media/image6.png" lightbox="../media/image6.png" alt-text="Screenshot of cluster tab in Container insights." border="true":::

4. Click **Live** to change from a past time interval to live data being collected every few seconds. This same data is being stored by Container insights as it’s being collected.
1. Select the **Nodes** tab to view each of the nodes for the cluster. The row hierarchy follows the Kubernetes object model, which starts with a node in your cluster. 
1. Click **Metric** at the top of the page and select **Memory working set (computed from Capacity)**.
1. Hover over one of the trend lines to show the detailed value of how much memory is being used in comparison to what is available. This will help you gauge how efficiently the nodes resources are being used which will highlight underutilized or overutilized nodes.

    :::image type="content" source="../media/image8.png" lightbox="../media/image8.png" alt-text="Screenshot of performance trend line on node tab in Container insights." border="true":::

2. Expand the node to view one or more pods running on it. If more than one container is grouped to a pod, they're displayed as the last row in the hierarchy. This page will allow you to drill into a specific node to see what is running on that node and potentially taking up all the Node CPU and Memory resources.
 
The icons in the status field indicate the online statuses of pods.

   :::image type="content" source="../media/image9.png" lightbox="../media/image9.png" alt-text="Screenshot of cluster tab in Container insights." border="true":::



4. Go to the **Containers** tab and then do a search for _contoso-website_. This is the container for the application workload in the sample application. This page will allow you to look at an individual pod and the resources it is using, along with the container logs.
5. Select the _contoso-website_ container so you can view its properties pane.
6. Select **Live Logs** for the container, which displays the real time log data for your application container. You may need to generate some traffic to generate log data to view.

    :::image type="content" source="../media/image15.png" lightbox="../media/image15.png" alt-text="Screenshot of live log data on Containers tab in Container insights." border="true":::