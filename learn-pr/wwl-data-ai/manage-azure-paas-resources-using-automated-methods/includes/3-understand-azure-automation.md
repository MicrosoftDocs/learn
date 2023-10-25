Azure offers several ways to automate processes. Azure Functions and Logic Apps are both Azure services that enable serverless workloads. Both services create workflows that are a collection of steps to execute complex tasks. For example, a Logic App can be created to populate a table in an Azure SQL Database when an entry is made in a SharePoint list. A full explanation of these services is beyond the scope of this course.

For more complete control and granularity of your automation, Azure Automation allows for process automation, configuration management, full integration with Azure platform options (such as role-based access control and Microsoft Entra ID) and can manage Azure and on-premises resources.

One of the unique benefits of Azure Automation is that it can manage resources within Azure or on-premises VMs. For example, if you have a VM that is normally kept in a down state for cost savings (except when it needs to be used), you have the ability within Azure Automation, using a feature called hybrid runbooks, to execute a script to start the VM, then kick off a SQL Server backup from within the VM, and finally shut down the VM.

Another common scenario is to use Azure Automation for periodic maintenance operations, such as purging stale or old data, or reindex a SQL database.

## Azure Automation components

Azure Automation supports both automation and configuration management activities. We're going to focus on the automation components, but Azure Automation can also be used to manage server updates and desired state configuration. The components of Azure Automation you'll need to use to execute automated tasks are as follows:

- **Runbooks** - Runbooks are the unit of execution in Azure Automation. Runbooks can be defined as one of three types: a graphical runbook based on PowerShell, a PowerShell script, or Python script. PowerShell runbooks are most commonly used to manage Azure SQL resources.

- **Modules** - Azure Automation defines an execution context for the PowerShell or Python code you're executing in your runbook. In order to execute your code, you need to import the supporting modules. For example, if you needed to run the `Get-AzSqlDatabase` PowerShell cmdlet, you would need to import the Az.SQL PowerShell module into your automation account.

- **Credentials** - Credentials store sensitive information that runbooks or configurations can use at runtime.

- **Schedules** - Schedules are linked to runbooks and trigger a runbook at a specific time.

## Azure policy

Group Policies, or GPOs, have been used by Windows server administrators for a long time, to manage security, provide consistency across the Windows Server environment in your organization. Some examples of group policies are enforcement of password complexity, mapping shared network drives and configuring networked printers.

Azure Policy includes initiative definitions to help establish and maintain compliance with different security standards for your Automation account. Similar features are also available in Azure Resource Manager. A policy provides a level of governance over your Azure subscriptions. Policy can enforce rules and controls over your Azure resources. Some examples of how you might use this include limiting the regions you can deploy a resource to, enforcing naming standards, or controlling resource sizes. Azure provides many example policies that you can use or you can define custom policies using JSON.

Policies are assigned to a specific scope, which could be a management group (a group of subscriptions that are managed together), a subscription, a resource group, or even an individual resource. Most commonly policy will be applied at the subscription or resource group level. Individual policies can be grouped using a structure known as initiatives, which are sometimes called policy sets. Policies have a scope of assignment that can be defined at the individual resource, the resource group, the subscription, or a management group (a group of subscriptions managed together), or all of the subscriptions in a given tenant.

Another example of how you might implement Azure Policy is tagging of resources. Azure tags, which are described below, store metadata about Azure resources in key-value pairs, and are commonly used to highlight environment type (test, QA, or production) or cost center for a given resource. A policy that required all resources to have a tag for environment and cost center would cause an error and block the deployment of any Azure resource that didn't have the required tags.

### Azure subscriptions and tags

Organizations use multiple subscriptions for several reasons, including budget management, security, or isolation of resources. One example of this would be an organization that has both internal and customer facing resources. The internal resources could exist in one subscription, and the customer resources in another, for easier separation of billing and for isolation of the internal resources. These subscriptions may be managed together in a management group, which allows you to manage policy and compliance across subscriptions.

Tags are simply metadata that are used to better describe your Azure resources. These tags are stored as `key:value` pairs and appear in the Azure portal associated with your Azure resources. Since they're associated with the resource, when you use PowerShell or Azure CLI commands, you can filter your commands based on tags. In that sense, you can think of them like a `WHERE` clause in a SQL query. A basic example is shown below:

```powershell
$rg=(get-AzResourceGroup)

$rg=($rg|where-object {($_.tags['Use'] -ne 'Internal')}).ResourceGroupName
```

On the second line of this code sample, you can see that the list of resource groups is being filtered by the tag called *'Use'*, and will return only those resource groups where that tag doesn't have a value of *'Internal'*. Tags can be applied in the Azure portal, or programmatically via PowerShell, Azure CLI, or as part of your deployment process. Tags can also be applied at the subscription, resource group, or individual resource level. Tags can also be modified at any time. Azure supports applying up to 15 tags to each Azure resource.

Tags are also included in Azure billing information, so tagging by cost center means it can be much easier for management to break down the Azure charges. Tags are in the overview section of the blade for every Azure Resource. To add tags to a resource using the Azure portal, select tags, and enter the key and value for your tag. Select save after you apply the tags to your resources.

[![Screenshot of how to add tags to an Azure SQL Database.](../media/module-66-automation-final-17.png)](../media/module-66-automation-final-17.png#lightbox)

You can also use PowerShell or the CLI to add tags. The PowerShell example is below:

```powershell
$tags = @{"Dept"="Finance"; "Status"="Normal"}

$resource = Get-AzResource -Name demoStorage -ResourceGroup demoGroup

New-AzTag -ResourceId $resource.id -Tag $tags
```

The Azure CLI example is below:

```powershell
az resource tag --tags 'Dept=IT' 'Environment=Test' -g examplegroup -n examplevnet `

 --resource-type "Microsoft.Network/virtualNetworks"
```

Tags enable customers to organize Azure resources and management hierarchy into a taxonomy.

>[!NOTE]
> Tags are stored as plain text. Never add sensitive values to tags. Sensitive values could be exposed through many methods, including cost reports, tag taxonomies, deployment histories, exported templates, and monitoring logs.
