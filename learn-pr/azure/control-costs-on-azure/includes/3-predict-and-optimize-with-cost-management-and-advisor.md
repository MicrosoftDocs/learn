So we've talked about how to estimate your costs before you deploy services on Azure, but what if you already have resources deployed? How do you get visibility into the costs you're already accruing? If we deployed our previous solution to Azure and now want to make sure that we've sized the virtual machines properly, and predict how much our bill will be, how can we do this? There are a few tools on Azure that you can use to help you solve this problem.

## Azure Advisor

Azure Advisor is a free service built into Azure that provides recommendations on high availability, security, performance, and cost. Advisor analyzes your deployed services and looks for ways to improve your environment across those four areas. We'll focus on the cost recommendations here, but you'll want to take some time to review the other recommendations as well.

You can find Advisor in the portal where you can see all recommendations, and you'll also see Advisor recommendations as a panel at a virtual machine level. Advisor makes cost recommendations in the following areas:

- **Reduce costs by eliminating unprovisioned ExpressRoute circuits** - this identifies ExpressRoute circuits that have been in the provider status of Not Provisioned for more than one month, and recommends deleting the circuit if you aren't planning to provision the circuit with your connectivity provider.
- **Buy reserved instances to save money over pay-as-you-go** - this reviews your virtual machine usage over the last 30 days and determine if you could save money by purchasing reserved instances. Advisor will show you the regions and sizes where you potentially have the most savings and will show you the estimated savings from purchasing reserved instances.
- **Right-size or shutdown underutilized virtual machines** - this monitors your virtual machine usage for 14 days and then identifies low-utilization virtual machines. Virtual machines whose average CPU utilization is 5 percent or less and network usage is 7 MB or less for four or more days are considered low-utilization virtual machines. The average CPU utilization threshold is adjustable up to 20%. By identifying these underutilized virtual machines, you can decide to resize them to a smaller instance type, reducing your costs.

These recommendations are all places where you may be inefficiently spending money, and are a great place to start and continue to revisit when looking for places to reduce cloud spend. Be sure and review this periodically for recommendations across all four areas.

## Azure Cost Management

Azure Cost Management is another free, built in Azure tool that can be used to gain greater insights into where your cloud spend is going. You can see historical breakdowns of what services you are spending your money on, and how it is tracking against budgets that you have set. You can set budgets, schedule reports, and analyze your areas of spend.

**Show a screenshot where we're able to track against a budget** https://docs.microsoft.com/en-us/azure/billing/billing-getting-started

## Cloudyn

Cloudyn, a Microsoft subsidiary, allows you to track cloud usage and expenditures for your Azure resources and other cloud providers including AWS and Google. Easy-to-understand dashboard reports help with cost allocation and showbacks/chargebacks as well. Cost Management helps optimize your cloud spending by identifying underutilized resources that you can then manage and adjust. Usage for Azure is free, and there are paid options for premium support and to view data from other clouds.

**Show a screenshot here where we're able to save money by identifying waste**

## Summary

The important thing to take away from what we've talked about here is that there are several tools you can use to track and predict your cloud spend, and identify where your environment may be inefficient from a cost perspective. Now let's take a look at some best practices to reduce your infrastructure costs.