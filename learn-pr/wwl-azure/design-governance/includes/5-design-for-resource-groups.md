[**Resource groups**](/azure/azure-resource-manager/management/overview) are logical containers into which Azure resources are deployed and managed.​ These resources can include web apps, databases, and storage accounts. You can use resource groups to:

- Place resources of similar usage, type, or location in logical groups.

- Organize resources by life cycle so all the resources can be created or deleted at the same time. 

- Apply role permissions to a group of resources or give a group access to administer a group of resources.

- Use resource locks to protect individual resources from deletion or change. 

### Things to know about resource groups

- Resource groups have their own location (region) assigned. This region is where the metadata is stored.

- If the resource group's region is temporarily unavailable, you can't update resources in the resource group because the metadata is unavailable. The resources in other regions will still function as expected, but you can't update them.

- Resources in the resource group can be in different regions. 

- A resource can connect to resources in other resource groups. For example, you can have a web app that connects to a database in a different resource group.

- Resources can be moved between resource groups.

- You can add a resource to or remove a resource from a resource group at any time.

- Resource groups can’t be nested. 

- Each resource must be in one, and only one, resource group.

- Resource groups cannnot be renamed.

### Things to consider when creating resource groups

Tailwind Traders has two Azure-based apps (App1 and App2). Each app has a web service with SQL database, virtual machines, and storage. Tailwind Traders needs to decide how to organize their resource groups. 

:::image type="content" source="../media/resource-groups.png" alt-text="Resource groups for the production apps.":::


- **Consider group by type**. Group by type is most appropriate for on-demand services that aren’t associated with an app. In our example, a resource group for the SQL databases (SQL-RG) and a separate resource group (WEB-RG) for the web services. 

:::image type="content" source="../media/group-type.png" alt-text="Separate resource groups for database and for web apps.":::



- **Consider group by app**. Group by app is appropriate when all the resources have the same policies and life cycle. This method could also be applied to test or prototype environments. For Tailwind Traders, App1 and App2 would have separate resource groups. Each group would have all the resources for that application. 

:::image type="content" source="../media/group-app.png" alt-text="Separate resource groups for app1 and app2.":::


- **Consider group by department, group by location (region), and group by billing (cost center)**. These grouping strategies aren’t common but may be useful in your situation. 

- **Consider a combination of organizational strategies.** Don’t restrict your thinking to one strategy. Often a combination of different strategies is best. 

- **Consider resource life cycle.** Do you want to deploy, update, and delete resources at the same time? If so, you may want to place all those resources in one resource group. 

- **Consider administration overhead**. How many resource groups would you like to manage? Do you have centralized or decentralized Azure administrators?

- **Consider resource access control**. At the resource group level, you can assign Azure policies, Azure roles, and resource locks. [Resource locks](/azure/azure-resource-manager/management/lock-resources?tabs=json) prevent unexpected changes to critical resources. 

- **Consider compliance requirements.** Do you need to ensure your resource group metadata is stored in a particular region?