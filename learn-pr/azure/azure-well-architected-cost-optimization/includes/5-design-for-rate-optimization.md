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

## Save more with reservations and discounts

**Save money by locking in long-term deals for resources that you know you'll use consistently. And keep your licensing team in the loop. They can help you get better pricing when it's time to renew or sign new agreements.**

Microsoft gives you better rates when you commit to using certain resources long-term, especially if you know that your usage won't change much. You'll pay less over time, and it's easier to spread out the cost.

Make sure your licensing team knows what you're using now and what you expect to use later. That way, they can make smarter decisions when it's time to renew or sign new deals. In some cases, your input could even help lower prices for other teams that use the same tools.

*Contoso's challenge*

- Now that the team has everything running in one cluster, they've reduced extra compute and maintenance work. They're looking for more ways to reduce the cost even further.

- The BI team is happy with how AKS is working, so they plan to stick with it long-term and maybe even expand how much they use it.

*Applying the approach and outcomes*

- AKS runs on top of Virtual Machine Scale Sets, so the team looks into Azure reservations. They already know which SKUs and sizes they need for their user nodes.

- They purchase a three-year reservation that covers the system node pool and the minimum number of nodes for each user node pool.
- Now they're saving money on compute and still have room to grow as needed without overpaying.

## Use fixed-price billing when practical

**If you use a resource often and you know it'll stay that way, switch to fixed pricing instead of consumption-based. It'll save you money if there's a comparable option available.**

When usage is high and predictable, a fixed-price model usually costs less and often supports more features. It's a smart way to boost your return on investment.

*Contoso's challenge*

- The API Management instances currently use the Consumption tier. But after looking at how often and how heavily the APIs are used, especially across different regions, they realized it might be time to rethink the pricing model. So, they're now comparing the current consumption-based setup with a fixed-price option.

*Applying the approach and outcomes*

- After doing a cost analysis, the team finds that switching from the Consumption tier to the Standard tier actually saves them money based on how they use the APIs. And as usage grows over the next year, the savings will likely get even better.

  Even though fixed pricing doesn't perfectly match the ups and downs of their traffic, sometimes locking in a set rate just makes more sense, especially when usage is steady and growing.

- As a bonus, switching to the Standard tier lets the team use a private endpoint for incoming traffic, which is something they've been wanting to set up for a while.
- So in this case, changing SKUs saves money and gives them better network control with added security.

