Let's start by introducing some important concepts that are helpful to understand when working with costs on Azure. Most importantly, on Azure you only pay for the services that you use, for the time that you use them. This is different from costs on-premises where you are still paying for hardware even if it's powered off or under-utilized. Azure services are billed in a few different ways, per minute, per execution, or per unit (i.e. network througput, DTU for databases) and may be a combination of these. The important part, again, is that you only pay for what you use. For instance, if you have a VM that only runs for 10.5 hours of the day, you only pay compute costs for 10.5 hours.

## Capex vs. Opex

With this shift to only paying for resources that you use, it also introduces a shift from capex to opex expenditures. You may have heard this before, but what does it actually mean? Capital expenditures (capex) are defined by [Wikipedia](https://en.wikipedia.org/wiki/Capital_expenditure) as *the money a company spends to buy, maintain, or improve its fixed assets such as buildings, vehicles, equipment or land*. In this case, servers in an on-premises data center fall into the *equipment* category. Operating expenses (opex) on the other hand are defined by [Wikipedia](https://en.wikipedia.org/wiki/Operating_expense) as *ongoing costs for running a product, business or system*. Cloud services fall into this space, since these costs are not for fixed assets and are ongoing. There are accounting implications for both, but the important part is that you no longer have to tie up money invested in fixed assets, you can instead shift these costs to ongoing expenses where you can have much greater flexibility and control and can gain efficiency.

Now that we have some basics out of the way, let's take a look at how we can estimate our costs before creating a single thing on Azure.

## Introducing the Azure Pricing Calculator

Imagine you have some resources that you want to run on the cloud, and you need to provide an estimate to your leadership so everyone can understand how much they would expect this to cost. Because all of our prices are fully transparent and available up front, this is much easier than it sounds. You can use the Azure Pricing Calculator to get an estimate for every service on Azure. Let's walk through an example scenario and see exactly how this can be done.

In another browser window or tab, go to the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) so we can walk through what it does and how it works. On the pricing calculator page you'll see 3 tabs:

- **Products:** This is where you'll do most of your activity. This tab has all the Azure services listed and is where you'll add/remove services to formulate your estimate.
- **Estimates:** This tab has all of your previously saved estimates here. We'll go through this in a bit.
- **FAQ:** Just as it says, this tab has answers to some frequently asked questions.

The Products tab is where we'll do most of our work, so make sure you're on that tab. You'll see the full listing of service categories down the left hand side, and clicking on any of the categories will display the services in that category. There's also a search box where you can search through all services for the service you're looking for. Clicking on the service will add that service to your estimate. You can just add one service, or you can add as many as you need, including multiples of the same service (multiple virtual machines for example). Once you've added the services you want to price, scrolling down on the page will show you customizable details for that service that apply to pricing. For instance, on virtual machines, you can select details such as the region, OS, and instance size, all of which will impact the pricing for the VM. You'll see a sub-total for the service, and scrolling further down you'll see a full total for all services included in the estimate. Along with the full total, you'll see buttons where you can export, save and share the estimate.

## Estimate a solution

Let's go through an example. Let's say we have a solution that will run on two Azure VMs and will connect to an Azure SQL DB. We'd also like to have a layer 7 firewall in place to ensure we have enhanced load balancing capabilities. Let's figure out what this might cost.

**image of architecture**

Let's start with a clean calculator, if you have anything presently in your estimate, click the trash can icon for delete all at the estimate level to remove all services from your estimate. Now, let's add the following services:

- Virtual Machines
- Azure SQL Database
- Application Gateway

Now let's configure the details of each so we can get a solid estimate of our costs. We'll use the West US region for all resources.

**Virtual Machines**
This is an ASP.NET application, so we'll need to use a Windows OS VM. This application doesn't require a massive amount of comuting power, so select the D2v3 instance size. We'll need two virtual machines and they will run all the time (730 hours/month). We're going to use premium SSD storage for these VMs, and will require just one disk per VM of size P10, for a total of two disks. 

**Azure SQL Database**
For the database we're going to provision a single database under the vCore model. This will be a General Purpose, Gen 4 database with 4 vCores. We'll need 32 GB of storage, and will be retaining an average of 16 GB of storage. Our retention policy will be 8 weeks, 12 months and 5 years.

**Application Gateway**
For Application Gateway we're going to use the Web Application Firewall tier so we have some protection for our environment, and we're going to go with just two instances, as our load isn't going to be user high. We expect to process 1 TB of data.

That helps us land on an estimate for our solution. We can now save this estimate so we can come back to it at a later time (and make adjustments if necessary) export it to Excel for further analysis and share the estimate via a URL. 

What we've been able to do here is arrive at a cost estimate for a set of Azure services without spending anything more than a few minutes time. We didn't have to create anything, and we've got a fully sharable estimate that we can do further analysis or modifications on in the future. 