Basic capacity planning starts with some straightforward calculations, but there are factors that can complicate the process. In addition to simple current and predicted usage numbers, you must also factor in the following considerations:

- Service limits and quotas
- Cost limitations
- Code and configuration inefficiencies
- Dependencies

In this unit, you look at how these considerations can affect your capacity planning, and how to address each of them.

## Service limits and quotas

There's a tendency to see cloud computing as an unlimited resource. In comparison to traditional server/datacenter models, the capacity of the cloud appears to be infinite. The cloud does offer a whole new level of scale. However, like everything else, it does have some limits. Capacity planning involves understanding when you’re going to reach those service limits.

When looking at your system and its architecture, you need to understand the limits for the cloud services you're using. For example, by default, you can have a maximum of 200 VMs per VM availability set in Azure. This limit may seem like more than enough VMs if you’re just getting started. However, when you reach that limit, you aren’t able to provision any more VMs, which could potentially result in an outage.

Likewise, by default, you can have 250 storage accounts per subscription, per region. These limits are both examples of soft limits that can be increased. But some services have maximum limits, which you can find at the following link.

[Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits?WT.mc_id=msignitethetour2019-slides-ops50)

These limits and quotas are something to be aware of and monitor. Let’s look at ways to do that.

### Azure portal

You can see the service quotas and where you are in relation to those limits in the **Usage + quotas** section under **Subscriptions -> Settings** in the navigation pane. You can filter on service category such as network / compute, and Azure region. It shows you where you are against the limits.

:::image type="content" source="../media/service-limits.png" alt-text="Screenshot of Service Limits info found in the Azure portal showing a table of different resources and their quotas.":::

### Via code

You can use the `Usage - List` endpoint for any Azure service to get the current resource usage information, and the limits for compute resources under the subscription, as shown in this truncated example.

```html
GET https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/usages?api-version=2023-03-01
{ 
    "currentValue": 124,
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/westeurope/usages/VirtualNetworks",
    "limit": 1000, 
    "name": { 
        "localizedValue": "Virtual Networks",
        "value": "VirtualNetworks" 
    }, 
    "unit": "Count" 
}
```

You can see that the current number of Azure Virtual Networks (VNets) being used is 124 against a limit of 1000. Increasing a limit requires a support request, so ensure that you know ahead of time when you might come close to the threshold.

## Cost limitations

Scaling isn't just about throwing more resources at the problem. It’s important for your organization to understand the cost of your cloud environment, and that adding more resources generally equals more cost. Be aware of this cost and work with your finance teams to ensure you’re in agreement about current and projected cloud spend.

You should forecast for cost both when initially designing the systems, and when performing regular reviews of your already running systems. Azure offers tooling that can help you:

- Plan for the cost of an environment using the [Azure calculator](https://azure.microsoft.com/pricing/calculator/).
- Review current and projected monthly spend in the Azure portal.
- Set up budgets in Microsoft Cost Management. This tool can enable you to examine your costs at different scopes including management group, resource group, and subscription.

## Code and configuration inefficiencies

Sometimes, directing more resources can resolve an issue, but that costs money. Sometimes scaling isn’t the solution, or isn’t the complete solution. In some cases, it may be that what appears to be a need to scale is actually a problem caused by bad coding or configuration.

You can potentially save money and time by finding the bugs first, before scaling out resources. Some examples of this approach include:

- If you have a badly designed database with hot partitions, such as using only one partition on a huge noSQL database, it's slow no matter how much you scale.
- If you have inefficient database queries, make them more performant before you throw more resources at the database. Sometimes, just adding the right index to a database based on common queries can drop your costs 100x.
- If your timeouts are set incorrectly, your database connections can get saturated due to retries from inconsistent timeouts between server and database. In that case, you need to fix the settings before scaling the database.
- If the developer’s code is inefficient, can you write more efficient code to address the problem? Perhaps the code doesn't free memory when it could, so you have been using larger memory VMs when that isn't necessary. Fixes like that can provide significant cost savings.

## Dependencies

The changes that are needed to address some of the issues described in this module often have dependencies on the developers of your application. Some of the solutions and best practices recommended here, require collaboration between you and those developers to make it happen.

You may not be able to implement all of these recommendations entirely by yourself. However, if you understand the cloud system and its capabilities and characteristics, you can become a driver for change in improving your systems and their scalability and reliability.