Log Analytics is an Azure tool for retrieving or visualizing the log data in Azure Monitor Logs. Azure Private 5G Core allows you to use Log Analytics to remotely monitor sites in a private mobile network. To do the monitoring, configure the packet core instance at each site to stream its log data to the Log Analytics workspace, and then use queries to retrieve the log data. You can also create dashboards that visualize the query data.

> [!NOTE]
> Log Analytics is part of Azure Monitor and is chargeable. In addition, currently you can only use Log Analytics to monitor private mobile networks that support 5G UEs. If you don't want to incur any costs or if you want to use 4G UEs, use other monitoring tools instead.

Log Analytics is helpful for enterprises with multiple sites in their private mobile networks. For example, the network operation manager of an enterprise can monitor geographically dispersed sites centrally from the headquarter of the enterprise.

In this unit, we'll go through basic tasks in using Log Analytics to monitor a private mobile network. After learning, you should be able to set up Log Analytics for packet core instances in a private mobile network, and use it to monitor the network.

## Enable Log Analytics for a packet core instance

To monitor a site in a private mobile network, first enable Log Analytics for the packet core instance at the site. You'll need to enable Log Analytics from both the cloud and the Kubernetes cluster.

Before starting the enablement process, get ready with the following items:

- Cloud resource and access permission:
  - The name of the Kubernetes-Azure Arc resource that represents the Azure Arc-enabled Kubernetes cluster on which your packet core instance is running.
  - You must have the Contributor role assignment on the Azure subscription that contains the Kubernetes-Azure Arc resource.
- Local access permission:
  - Your local machine needs to have admin kubectl access to the Azure Arc-enabled Kubernetes cluster on which your packet core instance is running.
  > [!TIP]
  > For this access, your trials engineer can help you get an admin `kubeconfig` file.

The enablement steps are as follows:

1. Create an Azure Monitor extension for the Azure Arc-enabled Kubernetes cluster and deploy it to the cluster. This step allows Azure Monitor to connect to the cluster.
  
  Follow the detailed instructions in [Azure Monitor Container Insights for Azure Arc-enabled Kubernetes clusters](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters) to create and deploy the extension.

  > [!NOTE]
  >
  > - Use Azure CLI for this step.
  > - In the "Create extension instance" step, make sure that you choose **Option 4 - On Azure Stack Edge**.

1. Configure and deploy a ConfigMap. This step allows the packet core instance to stream its log data to the Log Analytics workspace.
  
  For detailed instructions, see [Configure and deploy the ConfigMap](/azure/private-5g-core/enable-log-analytics-for-private-5g-core).

> [!TIP]
>
> - All the sites in a private mobile network share the same Log Analytics workspace.
> - You need to enable Log Analytics for each site in a private mobile network separately.

## Use queries to retrieve log data

Once Log Analytics is enabled for a site, the packet core at the site starts to stream its log data to the Log Analytics workspace. You can use queries to retrieve relevant data from the workspace. For example, you might want to check the data of a particular traffic type or the data from a particular UE.

To create a query, open the Log Analytics workspace you assigned to the Kubernetes cluster. Select **Log** from the left-hand menu. In the Log Analytics tool that is displayed, enter your query, as shown below:

:::image type="content" source="../media/log-analytics-tool.png" alt-text="A screenshot showing the query creation interface of Log Analytics" border="true":::

You need to use the Kusto query language (KQL) to create queries in Log Analytics. For details about KQL, see [Get started with log queries in Azure Monitor](/azure/azure-monitor/logs/get-started-queries).

Each packet core instance streams [several logs](/azure/private-5g-core/monitor-private-5g-core-with-log-analytics) to the Log Analytics workspace. When you construct a query, you need to specify the relevant log name, such as `amf_registered_subscribers` or `amfcc_n1_auth_reject`.

After creating queries, you can use the Log Analytics dashboards to visualize query results. The [Use dashboards to visualize query results](#use-dashboards-to-visualize-query-results) section describes the process.

> [!TIP]
> If you have multiple sites in a private mobile network, you may want to restrict query results to a specific site. To do that, select the cluster on which the relevant packet core instance is running when you specify the scope of the query.

## Use dashboards to visualize query results

The Log Analytics dashboards can visualize all your saved log queries, giving you the ability to find, correlate, and share data about your private mobile network. You can use the dashboards to monitor important Key Performance Indicators (KPIs) for your private mobile network's operation, including throughput and the number of connected devices.

The following dashboard shows a dashboard with several charts providing information on important KPIs:

:::image type="content" source="../media/ap5gc-overview-dashboard.png" alt-text="A screenshot showing a Log Analytics dashboard that displays several charts" border="true":::

For instructions in creating the Log Analytics dashboards, see [Creating and sharing dashboards of Log Analytics data](/azure/azure-monitor/visualize/tutorial-logs-dashboards).

> [!TIP]
> Log Analytics will ingest an average of 1.4 GB of data a day from each packet core instance. To estimate the cost of using Log Analytics, see [Azure Monitor cost and usage](/azure/azure-monitor/usage-estimated-costs).

## Best practices for monitoring with Log Analytics

Follow these best practices when you design or implement your monitoring solution with Log Analytics:

- All the sites in a private mobile network share the same Log Analytics workspace. Restrict the scope of a query to a specific site unless you need cross-site results.
- Analyze the business needs of your private mobile network solution and define key metrics that you want to monitor. For example, the number of bytes transmitted might be of critical importance to a drone control application.
  
  Log Analytics allows you to create alerts for monitoring metrics. Once an alert rule is triggered, Log Analytics takes the specified action, such as notifying an application or running an automated task. With alerts, you can proactively detect and address issues in your private mobile network before users notice them. For details about using alerts in Log Analytics, see [What are Azure Monitor Alerts](/azure/azure-monitor/alerts/alerts-overview).

- Log Analytics is a standard monitoring tool that you can use through the Azure portal. For monitoring sites in your private mobile network, it heavily relies on the connection between the cloud and the on-premises network. For real-time monitoring of a site, consider using the packet core dashboards that Azure Private 5G Core offers.
