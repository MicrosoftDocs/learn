You've gone through your resources and moved them into resource groups that are more organized than before; but what if resources have multiple uses? How do you better search, filter, and organize these resources? Tags can be helpful as you look to improve organization of your Azure resources.

## What are tags?

Tags are name/value pairs of text data that you can apply to resources and resource groups. Tags allow you to associate custom details about your resource. In addition to the standard Azure properties, a resource has the following properties:

- department (like finance, marketing, and more)
- environment (prod, test, dev)
- cost center
- lifecycle and automation (like shutdown and startup of virtual machines)

A resource can have up to 50 tags. The name value is limited to 512 characters for all types of resources except storage accounts, which have a limit of 128 characters. The tag value is limited to 256 characters for all types of resources. Tags aren't inherited from parent resources. Not all resource types support tags, and you can't apply tags to [classic resources](/azure/azure-resource-manager/management/deployment-models#history-of-the-deployment-models).

You can add and manipulate tags through the Azure portal, Azure CLI, Azure PowerShell, Azure Resource Manager templates, and through the REST API. For example, to add a resource tag to a virtual network using the Azure CLI, you could use the following command:

```azurecli
az resource tag --tags Department=Finance \
    --resource-group msftlearn-core-infrastructure-rg \
    --name msftlearn-vnet1 \
    --resource-type "Microsoft.Network/virtualNetworks"
```

You can use Azure Policy to automatically add or enforce tags for resources your organization creates based on policy conditions that you define. For example, you could require that a value for the Department tag is entered when someone in your organization creates a virtual network in a specific resource group.

## Apply tags to resources

Let's apply some tags to the resources you created. Recall that you created a resource group called **msftlearn-core-infrastructure-rg** and two virtual networks inside that resource group called **msftlearn-vnet1** and **msftlearn-vnet2**. The virtual-network names are relatively generic, so you'd like to associate the virtual networks with services from different departments.

1. Open the [Azure portal](https://portal.azure.com/?azure-portal=true) and navigate to your **msftlearn-core-infrastructure-rg** resource group.

1. Your two virtual networks should be listed on your resource group's **Overview** pane. The default view doesn't display the tags column, so you'll add that column to the list view. In the toolbar, select **Manage view**, then select **Edit columns**. On the **Edit columns** pane, select **Add Column** and then select the field to display the dropdown list. Select the Property **Tags** to add it to the columns in the list view. Select **Save** to add your changes.

    :::image type="content" source="../media/3-edit-tag-columns.png" alt-text="Screenshot of Azure portal showing edit columns dialog with available columns on the left and selected columns on the right.":::

    You should now have the **Tags** column, but it's empty because you haven't added any tags yet. You'll add the tags directly here.

1. You can also add tags to any resource that supports this feature on the resource's **Tags** pane. For the **msftlearn-vnet1** resource, select the ellipsis (`...`) and then select **Edit tags** to display the **Edit tags** pane. This pane enables you to create specific tags for the selected resource.

1. Let's add a couple tags to this virtual network. The two fields on this pane remember all of the previously used tags. You can select one or create a new tag. In the **Name** box type _Department_, and in the **Value** box type _Finance_. Click **Save** to save your changes.

    :::image type="content" source="../media/3-edit-tags.png" alt-text="Screenshot of Azure portal showing the edit tags dialog with new tag name and value entered.":::

1. Do the same steps for the **msftlearn-vnet2** virtual network. For this virtual network, add a _Department_ tag to the resource with value _Marketing_.

    You should now have your tags applied to each resource.

    :::image type="content" source="../media/3-display-vnet-tags.png" alt-text="Screenshot of Azure portal showing virtual network resources with department tags.":::

1. To quickly categorize resources, you can add tags to resources in bulk. In your list, select the checkbox on the left for each virtual network, and then, in the toolbar, select **Assign tags**. (If not visible, this option may be contained inside the `...` menu.) By selecting multiple resources, you can add a tag all of the selected items, making it easy to apply the same tag to multiple resources.

    Add the `Environment`:`Training` tag to the selected resources. You should see in the dialog that the tag will be applied to each of the virtual networks. Select **Save**.

    :::image type="content" source="../media/3-assign-tags.png" alt-text="Screenshot of Azure portal showing the assign tags dialog to add tags in bulk.":::

    In the resource list, you'll now have the **Tags** column populated with multiple values. If your window width is limited, the tag text might be truncated. Hover over the title of a column and use the vertical line to resize the column. If you have an ellipsis in the far right, it indicates additional columns are available but not shown.

1. Select **Add filter**. In the **Filter** field, select **Environment**. For the **Value**, select **Training** and ensure all other checkboxes are empty, then select **Apply**. Only your two virtual networks should be displayed because you tagged those resources with the **Environment** tag set to **Training**.

    :::image type="content" source="../media/3-tag-filter.png" alt-text="Screenshot of Azure portal resource list filtered on the training environment tag.":::

1. You can further filter the resource list by adding a filter for **Department** tag with a value of either **Finance** or **Marketing**.

## Use tags for organization

The preceding exercise is just one example of where and how you can use tags to organize your resources. With their flexibility, there are several ways you can use tags to your advantage.

You can use tags to group your billing data. For example, if you're running multiple VMs for different organizations, use the tags to group usage by cost center. You can also use tags to categorize costs by runtime environment, such as the billing usage for VMs running in the production environment. When you export billing data or access it through billing APIs, tags are included as part of the data, and you can use them to further slice your data from a cost perspective.

You can retrieve all the resources in your subscription that have a specific tag name or value. Tags allow you to retrieve related resources from different resource groups, as well. This approach is helpful when you need to organize resources for billing or management.

Tagging resources can also help in monitoring to track down impacted resources. Monitoring systems can use tag data with alerts, allowing you to know exactly who is impacted. In our example above, you applied the **Department** tag with a value of **Finance** to the **msftlearn-vnet1** resource. If an alarm was thrown on **msftlearn-vnet1** and the alarm included the tag, you'd know that the finance department might be impacted by the condition that triggered the alarm. This contextual information can be valuable if an issue occurs.

It's also common for tags to be used in automation. If you want to automate the shutdown and startup of virtual machines in development environments during off-hours to save costs, you can use tags to support automation. Add a **shutdown:6PM** and **startup:7AM** tag to the virtual machines, then create an automation job that looks for these tags and shuts down or starts resources based on their tag value. There are several solutions in the Azure Automation Runbooks Gallery that use tags in a similar manner to accomplish this result.
