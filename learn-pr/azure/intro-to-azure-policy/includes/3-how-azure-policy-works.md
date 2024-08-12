## Azure Policy concepts

Here, we cover some concepts you need to understand in advance to work with Azure Policy.

**Policy:** A policy is the business rule to be applied within your organization.

**Initiative:** An initiative is a set of policies combined to simplify management. Both policies and initiatives are written in JSON format.

**Definitions:** The definitions are the list of built-in or custom initiatives and policies available to be assigned.

**Assignments:** The assignments are the associations of initiatives or policies with scopes. A scope for Azure Policy could be a Management Group, an Azure Subscription or a Resource Group. All child resources inherit the assignments of the parent resource.

**Exemptions:**: The exemptions are used to exempt a resource hierarchically or an individual resource from the evaluation of initiatives or definitions.

**Remediation:** A remediation is a way to handle noncompliant resources. It allows you to create remediation tasks and ensure the desired state for resources.

**Policy versioning (preview)** Built-in policy definitions and initiatives can have multiple versions with the same definition ID. The default is to use the latest major version. You can choose to accept new minor versions or pin to a specific minor version. Patch versions are automatically accepted for security purposes.

## Resources covered

Azure policy covers all Azure resources, including Arc-enabled resources. For example, you can extend the coverage of your controls over Windows and Linux physical servers, and virtual machines hosted outside of Azure, on your corporate network, or other cloud providers. Using Azure Policy is free for Azure resources, but there's a fee associated for an Arc resource.

Azure Arc is a service that allows you to manage resource types hosted outside of Azure. The following resource types are supported:

- Physical and Virtual Windows or Linux Servers.
- Kubernetes clusters.
- Azure data services such as Azure SQL Managed Instance.
- SQL Server.
- Provision, resize, delete and manage virtual machines based on VMware vSphere or Azure Stack HCI and enable VM self-service through role-based access.

## Related services

- **Azure Blueprints:** A policy assignment is an artifact type from Azure Blueprints, meaning you can use Azure Blueprints to assign policy assignments. You can assign a policy through .NET, JavaScript, Python, REST API, PowerShell, Azure CLI, ARM template, Bicep, and Terraform as well.
- **Azure Resource Graph:** Through Azure Resource Graph, you can run queries to get information about compliance details by assignments and resource types, list all noncompliant resources, summarize resource compliance by state, and more.
- **Azure Security Center:** The recommendations from Azure Security Center come from built-in security policies initiatives.

## Costs of Azure Policy

There are no costs to use Azure Policy for your Azure resources.

If you plan use Azure Policy to cover an Azure Arc resource, there are specific scenarios where you're charged a fee. To estimate costs, use [Azure Policy pricing](https://azure.microsoft.com/pricing/details/azure-policy/) or the [Pricing calculator](https://azure.microsoft.com/pricing/calculator/).
