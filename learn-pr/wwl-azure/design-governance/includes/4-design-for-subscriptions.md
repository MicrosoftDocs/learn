**Azure Subscriptions** are logical containers that serve as units of management and scale and billing boundaries. Limits and quotas can be applied, and each organization can use subscriptions to manage costs and resources by group.​ 

### Things to know about subscriptions

Using Azure requires an Azure subscription. A subscription provides you with a logical container to provision and pay for Azure products and services. There are [several types of subscriptions](https://azure.microsoft.com/support/legal/offer-details/), such as Enterprise Agreement and Pay-as-You-Go. 

:::image type="content" source="../media/azure-active-directory-subscriptions.png" alt-text="Azure Active Directory has dev, test, and production subscriptions.":::


You can use subscriptions to:

- Organize specialized workloads that need to scale outside the existing subscription limits.

- Provide different billing environments such as development, test, and production. 

- Achieve compliance by applying policies to a subscription. 

- Manage and track costs for your organizational structure.

### Things to consider when creating subscriptions

Tailwind Traders has established their management group structure. Now they need to determine where to assign subscriptions. Here’s one possible solution. 

:::image type="content" source="../media/subscriptions-example.png" alt-text="Subscriptions include sales, corporate, and IT.":::


- **Treat subscriptions as a democratized unit of management**. Align your subscriptions with business needs and priorities.

- **Group subscriptions together under management groups**. Grouping ensures that subscriptions with the same set of policies and Azure role assignments can inherit them from a management group. For example, both the West and East subscriptions will inherit policy from the Sales management group. 

- **Consider a dedicated shared services subscription**. A shared services subscription ensures that all common network resources are billed together and isolated from other workloads. For example, Azure ExpressRoute and Virtual WAN. 

- **Consider subscription scale limits.** Subscriptions serve as a scale unit for component workloads. For example, large, specialized workloads like high-performance computing, IoT, and SAP are all better suited to use separate subscriptions. Separate subscriptions will avoid [resource limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) (such as a limit of 50 Azure Data Factory integrations). 

- **Consider administrative management.** Subscriptions provide a management boundary, which allows for a clear separation of concerns. Will each subscription need a separate administrator, or can you combine subscriptions? In our example, the Corporate management group could have a single subscription for both the HR and Legal departments. 

- **Consider how you’ll assign Azure policies?** Both management groups and subscriptions serve as a boundary for the assignment of Azure policies. For example, workloads such as Payment Card Industry (PCI) workloads typically require additional policies to achieve compliance. Instead of using a management group to group workloads that require PCI compliance, you can achieve the same isolation with a subscription. These types of decisions ensure you don’t have too many management groups with only a few subscriptions. 

- **Consider network topologies.** Virtual networks can't be shared across subscriptions. Resources can connect across subscriptions with different technologies such as virtual network peering or Virtual Private Networks (VPNs). Consider which workloads must communicate with each other when you decide whether a new subscription is required.

- **Consider making subscription owners aware of their roles and responsibilities**. For example, conduct an access review using Azure AD Privileged Identity Management quarterly or twice a year. Access reviews ensure privileges don't proliferate as users move within the customer organization.

 

>[!NOTE]
>One size doesn't fit all for subscriptions. What works for one business unit might not work for another. 