Azure Machine Learning uses endpoints to perform inferencing. An endpoint is a stable and durable URL for requesting or invoking a model. Azure Machine Learning uses integration with Azure Monitor to track and monitor metrics and logs for online endpoints.

Like workspace monitoring, you can view metrics and logs for online endpoints directly from the Azure portal. Because online endpoints are separate resources in Azure, you need to open those resources directly from the Azure portal within the resource group that contains them.

The following example shows disk utilization and memory utilization of an endpoint.

![Screenshot of a monitoring dashboard for an Azure Machine Learning endpoint.](../media/online-endpoint.png)
