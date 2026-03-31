Recall that tags and resource locks are two (2) tools within Microsoft Azure to help protect and manage resources.

## Tags
Tags let you keep track of resources, group them in ways that make sense to you, and then gather information based on the tagging methodology or schema that you implement.

For example, if you had 100 virtual machines, some used by developers, some used by testers, and other machines used by people not working on your website, you could create a tagging schema that would help you separate the costs into different buckets. You could create a **Purpose** tag. Within that tag, you could assign values such as developers, testers, an overhead.

Then, you could see statistics and metrics on each of those groups simply by referencing the tag value when querying the data.

From the **Tags** blade of Azure, you can quickly see your assigned tags. By selecting one of the tags, you can also see all resources that have that tag assigned.

:::image type="content" source="../media/azure-tags.png" alt-text="Screenshot of the tags blade showing multiple tags assigned to resources.":::

And recall that tags can be set at different levels. You can set a tag at the subscription level, or the resource group level, or on individual resources. You can even use Azure policy to set it up so that a tag on a resource group is automatically applied to resources within the resource group. Or, you could set it so you got a notification if a resource within that resource group didn’t have the tag – so you could investigate if the resource was in the wrong resource group or if you simply needed to update the tags.

## Locks
Recall that **resource locks** are another management tool available within Azure. Azure offers two types of resource locks.
* Read-only: Prevents any modifications or deletions. Users are able to read the resource.
* Delete: A delete lock prevents the locked entity from being deleted. However, users with sufficient permissions can still read and edit the resource.

>[!NOTE]
>Resource locks override other access and control permissions. For example: If a resource has a delete lock preventing deletion, a user with full administrative rights still won’t be able to delete the resource without first removing the delete lock.

Locks can be created at various levels and they apply to child resources as well. For example, if you create a delete lock on a resource group to prevent deletion of the resource group, all resources within that resource group would also be protected from deletion.

Locks can typically be applied within the resource *settings* section of the resource blade.

:::image type="content" source="../media/resource-locks.png" alt-text="Screenshot of a virtual machine blade in Azure with settings and locks highlighted.":::