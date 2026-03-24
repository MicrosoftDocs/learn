The following video provides an introduction to things that can impact your costs in Azure.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=ef760ebd-b3c1-44d8-9628-2b54c45fcbfe]

With Azure, you pay for IT resources as you use them instead of purchasing and maintaining your own infrastructure. Whether it's compute, storage, or networking, you rent what you need and release it when you're done. This consumption-based approach means your costs scale with your actual usage.

Many factors affect how much you pay. Some of the factors that affect cost are:

 -  Resource type
 -  Consumption
 -  Maintenance
 -  Geography
 -  Subscription type
 -  Azure Marketplace

:::image type="content" source="../media/cost-factors-overview.png" alt-text="Diagram showing six factors that affect Azure costs: resource type, consumption, maintenance, geography, subscription type, and Azure Marketplace.":::

## Resource type

A number of factors influence the cost of Azure resources. The type of resources, the settings for the resource, and the Azure region will all have an impact on how much a resource costs. When you provision an Azure resource, Azure tracks how much of each resource you use and charges you based on that usage.

### Examples

With a storage account, you choose options that affect the price, such as the type of data stored (for example, blob storage for files and images), how fast you need to access it, how many backup copies to keep, and which region to use. Creating the same storage account in different regions may show different costs and changing any of the settings may also impact the price.

With a virtual machine (VM), you may have to consider licensing for the operating system or other software, the processor and number of cores for the VM, the attached storage, and the network interface. Just like with storage, provisioning the same virtual machine in different regions may result in different costs.

## Consumption

Pay-as-you-go has been a consistent theme throughout, and that's the cloud payment model where you pay for the resources that you use during a billing cycle. If you use more compute this cycle, you pay more. If you use less in the current cycle, you pay less. It's a straightforward pricing mechanism that allows for maximum flexibility.

Azure also offers discount options for predictable workloads. With Reservations, you can commit to specific resources for one- or three-year terms to reduce cost. Reservations can apply to services such as virtual machines, databases, and storage.

If you want flexibility in which compute resources you use, Azure savings plan for compute is another option. Instead of committing to a specific VM type, you commit to an hourly spend amount on eligible compute services for one or three years, and Azure automatically applies the best available price as usage occurs.

If you have workloads that can handle interruptions, such as a batch data processing job, Azure Spot Virtual Machines can help reduce cost further. Spot pricing uses unused Azure capacity at lower prices, but those workloads can be evicted when Azure needs the capacity back.

:::image type="content" source="../media/consumption-pricing-options.png" alt-text="Comparison chart of four Azure pricing options: pay-as-you-go, reservations, savings plan, and spot pricing.":::

## Maintenance

The flexibility of the cloud makes it possible to rapidly adjust resources based on demand. Using resource groups can help keep all of your resources organized. To control costs, it’s important to maintain your cloud environment. For example, every time you provision a VM, additional resources such as storage and networking are also provisioned. If you deprovision the VM, those additional resources may not deprovision at the same time, either intentionally or unintentionally. By keeping an eye on your resources and making sure you’re not keeping around resources that are no longer needed, you can help control cloud costs.

## Geography

When you provision most resources in Azure, you need to define a region where the resource deploys. Azure infrastructure is distributed globally, which enables you to deploy your services centrally or closest to your customers, or something in between. With this global deployment comes global pricing differences. The cost of power, labor, taxes, and fees vary depending on the location. Due to these variations, Azure resources can differ in costs to deploy depending on the region.

Network traffic is also impacted based on geography. For example, it’s less expensive to move information within Europe than to move information from Europe to Asia or South America.

### Network traffic

Billing zones are a factor in determining the cost of some Azure services. Billing zones are different from availability zones; a billing zone is a geographical grouping of Azure regions used specifically for data-transfer pricing.

Bandwidth refers to data moving in and out of Azure datacenters. Some inbound data transfers (data going into Azure datacenters) are free. For outbound data transfers (data leaving Azure datacenters), data transfer pricing is based on zones.

A zone is a geographical grouping of Azure regions for billing purposes. The [bandwidth pricing page](https://azure.microsoft.com/pricing/details/bandwidth/) has additional information on pricing for data ingress, egress, and transfer.

## Subscription type

Some Azure subscription types also include usage allowances, which affect costs.

For example, an Azure free trial subscription provides access to a number of Azure products that are free for 12 months. It also includes credit to spend within your first 30 days of sign-up. You'll get access to more than 25 products that are always free (based on resource and region availability).

## Azure Marketplace

Azure Marketplace lets you purchase Azure-based solutions and services from third-party vendors. This could include a preconfigured web server, a virtual machine with specialized software already installed, or a managed backup solution. When you purchase products through Azure Marketplace, you may pay for not only the Azure services that you’re using, but also the services or expertise of the third-party vendor. Billing structures are set by the vendor.

All solutions available in Azure Marketplace are certified and compliant with Azure policies and standards. The certification policies may vary based on the service or solution type and Azure service involved. [Commercial marketplace certification policies](/legal/marketplace/certification-policies) has additional information on Azure Marketplace certifications.

