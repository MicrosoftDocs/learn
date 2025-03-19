Azure offers several ways to automate processes. Azure Functions and Logic Apps are services that enable serverless workloads, creating workflows composed of steps to execute complex tasks. For example, a Logic App can populate a table in an Azure SQL Database when an entry is made in a SharePoint list. A full explanation of these services is beyond the scope of this course.

For more control and granularity in your automation, Azure Automation provides process automation, configuration management, full integration with Azure platform options (such as role-based access control and Microsoft Entra ID), and the ability to manage both Azure and on-premises resources.

One unique benefit of Azure Automation is its capability to manage resources within Azure or on-premises VMs. For instance, if you have a VM that is kept in a down state for cost savings, you can use Azure Automation with hybrid runbooks to start the VM, perform a SQL Server backup, and then shut down the VM.

Another common use of Azure Automation is for periodic maintenance operations, such as purging stale or old data or reindexing an SQL database.

## Azure Automation components

[Azure Automation](/azure/automation/overview?azure-portal=true) supports both automation and configuration management activities. While we'll focus on the automation components, Azure Automation can also manage server updates and desired state configuration. Here are the key components you need to execute automated tasks.

- **Runbooks**: Runbooks are the units of execution in Azure Automation. They can be defined as graphical runbooks based on PowerShell, PowerShell scripts, or Python scripts. PowerShell runbooks are most commonly used to manage Azure SQL resources.

- **Modules**: Azure Automation provides an execution context for the PowerShell or Python code in your runbook. To execute your code, you need to import the necessary modules. For example, to run the `Get-AzSqlDatabase` PowerShell cmdlet, you would import the Az.SQL PowerShell module into your automation account.

- **Credentials**: Credentials store sensitive information that runbooks or configurations can use at runtime.

- **Schedules**: Schedules are linked to runbooks and trigger a runbook at a specific time.

## Azure policy

Group Policies (GPOs) have long been used by Windows server administrators to manage security and ensure consistency across Windows Server environments. Examples include enforcing password complexity and mapping shared network drives.

[Azure Policy](/azure/governance/policy/overview?azure-portal=true) offers similar governance for Azure resources, enforcing rules like region limitations, naming standards, and resource sizes. Policies can be applied at various levels, such as management groups, subscriptions, or resource groups. They can also be grouped into initiatives for broader application.

Another use of Azure Policy is resource tagging, which stores metadata in key-value pairs. For example, a policy might require all resources to have tags for environment and cost center, blocking deployment if tags are missing.

### Azure subscriptions and tags

Organizations use multiple subscriptions for various reasons, such as budget management, security, or resource isolation. For instance, an organization might separate internal and customer-facing resources into different subscriptions to simplify billing and isolate internal resources. These subscriptions can be managed together in a management group, allowing for unified policy and compliance management across subscriptions.

Tags are metadata used to describe your Azure resources better. Stored as `key:value` pairs, tags appear in the Azure portal alongside your resources. Because they're associated with the resource, you can filter PowerShell or Azure CLI commands based on tags, similar to using a `WHERE` clause in a SQL query. Here's a basic example:

```powershell
$rg=(get-AzResourceGroup)

$rg=($rg|where-object {($_.tags['Use'] -ne 'Internal')}).ResourceGroupName
```

In the second line of this code sample, the list of resource groups is filtered by the tag called *'Use'*, returning only those resource groups where the tag value isn't *'Internal'*. Tags can be applied in the Azure portal, programmatically via PowerShell, Azure CLI, or as part of your deployment process. They can be applied at the subscription, resource group, or individual resource level and can be modified at any time. Azure supports up to 15 tags per resource.

Tags are also included in Azure billing information, making it easier for management to break down charges by cost center. Tags are found in the overview section of the blade for every Azure resource. To add tags to a resource using the Azure portal, select **Tags**, enter the key and value for your tag, and then select **Save**.

[![Screenshot of how to add tags to an Azure SQL Database.](../media/module-66-automation-final-17.png)](../media/module-66-automation-final-17.png#lightbox)

The following example shows how to add tags using PowerShell.

```powershell
$tags = @{"Dept"="Finance"; "Status"="Normal"}

$resource = Get-AzResource -Name demoStorage -ResourceGroup demoGroup

New-AzTag -ResourceId $resource.id -Tag $tags
```

The following example shows how to add tags using Azure CLI.

```azurecli
az resource tag --tags 'Dept=IT' 'Environment=Test' -g examplegroup -n examplevnet `

 --resource-type "Microsoft.Network/virtualNetworks"
```

Tags enable customers to organize Azure resources and management hierarchy into a taxonomy.

>[!NOTE]
> Tags are stored as plain text, so never add sensitive values to them. Sensitive information could be exposed through various methods, including cost reports, tag taxonomies, deployment histories, exported templates, and monitoring logs.
