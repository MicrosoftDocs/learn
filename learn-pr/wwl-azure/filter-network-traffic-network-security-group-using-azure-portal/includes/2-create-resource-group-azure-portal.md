Before creating network security resources, you need a resource group to organize and manage them. A **resource group** is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group.

Generally, add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group. In this module, you create a resource group to contain your virtual network, subnets, and network security groups.

**Resource groups store metadata about the resources**. When you specify a location for the resource group, you're specifying where that metadata is stored. For compliance reasons, you need to ensure that your data is stored in a particular region.

**Example: Azure Resource Group**

:::image type="content" source="../media/azure-resource-group-example-40b20fe0.png" alt-text="Screenshot showing an example of an Azure Resource Group.":::
