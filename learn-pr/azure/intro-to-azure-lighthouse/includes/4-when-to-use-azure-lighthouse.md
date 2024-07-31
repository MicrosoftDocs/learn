Now that you understand how Contoso can use Azure Lighthouse to access its customers' Azure environments, you need to learn more about the kinds of services that can be offered to those customers.

As long as the appropriate roles are granted, Contoso can perform a wide range of tasks using various Azure services. Contoso can do so through the Azure portal, or through APIs and management tools such as Azure CLI and Azure PowerShell. All existing APIs can be used on delegated resources, as long as the functionality is supported for cross-tenant management and the user has the appropriate permissions.

For example, Contoso can deploy and manage Azure Kubernetes Service (AKS) clusters for its customers. It can manage a customer’s hybrid cloud resources through Azure Arc. And it can monitor the health of customer resources with Azure Service Health, then address concerns that may be found.

In addition to accessing each customer's resources directly, Azure Lighthouse also makes it easier for Contoso to perform tasks at scale across many customers. For example, Contoso can have a single view of all Azure Migrate projects that they manage across multiple customers, letting them discover, assess, and migrate workloads for customers at scale, rather than accessing each customer subscription one at a time.

Let's take a look at a few key areas where Azure Lighthouse can simplify and enhance Contoso’s management operations.

## Monitor Azure environments

Contoso can monitor delegated resources across customer tenants by creating Log Analytics workspaces for Azure Monitor logs and deploy policies that help log data. This lets Contoso analyze all of the collected data across customer tenants.

Log Analytics workspaces are unique environments for data collected by Azure Monitor. Each workspace has its own data repository and configuration, and data sources and solutions are configured to store their data in a particular workspace. Contoso can create these workspaces in each customer subscription, allowing customers to maintain control of their data.

After that, Contoso can deploy policies across tenants to ensure that information is sent to the appropriate workspace, which allows the data to remain with each tenant. These policies can be customized depending on the resources types that you want to monitor.

To gain insights across all customers, Contoso can use tools such as Azure Monitor Workbooks to gather and analyze information from multiple data sources. They can also run log queries to retrieve data across Log Analytics workspaces in different customer tenants by creating a union that includes multiple workspaces.

Contoso can also view activity log alerts for delegated subscriptions, letting them respond quickly to issues for each customer.

## Apply policies and manage governance

You can deploy a policy definition and policy assignment across delegated subscriptions in multiple customer tenants.

For example, one service that Contoso offers is managing customers’ storage accounts. As part of this, Contoso needs to ensure that all storage accounts use HTTPS for traffic. Contoso can deploy a policy to all customers that ensures that all storage accounts in customer subscriptions only use HTTPS, marking any storage accounts that aren't set to HTTPS as noncompliant. The policy also prevents new storage accounts that don’t use HTTPS from being created. Since this policy applies across all of the customers that Contoso manages, it only has to deploy the policy one time.

## Help secure customer resources

Microsoft Sentinel delivers security analytics and threat intelligence, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response. With Azure Lighthouse, Contoso can manage multiple Microsoft Sentinel workspaces across its customers. This enables scenarios such as running queries across multiple workspaces, or creating workbooks to visualize and monitor data from your connected data sources to gain insights. Contoso's IP, such as queries and playbooks, can be used to monitor, visualize, and take action on customer resources. However, these resources can remain in Contoso's tenant so that they're not directly accessible by its customers.

Contoso can also use Microsoft Defender for Cloud to monitor compliance with security policies across its customers. Defender for Cloud can help detect threats across tenants' resources and apply advanced threat protection controls. With Azure Lighthouse, Contoso can monitor compliance across all customers in a single view.
