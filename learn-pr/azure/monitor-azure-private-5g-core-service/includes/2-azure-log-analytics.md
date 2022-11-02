Log Analytics is a tool in the Azure portal for retrieving or visualizing the log data in the Azure Monitor Logs store. Azure Private 5G Core allows you to use Log Analytics to remotely monitor sites in a private mobile network. To do the monitoring, configure the packet core instance at each site to stream its log data to the Azure Monitor Logs store, and then use queries to retrieve the log data. You can also create dashboards that visualize the query data.

> [!NOTE]
> Log Analytics is part of Azure Monitor and is chargeable. In addition, currently you can only use Log Analytics to monitor private mobile networks that support 5G UEs. If you don't want to incur any costs or if you want to use 4G UEs, use the packet core dashboards to do the monitoring.

Log Analytics is helpful for enterprises with multiple sites in their private mobile networks. For example, the network operation manager can monitor geographically dispersed sites from the headquarter of an enterprise.

In this unit, we'll go through basics tasks in using Log Analytics to monitor Azure Private 5G Core. After the learning, you should be able to set up Log Analytics for packet core instances in a private mobile network and use it to monitor the network.

## Enable Log Analytics for a packet core instance

To monitor a site in a private mobile network, you need to first enable Log Analytics for the packet core instance that powers the site.

You'll need to enable Log Analytics from both the cloud and the Kubernetes cluster. Get ready with the following items before starting the enablement process:

- Azure resource: The Kubernetes-Azure Arc resource that represents the Azure Arc-enabled Kubernetes cluster on which your packet core instance is running.
- Contributor role: You must have the Contributor role assignment on the Azure subscription that contains the Kubernetes-Azure Arc resource.
- Admin access: Your local machine needs to have admin kubectl access to the Azure Arc-enabled Kubernetes cluster.
  > [!TIP]
  > For this access, your trials engineer can help you get an admin `kubeconfig` file.

The enablement steps are as follows:

- Create an Azure Monitor extension for the Azure Arc-enabled Kubernetes cluster. This allows Azure Monitor to connect to the specified cluster.
  
  Follow the detailed instructions in [Azure Monitor Container Insights for Azure Arc-enabled Kubernetes clusters](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters) to create the extension.

  > [!NOTE]
  >
  > - Use Azure CLI for this step.
  > - In the "Create extension instance" step, make sure that you choose **Option 4 - On Azure Stack Edge**.

- Configure and deploy a ConfigMap. This opens the Azure Arc-enabled Kubernetes cluster for metrics collection from Azure Monitor.
  
  For detailed instructions, see [Configure and deploy the ConfigMap](/azure/private-5g-core/enable-log-analytics-for-private-5g-core).

## Configure Log Analytics for a packet core instance

## Use queries to retrieve log data

## Use dashboards to visualize log data

## Monitor your private mobile network with Log Analytics

1) label individual sites 2) Define critical alerts and alert levels 3) Can't replace real-time on-site monitoring
