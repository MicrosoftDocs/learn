Microsoft has been continually augmenting the portfolio of its commercial offerings to benefit customers who, like your company, remain committed to using Azure services. Azure savings plan for compute supplements that portfolio and represents an additional cost saving option available to existing and new customers.

### Use multiple Azure cost saving options

In general, compute cost comprises software and infrastructure components. To minimize the software cost of Windows Server and SQL Server workloads, Azure Hybrid Benefit-eligible customers can use existing on-premises licenses. The optimal approach to minimizing compute charges depends on your workloads:

- Azure reservations offer the maximum cost savings for stable, predictable workloads running on specific virtual machines in a specific Azure region.
- Spot Virtual Machines are optimal for interruptible workloads.
- Azure savings plan for compute is most suitable for customers who are looking for a flexible way to save costs on dynamic compute usage.

:::image type="content" source="../media/3-compute-costs-comparison.svg" alt-text="Diagram comparing the compute costs for with savings and without savings options." border="false":::

Some of the more common use cases for Azure savings plan for compute include scenarios where you have:

- Centralized budgeting and procurement.
- Dynamic workloads that move across data center regions (for example, in the follow-the-sun scenarios).
- An actively evolving IT roadmap (for example. a planned transition from the Infrastructure-as-a-Service to Platform-as-a-Service model).
- A need for automating cost optimization across a variety of services.

You can use both the Azure savings plan for compute and reservations. Microsoft automatically maximizes your benefit and savings across eligible usage each hour. Microsoft always applies the reservations first due to their more targeted scope and higher savings rates. Azure savings plan then applies to the remaining eligible usage until the commitment is fully consumed. After a reservation or an Azure saving plan for compute is fully consumed or expires, you will be billed on a pay-as-you-go basis.

Let’s assume that your compute cost totals **$1,000,000** per year billed on a **pay-as-you-go basis**. By allocating costs to the appropriate savings options based on your needs, you can optimize the cloud budget usage in the following manner:

- Purchase **reservations** for the most stable resource needs, lowering the $300,000 costs to $150,000.
- Purchase an Azure **savings plan** to cover the dynamic resource needs, lowering the $500,000 costs to $200,000.
- Continue **paying only for what you use** for the most inconsistent resource needs with no commitment required.

:::image type="content" source="../media/3-compute-costs-values.svg" alt-text="Example comparing the compute costs for the with savings and without savings options." border="false":::

Note that individual savings options are subject to their respective terms based on their purchase dates.

:::image type="content" source="../media/3-individual-savings-plan-purchase-dates.svg" alt-text="Diagram illustrating  that individual savings options are subject to their respective terms based on their purchase dates." border="false":::

To realize additional savings, customize the plan’s term length, scope, billing frequency, and hourly commitment according to the usage patterns of your compute resources. You should evaluate the optimal hourly commitment after savings are applied by comparing the lower saving plan prices vs. pay-as-you-go prices.

You can review personalized recommendations in the Azure portal based on the recent resource usage. It’s important to consider future needs for one or three years out when setting the hourly commitment amount. The longer-term plan offers more cost savings opportunities.

To summarize, a savings plan is designed for users that utilize compute resources in a predictable manner, but also need additional flexibility to accommodate changes. Reservations is a great option if you know exactly what you’ll need and are looking for additional savings.

In your case, you can continue leveraging your existing reservation commitments, which cover services such as Cosmos DB and Azure Storage. For others, you should consider the suitability of Azure savings plan for compute to workloads that transition across Azure regions in the follow-the-sun manner and will be rearchitected to take full advantage of the cloud capabilities.
