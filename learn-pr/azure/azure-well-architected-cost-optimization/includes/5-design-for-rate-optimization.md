| :::image type="icon" source="../media/goal.svg"::: Increase efficiency without redesigning, renegotiating, or sacrificing functional or nonfunctional requirements. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Take advantage of opportunities to optimize the utility and costs of your existing resources and operations. If you don't, you unnecessarily spend money without any added ROI.

**Example scenario**

Contoso's business intelligence (BI) team hosts a suite of GraphQL APIs for various business units to access data stores across the organization without granting direct database access. They’ve been building these up over the years and found that versioning was important, so they have been exposing their APIs now over versioned endpoints on a single Consumption tier API Management gateway.

Behind the API Management instances are three AKS clusters that host the APIs that are exposed. One running a Windows node pool for APIs written in .NET 4.5, one Linux cluster for the APIs written in Java Spring, and one Linux they inherited from a prior team running dotnet core APIs. The clusters are now all owned by the BI team and are only used for these APIs. While managing three clusters isn’t ideal, they've been working as intended so have been left alone.

As a cost center in the business, the BI team is looking for ways to optimize its rates to drive down operating costs.

## Consolidate infrastructure where practical

**Co-locate usage with other resources, workloads, and even teams. Prefer services that make it easier to achieve higher density. Consider the potential tradeoffs, especially on security boundaries.**

Consolidating your infrastructure will help you optimize your cloud costs. As density increases, the amount of resources that you need to run a workload decreases. This decrease reduces cost per unit and the cost of management.

*Contoso's challenge*

- The workload team has designed their AKS infrastructure according to the Microsoft baseline architecture guidance, which recommends running at least three nodes per cluster. This configuration has resulted in the team supporting nine system nodes across the three clusters.
- The team applies patches and updates to the clusters three times per month.

*Applying the approach and outcomes*

- After testing, the team decides that they can combine all the API into a single cluster with three user node pools while achieving the same performance and OS characteristics of their original cluster.
- After consolidating the APIs onto one cluster, they consolidate to four nodes for their system node pool, saving the costs of five virtual machines.
- The team can also now streamline their patching and upgrading process on their cluster as they only have one cluster to manage.
- Their next cost savings goal is to evaluate consolidating the two linux node pools into one to reduce the operational overhead even further.

## Take advantage of reservations and other infrastructure discounts

**Optimize by committing and pre-purchasing to take advantage of discounts offered on resource types that aren't expected to change over time and for which costs and utilization are predictable. Also, work with your licensing team to influence future purchase agreement programs and renewals.**

Microsoft offers reduced rates for predictable and long-term commitment to specific resources and resource categories. Resources cost less during the usage period and can be amortized over the period.

By keeping your licensing team aware of the current and predicted investment by resource, you can help them right-size commitments when your organization signs the agreement. In some cases, these projections and commitments could influence your organization's price sheet, which benefits your workload's cost and also other teams that use the same technology.

*Contoso's challenge*

- Now that the team has consolidated onto one cluster, removing some of the excess compute and operational burden they previously absorbed, they're interested in finding additional measures to lower the cost of the cluster.
- Because the BI team is happy with the AKS platform, they plan on continuing to use it for the foreseeable future, and likely will even grow its usage.

*Applying the approach and outcomes*

- Because AKS is built on top of Virtual Machine Scale Sets, the team looks into Azure Reservations. They know the expected SKUs and scale units they need for the user nodes.
- They purchase a three-year reservation that covers the system node pool and the minimum instance count of nodes per user node pool.
- With this purchase, the team knows they're getting the best deal on their compute needs while allowing the workload to grow over time.

## Use fixed-price billing when practical

**Switch to fixed-price billing instead of consumption-based billing for a resource when its utilization is high and predictable and a comparable SKU or billing option is available.**

When utilization is high and predictable, the fixed-price model usually costs less and often supports more features. Using it could increase your ROI.

*Contoso's challenge*

- The API Management instances are all deployed as Consumption tier SKUs currently. After evaluating the APIs' usage patterns, they understand that the APIs are used globally and sometimes quite heavily. The team decides to analyze the cost differences between the current billing model and a fixed-price model.

*Applying the approach and outcomes*

- After performing the cost analysis, the team finds that migrating from Consumption to Standard tier will be a bit less expensive overall given the current usage patterns. As the services grow over the next year, the cost differences will likely become more pronounced. Even though the fixed-pricing model doesn't reflect the elasticity characteristics of the requests, sometimes prepurchased billing models are the right choice.
- As an added bonus, using the Standard tier allows the use of a Private Endpoint for inbound connections, which the team has been eager to implement for the workload.
- In this case, switching SKUs made sense for both utilization purposes and for the added benefit of the additional network segmentation that's possible with a Private Endpoint implementation.
