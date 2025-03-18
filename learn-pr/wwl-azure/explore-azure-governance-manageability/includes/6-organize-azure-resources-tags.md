You can apply tags to your Azure resources to logically organize them into categories. Each tag consists of a name and a value. For example, you can apply the name **Environment** and the value **Production** or **Development** to your resources. After creating your tags, you associate them with the appropriate resources.

With tags in place, you can retrieve all the resources in your subscription with that tag name and value. This means you can retrieve related resources from different resource groups.

:::image type="content" source="../media/adding-tags-overview-d2f46061.png" alt-text="Screenshot of Resource group page for adding tags under the Overview option. Tags link is highlighted.":::

Perhaps one of the best uses of tags is to group billing data. When you download the usage CSV for services, the tags appear in the **Tags** column. For example, you could group virtual machines by cost center and production environment.

:::image type="content" source="../media/service-usage-csv-tags-fcd1b31f.png" alt-text="Screenshot of the C S V file for service usage. It shows two entries for virtual machines with the fields usage consumption by unit Hours, instance ID, and the associated tags.":::

There are a few things to consider about tagging:

- Each resource or resource group can have a maximum of 50 tag name/value pairs.
- Tags applied to the resource group aren't inherited by the resources in that resource group.

> [!NOTE]
> If you need to create a lot of tags you'll want to do that programmatically. You can use PowerShell or the CLI.
