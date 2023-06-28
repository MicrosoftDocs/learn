## Azure Policy concepts

Here, we'll cover some concepts you need to understand in advance to work with Azure Policy.

**Policy:** A policy is the business rule to be applied within your organization.

**Initiative:** An initiative is a set of policies combined to simplify management. Both policies and initiatives are written in JSON format.

**Definitions:** The definitions are the list of built-in or custom initiatives and policies available to be assigned.

**Assignments:** The assignments are the associations of initiatives or policies with scopes. A scope for Azure Policy could be a Management Group, an Azure Subscription or a Resource Group. Assignments are inherited by all child resources.

**Exemptions:**: The exemptions are used to exempt a resource hierarchically or an individual resource from the evaluation of initiatives or definitions.

**Remediation:** A remediation is a way to handle noncompliant resources. It allows you to create remediation tasks and ensure the desired state for resources.

## Resources covered

Azure policy covers all Azure resources, including Arc-enabled resources. This means that you can extend the coverage of your controls over Windows and Linux physical servers, virtual machines hosted outside of Azure, on your corporate network, or other cloud providers (as examples). Using Azure Policy is free for Azure resources, but there's a fee associated for an Arc resource.

## Related services

* **Azure Blueprints:** A policy assignment is an artifact type from Azure Blueprints, meaning you can use Azure Blueprints to assign policy assignments. You can assign a policy through .NET, JavaScript, Python, REST API, PowerShell, Azure CLI, ARM template, Bicep, and Terraform as well.
* **Azure Resource Graph:** Through Azure Resource Graph, you can run queries to get information about compliance details by assignments and resource types, list all noncompliant resources, summarize resource compliance by state, and more.
* **Azure Security Center:** The recommendations from Azure Security Center come from built-in security policies initiatives.


## Costs of Azure Policy

If you're using Azure Policy on **Azure Resources**, there are **no costs** associated. However, if you plan use the capabilities of Azure Policy to cover an **Azure Arc Resource**, there are **specific scenarios** where you'll be **charged**. Refer to the [Azure Policy Pricing](https://azure.microsoft.com/pricing/details/azure-policy/) page for reference.

* Azure Policy guest configuration (includes Azure Automation change tracking, inventory, state configuration): $6/Server/Month
* Kubernetes Configuration: First 6 vCPUs are free, $2/vCPU/month

> [!NOTE]
>Azure Arc is a service that allows you to manage some resource types hosted outside of Azure. Today, the following resource types are supported:
>
>* Physical and Virtual Windows or Linux Servers
>* Kubernetes clusters
>* Azure data services such as Azure SQL Managed Instance
>* SQL Server
