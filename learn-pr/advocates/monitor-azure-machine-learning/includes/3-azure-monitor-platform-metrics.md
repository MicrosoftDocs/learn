Azure Monitor collects and aggregates metrics from every component of Azure Machine Learning by default. Azure Monitor platform metrics provide a view of availability, performance, and resilience.

Azure Monitor uses the concept of *resource types* to identify Azure resources. Resource types are also part of the resource ID for every resource running in Azure. For example, one resource type for Azure Machine Learning is **Microsoft.MachineLearningServices/workspaces**.

Azure Monitor organizes core monitoring data into metrics on resource types, also called *namespaces*. Metrics and logs are available for various resource types. The metric categories in the **Microsoft.MachineLearningServices/workspaces** resource are **Model**, **Quota**, **Resource**, **Run**, and **Traffic**. Quota information is for Machine Learning compute only. The **Run** category provides information on training runs for the workspace.

You can use that data to analyze the performance of your Azure Machine Learning environment. For example, if you want to check how many cores a workspace is consuming:

1. In the Azure portal, open the Azure Machine Learning resource.

1. On the left menu, expand **Monitoring** and select **Metrics**.

1. On the chart, make sure that **Scope** is set to the Azure Machine Learning resource. Make sure that **Metric Namespace** is set to the namespace of the resource. (You might need to select **Add metric** if no options appear in the graph.)

1. Under **Metric**, scroll down to **Quota** > **Total Cores**.

   ![Screenshot of the metrics dashboard in the Azure portal.](../media/metrics-dashboard.png)

1. Adjust the details of the chart to match your needs, such as time range, time granularity, and aggregation. You can also add more metrics to the same chart for correlation.
