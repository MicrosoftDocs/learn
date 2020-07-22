In this part, you'll learn how to purchase Azure services as well as get a sense for other factors that affect cost.

You meet with your Chief Financial Officer and some of the team leads. You learn about some assumptions you've missed and were able to quickly update your total estimated spend through the Total Cost of Ownership (TCO) Calculator.

During the meeting, a few more questions came up as the discussion moved towards cloud migration:

> [!div class="checklist"]
> * How do we purchase Azure services?
> * What other factors affect the final cost?
> * How do inbound and outbound network traffic affect cost?
> * How can we get a more detailed estimate of the cost to run on Azure?

You agree to research these questions a bit more, so let's review each one in greater detail.

## How do I purchase Azure services?

There are three main ways to purchase services on Azure. They are:

* **Through an Enterprise Agreement**

    Enterprise customers sign an Enterprise Agreement with Azure that commits them to spending a predetermined amount on Azure services, which is typically paid annually. As an enterprise customer, you can receive customized pricing based on the kinds and the amount of services you plan on using.

* **Directly from the web**

    Here, you pay standard prices for Azure resources. You're billed monthly and make payments through the Azure website.

* **Through a Cloud Solution Provider (CSP)**

    A CSP is a Microsoft partner that you hire to build solutions on top of Azure. You're typically billed for Azure usage directly through your CSP.

<div style="background:yellow;">
TODO: Diagram doesn't match above bullets. And do we even need a graphic?
</div>

![Depiction of the various Azure subscription options](../media/subscription-options.png)

You can bring up, or _provision_, Azure resources from the Azure portal or from the command line. The Azure portal arranges products and services by category. You simply select the services that fit your needs, and your account is billed according to Azure's "pay for what you use" model.

![Depiction of the various Azure products with the Featured products selection highlighted, displaying names and short descriptions of those products.](../media/product-overview.png)

<div style="background:yellow;">
TODO: Update image - it's blurry.
</div>

<div style="background:yellow;">
TODO: Do we need to clarify - End of each calendar month? Date from when you signed up?
</div>

At the end of each month, you're billed for what you use. At any time, you can check the billing page in the Azure portal to get a summary of your current usage and review invoices from prior months.

The point is, you're always charged based on what you use. As a brief example, consider what happens when you deallocate a virtual machine (VM).

<div style="background:yellow;">
TODO: Not sure I like this, but I rewrote what was there to make it more of a digestible story.
</div>

When you deallocate a VM, you still keep the VM, but the VM is not assigned to a CPU or network in Azure's datacenter. However, the associated hard disks remain with your data, and the resource is present in your Azure subscription. It's similar to turning off your physical computer. While the VM is deallocated, you're not billed for compute time or for the VM's private IP address; you're billed only for your disk storage. Deallocating a VM when you don't plan on using it for some time is just one example of how to minimize costs.

## Which factors affect the final cost?

<div style="background:yellow;">
TODO: Weak lead-in sentence. Improve it.
Also, I'm not in love with this section. Can we trim down to bullet points and a paragraph for each? (like we do for the first H2?)
</div>

Usage meters, resource types, services, and location all impact your final cost. Let's review what each of these mean.

### Usage meters

When you provision a resource, Azure creates _meters_ to track usage of that resource. Azure uses these meters to generate a usage record that's later used to calculate your bill.

Think of usage meters similar to how you use electricity or water in your home. You might pay a base price each month for electricity or water service, but your final bill is based on the total amount that you consume.

As an example, a single virtual machine that you provision on Azure might have the following meters tracking its usage:

<div style="background:yellow;">
TODO: Does this sufficiently summarize the previous list we had?
</div>

* Overall CPU time.
* Time spent with a public IP address.
* Ingress and egress traffic in and out of the VM.
* Disk size and amount of I/O operations.

### Resource type

<div style="background:yellow;">
TODO: This really isn't saying anything. Do we mean the "type" as in how big the VM is or which tier you select? Or something else?
</div>

Costs are resource-specific, so the usage that a meter tracks and the number of meters associated with a resource depend on the resource type.

> [!NOTE]
> Each meter tracks a specific type of usage.  For example, a meter might track bandwidth usage (ingress or egress network traffic in bits-per-second), number of operations, size (storage capacity in bytes), or similar items.

The usage that a meter tracks correlates to a quantity of billable units. Those are charged to your account for each billing period, and the rate per billable unit depends on the resource type you are using.

### Services

Your bill can vary depending on how you purchase Azure services (through an Enterprise Agreement, directly from the web, or through a CSP). Some subscription types also include usage allowances, which affect costs.

<div style="background:yellow;">
TODO: Need more on usage allowances?
</div>

Microsoft offers its set of first-party products and services, while products and services from third-party vendors are available in the **Azure Marketplace**. Different billing structures apply to each of these categories.

<div style="background:yellow;">
TODO: Need more 3rd party / Marketplace services and cost?
</div>

<div style="background:yellow;">
TODO: Image below has no information. Do we need it? Is there a better one?
</div>

![Depicts a billing period, with a calendar, computer, and meter linked to illustrate correlation between the three">](../media/billing-period.png)

### Location

Azure infrastructure is distributed globally, which enables you to also distribute your services globally or closest to where your customers use them. The locations where you provision resources can affect cost.

For example, say you build your solution on Azure by provisioning resources in locations that offer the lowest prices. If you need to transfer data between locations or your users are located in different parts of the world, any potential savings you make from choosing the cheapest location could be offset by the additional cost of transferring data between those resources.

<div style="background:yellow;">
TODO: ^^ The point?
</div>

<div style="background:yellow;">
TODO: Likely move this link to the summary.
</div>

> [!NOTE]
> For more information about Azure usage charges, refer to [Understand terms on your Microsoft Azure invoice](https://docs.microsoft.com/azure/billing/billing-understand-your-invoice?azure-portal=true).

## Identify zones for billing purposes

<div style="background:yellow;">
TODO: Clean this up. Change title to reflect one of the probing questions at the top of the page.
</div>

Billing zones help determine the cost of services you are using.

[Bandwidth](https://azure.microsoft.com/pricing/details/bandwidth?azure-portal=true) refers to data moving in and out of Azure datacenters. Some inbound data transfers, such as data going into Azure datacenters, are free. For outbound data transfers, such as data going out of Azure datacenters, data transfer pricing is based on **Zones**.

![Image that shows internet traffic traveling between two datacenters around a globe](../media/billing-zones.png)

A Zone is a geographical grouping of Azure Regions for billing purposes. the following Zones exist and include the sample regions as listed below:

+ **Zone 1** – West US, East US, Canada West, West Europe, France Central and others

+ **Zone 2** – Australia Central, Japan West, Central India, Korea South and others

+ **Zone 3** - Brazil South

+ **DE Zone 1** - Germany Central, Germany Northeast

> [!div class="checklist"]
> * To avoid confusion, be aware that a *Zone for billing purposes* is not the same as an *Availability Zone*. In Azure, the term *Zone* is for billing purposes only, and the full-term *Availability Zone* refers to the failure protection that Azure provides for datacenters.

## Explore the Pricing Calculator

<div style="background:yellow;">
TODO: Clean this up. Change title to reflect one of the probing questions at the top of the page.
</div>

The [Pricing Calculator](https://azure.microsoft.com/pricing/calculator?azure-portal=true) is a tool that helps you estimate the cost of Azure products. It displays Azure products in categories, and you choose the Azure products you need and configure them according to your specific requirements.  Azure then provides a detailed estimate of the costs associated with your selections and configurations.


Get a new estimate from the Pricing Calculator by adding, removing, or reconfiguring your selected products. You also can access pricing details, product details, and documentation for each product from the Pricing Calculator.

![Screenshot of a Pricing Calculator estimate](../media/pricing-calculator.png)

The options that you can configure in the Pricing Calculator vary between products, but basic configuration options include:

+ **Region**. Lists the regions from which you can provision a product. Southeast Asia, central Canada, the western United States, and Northern Europe are among the possible regions available for some resources.

+ **Tier**. Sets the type of tier you wish to allocate to a selected resource, such as Free Tier, Basic Tier, etc.

+ **Billing Options**. Highlights the billing options available to different types of customer and subscriptions for a chosen product.

+ **Support Options**: Allows you to pick from included or paid support pricing options for a selected product.

+ **Programs and Offers**. Allows you to choose from available price offerings according to your customer or subscription type.

+ **Azure Dev/Test Pricing**. Lists the available development and test prices for a product. Dev/Test pricing applies only when you run resources within an Azure subscription that is based on a Dev/Test offer.

✔️ The Pricing Calculator provides estimates, *not* actual price quotes. Actual prices may vary depending upon the date of purchase, the payment currency you are using, and the type of Azure customer you are.
