Let's start with an introduction to Azure Monitor. This overview will help you understand what Azure Monitor is and why it is an important part of your Azure deployments.

## What is monitoring?
Monitoring is a task that involves collecting and reviewing data about the activity of some process or behavior. In the world of Azure, monitoring is used to collect insights into the operation, performance, and behavior of your applications and services.

You can perform monitoring as a near real-time event or review the data later. Metrics can also be reviewed later as they are stored for 93 days by default. Whatever your preferred method, Azure Monitor is ready to help you collect the necessary information that you need.

:::image type="content" source="../media/monitoring.png" alt-text="Depiction of data sources on the left feeding into a metrics and/or log database destinations on the right.":::

## Azure Monitor definition
Azure Monitor is a service for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. Azure Monitor is used by IT Operations, DevOps, and developer teams to maximize the availability and performance of applications and services.

Azure Monitor provides a broad set of capabilities with a varying set of prerequisites depending on your specific monitoring goal. On one end of the spectrum, getting started with Azure Monitor metrics requires no incoming experience because metric collection is on by default for Azure resources. Viewing metrics in Metric Explorer is straightforward in the Azure portal UI. However, when using Azure Monitor Log Analytics for trend analysis and pattern recognition, familiarity with query languages would be helpful.

Key aspects of Azure Monitor are:

* Azure Monitor can collect performance and availability telemetry for all of the layers in your stack, from applications, infrastructure, the Azure platform, and any custom sources you integrate.

* Storage of the collected data in one of two data stores, Azure Monitor Metrics for numerical time-series values and Azure Monitor Logs for storing log data.

* Azure Monitor metrics are automatically collected and stored for Azure resources, but user configuration is required to send and store resource logs in Azure Monitor Logs.

* Azure Monitor includes Insights, which are out-of-the box monitoring and troubleshooting experiences for Azure resources. Available Insights include Azure Monitor VM insights, Azure Monitor application insights, and Azure Monitor container insights.

* Azure Monitor can be used to visualize data with workbooks and dashboards as well as analyze data with custom charts and analytics. Azure Monitor enables you to receive notification and take automated action based on performance and availability criteria.

:::image type="content" source="../media/azure-monitor.png" alt-text="Azure monitor capabilities showing data sources feeding into metrics and logs, providing insights, visualizations, and analysis options from the data collected.":::

## How to monitor your web application
Evaluating performance of a web application requires monitoring where, and when, the web app experiences demand. For the back-to-school campaign, we want to evaluate the impact on user demand. Azure Monitor can collect performance and availability telemetry for all of the layers in your stack, from applications, infrastructure, the Azure platform, and any custom sources you integrate.

Azure Monitor is enabled by default. As soon as you create an Azure subscription and start adding resources, such as web apps, Azure Monitor starts collecting data. Activity logs record when resources are created or modified. You can use the information in the activity logs to trace the history of the resource creation and modifications. Metrics tell you how the resource is performing and any other resources that it's consuming.

As an example, the **Contoso-web-sales Metrics** chart displayed below, demonstrates the ability to select the **Requests** metric for our web app. The chart displays the sum aggregation of the requests for the web app, using a line chart format. The list of metrics is available automatically for your resource. There is no requirement to install other software or services. You find Metrics under the Monitoring category in each resource panel that you have in your Azure subscription.

:::image type="content" source="../media/web-app-metrics.png" alt-text="Depiction of the Monitoring option selected in the Azure portal for a web app, showing chart of requests for the web app.":::
