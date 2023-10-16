You can apply tags to your Azure resources to logically organize them by categories. Tags are useful for sorting, searching, managing, and doing analysis on your resources.

Each resource tag consists of a name and a value. You could have the tag name `Server` and the value `Production` or `Development`, and then apply the tag/value pair to your Engineering computer resources.

Here's an example that shows how to add tags for a resource group in the Azure portal:

:::image type="content" source="../media/resource-tags-357b5e1a.png" alt-text="Screenshot that shows how to add tags for a resource group in the Azure portal.":::

### Things to know about resource tags

As you plan your Azure subscriptions, resources, and services, review these characteristics of Azure resource tags:

- Each resource tag has a name and a value.

- The tag name remains constant for all resources that have the tag applied.

- The tag value can be selected from a defined set of values, or unique for a specific resource instance. 

- A resource or resource group can have a maximum of 50 tag name/value pairs.

- Tags applied to a resource group aren't inherited by the resources in the resource group.

### Things to consider when using resource tags

Here are a few things you can do with resource tags:

- **Consider searching on tag data**. Search for resources in your subscription by querying on the tag name and value.

- **Consider finding related resources**. Retrieve related resources from other resource groups by searching on the tag name or value.

- **Consider grouping billing data**. Group resources like virtual machines by cost center and production environment. When you download the resource usage comma-separated values (CSV) file for your services, the tags appear in the `Tags` column. 

- **Consider creating tags with PowerShell or the Azure CLI**. Create many resource tags programmatically by using Azure PowerShell or the Azure CLI.