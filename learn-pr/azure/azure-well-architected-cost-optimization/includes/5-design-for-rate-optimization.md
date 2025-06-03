| :::image type="icon" source="../media/goal.svg"::: Boost efficiency without changing the design, reworking deals, or giving up any must-have features. |
| :----------------------------------------------------------------------------------------------------------------------------- |

You don't always need to redesign or renegotiate to save money. Sometimes, you can make better use of what you already have. If you don't optimize existing resources and operations, you could be wasting money without seeing any real benefit.

**Example scenario**

Contoso's business intelligence (BI) team hosts a suite of GraphQL APIs  so that different departments can access data without touching the databases directly. Over time, they've added versioning and now run everything through a single Azure API Management gateway on the Consumption tier.

Three AKS clusters are behind the API Management instances:
  - One runs a Windows node pool for APIs written in .NET 4.5.
  
  - One Linux cluster for the APIs written in Java Spring. 
  - One runs a Windows node pool for APIs written in .NET Core on Linux. They inherited this cluster.
  
These clusters are only used for the APIs and are now all managed by the BI team. It's not the cleanest setup, but it works, so they've left it alone.

The BI team is a cost center in the business, so they're looking for ways to optimize its rates to drive down operating costs.

## Match pricing models to workload patterns

**Choose the right billing model based on how your workloads behave.**

Not all workloads need the same pricing model. Some run all the time and benefit from fixed pricing or reserved instances. Others are used occasionally and are better suited for pay-as-you-go or consumption-based pricing. Matching the pricing model to the workload helps avoid paying for unused capacity and keeps costs aligned with actual usage.

*Contoso's challenge*

- Some APIs are used heavily and consistently, while others are only active during peak times like registration.

- Everything runs on always-on infrastructure, even the low-traffic APIs.
- They're using pay-as-you-go pricing across the board, even for workloads with predictable usage.

*Applying the approach and outcomes*

- The team identifies APIs with steady usage and moves them to fixed-price SKUs or reserved instances to lock in savings.

- For APIs with bursty or seasonal traffic, they switch to consumption-based services like Azure Container Apps.
- They also evaluate whether some APIs can be consolidated or scaled down during off-hours.
- These changes help them align costs with actual usage and avoid paying for idle resources.

## Optimize licensing and agreements

**Use smart licensing strategies and work with your licensing team to cut costs.**

Licensing can be a hidden cost driver. By using benefits like Azure Hybrid Benefit, dev/test pricing, and coordinating with your licensing team, you can reduce spend without changing how your workloads run. Forecasting your needs also helps your organization negotiate better deals that benefit multiple teams.

*Contoso's challenge*

- They're running Windows workloads on AKS without using Azure Hybrid Benefit.

- Preproduction environments are deployed in the same pricing tier and region as production.
- They haven't coordinated with the licensing team, so they're missing out on potential discounts.

*Applying the approach and outcomes*

- The team enables Azure Hybrid Benefit to use existing Windows Server licenses.

- They move dev and test environments to Dev/Test subscriptions and lower-cost regions.
- They share their usage forecasts with the licensing team to help negotiate better enterprise agreements.
- These steps reduce licensing costs and help the organization get better deals overall.

## Combine infrastructure where it makes sense

**Try to run things in the same place, whether it's resources, workloads, or teams. Use services that help you pack more into less space. Consider any trade-offs, especially around security.**

When you pack more utility into fewer systems, you use less hardware and spend less on managing it all. That means lower costs and less complexity.

*Contoso's challenge*

- Contoso's team followed the Microsoft Azure Kubernetes Service (AKS) baseline architecture. They run three clusters that each have three system nodes, so nine nodes total.

- They apply patches and updates to all clusters three times every month.

*Applying the approach and outcomes*

- After the team does testing, they decide to combine all the APIs into a single cluster with three user node pools while achieving the same performance and OS characteristics of their original cluster.

- They also consolidate to four nodes for their system node pool, saving the costs of five virtual machines.
- Now they only have one cluster to patch and update, which saves even more time.
- Next, they're looking at merging two Linux node pools into one to make things even simpler.
