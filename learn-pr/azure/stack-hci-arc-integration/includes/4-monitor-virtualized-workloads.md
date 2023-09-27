Another important advantage of Azure Arc is its ability to centralize and standardize enterprise-wide management and monitoring of technology assets regardless of their location. In this unit, you'll learn how this principle applies to Azure Stack HCI clusters.

## How to integrate Azure Stack HCI with Azure Arc

Azure Stack HCI is delivered as an Azure service, and you need to register it in an Azure subscription within 30 days of its installation. The registration process automatically triggers creation of an Azure Stack HCI Azure Resource Manager resource representing an Azure Stack HCI cluster, effectively onboarding it onto the Azure management plane. A periodic synchronization process ensures that the  Azure Stack HCI resource's status in the Azure portal reflects the actual state of the on-premises cluster. Registering an Azure Stack HCI cluster with Azure Arc is required from the support and billing standpoint. It's also likely to serve in the future as the basis for provisioning additional Arc-enabled resources, including the process of creating Azure Arc VMs directly from the Azure portal.

The Azure Support team provides support for Azure Stack HCI because it's an Azure solution. You can request technical support through the Azure portal. The terms and conditions of request handling are dependent on your support plan. Billing for Azure Stack HCI is subscription-based, just like any other Azure service. Azure Stack HCI pricing data is available via the Azure portal cost management tools.

## How to leverage Azure Arc to centralize monitoring of Azure Stack HCI clusters

With Azure Arc, the Azure portal can provide a centralized dashboard for status monitoring and a launching pad for management of all your Azure Stack HCI clusters, along with all your Azure and Azure Arc-enabled resources. The home page for the Azure Stack HCI resources lists all your clusters, along with their resource group, location, and associated subscription. For each cluster, you can readily identify its name, OS version, OS build, model, total number of CPU cores, and its nodes. For each node, the portal displays its manufacturer, model, serial number, total number of CPU cores, the amount of memory, and OS version and OS build.

More in-depth monitoring, alerting, log collection, and log analytics are available through integration with Azure Monitor. The simplest way to onboard your cluster to Azure Monitor is by using the automated workflow in Windows Admin Center, which first provisions a Log Analytics workspace in the target Azure subscription and then configures the Health Service and installs the Log Analytics agent on each cluster node. Alternatively, you can accomplish the same outcome by using Windows PowerShell.

Once this process is completed, cluster nodes will start forwarding telemetry and logs to Azure Monitor, which you can subsequently display via Azure Monitor dashboards and analyze via Log Analytics queries. You also have the option of implementing metric or log-based rules that will trigger alerts and autoremediation tasks.

Cloud-based monitoring might potentially eliminate the need for an on-premises monitoring system. If you have existing Azure resources, this provides a uniform monitoring solution that leverages cloud hyperscale and seamlessly integrates with other Azure services.

## What is the purpose of Azure Resource Manager activity log, access control, locks, and tags in Azure Stack HCI clusters?

As with Azure-enabled servers, the Azure portal offers the interface from which you can monitor activity log and manage access control, tags, and locks associated with the Azure resource representing each of your Azure Stack HCI clusters. The Azure Resource Manager activity log provides a list of recent operations and events on the cluster along with their status, time, associated subscription, and initiating user. You can filter events by subscription, severity, time span, resource group, and resource. Access-control settings allow you to review and modify role assignments that grant permissions to the Azure resource. By creating a resource lock, you can prevent accidental changes or deletions of the Azure Stack HCI cluster resource. Tags allow you to categorize resources and facilitate consolidated billing.

## Additional reading

You can learn more by visiting the following webpages:

- [Use the Azure portal with Azure Stack HCI](/azure-stack/hci/manage/azure-portal/?azure-portal=true)
- [Monitor Azure Stack HCI with Azure Monitor HCI Insights](/azure-stack/hci/manage/monitor-hci-single/?azure-portal=true)
- [Azure Stack HCI billing and payment](/azure-stack/hci/concepts/billing/?azure-portal=true)

Choose the best response for each of the following questions. Then select "Check your answers".