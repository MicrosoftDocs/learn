| :::image type="icon" source="../media/goal.svg"::: Boost efficiency without changing the design, reworking deals, or giving up any must-have features. |
| :----------------------------------------------------------------------------------------------------------------------------- |

You don't always need to redesign or renegotiate to save money. Sometimes, you can make better use of what you already have. If you don't optimize existing resources and operations, you could be wasting money without seeing any real benefit.

**Example scenario**

Contoso's business intelligence (BI) team hosts a suite of GraphQL APIs  so that different departments can access data without touching the databases directly. Over time, they've added versioning and now run everything through a single Azure API Management gateway on the Consumption tier.

Three Azure Kubernetes Service (AKS) clusters are behind the API Management instances:
  - One runs a Windows node pool for APIs written in .NET 4.5.
  
  - One Linux cluster for the APIs written in Java Spring. 
  - One runs a Windows node pool for APIs written in .NET Core on Linux. They inherited this cluster.
  
These clusters are only used for the APIs and are now all managed by the BI team. It's not the cleanest setup, but it works, so they've left it alone.

The BI team is a cost center in the business, so they're looking for ways to optimize its rates to drive down operating costs.

## Match pricing models to workload patterns

**Choose the right billing model based on how your workloads behave.**

Not all workloads need the same pricing model. Some run all the time and benefit from fixed pricing or reserved instances. Others are used occasionally and are better suited for pay-as-you-go pricing. Matching the pricing model to the workload helps avoid paying for unused capacity and keeps costs aligned with actual usage.

*Contoso's challenge*

- The team manages a suite of GraphQL APIs that serve different departments. Some APIs are used constantly, like daily reporting. Others only see traffic during specific business cycles, like quarterly planning or audit periods.

- Everything runs on always-on infrastructure, even the low-traffic APIs.
- They're using pay-as-you-go pricing across the board, even for workloads with predictable usage.

*Applying the approach and outcomes*

- The team identifies APIs that have steady usage and moves them to fixed-price SKUs or reserved instances to lock in savings.

- For APIs that have bursty or seasonal traffic, they switch to consumption-based services like Azure Container Apps.
- They also evaluate whether some APIs can be consolidated or scaled down during off-hours.
- These changes help them align costs with actual usage and avoid paying for idle resources.

## Optimize licensing and agreements

**Use smart licensing strategies and work with your licensing team to cut costs.**

Licensing can be a hidden cost driver. By using benefits like Azure Hybrid Benefit, dev/test pricing, and coordinating with your licensing team, you can reduce spend without changing how your workloads run. Forecasting your needs also helps your organization negotiate better deals that benefit multiple teams.

*Contoso's challenge*

- The team manages several AKS clusters that support their GraphQL APIs. One of those clusters runs Windows workloads, but the team hasn’t looked closely at how those workloads are licensed. The setup has been stable, and since costs haven’t spiked, there hasn’t been much urgency to revisit it.

- Their preproduction environments run in the same pricing tier and region as production. It’s convenient, but they’re starting to wonder if that’s the most efficient use of resources.
- Licensing decisions have mostly been handled separately from infrastructure planning, so the team hasn’t had much visibility into whether they’re getting the best possible pricing.

*Applying the approach and outcomes*

- The team reviews their AKS clusters and realize that the Windows node pools could qualify for Azure Hybrid Benefit. By applying their existing Windows Server licenses, they can reduce compute costs without changing the workload.

- They also evaluate their environment structure and move development and test workloads into dev/test subscriptions. To save even more, they shift those environments to lower-cost regions, since they don’t need the same performance or availability as production.
- They loop in the licensing team and share their usage forecasts. This collaboration helps procurement negotiate better enterprise agreements, unlocking extra savings.
- These steps reduce licensing costs and help the organization get better deals overall.

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
