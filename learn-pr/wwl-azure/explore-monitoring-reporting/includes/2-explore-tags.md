You apply [tags](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-using-tags?azure-portal=true) to your Azure resources giving metadata to logically organize them into a taxonomy. Each tag consists of a name and a value pair. For example, you can apply the name **Environment** and the value **Production** to all the resources in production, or tag by company departments. For example, the name of **Department** with a value of **IT**.

| Name | Value |
| --- | --- |
| Environment | Production |
| Department | IT |

After you apply tags, you can retrieve all the resources in your subscription with that tag name and value. Tags enable you to retrieve related resources from different resource groups. This approach is helpful when you need to organize resources for billing or management.

## Tag limitations

There are some limitations with using **tags**, such as:

+ Not all resource types support tags. 

+ Each resource or resource group can have a maximum of 50 tag name/value pairs. Currently, storage accounts only support 15 tags, but that limit will be raised to 50 in a future release. If you need to apply more tags than the maximum allowed number, use a JSON string for the tag value. The JSON string can contain many values that are applied to a single tag name. A resource group can contain many resources that each have 50 tag name/value pairs.

+ The tag name is limited to 512 characters, and the tag value is limited to 256 characters. For storage accounts, the tag name is limited to 128 characters, and the tag value is limited to 256 characters.

+ Virtual Machines and Virtual Machine Scale Sets are limited to a total of 2048 characters for all tag names and values.

+ Tags applied to the resource group are not inherited by the resources in that resource group.

You can use Azure Policy to enforce tagging values and rules on resources.
