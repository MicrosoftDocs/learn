## Resource tags

Organizing your cloud-based resources can make management tasks and reporting significantly easier. As well as the ability to place related resources into resource groups and subscriptions, you can define and implement resource tags to provide extra information about a resource, that's relevant to your organization. This "metadata" is useful for:

+ **Resource management** - Locating and acting on resources associated with specific workloads, environments, business units, ownership or other important information.
+ **Cost management and optimization** - Grouping resources for cost reporting, internal cost center allocation, budget tracking and alerting, and estimated cost forecasting.
+ **Operations management** - Grouping resources according to how critical their availability is to your business, for SLA visibility.
+ **Security** - Tagging resources related to the classification of the data they hold and the security level of that data (such as public or confidential).
+ **Governance and regulatory compliance** - Choosing a tagging pattern that aligns with any governance or regulatory compliance requirements. This can be used to identify resources that must comply to a particular standard (such as ISO27001), or the tag can be part of your standards enforcement (such as all resources must be tagged with an owner name).   
+ **Workload optimization and automation** - Tagging resources with their associated workload or application name can make it easier to visualize all resources across a complex solution and act on those resources with tools like Azure DevOps. 

## Tailwind Traders tag structure
Resource tags consist of a tag name and a tag value. Azure resources can have more than one tag assigned to them. After reviewing their business requirements, Tailwind Traders has decided to implement the following tags:
| Tag Name  | Tag Value | 
|-----------|-----------|
|AppName    |*Name of the application the resource is part of*|
|CostCenter |*Internal cost center code*|
|Owner      |*Name of the business owner responsible for the resource*|
|Environment|Prod, Dev or Test|
|Impact     |Mission-critical, High-impact or Low-impact |

<div style="background: yellow;">
TODO: 
Maybe a screenshot of a tag? 
</div>

> [!Note]
> You do not have to enforce that a tag is present on all of your resources. For example, you could decide that only mission-critical resources have the Impact tag, and all non-tagged resources are then not deemed mission-critical.

For recommendations on how to implement your own tagging strategy, visit [Resource naming and tagging decision guide](https://docs.microsoft.com/azure/cloud-adoption-framework/decision-guides/resource-tagging/?toc=/azure/azure-resource-manager/management/toc.json)

## Deploying resource tags
Tags can be added to resource via PowerShell, the Azure CLI, Azure Resource Manager templates, the REST API or the Azure Portal.

A resource group can have it's own tags, which will not be applied to the resources in that resource group. If you want resources to inherit the same tags as their parent resource group, you can achieve this using an Azure Policy.

You can also use Azure Policy to enforce tagging rules and conventions - requiring tags on new resources during deployment, adding tags to existing resources or remediating (redeploying) tags which may have been removed.  

For further information policies for tag compliance, visit [Assign polcies for tag compliance[(https://docs.microsoft.com/azure/azure-resource-manager/management/tag-policies)]]
