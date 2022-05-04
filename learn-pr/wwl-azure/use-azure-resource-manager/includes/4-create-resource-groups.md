Resources can be deployed to any new or existing resource group. Deployment of resources to a resource group becomes a job where you can track the template execution. If deployment fails, the output of the job can describe why the deployment failed. Whether the deployment is a single resource to a group or a template to a group, you can use the information to fix any errors and redeploy. Deployments are incremental; if a resource group contains two web apps and you decide to deploy a third, the existing web apps will not be removed. 

## Considerations

Resource Groups are at their simplest a logical collection of resources. There are a couple of small rules for resource groups.

 -  Resources can only exist in one resource group.
 -  Resource Groups cannot be renamed.
 -  Resource Groups can have resources of many different types (services).
 -  Resource Groups can have resources from many different regions.

## Creating resource groups

There are some important factors to consider when defining your resource group:

 -  All the resources in your group should share the same lifecycle. You deploy, update, and delete them together. If one resource, such as a database server, needs to exist on a different deployment cycle it should be in another resource group.
 -  Each resource can only exist in one resource group.
 -  You can add or remove a resource to a resource group at any time.
 -  You can move a resource from one resource group to another group.
 -  A resource group can contain resources that reside in different regions.
 -  A resource group can be used to scope access control for administrative actions.
 -  A resource can interact with resources in other resource groups. This interaction is common when the two resources are related but don't share the same lifecycle (for example, web apps connecting to a database).

When creating a resource group, you need to provide a location for that resource group. You may be wondering, "Why does a resource group need a location? And, if the resources can have different locations than the resource group, why does the resource group location matter at all?" The resource group stores metadata about the resources. Therefore, when you specify a location for the resource group, you're specifying where that metadata is stored. For compliance reasons, you may need to ensure that your data is stored in a particular region.

> [!NOTE]
> By scoping permissions to a resource group, you can add/remove and modify resources easily without having to recreate assignments and scopes.
