In this part, you learn how to purchase Azure services as well as get a sense for other factors that affect cost.

You meet with your Chief Financial Officer and some of the team leads. You learn about some assumptions you've missed and were able to quickly update your total estimated spend through the Total Cost of Ownership (TCO) Calculator.

During the meeting, some new questions come up as the discussion moves towards cloud migration:

> [!div class="checklist"]
> * What types of Azure subscriptions are available?
> * How do we purchase Azure services?
> * Does location or network traffic affect cost?
> * What other factors affect the final cost?
> * How can we get a more detailed estimate of the cost to run on Azure?

It's important to learn how costs are generated in Azure so that you can understand how your purchasing and solution design decisions can impact your final cost. You agree to research these questions, so let's review each one in greater detail.

## What types of Azure subscriptions can I use?

You probably know that an Azure _subscription_ provides you with access to Azure resources, such as virtual machines, storage, and databases. The types of resources you use impact your monthly bill.

Azure offers both free and paid subscription options to fit your needs and requirements. They are:

* **Free Trial**

    A Free Trial subscription provides you with 12 months of popular free services, a credit to explore any Azure service for 30 days, and 25+ services that are always free. Your Azure services are disabled when the trial ends or when your credit expires for paid products, unless you upgrade to a paid subscription.

* **Pay-As-You-Go**

    A Pay-As-You-Go subscription enables you to pay for what you use by attaching a credit or debit card to your account. Organizations can apply for volume discounts and pre-paid invoicing.

* **Member offers**

    Your existing membership to certain Microsoft products and services might provide you with credits for your Azure account and reduced rates on Azure services. For example, member offers are available to Microsoft Visual Studio subscribers, Microsoft Partner Network members, Microsoft for Startups members, and Microsoft Imagine members.

## How do I purchase Azure services?

There are three main ways to purchase services on Azure. They are:

* **Through an Enterprise Agreement**

    Larger customers (known as Enterprise customers) can sign an Enterprise Agreement with Microsoft that commits them to spending a predetermined amount on Azure services over a period of 3 years, which is typically paid annually. As an Enterprise Agreement customer, you will receive the best, customized pricing based on the kinds and amounts of services you plan on using.

* **Directly from the web**

    Here, you purchase Azure services directly from the Azure portal website and pay standard prices. You're billed monthly, as a credit card payment or through an invoice. This purchasing method is known as Web Direct.

* **Through a Cloud Solution Provider (CSP)**

    A CSP is a Microsoft Partner who helps you build solutions on top of Azure. Your CSP bills you for your Azure usage at a price they determine. They also answer your support questions, escalating them to Microsoft as needed.

You can bring up, or _provision_, Azure resources from the Azure portal or from the command line. The Azure portal arranges products and services by category. You select the services that fit your needs, and your account is billed according to Azure's "pay for what you use" model.

Here's an example that shows the Azure portal:

:::image type="content" source="../media/4-azure-portal-create-resource.png" alt-text="A screenshot of the Azure portal showing many service categories. The Compute category is selected, which reveals compute services.":::

At the end of each month, you're billed for what you've used. At any time, you can check the cost management and billing page in the Azure portal to get a summary of your current usage and review invoices from prior months.

## What factors affect cost?

The way you use resources, your subscription type, and pricing from third-party vendors are common factors. Let's take a quick look at each.

### Resource usage

In Azure, you're always charged based on what you use. Let's look at how this applies to deallocating a virtual machine (VM).

In Azure, you can delete or deallocate a VM. Deleting a VM means that you no longer need it; the VM is removed from your subscription and then it's prepared for another customer.

Deallocating a VM means that the VM is no longer running, but the associated hard disks and data are still kept in Azure. The VM is not assigned to a CPU or network in Azure's datacenter, so it doesn't generate the costs associated with compute time or the VM's IP address. However, because the disks and data are still stored, and the resource is present in your Azure subscription, you are still billed for disk storage.

Deallocating a VM when you don't plan on using it for some time is just one way to minimize costs. For example, you might deallocate the VMs you use for testing purposes on weekends when your testing team is not using them.

### Azure subscription types

Some Azure subscription types also include usage allowances, which affect costs.

For example, an Azure Free Trial subscription provides access to a number of Azure products that are free for 12 months, as well as credit to spend within your first 30 days of sign-up, and access to more than 25 products that are always free (based on resource and region availability).

### Azure Marketplace

You can also purchase Azure-based solutions and services from third-party vendors through the Azure Marketplace. Examples include managed network firewall appliances or connectors to third-party backup services. Billing structures are set by the vendor.

## Does location or network traffic affect cost?

When you provision a resource in Azure, you need to define the location (known as the Azure region) of where it will be deployed. Let's see why this decision can have cost consequences.

### Location

Azure infrastructure is distributed globally, which enables you to deploy your services centrally or provision your services closest to where your customers use them.

Different regions can have different associated prices. Because geographic regions can impact where your network traffic flows, network traffic is a cost influence to consider as well.

For example, say Tailwind Traders decides to provision their Azure resources in the Azure regions that offer the lowest prices. That would save them some money! However, if they need to transfer data between those regions, or if their users are located in different parts of the world, any potential savings could be offset by the additional network usage costs of transferring data between those resources.

### Zones for billing of network traffic

Billing zones are a factor in determining the cost of some Azure services.

[Bandwidth](https://azure.microsoft.com/pricing/details/bandwidth?azure-portal=true) refers to data moving in and out of Azure datacenters. Some inbound data transfers (data going into Azure datacenters), are free. For outbound data transfers (data leaving Azure datacenters), data transfer pricing is based on _Zones_.

![Image that shows internet traffic traveling between two datacenters around a globe](../media/4-billing-zones.png)

A Zone is a geographical grouping of Azure regions for billing purposes. The following Zones include some of the regions as shown here:

* **Zone 1** – Australia Central, West US, East US, Canada West, West Europe, France Central and others.

* **Zone 2** – Australia East, Japan West, Central India, Korea South and others.

* **Zone 3** - Brazil South, South Africa North, South Africa West, UAE Central, UAE North.

* **DE Zone 1** - Germany Central, Germany Northeast.

## What other factors affect the final cost?

When you create a resource, the customization options you choose can impact its cost. Another factor is how much of that resource you use. Let's look at these two factors now.

### Resource type

Azure resources have a number of factors which influence their cost, depending on the type of resource or how you customize it.

For example, with a storage account you would specify a type (such as block blob storage or table storage), a performance tier (standard or premium), and an access tier (hot, cool or archive). These selections present different costs.

### Usage meters

When you provision a resource, Azure creates _meters_ to track usage of that resource. Azure uses these meters to generate a usage record that's later used to help calculate your bill.

Think of usage meters similar to how you use electricity or water in your home. You might pay a base price each month for electricity or water service, but your final bill is based on the total amount that you have consumed.

> [!NOTE]
> Each meter tracks a specific type of usage.  For example, a meter might track bandwidth usage (ingress or egress network traffic in bits-per-second), number of operations, size (storage capacity in bytes), or similar items.

The usage that a meter tracks correlates to a quantity of billable units. Those are charged to your account for each billing period, and the rate per billable unit depends on the resource type you are using.

Let's look at a single virtual machine as an example. The following kinds of meters are relevant to tracking its usage:

* Overall CPU time.
* Time spent with a public IP address.
* Incoming (ingress) and outgoing (egress) network traffic in and out of the VM.
* Disk size and amount of disk read and disk write operations.

## How can I estimate the total cost?

As you've learned, an accurate cost estimate would take all of the above factors into account. Fortunately, the Azure Pricing calculator helps you do just that.

The Pricing calculator displays Azure products in categories, which you add to your estimate and then configure according to your specific requirements.  You then receive a consolidated estimated price, with a detailed breakdown of the costs associated with each resource you've added to your solution. Then, you can export or share that estimate, or save it for later. You can load a saved estimate and modify it to match updated requirements.

You also can access pricing details, product details, and documentation for each product from within the Pricing calculator.

:::image type="content" source="../media/4-pricing-calculator.png" alt-text="A screenshot of the Price calculator showing a sample estimate for virtual machines.":::

The options that you can configure in the Pricing calculator vary between products, but can include:

* **Region**

    A region is the geographical location in which you can provision a service. Southeast Asia, Central Canada, Western United States, and Northern Europe are a few examples.

* **Tier**

    Tiers such as the Free Tier, Basic Tier, and so on, have different levels of availability or performance, and therefore different associated costs.

* **Billing Options**

    Billing options highlight the different ways you can pay for a service. Options can vary based on your customer type and subscription type and can include options to save costs.

* **Support Options**

    These options enable you to select additional support pricing options for certain services.

* **Programs and Offers**

    Your customer or subscription type might enable you to choose from specific licensing programs or other offers.

* **Azure Dev/Test Pricing**

    This option lists the available prices for development and test workloads. Dev/Test pricing applies when you run resources within an Azure subscription that is based on a Dev/Test offer.

Keep in mind that the Pricing calculator provides estimates, and *not* actual price quotes. Actual prices can vary depending upon the date of purchase, the payment currency you are using, and the type of Azure customer you are.
