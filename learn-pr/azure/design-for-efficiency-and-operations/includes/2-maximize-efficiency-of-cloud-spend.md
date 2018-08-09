As you move to the cloud, your costs are going to play a large role in your success. Spend too much money and you jeopardize the health of your business. Let's imagine the healthcare company you work for has seen their bill increase steadily over the last few months, but aren't sure if this increase is natural, efficient growth or if it's due to waste and inefficiencies. How do you make sure you're being as efficient as possible? What does efficiency even look like? Let's look at some ways to ensure your architecture is making best use of your money.

## How the cloud changes your expenses

One of the fundamental differences between the public cloud and on-premises infrastructure is how you pay for the services you use. In an on-premises data center hardware procurement time is typically long, costs are hidden, and hardware is typically spec'd out for maximum capacity. Purchasing physical infrastructure ties up investments in long-term assets, hindering your ability to be agile with the resources you actually need.

Shifting to the cloud introduces a true pay for what you use cost model and costs are fully transparent. You no longer need to tie up investments in assets, and if your resource requirements change you can quickly and easily shift your costs along with them. Workloads are going to vary between and within services, demand can be unpredictable, and your growth patterns will shift over time. Since you only pay for what you use on the cloud, your cost structure can move in sync with these changes in resources.

![Service Health](../media/2-maximize-efficiency-of-cloud-spend/cloudcomputingpatterns.png)

```[JB] Let's add some details around what being efficient is. What properties make up an efficient system?```

In this module, we'll focus on covering various techniques to make sure costs can be optimized where possible. Another term for this optimization is *right-sizing*. In the module on monitoring and analytics, we'll cover approaches to ensure your workload is not *undersized* resulting in a poor experience for your end users. Whenever your deploying a new service to Azure it's a good practice to set aside some time to read through the pricing documentation in order to have a good understanding of the potential impact of a certain deployment. Taking it one step further you could even use the Azure Pricing calculator to forecast what a certain workload is going to cost. It's impossible to optimize your cloud spend without having a good understanding of your current spending patterns.
```[JB] I think we should remove this paragraph and try instead to make a smoother transition to the next section. We don't need to detail what we'll cover in this unit (they're already in it) and we'll frame up the next unit when we start that one.```

Now that we've talked through how the cloud changes your expenses, there's a path you can follow to ensure you're efficient, and maintain your efficiency. Tracking your spend, organizing your resources, and optimizing your resources. 
```[JB] Added this paragraph, not sure I totally like the wording, but we need to show how all the stuff below connects into an approach they can follow.```

## Track your cloud spend

```[JB] This section as a whole doesn't feel quite right. Instead of jumping straight into Cost Management, can we talk a bit about why the reporting is important, and how matching up spend with resource utilization will help identify inefficiencies in your environment?```
Getting costs under control typically involves various steps. The first step is knowing where to look to get a good overview of what costs are being charged. Azure offers [Azure Cost Management](https://docs.microsoft.com/en-us/azure/cost-management/overview) which can help you generate various reports depending on your needs. If you prefer to work with the raw data and build reports yourself, you can always extract the consumption details and use excel or Power BI to generate the views you're after.

The advantage of Azure Cost Management is that it abstracts away the complexity of the underlying data model present in a typical billing scenario. There's numerous fields with complex data and it might seem daunting at first to visualize your consumption. Azure Cost Management gives you a jump-start by offering various ways to visualize the data and even offer some built-in reports that make you save money right away.

## Organize to optimize

```[JB] Made this a section and added the title, not 100% sold on the title, but we can split these into two different sections I think.```

```[JB] Can we make this flow a little better? What is baseline consumption, why does it matter?How do I get my baseline consumption?```
Once you know where to look for your consumption, you can start getting a better understanding. Without having some kind of an idea about the **baseline consumption** (for example, during the last 30 days) it's difficult to detect workloads causing more consumption than expected. This increase in consumption could potentially be going on for months before it's detected. That's why as one of the first things to master when taking control of your consumption is to have an idea of this baseline consumption. Depending on the size of your environment, you baseline might be for all of the Azure consumption. For larger organizations each team might need to have a good understanding of their specific consumption baseline.

```[JB] This is good info to put here, but why are we doing this? Can we explain this better?```
There are various ways to ensure you can allocate a specific cost to a specific team or any other dimension you might have in mind:

* Putting resources in different **subscriptions**
* Putting resources in different **resource groups**
* Applying **tags** to resources

While the subscription and resource group hierarchy allow you to allocate costs to different buckets, there might also be other factors driving their structure. Role-based access control and limits on the subscription level might further push this hierarchy away from the intended model that would provide the best consumption insights.

The tagging option provides the best flexibility as this can changed as many times as desired throughout the life cycle of the resource. Applying tags to resources, or in short tagging resources, is a capability Azure provides in which you can apply up to 15 key-value pairs to a resource. The following list shows some example keys that are frequently used:

* Cost Center
* Department / Business Unit
* Environment (Production, Stage, Development)
* Application Owner
* Project Name

Applying tags does take some discipline, but luckily there are various controls that can help you. Tags can be easily included in Resource Manager templates so resources are tagged correctly right from the beginning. Alternatively the Azure portal also allows for bulk adding of tags, which can be a great way to tag many resources at once.

```[JB] This seems out of place, just like a random screenshot. Do we need this here or can we give some better explanation around it?```
Here's a screenshot of the Azure portal cost analysis experience:

![Portal Cost Analysis](../media/2-maximize-efficiency-of-cloud-spend/portal-cost-analysis.png)

Using these insights should allow you to get an idea of how costs are distributed. Understanding where the largest contributors are is good to know where you might potentially optimize. In an organization that's deploying many IaaS resources the virtual machine compute cost is often a good place to start. The following section will cover some tips on how cost savings might be realized.

## Optimizing IaaS Costs

```[JB] We've already covered much of this in an earlier section, can we instead focus on how/why we would optimize IaaS costs, and make a better introduction to the sections below?```
When you deploy a virtual machine on-premises, you don't really pay. Well, strictly spoken that's not true, you do have certain operational and facility costs (for example, electricity), but the compute power itself was paid earlier when you bought the required hardware. The hardware was paid for in full regardless of whether you use it or not. In Azure, there's a different approach. You only pay for what you use. Running virtual machines involves various costs: compute, network, and storage. Network costs are typically only a small portion compared to the compute and storage costs of a virtual machine.

```[JB] Can we add a sentence or two here introducing the following areas of IaaS that we're going to provide details on for optimization?```

### Compute

There are different options available to achieve cost savings for virtual machines.

* Choose a smaller virtual machine instance size
* Reduce the number of hours a virtual machine runs
* Use discounts for the compute costs

#### Right-size virtual machines

When creating on-premises virtual machines, there's often a hard boundary that's limiting how many VMs and how much resources they can consume. This boundary is a lot higher in Azure and thus the size and number of VMs you ask will be deployed for you. But is it required that the server running a given application is so large?

When you choose a VM size that's one size smaller than the one your running today, you will already save 50% of the costs to run that VM. So this is definitely something worth looking into. After all, by switching to a smaller size you can still have the same functionality with reduced costs. Assuming the VM is oversized that is.

[Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations#optimize-virtual-machine-spend-by-resizing-or-shutting-down-underutilized-instances) can be a great help in identifying which virtual machines are underutilized. Advisor monitors your virtual machine usage for 14 days and then identifies low-utilization virtual machines. Virtual machines whose CPU utilization is 5 percent or less and network usage is 7 MB or less for four or more days are considered low-utilization virtual machines.

#### Implement shutdown schedules for virtual machines

There are many cases where a VM is used on a regular base but there's no need to actually run 24/7. A common example is a vm used by a developer to deploy and test new code. The developer will probably depend on this machine during business hours but after hours and in the weekend there's no need to have this machine running. If a full day consists of 24 hours, then only running the VM between 9:00 and 17:00 would result in a cost reduction of 66% for that VM. If the machine doesn't need to be on the weekend that would further reduce costs. To avoid forgetting to shut down the machine, it's recommended to look at implementing VM auto-shutdown where possible. When we want the VMs to also automatically start in the morning, we can use Azure Automation.

![Service Health](../media/2-maximize-efficiency-of-cloud-spend/auto-shutdown.png)

#### Apply compute cost discounts

The [**Azure Hybrid Benefit**](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/) allows you to further optimize your costs for both Windows Server and SQL Server by allowing you to use your on-premises Windows Server or SQL Server licenses with Software Assurance to be used as a discount towards to the compute cost of these VMs.

Some virtual machines need to be up and running all the time. Maybe you have a web application server farm for a production workload or maybe a domain controller supporting various servers on a virtual network. If you know with certainty that these virtual machines will run over the coming year or maybe longer, you might further achieve cost savings by deciding to buy a Reserved Instance for those VM's instance size and the region where they're deployed. [**Azure Reserved VM Instances**](https://docs.microsoft.com/en-us/azure/billing/billing-save-compute-costs-reservations) helps you save money by pre-paying for one-year or three-years of compute capacity allowing you to get a discount on the virtual machines you use. Azure reserved instances can significantly reduce your virtual machine costs—up to 72 percent on pay-as-you-go prices–with one-year or three-year upfront commitment. Reserved instances provide a billing discount and do not affect the runtime state of your virtual machines.

[Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations#buy-virtual-machine-reserved-instances-to-save-money-over-pay-as-you-go-costs) will review your virtual machine usage over the last 30 days and determine if you could save money by buying reserved instances. Advisor will show you the regions and sizes where you potentially have the most savings and will show you the estimated savings from buying reserved instances.

### Virtual machine disk storage cost optimization

```[JB] Moved this section down to go through compute costs first since they are the biggest driver of cost typically. Also renamed it to add clarity since we talk about storage below as well```

```[JB] Can we make this flow better? Some of these sentences don't sound quite right.```
The storage costs being charged are covering for the disks used by the virtual machine. As these disks are persistent they are charged for during their full life cycle, even if the virtual machine is deallocated. One of the potential hidden costs in your environment might be the one of managed disks or disk snapshots that are no longer used. When deleting a virtual machine, it's easy to forget deleting the association disk(s) and snapshots. While the virtual machine no longer exists, charges will still occur for the disks that used to belong to the virtual machine.

There are various ways to avoid this. Grouping resources that have a common life cycle together in a resource group allows for easier cleanup by deleting the resource group. Through automation or reporting it's also possible to gather the list of disks that are not associated with any VM and therefore are potential candidates for deletion. Azure Cost Management even has a built-in report to display these disks.

## Optimizing PaaS costs

Similar as with IaaS PaaS offers certain techniques, which could be used to optimize your cloud spend without loosing functionality. In the following sections we'll provide two examples: for Azure SQL and for blob storage

### Optimizing Azure SQL Database costs

```[JB] Can you make this flow better? Some of these sentences don't make sense grammatically.```
When creating an Azure SQL database, you have to select an Azure SQL Server and decide on a performance tier. Each performance tier comes with a certain cost associated with it and allows the database to operate at a certain performance level (the so called Database Transaction Units (DTUs)). The load on a database might be steady in which you can easy right-size the pricing tier resulting in enough performance at the right price. But what if your database has unpredictable bursts? At certain points in time, you want to cater for those peaks but you rather won't pay for that peak performance at all time.

When you have several databases each with their own load patterns, you can combine them in a [SQL Database elastic pool](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool). All databases in a SQL database elastic pool run on a single Azure SQL Database server and share a set number of resources at a set price.

[SQL Database elastic pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool) are a simple, cost-effective solution for managing and scaling several databases that have varying and unpredictable usage demands. The databases in an elastic pool are on a single Azure SQL Database server and share a set number of resources at a set price. Elastic pools in Azure SQL Database enable SaaS developers to optimize the price performance for a group of databases within a prescribed budget while delivering performance elasticity for each database.

### Blob storage

Many applications have a need for blob storage to store data on. There are many different types of data that can be stored each which might have different access patterns. A medical imaging application for instance might store many images on blob storage resulting in a considerate cost for the application because of the sheer amount and size of these files. If an image has been taken for a patient, then it's likely that in the first week that image might be consulted by someone. So it's important that the time required to access that image, that blob, is as small as possible. But maybe it's ok for an image that was taken over a year ago just to be available, but not as fast. Having different types of blobs each with their own access pattern and cost is what we call tiering.

Azure storage offers [three storage tiers](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers) for Blob object storage so that you can store your data most cost-effectively depending on how you use it. The Azure hot storage tier is optimized for storing data that is accessed frequently. The Azure cool storage tier is optimized for storing data that is infrequently accessed and stored for at least 30 days. The Azure archive storage tier is optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements.

Each of these tiers has a different cost:

* **Hot access tier**: has higher storage costs than cool and archive storage, but the lowest access costs
* **Cool access tier**: has lower storage costs and higher access costs compared to hot storage. This tier is intended for data that will stay in the cool tier for at least 30 days.
* **Archive access tier**: has the lowest storage cost and higher data retrieval costs compared to hot and cool storage. This tier is intended for data that can tolerate several hours of retrieval latency and will stay in the archive tier for at least 180 days.

```[JB] If there's information to cover on pricing, put some of that here (minus the specific costs) otherwise let's not link to pricing pages.```
To learn more about the actual pricing take a look [here](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/).


## Knowledge Check

What happens with the Reserved Instance if you delete a VM and create another one

* it still applies if you create it in the same region
* it still applies if you create it with the same size
* **it still applies if you create it in the same region and the same size**
* it only applies if you give the VM the same name
* it no longer applies

When does VM compute cost stop from being charged

* when you shut down the VM from inside the guest
* **when you stop the VM from the Portal**
* When you shut down the VM from inside the guest or from the Portal 


## Resources [To Be removed]

Some of the resources I used. 
https://docs.microsoft.com/en-us/azure/cost-management/
https://docs.microsoft.com/en-us/azure/billing/billing-getting-started
https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption-guide/subscription-governance
https://docs.microsoft.com/en-us/azure/billing/billing-understand-your-bill
https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations

