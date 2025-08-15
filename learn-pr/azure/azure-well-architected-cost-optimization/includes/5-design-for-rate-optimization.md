| :::image type="icon" source="../media/goal.svg"::: Boost efficiency without changing the design, reworking deals, or giving up any must-have features. |
| :----------------------------------------------------------------------------------------------------------------------------- |

You don't always need to redesign or renegotiate to save money. Sometimes, you can make better use of what you already have. If you don't optimize existing resources and operations, you could be wasting money without seeing any real benefit.

**Example scenario**

Contoso's business intelligence (BI) team hosts a suite of GraphQL APIs  so that different departments can access data without touching the databases directly. Over time, they've added versioning and now run everything through a single Azure API Management gateway on the Consumption tier.

Three Azure Kubernetes Service (AKS) clusters are behind the API Management instances:
  - One runs a Windows node pool for APIs written in .NET 4.5.
  
  - One Linux cluster for the APIs written in Java Spring. 
  - One runs a Windows node pool for APIs written in .NET Core on Linux. They inherited this cluster from a prior team.
  
These clusters are only used for the APIs and are now all managed by the BI team. It's not the cleanest setup, but it works, so they've left it alone.

The BI team is a cost center in the business, so they're looking for ways to optimize its rates to drive down operating costs.

## Combine infrastructure where it makes sense

**Try to run things in the same place, whether it's resources, workloads, or teams. Use services that help you pack more into less space. Consider any trade-offs, especially around security.**

When you pack more utility into fewer systems, you use less hardware and spend less on managing it all. That means lower costs and less complexity.

*Contoso's challenge*

- Contoso's team followed the Microsoft AKS baseline architecture. They run three clusters that each have three system nodes, so nine nodes total.

- They apply patches and updates to all clusters three times every month.

*Applying the approach and outcomes*

- After the team does testing, they decide to combine all the APIs into a single cluster with three user node pools while achieving the same performance and OS characteristics of their original cluster.

- They also consolidate to four nodes for their system node pool, saving the costs of five virtual machines.
- Now they only have one cluster to patch and update, which saves even more time.
- Next, they're looking at merging two Linux node pools into one to make things even simpler.

## Take advantage of reservations and other infrastructure discounts

**Optimize by committing and prepurchasing to take advantage of discounts offered on resource types that aren't expected to change over time and for which costs and utilization are predictable. Also, work with your licensing team to influence future purchase agreement programs and renewals.**

Microsoft offers reduced rates for predictable and long-term commitment to specific resources and resource categories. Resources cost less during the usage period and can be amortized over the period.

By keeping your licensing team aware of the current and predicted investment by resource, you can help them rightsize commitments when your organization signs the agreement. In some cases, these projections and commitments could influence your organization's price sheet, which benefits your workload's cost and also other teams that use the same technology.

*Contoso's challenge*

- Now that the team has consolidated onto one cluster, removing some of the excess compute and operational burden they previously absorbed, they're interested in finding additional measures to lower the cost of the cluster.

- Because the BI team is happy with the AKS platform, they plan on continuing to use it for the foreseeable future, and likely will even grow its usage.

*Applying the approach and outcomes*

- Because AKS is built on top of Azure Virtual Machine Scale Sets, the team looks into Azure reservations. They know the expected SKUs and scale units they need for the user nodes.

- They purchase a three-year reservation that covers the system node pool and the minimum instance count of nodes per user node pool.
- With this purchase, the team knows they're getting the best deal on their compute needs while allowing the workload to grow over time.

## Use fixed-price billing when practical

**Switch to fixed-price billing instead of consumption-based billing for a resource when its utilization is high and predictable and a comparable SKU or billing option is available.**

When utilization is high and predictable, the fixed-price model usually costs less and often supports more features. Using it could increase your ROI.

*Contoso's challenge*

- The API Management instances are all deployed as Consumption tier SKUs currently. After evaluating the APIs' usage patterns, they understand that the APIs are used globally and sometimes quite heavily. The team decides to analyze the cost differences between the current billing model and a fixed-price model.

*Applying the approach and outcomes*

- After performing the cost analysis, the team finds that migrating from Consumption to Standard tier will be a bit less expensive overall given the current usage patterns. As the services grow over the next year, the cost differences will likely become more pronounced. Even though the fixed-pricing model doesn't reflect the elasticity characteristics of the requests, sometimes prepurchased billing models are the right choice.

- As an added bonus, using the Standard tier allows the use of a private endpoint for inbound connections, which the team has been eager to implement for the workload.
- In this case, switching SKUs made sense for both utilization purposes and for the added benefit of the additional network segmentation that's possible with a private endpoint implementation.