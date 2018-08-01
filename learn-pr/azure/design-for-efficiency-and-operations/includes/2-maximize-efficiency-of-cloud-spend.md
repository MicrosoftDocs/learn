# Maximize efficiency of cloud spend

Lamna Healthcare is a national healthcare provider with several thousand physicians and clinicians across multiple facilities throughout the country. Their IT organization has recently undertaken an effort to exit their data center footprint and move the majority of their IT systems to Azure. They have a mixture of in-house developed applications open source and off-the-shelf applications, with varying architectures and technology platforms. While they are very satisfied with the services they have running they are a bit worried about the monthly costs being higher than expected. They are looking to get a better understanding of their current consumptions and would also leverage some tricks to optimize consumption.

## Understand resource billing

As a starting point it's important to understand the pricing options for each service you deploy in Azure. Some of these services are free, others have to be paid for. All of the Azure services have a well documented pricing page that clearly explains what to expect. [Here's](https://azure.microsoft.com/en-us/pricing/details/storage/) an example for Azure storage.

Virtual machines involve various resources each with their pricing model. Each VM might have compute, storage and network costs. Some of these will only be accounted for when the VM is actually allocated but will not be accounted for when the VM is deallocated. Needless to say if an instance of a virtual machine is not actually used it's recommended to deallocate or delete it in order to save money.

When trying to optimize your deployed resources for costs it's really important to take a step back and look where the real gains are to be achieved. One of the costs that typically jumps out is the cost for running the virtual machines, the compute cost. Some of the following sections will guide you through the various principles that can be applied and which will result in cost savings.

## Right-size virtual machines

When creating on-premises virtual machines there's often a hard boundary that's limiting how many VMs and how much resources they can consume. This boundary is a lot higher in Azure and thus the size and amount of VMs you ask will be deployed for you. But is it really required that the server running a given application is so big?

As a simple rule of thumb when you choose a VM size that's one size smaller than the one your running today you will already save 50% of the costs to run that VM. So this is definitely something worth looking into. After all by switching to a smaller size you can still have the same functionality with reduced costs. Assuming the VM is oversized that is.

[Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations#optimize-virtual-machine-spend-by-resizing-or-shutting-down-underutilized-instances) can be a great help in identifying which virtual machines are underutilized. Advisor monitors your virtual machine usage for 14 days and then identifies low-utilization virtual machines. Virtual machines whose CPU utilization is 5 percent or less and network usage is 7 MB or less for four or more days are considered low-utilization virtual machines.

<consider: insert screenshot of azure advisor recommendation?>

## Implement shutdown schedules for virtual machines

There are many cases where a VM is used on a regular base but there's no need to actually run 24/7. A common example is a vm used by a developer to deploy and test new code. The developer will probably depend on this machine during business hours but after hours and in the weekend there's no need to have this machine running. If a full day consists of 24 hours than only running the VM between 9:00 and 17:00 would result in a cost reduction of 66% for that VM. If the machine doesn't need to be on the weekend that would further reduce costs. In order to avoid forgetting to shutdown the machine it's recommended to look at implementing [VM auto-shutdown](https://docs.microsoft.com/en-us/azure/billing/billing-getting-started#consider-enabling-cost-cutting-features-like-auto-shutdown-for-vms) where possible. When it's desired that the VMs also automatically start in the morning we can leverage Azure Automation. An example approach is explained [here](https://docs.microsoft.com/en-us/azure/automation/automation-solution-vm-management) but if you don't like that one or want to build your one you can start by using one of the many other examples from the [Runbook Gallery](https://docs.microsoft.com/en-us/azure/automation/automation-runbook-gallery).

<consider: insert screenshot of auto-shutdown blade?>

## Leverage Reserved Instances

Even if a VM is required to run all the time it's possible to achieve cost savings by deciding to buy a Reserved Instance for that VM's SKU and the region where it's deployed. [Azure Reserved VM Instances](https://docs.microsoft.com/en-us/azure/billing/billing-save-compute-costs-reservations) helps you save money by pre-paying for one-year or three-years of compute capacity allowing you to get a discount on the virtual machines you use. Azure reserved instances can significantly reduce your virtual machine costs—up to 72 percent on pay-as-you-go prices–with one-year or three-year upfront commitment. Reserved instances provide a billing discount and do not affect the runtime state of your virtual machines.

[Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations#buy-virtual-machine-reserved-instances-to-save-money-over-pay-as-you-go-costs) will review your virtual machine usage over the last 30 days and determine if you could save money by purchasing reserved instances. Advisor will show you the regions and sizes where you potentially have the most savings and will show you the estimated savings from purchasing reserved instances.

<consider: insert image of RI savings? e.g. from here: https://azure.microsoft.com/en-us/pricing/reserved-vm-instances or an image from Cloudyn RI simulation>

## Save on Compute costs by leveraging Azure Hybrid Use Benefit (AHUB)

The Azure Hybrid Use Benefit ([AHUB](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/)) allows you to further optimize your costs for both Windows Server and SQL Server by allowing you to use your on-premises Windows Server or SQL Server licenses with Software Assurance to be used as a discount towards to the compute cost of these VMs.

## Clean up old managed disks and disk snapshots

One of the potential hidden costs in your environment might be the one of managed disks or disk snapshots that are no longer used. When deleting a virtual machine it's easy to forget deleting the association disk(s) and snapshots. While the virtual machine no longer exists charges will still occur for the disks that used to belong to the virtual machine.

There are various ways to avoid this. Grouping resources that have a common life cycle together in a resource group allows for easier clean up by deleting the resource group. Through automation or reporting it's also possible to gather the list of disks that are not associated with any VM and thus are potential candidates for deletion. [Azure Cost Management](https://docs.microsoft.com/en-us/azure/cost-management/overview#improve-efficiency) even has a built-in report to display these disks.

## Leverage SQL Database Elastic Pools to optimize Azure SQL Costs

While the sections above are mostly applicable for IaaS there are also other services that can benefit cost optimizations. [SQL Database elastic pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool) are a simple, cost-effective solution for managing and scaling multiple databases that have varying and unpredictable usage demands. The databases in an elastic pool are on a single Azure SQL Database server and share a set number of resources at a set price. Elastic pools in Azure SQL Database enable SaaS developers to optimize the price performance for a group of databases within a prescribed budget while delivering performance elasticity for each database.

<consider: insert image of 20 databases from here: https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool>

## Choose the right storage option

Azure storage offers [three storage tiers](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers) for Blob object storage so that you can store your data most cost-effectively depending on how you use it. The Azure hot storage tier is optimized for storing data that is accessed frequently. The Azure cool storage tier is optimized for storing data that is infrequently accessed and stored for at least 30 days. The Azure archive storage tier is optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements.

Each of these tiers have different cost properties:

- **Hot access tier**: has higher storage costs than cool and archive storage, but the lowest access costs
- **Cool access tier**: has lower storage costs and higher access costs compared to hot storage. This tier is intended for data that will remain in the cool tier for at least 30 days.
- **Archive access tier**: has the lowest storage cost and higher data retrieval costs compared to hot and cool storage. This tier is intended for data that can tolerate several hours of retrieval latency and will remain in the archive tier for at least 180 days.

In order to learn more about the actual pricing please take a look [here](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/).

## Getting insights in the actual consumption

There are various ways to get an overview of what your azure resources are costing. Depending on which [offer](https://azure.microsoft.com/en-us/support/legal/offer-details/) you use other capabilities might be offered.

Costs can be analysed using [Azure Cost Management](https://docs.microsoft.com/en-us/azure/cost-management/overview) or from within the [Azure Portal](https://docs.microsoft.com/en-us/azure/billing/billing-understand-your-bill#option-2-review-your-invoice-and-compare-with-the-usage-and-costs-in-the-azure-portal).

There are also some options with or specific to the offer you're using.

- For Enterprise Agreement customers the costs can be analysed using the [EA Portal](https://ea.azure.com) or [Power BI](https://docs.microsoft.com/en-us/power-bi/service-connect-to-azure-consumption-insights)
- For Pay As You Go or MSDN customers the costs can be analysed using the [Azure Account Center](https://docs.microsoft.com/en-us/azure/billing/billing-download-azure-invoice-daily-usage-date)

One of the challenges with analyzing cost data is that it's often difficult to determine which project or cost center is responsible for the costs. This challenge can be tackled by implementing a good hierarchy where resources are structured in resource groups and subscriptions. Sometimes that doesn't offer the dimensions you want to roll up costs to. In order to further complement the resource group/subscription structure we can [leverage tags on resources](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption-guide/subscription-governance#resource-tags).

<Consider: insert image of cost reporting in azure portal: https://docs.microsoft.com/en-us/azure/billing/billing-understand-your-bill#option-2-review-your-invoice-and-compare-with-the-usage-and-costs-in-the-azure-portal>



## Knowledge Check

What happens with the Reserved Instance if you delete a VM and create another one
- it still applies if you create it in the same region
- it still applies if you create it with the same size
- **it still applies if you create it in the same region and the same size**
- it only applies if you give the VM the same name
- it nog longer applies

When does VM compute cost stop from being charged
- when you shutdown the VM from inside the guest
- **when you stop the VM from the Portal**
- When you shutdown the VM from inside the guest or from the Portal 


## Resources [To Be removed]

Some of the resources I used. 
https://docs.microsoft.com/en-us/azure/cost-management/
https://docs.microsoft.com/en-us/azure/billing/billing-getting-started
https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption-guide/subscription-governance
https://docs.microsoft.com/en-us/azure/billing/billing-understand-your-bill
https://docs.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations

