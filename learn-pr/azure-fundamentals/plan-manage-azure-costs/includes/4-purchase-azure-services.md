In this unit, you learn how to purchase Azure services and get a sense for other factors that affect cost.

You meet with your Chief Financial Officer and some of the team leads. You learn about some assumptions you've missed. You were able to quickly update your total estimated spend through the Total Cost of Ownership (TCO) Calculator.

During the meeting, some new questions arose as the discussion moves toward cloud migration:

> [!div class="checklist"]
> * What types of Azure subscriptions are available?
> * How do we purchase Azure services?
> * Does location or network traffic affect cost?
> * What other factors affect the final cost?
> * How can we get a more detailed estimate of the cost to run on Azure?

It's important to learn how costs are generated in Azure so that you can understand how your purchasing and solution design decisions can impact your final cost. You agree to research these questions, so let's review each one in greater detail.

## What types of Azure subscriptions can I use?

You probably know that an Azure _subscription_ provides you with access to Azure resources, such as virtual machines (VMs), storage, and databases. The types of resources you use impact your monthly bill.

Azure offers both free and paid subscription options to fit your needs and requirements. They are:

* **Free trial**

    A free trial subscription provides you with 12 months of popular free services, a credit to explore any Azure service for 30 days, and more than 25 services that are always free. Your Azure services are disabled when the trial ends or when your credit expires for paid products, unless you upgrade to a paid subscription.

* **Pay-as-you-go**

    A pay-as-you-go subscription enables you to pay for what you use by attaching a credit or debit card to your account. Organizations can apply for volume discounts and prepaid invoicing.

* **Member offers**

    Your existing membership to certain Microsoft products and services might provide you with credits for your Azure account and reduced rates on Azure services. For example, member offers are available to Visual Studio subscribers, Microsoft Partner Network members, Microsoft for Startups members, and Microsoft Imagine members.

## How do I purchase Azure services?

There are three main ways to purchase services on Azure. They are:

* **Through an Enterprise Agreement**

    Larger customers, known as enterprise customers, can sign an Enterprise Agreement with Microsoft. This agreement commits them to spending a predetermined amount on Azure services over a period of three years. The service fee is typically paid annually. As an Enterprise Agreement customer, you'll receive the best customized pricing based on the kinds and amounts of services you plan on using.

* **Directly from the web**

    Here, you purchase Azure services directly from the Azure portal website and pay standard prices. You're billed monthly, as a credit card payment or through an invoice. This purchasing method is known as Web Direct.

* **Through a Cloud Solution Provider**

    A Cloud Solution Provider (CSP) is a Microsoft Partner who helps you build solutions on top of Azure. Your CSP bills you for your Azure usage at a price they determine. They also answer your support questions and escalate them to Microsoft, as needed.

You can bring up, or _provision_, Azure resources from the Azure portal or from the command line. The Azure portal arranges products and services by category. You select the services that fit your needs. Your account is billed according to Azure's "pay for what you use" model.

Here's an example that shows the Azure portal.

:::image type="content" source="../media/4-azure-portal-create-resource.png" alt-text="A screenshot of the Azure portal showing many service categories. The Compute category is selected, which reveals compute services.":::

At the end of each month, you're billed for what you've used. At any time, you can check the cost management and billing page in the Azure portal to get a summary of your current usage and review invoices from prior months.

## What factors affect cost?

The way you use resources, your subscription type, and pricing from third-party vendors are common factors. Let's take a quick look at each.

### Resource type

A number of factors influence the cost of Azure resources. They depend on the type of resource or how you customize it.

For example, with a storage account you specify a type (such as block blob storage or table storage), a performance tier (standard or premium), and an access tier (hot, cool, or archive). These selections present different costs.

### Usage meters

When you provision a resource, Azure creates _meters_ to track usage of that resource. Azure uses these meters to generate a usage record that's later used to help calculate your bill.

Think of usage meters similar to how you use electricity or water in your home. You might pay a base price each month for electricity or water service, but your final bill is based on the total amount that you consumed.

Let's look at a single VM as an example. The following kinds of meters are relevant to tracking its usage:

* Overall CPU time.
* Time spent with a public IP address.
* Incoming (ingress) and outgoing (egress) network traffic in and out of the VM.
* Disk size and amount of disk read and disk write operations.

Each meter tracks a specific type of usage. For example, a meter might track bandwidth usage (ingress or egress network traffic in bits per second), number of operations, or its size (storage capacity in bytes).

The usage that a meter tracks correlates to a quantity of billable units. Those units are charged to your account for each billing period. The rate per billable unit depends on the resource type you're using.

### Resource usage

In Azure, you're always charged based on what you use. As an example, let's look at how this billing applies to deallocating a VM.

In Azure, you can delete or deallocate a VM. Deleting a VM means that you no longer need it. The VM is removed from your subscription, and then it's prepared for another customer.

Deallocating a VM means that the VM is no longer running. But the associated hard disks and data are still kept in Azure. The VM isn't assigned to a CPU or network in Azure's datacenter, so it doesn't generate the costs associated with compute time or the VM's IP address. Because the disks and data are still stored, and the resource is present in your Azure subscription, you're still billed for disk storage.

Deallocating a VM when you don't plan on using it for some time is just one way to minimize costs. For example, you might deallocate the VMs you use for testing purposes on weekends when your testing team isn't using them. You'll learn more about ways to minimize cost later in this module.

### Azure subscription types

Some Azure subscription types also include usage allowances, which affect costs.

For example, an Azure free trial subscription provides access to a number of Azure products that are free for 12 months. It also includes credit to spend within your first 30 days of sign-up. And you get access to more than 25 products that are always free (based on resource and region availability).

### Azure Marketplace

You can also purchase Azure-based solutions and services from third-party vendors through Azure Marketplace. Examples include managed network firewall appliances or connectors to third-party backup services. Billing structures are set by the vendor.

## Does location or network traffic affect cost?

When you provision a resource in Azure, you need to define the location (known as the Azure region) of where it will be deployed. Let's see why this decision can have cost consequences.

### Location

Azure infrastructure is distributed globally, which enables you to deploy your services centrally or provision your services closest to where your customers use them.

Different regions can have different associated prices. Because geographic regions can impact where your network traffic flows, network traffic is a cost influence to consider as well.

For example, say Tailwind Traders decides to provision its Azure resources in the Azure regions that offer the lowest prices. That decision would save the company some money. But, if they need to transfer data between those regions, or if their users are located in different parts of the world, any potential savings could be offset by the additional network usage costs of transferring data between those resources.

### Zones for billing of network traffic

Billing zones are a factor in determining the cost of some Azure services.

[Bandwidth](https://azure.microsoft.com/pricing/details/bandwidth?azure-portal=true) refers to data moving in and out of Azure datacenters. Some inbound data transfers (data going into Azure datacenters) are free. For outbound data transfers (data leaving Azure datacenters), data transfer pricing is based on _zones_.

![Image that shows internet traffic traveling between two datacenters around a globe.](../media/4-billing-zones.png)

A zone is a geographical grouping of Azure regions for billing purposes. The following zones include some of the regions as shown here:

* **Zone 1**: Australia Central, West US, East US, Canada West, West Europe, France Central, and others
* **Zone 2**: Australia East, Japan West, Central India, Korea South, and others
* **Zone 3**: Brazil South, South Africa North, South Africa West, UAE Central, UAE North
* **DE Zone 1**: Germany Central, Germany Northeast

## How can I estimate the total cost?

As you've learned, an accurate cost estimate takes all of the preceding factors into account. Fortunately, the Azure Pricing calculator helps you with that process.

The Pricing calculator displays Azure products in categories. You add these categories to your estimate and configure according to your specific requirements. You then receive a consolidated estimated price, with a detailed breakdown of the costs associated with each resource you added to your solution. You can export or share that estimate or save it for later. You can load a saved estimate and modify it to match updated requirements.

You also can access pricing details, product details, and documentation for each product from within the Pricing calculator.

:::image type="content" source="../media/4-pricing-calculator.png" alt-text="A screenshot of the Pricing calculator showing a sample estimate for virtual machines.":::

The options that you can configure in the Pricing calculator vary between products, but they can include:

* **Region**

    A region is the geographical location in which you can provision a service. Southeast Asia, Central Canada, Western United States, and Northern Europe are a few examples.

* **Tier**

    Tiers, such as the Free tier or Basic tier, have different levels of availability or performance and different associated costs.

* **Billing options**

    Billing options highlight the different ways you can pay for a service. Options can vary based on your customer type and subscription type and can include options to save costs.

* **Support options**

    These options enable you to select additional support pricing options for certain services.

* **Programs and offers**

    Your customer or subscription type might enable you to choose from specific licensing programs or other offers.

* **Azure Dev/Test pricing**

    This option lists the available prices for development and test workloads. Dev/Test pricing applies when you run resources within an Azure subscription that's based on a Dev/Test offer.

Keep in mind that the Pricing calculator provides estimates and *not* actual price quotes. Actual prices can vary depending upon the date of purchase, the payment currency you're using, and the type of Azure customer you are.
