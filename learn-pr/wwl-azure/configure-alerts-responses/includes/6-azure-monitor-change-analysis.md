
Change Analysis detects various types of changes, from the infrastructure layer through application deployment. Using Azure Resource Graph, Change Analysis provides a historical record of how the Azure resources that host your application have changed over time. Change Analysis is a subscription-level Azure resource provider that:

- Checks resource changes in the subscription.
- Provides data for various diagnostic tools to help users understand what changes might have caused issues.

Azure Monitor's Change Analysis queries for:

- Azure Resource Manager resource properties.
- Resource configuration changes.
- App Service Function and Web App in-guest changes.

Change Analysis also tracks resource dependency changes to diagnose and monitor an application end-to-end.

Azure Monitor Change Analysis service supports resource property level changes in all Azure resource types, including common resources like:

- Virtual Machine
- Virtual machine scale set
- App Service
- Azure Kubernetes Service (AKS)
- Azure Function
- Networking resources:
	- Network Security Group
	- Virtual Network
	- Application Gateway, etc.
- Data services:
	- Storage
	- SQL
	- Redis Cache
	- Azure Cosmos DB, etc.

To enable Azure Monitor Change Analysis, register the Microsoft.ChangeAnalysis resource provider with an Azure Resource Manager subscription to make the resource properties and configuration change data available. The Microsoft.ChangeAnalysis resource provider is automatically registered as you either:

- Enter any UI entry point, like the Web App Diagnose and Solve Problems tool, or
- Bring up the Change Analysis standalone tab.
