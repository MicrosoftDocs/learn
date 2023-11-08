Azure Subscriptions are logical containers that serve as units of management and scale and billing boundaries. Limits and quotas can be applied, and each organization can use subscriptions to manage costs and resources by group.​ 

### Things to know about subscriptions

To use Azure, you must have an Azure subscription. A subscription provides you with a logical container to create and pay for Azure products and services. There are [several types of subscriptions](https://azure.microsoft.com/support/legal/offer-details/), such as Enterprise Agreement and Pay-as-You-Go. 

:::image type="content" source="../media/azure-active-directory-subscriptions.png" alt-text="Diagram of Microsoft Entra ID showing the subscription types - dev, test, and production." border="false":::

As you plan the governance strategy for Tailwind Traders, consider these characteristics of subscriptions:

- Subscriptions can provide separate billing environments, such as development, test, and production. 

- Policies for individual subscriptions can help satisfy different compliance standards. 

- You can organize specialized workloads to scale beyond the limits of an existing subscription.

- By using subscriptions, you can manage and track costs for your organizational structure.

### Things to consider when creating subscriptions

You defined your strategy for the Tailwind Traders management group structure. Now you need to determine where to assign subscriptions. Here's one possible solution:

:::image type="content" source="../media/subscriptions-example.png" alt-text="Diagram that shows subscription options for Tailwind Traders departments, such as sales, corporate, and IT." border="false":::

- **Treat subscriptions as a democratized unit of management**. Align your subscriptions to meet specific Tailwind Traders business needs and priorities.

- **Group subscriptions together under management groups**. Group together subscriptions that have the same set of policies and Azure role assignments to inherit these settings from the same management group. For Tailwind Traders, both the West and East subscriptions can inherit policy settings from the Sales management group. 

- **Consider a dedicated shared services subscription**. Use a shared services subscription to ensure all common network resources are billed together and isolated from other workloads. Examples of shared services subscriptions include Azure ExpressRoute and Virtual WAN. 

- **Consider subscription scale limits**. Subscriptions serve as a scale unit for component workloads. Large, specialized workloads like high-performance computing, IoT, and SAP are all better suited to use separate subscriptions. By having separate subscriptions for different Tailwind Traders groups or tasks, you can avoid [resource limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) (such as a limit of 50 Azure Data Factory integrations). 

- **Consider administrative management**. Subscriptions provide a management boundary, which allows for a clear separation of concerns. Will each subscription for Tailwind Traders need a separate administrator, or can you combine subscriptions? The Corporate management group could have a single subscription for both the HR and Legal departments. 

- **Consider how to assign Azure policies**. Both management groups and subscriptions serve as a boundary for the assignment of Azure policies. Workloads like those for the Payment Card Industry (PCI) typically require extra policies to achieve compliance. Rather than using a management group to group workloads that require PCI compliance, you can achieve the same isolation with a subscription. These types of decisions ensure you don't have too many Tailwind Traders management groups with only a few subscriptions. 

- **Consider network topologies**. Virtual networks can't be shared across subscriptions. Resources can connect across subscriptions with different technologies, such as virtual network peering or Virtual Private Networks (VPNs). Consider which Tailwind Traders workloads must communicate with each other when you decide if a new subscription is required.

- **Consider making subscription owners aware of their roles and responsibilities**. Conduct a quarterly or biannual access review by using Microsoft Entra Privileged Identity Management. Access reviews ensure privileges don't proliferate as users move within the Tailwind Traders customer organization.

> [!NOTE]
> When it comes to subscriptions, one size doesn't fit all. A solution that works for one business unit might not be suitable for another. Explore your options.
