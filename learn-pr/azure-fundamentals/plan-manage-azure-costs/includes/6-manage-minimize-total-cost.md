As a home improvement retailer, the proverb "measure twice, cut once" is fitting for the team at Tailwind Traders.

Here are some recommended practices that can help you minimize your costs.

## Understand estimated costs before you deploy

To help you plan your solution on Azure, carefully consider the products, services, and resources you need. Read the relevant documentation to understand how each of your choices is metered and billed.

Calculate your projected costs by using the Pricing calculator and the Total Cost of Ownership (TCO) Calculator. Only add the products, services, and resources that you need for your solution.

## Use Azure Advisor to monitor your usage

Ideally, you want your provisioned resources to match your actual usage.

Azure Advisor identifies unused or underutilized resources and recommends unused resources that you can remove. This information helps you configure your resources to match your actual workload.

The following image shows some example recommendations from Azure Advisor:

:::image type="content" source="../media/6-azure-advisor.png" alt-text="A screenshot of Azure Advisor showing cost-savings recommendations. Recommendations are sorted by high, medium, or low impact. Also shown are potential yearly savings, the number of impacted resources, and the recommendation's creation date." lightbox="../media/6-azure-advisor-expanded.png":::

Recommendations are sorted by impact: high, medium, or low. In some cases, Azure Advisor can automatically remediate, or fix, the underlying problem. Other issues, such as the two that are listed as high impact, require human intervention.

## Use spending limits to restrict your spending

If you have a free trial or a credit-based Azure subscription, you can use spending limits to prevent accidental overrun.

For example, when you spend all the credit included with your Azure free account, Azure resources that you deployed are removed from production and your Azure virtual machines (VMs) are stopped and deallocated. The data in your storage accounts is available as read-only. At this point, you can upgrade your free trial subscription to a pay-as-you-go subscription.

If you have a credit-based subscription and you reach your configured spending limit, Azure suspends your subscription until a new billing period begins.

A related concept is *quotas*, or limits on the number of similar resources you can provision within your subscription. For example, you can allocate up to 25,000 VMs per region. These limits mainly help Microsoft plan its datacenter capacity.

## Use Azure Reservations to prepay

Azure Reservations offers discounted prices on certain Azure services. Azure Reservations can save you up to 72 percent as compared to pay-as-you-go prices. To receive a discount, you can reserve services and resources by paying in advance.

For example, you can prepay for one year or three years of use of VMs, database compute capacity, database throughput, and other Azure resources.

The following example shows estimated savings on VMs. In this example, you save an estimated 72 percent by committing to a three-year term.

:::image type="content" source="../media/6-azure-reservations.png" alt-text="A screenshot of Azure Reservations showing an estimated cost savings of 72 percent by committing to a three-year term on seven VMs.":::

Azure Reservations are available to customers with an Enterprise Agreement, Cloud Solution Providers, and pay-as-you-go subscriptions.

## Choose low-cost locations and regions

The cost of Azure products, services, and resources can vary across locations and regions. If possible, you should use them in those locations and regions where they cost less.

But remember, some resources are metered and billed according to how much outgoing (egress) network bandwidth they consume. You should provision connected resources that are metered by bandwidth in the same Azure region to reduce egress traffic between them.

## Research available cost-saving offers

Keep up to date with the latest Azure customer and subscription offers, and switch to offers that provide the greatest cost-saving benefit.

## Use Microsoft Cost Management + Billing to control spending

Cost Management is a free service that helps you understand your Azure bill, manage your account and subscriptions, monitor and control Azure spending, and optimize resource use.

The following image shows current usage broken down by service:

:::image type="content" source="../media/6-cost-management.png" alt-text="A screenshot of Cost Management showing usage broken down by Azure service." lightbox="../media/6-cost-management-expanded.png":::

In this example, Azure App Service, a web application hosting service, generates the greatest cost.

Cost Management features include:

+ **Reporting**

    Use historical data to generate reports and forecast future usage and expenditure.

+ **Data enrichment**

    Improve accountability by categorizing resources with tags that correspond to real-world business and organizational units.

+ **Budgets**

    Create and manage cost and usage budgets by monitoring resource demand trends, consumption rates, and cost patterns.

+ **Alerting**

    Get alerts based on your cost and usage budgets.

+ **Recommendations**

    Receive recommendations to eliminate idle resources and to optimize the Azure resources you provision.

## Apply tags to identify cost owners

*Tags* help you manage costs associated with the different groups of Azure products and resources. You can apply tags to groups of Azure resources to organize billing data.

For example, if you run several VMs for different teams, you can use tags to categorize costs by department, such as Human Resources, Marketing, or Finance; or by environment, such as Test or Production.

Tags make it easier to identify groups that generate the biggest Azure costs, which can help you adjust your spending accordingly.

The following image shows a year's worth of usage broken down by tags on the Cost Management page:

:::image type="content" source="../media/6-cost-management-tags.png" alt-text="A screenshot of Cost Management showing usage broken down by tags.":::

## Resize underutilized virtual machines

A common recommendation that you'll find from Cost Management and Azure Advisor is to resize or shut down VMs that are underutilized or idle.

As an example, say you have a VM whose size is **Standard_D4_v4**, a general-purpose VM type with four vCPUs and 16 GB of memory. You might discover that this VM is idle 90 percent of the time.

Virtual machine costs are linear and double for each size larger in the same series. So in this case, if you reduce the VM's size from **Standard_D4_v4** to **Standard_D2_v4**, which is the next size lower, you reduce your compute cost by 50 percent.

The following image shows this idea:

:::image type="content" source="../media/6-vm-resize.png" alt-text="An illustration showing 50 percent savings by reducing the size of an underutilized VM." border="false":::

Keep in mind that [resizing a VM](/azure/virtual-machines/resize-vm) requires it to be stopped, resized, and then restarted. This process might take a few minutes depending on how significant the size change is. Be sure to properly plan for an outage, or shift your traffic to another instance while you perform resize operations.

## Deallocate virtual machines during off hours

Recall that to *deallocate* a VM means to no longer run the VM, but preserve the associated hard disks and data in Azure.

If you have VM workloads that are only used during certain periods, but you're running them every hour of every day, you're wasting money. These VMs are great candidates to shut down when not in use and start back when you need them, saving you compute costs while the VM is deallocated.

This approach is an excellent strategy for development and testing environments, where the VMs are needed only during business hours. Azure even provides a way to automatically start and stop your VMs on a schedule.

## Delete unused resources

This recommendation might sound obvious, but if you aren't using a resource, you should shut it down. It's not uncommon to find nonproduction or proof-of-concept systems that are no longer needed following the completion of a project.

Regularly review your environment, and work to identify these systems. Shutting down these systems can have a dual benefit by saving you on infrastructure costs and potential savings on licensing and operating costs.

## Migrate from IaaS to PaaS services

As you move your workloads to the cloud, a natural evolution is to start with infrastructure as a service (IaaS) services, because they map more directly to concepts and operations you're already familiar with.

Over time, one way to reduce costs is to gradually move IaaS workloads to run on platform as a service (PaaS) services. While you can think of IaaS as direct access to compute infrastructure, PaaS provides ready-made development and deployment environments that are managed for you.

As an example, say you run SQL Server on a VM running on Azure. This configuration requires you to manage the underlying operating system, set up a SQL Server license, manage software and security updates, and so on. You also pay for the VM whether or not the database is processing queries. One way to potentially save costs is to move your database from SQL Server on a VM to Azure SQL Database. Azure SQL Database is based on SQL Server.

Not only are PaaS services such as Azure SQL Database often less expensive to run, but because they're managed for you, you don't need to worry about software updates, security patches, or optimizing physical storage for read and write operations.

## Save on licensing costs

Licensing is another area that can dramatically affect your cloud spending. Let's look at some ways you can reduce your licensing costs.

### Choose cost-effective operating systems

Many Azure services provide a choice of running on Windows or Linux. In some cases, the cost depends on which you choose. When you have a choice, and your application doesn't depend on the underlying operating system, it's useful to compare pricing to see whether you can save money.

### Use Azure Hybrid Benefit to repurpose software licenses on Azure

If you've purchased licenses for Windows Server or SQL Server, and your licenses are covered by [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default?azure-portal=true), you might be able to repurpose those licenses on VMs on Azure.

Some of the details vary between Windows Server or SQL Server. We'll provide resources for you to learn more at the end of this module.
