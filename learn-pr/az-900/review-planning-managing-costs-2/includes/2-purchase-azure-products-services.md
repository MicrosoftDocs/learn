In this part, you'll learn how to purchase Azure services as well as get a sense for other factors that affect cost.

You meet with your Chief Financial Officer and some of the team leads. You learn about some assumptions you've missed and were able to quickly update your total estimated spend through the Total Cost of Ownership (TCO) Calculator.

During the meeting, some new questions came up as the discussion moved towards cloud migration:

> [!div class="checklist"]
> * How do we purchase Azure services?
> * Does location or network traffic affect cost?
> * What other factors affect the final cost?
> * How can we get a more detailed estimate of the cost to run on Azure?

It's important to learn how costs are generated in Azure, so you can understand how your purchasing and solution design decisions can impact your final cost. You agree to research these questions, so let's review each one in greater detail.

## How do I purchase Azure services?

There are three main ways to purchase services on Azure. They are:

* **Through an Enterprise Agreement**

    Larger customers (known as Enterprise customers) can sign an Enterprise Agreement with Microsoft that commits them to spending a predetermined amount on Azure services over a period of 3 years, which is typically paid annually. As an Enterprise Agreement customer, you will receive the best, customized pricing based on the kinds and amounts of services you plan on using.

* **Directly from the web**

    Here, you purchase Azure services directly from the Azure portal website and pay standard prices. You're billed monthly, as a credit card payment or via an invoice. This purchasing method is known as Web Direct. 

* **Through a Cloud Solution Provider (CSP)**

    A CSP is a Microsoft Partner who may help you build solutions on top of Azure. You will be billed for your Azure usage by your CSP, at a price determined by them. They will also answer your support questions,  escalating them to Microsoft if needed.

You can bring up, or _provision_, Azure resources from the Azure portal or from the command line. The Azure portal arranges products and services by category. You simply select the services that fit your needs, and your account is billed according to Azure's "pay for what you use" model.

![Depiction of the various Azure products with the Featured products selection highlighted, displaying names and short descriptions of those products.](../media/product-overview.png)

<div style="background:yellow;">
TODO: Update image - it's blurry.
</div>

At the end of each month, you're billed for what you have used. At any time, you can check the cost management & billing page in the Azure portal to get a summary of your current usage and review invoices from prior months.

The point is, you're always charged based on what you use. Lets look at how that applies to a virtual machine (VM).

<div style="background:yellow;">
TODO: Not sure I like this, but I rewrote what was there to make it more of a digestible story. Sonia has updated - see what you think.
</div>

In Azure, you can deallocate a VM. This means that the VM is not running, but the associated hard disks and data are still kept in Azure. The VM is not assigned to a CPU or network in Azure's datacenter, so it doesn't generate the costs associated with compute time or the VM's private IP address. However, because the disks and data are still stored, and the resource is present in your Azure subscription, you are still billed for disk storage.  

Deallocating a VM when you don't plan on using it for some time is just one example of how to minimize costs.

### Azure subscription types
In addition, some Azure subscription types also include usage allowances, which affect costs. 

For example, an Azure free account subscription offers access to a number of Azure products that are free for 12 months, a $200 credit to spend within your first 30 days of sign-up and access to more than 25 products that are always free (based on resource and region availability).  To learn more, visit the [Azure free account FAQ] (https://azure.microsoft.com/free/free-account-faq/).

### Azure Marketplace
<div style="background:yellow;">
TODO: Need more 3rd party / Marketplace services and cost? - Review Sonia's edit.
</div>
You can also purchase Azure-based solutions and services from third-party vendors through the **Azure Marketplace**. Examples of these include a managed network firewall appliance or a connector to a third-party backup service. Billing structures are set by the third-party vendor.

## Does location or network traffic affect cost?
When you provision a resource in Azure, you need to define the location (known as the Azure region) of where it will be deployed. This decision can have cost consequences. 

### Location
<div style="background:yellow;">
TODO: Review Sonia's edit.
</div>

Azure infrastructure is distributed globally, enabling you to deploy your services centrally or provision your services closest to where your customers use them. Different regions have different pricing though, and impact where your network traffic flows, influencing that cost component too.

For example, say Tailwind Traders decided to provision their Azure resources in the Azure regions that offer the lowest prices. That would save them some money! However, if they needed to transfer data between those regions, or if their users are located in different parts of the world, any potential savings could be offset by the additional network usage costs of transferring data between those resources.

### Zones for billing of network traffic
<div style="background:yellow;">
TODO: Clean this up. Change title to reflect one of the probing questions at the top of the page. Review Sonia's edits.
</div>

Billing zones are a factor in determining the cost of some Azure services.

[Bandwidth](https://azure.microsoft.com/pricing/details/bandwidth?azure-portal=true) refers to data moving in and out of Azure datacenters. Some inbound data transfers (data going into Azure datacenters), are free. For outbound data transfers (data leaving Azure datacenters), data transfer pricing is based on **Zones**.

![Image that shows internet traffic traveling between two datacenters around a globe](../media/billing-zones.png)

A Zone is a geographical grouping of Azure Regions for billing purposes. The following Zones exist and include some of the regions as listed below:

+ **Zone 1** – Australia Central, West US, East US, Canada West, West Europe, France Central and others

+ **Zone 2** – Australia East, Japan West, Central India, Korea South and others

+ **Zone 3** - Brazil South, South Africa North, South Africa West, UAE Central, UAE North

+ **DE Zone 1** - Germany Central, Germany Northeast

For a full, up-to-date list of Azure regions and zones, visit the FAQ on the [Azure Bandwidth product page](https://azure.microsoft.com/pricing/details/bandwidth?azure-portal=true).

> [!div class="checklist"]
> * To avoid confusion, be aware that a *Zone for billing purposes* is not the same as an *Availability Zone*. In Azure, the term *Zone* is used to refer to billing purposes only, and the full-term *Availability Zone* refers to a failure protection feature that Azure provides with its cloud datacenters.

## What other factors affect the final cost?
Finally, the range of Azure products and services have different ways of calculating cost, depending on what is relevant to that kind of resource.  

### Resource type

<div style="background:yellow;">
TODO: This really isn't saying anything. Do we mean the "type" as in how big the VM is or which tier you select? Or something else? - Great question! I'm going to go with Tier (Sonia).
</div>

Azure resources have a number of factors which influence their cost, depending on the type of resource.

For example, with a storage account you would specify a type (such as block blob storage or table storage), a performance tier (standard or premium) and an access tier (hot, cool or archive). These selections apply different costs. 


### Usage meters

When you provision a new resource, Azure creates _meters_ to track usage of that resource. Azure uses these meters to generate a usage record that's later used to help calculate your bill.

Think of usage meters similar to how you use electricity or water in your home. You might pay a base price each month for electricity or water service, but your final bill is based on the total amount that you have consumed.

> [!NOTE]
> Each meter tracks a specific type of usage.  For example, a meter might track bandwidth usage (ingress or egress network traffic in bits-per-second), number of operations, size (storage capacity in bytes), or similar items.

The usage that a meter tracks correlates to a quantity of billable units. Those are charged to your account for each billing period, and the rate per billable unit depends on the resource type you are using.

Lets look at a single virtual machine, as an example. The following kinds of meters are relevant to tracking its usage:

<div style="background:yellow;">
TODO: Does this sufficiently summarize the previous list we had? (Sonia: I think so)
</div>

* Overall CPU time.
* Time spent associate with a public IP address.
* Ingress and egress traffic, in and out of the VM.
* Disk size and amount of disk read and disk write operations.

> [!NOTE]
> For more information about Azure usage charges, refer to [Understand terms on your Microsoft Azure invoice](https://docs.microsoft.com/azure/billing/billing-understand-your-invoice?azure-portal=true).

## How can I estimate the total cost?

<div style="background:yellow;">
TODO: Clean this up. Change title to reflect one of the probing questions at the top of the page.
</div>

As you've learned, an accurate cost estimate would take all of the above factors into account. Fortunately, the Azure [Pricing Calculator](https://azure.microsoft.com/pricing/calculator?azure-portal=true) helps you do just that. 

It displays Azure products in categories, which you add to your estimate and then configure according to your specific requirements.  You then receive a consolidated estimated price, with a detailed breakdown of the costs associated with each resource you've added to your customized Azure solution. Then, you can export or share that estimate, or save it for later, letting you go back and edit your configurations.  


You also can access pricing details, product details, and documentation for each product from within the Pricing Calculator.

![Screenshot of a Pricing Calculator estimate](../media/pricing-calculator.png)

The options that you can configure in the Pricing Calculator vary between products, but may include:

+ **Region**. Lists the geographical regions in which you can provision a product. Southeast Asia, central Canada, the western United States, and Northern Europe are among the possible regions available, for some resources.

+ **Tier**. Sets the type of tier you wish to allocate to a selected resource, such as Free Tier, Basic Tier, etc. Tiers have different levels of availability or performance, and associated costs.

+ **Billing Options**. Highlights the billing options available to different types of customer and subscriptions for a chosen product, including any further options for cost savings.

+ **Support Options**: Allows you to pick from included or paid support pricing options for selected products.

+ **Programs and Offers**. Allows you to choose from available licensing programs or offers, according to your customer or subscription type.

+ **Azure Dev/Test Pricing**. Lists the available prices for development and test workloads. Dev/Test pricing applies only when you run resources within an Azure subscription that is based on a Dev/Test offer. For more information, visit [Azure Dev/Test Pricing](https://azure.microsoft.com/pricing/dev-test/?azure-portal=true)

✔️ The Pricing Calculator provides estimates, *not* actual price quotes. Actual prices may vary depending upon the date of purchase, the payment currency you are using, and the type of Azure customer you are.
