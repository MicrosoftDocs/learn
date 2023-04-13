Tailwind Traders decides that an SLA of 99.9 percent is acceptable for the Special Orders application. Recall that this gives the company an estimated downtime of 10.1 minutes per week.

Now you need to design an efficient and reliable solution for this application on Azure, keeping that application SLA in mind. You'll select the Azure products and services you need, and provision your cloud resources according to those requirements.

In reality, failures will happen. Hardware can fail. The network can have intermittent timeout periods. While it's rare for an entire service or region to experience a disruption, you still need to plan for such events.

Let's follow the process Tailwind Traders uses to ensure that its technology choices meet its application SLA.

## Identify your workloads

A *workload* is a distinct capability or task that's logically separated from other tasks, in terms of business logic and data storage requirements. Each workload defines a set of requirements for availability, scalability, data consistency, and disaster recovery.

On Azure, the Special Orders application will require:

 -  Two virtual machines.
 -  One instance of Azure SQL Database.
 -  One instance of Azure Load Balancer.

Here's a diagram that shows the basic architecture:

:::image type="content" source="../media/4-special-orders-architecture-75dc6b93.png" alt-text="A diagram showing two virtual machines connected to Azure Load Balancer and Azure SQL Database.":::


## Combine SLAs to compute the composite SLA

After you've identified the SLA for the individual workloads in the Special Orders application, you might notice that those SLAs are not all the same. How does this affect our overall application SLA requirement of 99.9 percent? To work that out, you'll need to do some math.

The process of combining SLAs helps you compute the *composite SLA* for a set of services. Computing the composite SLA requires that you multiply the SLA of each individual service.

From [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true), you discover the SLA for each Azure service that you need. They are:

:::row:::
  :::column:::
    **Service**
  :::column-end:::
  :::column:::
    **SLA**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Virtual Machines
  :::column-end:::
  :::column:::
    99.9 percent
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure SQL Database
  :::column-end:::
  :::column:::
    99.99 percent
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Load Balancer
  :::column-end:::
  :::column:::
    99.99 percent
  :::column-end:::
:::row-end:::


Therefore, for the Special Orders application, the composite SLA would be:

$$99.9\\% \\times 99.9\\% \\times 99.99\\% \\times 99.99\\%$$ $$= 0.999 \\times 0.999 \\times 0.9999 \\times 0.9999$$ $$= 0.9978$$ $$= 99.78\\%$$

Recall that you need two virtual machines. Therefore, you include the Virtual Machines SLA of 99.9 percent two times in the formula.

Note that even though all of the individual services have SLAs equal to or better than the application SLA, combining them results in an overall number that's *lower* than the 99.9 percent you need. Why? Because using multiple services adds an extra level of complexity and slightly increases the risk of failure.

You see here that the composite SLA of 99.78 percent doesn't meet the required SLA of 99.9 percent. You might go back to team and ask whether this is acceptable. Or you might implement some other strategies into your design to improve this SLA.

## What happens when the composite SLA doesn't meet your needs?

For the Special Orders application, the composite SLA doesn't meet the required SLA of 99.9 percent. Let's look at a few strategies that Tailwind Traders might consider.

### Choose customization options that fit your required SLA

Each of the workloads defined previously has its own SLA, and the customization choices you make when you provision each workload affects that SLA. For example:

 -  **Disks** With Virtual Machines, you can choose from a Standard HDD Managed Disk, a Standard SSD Managed Disk, or a Premium SSD or Ultra Disk. The SLA for a single VM would be either 95 percent, 99.5 percent or 99.9 percent, depending on the disk choice.
 -  **Tiers** Some Azure services are offered as both a free tier product and as a standard paid service. For example, Azure Automation provides 500 minutes of job runtime in an Azure free account, but is not backed by an SLA. The standard tier SLA for Azure Automation is 99.9 percent.

Make sure that your purchasing decisions take into account the impact on the SLA for the Azure services that you choose. Doing so ensures that the SLA supports your required application SLA.

Here, Tailwind Traders might choose the Ultra Disk option for its virtual machines to help guarantee greater uptime.

### Build availability requirements into your design

There are application design considerations you can use that relate to the underlying cloud infrastructure.

For example, to improve the availability of the application, avoid having any single points of failure. So instead of adding more virtual machines, you can deploy one or more extra instances of the same virtual machine across the different availability zones in the same Azure region.

An *availability zone* is a unique physical location within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. These zones use different schedules for maintenance, so if one zone is affected, your virtual machine instance in the other zone is unaffected.

Deploying two or more instances of an Azure virtual machine across two or more availability zones raises the virtual machine SLA to 99.99 percent. Recalculating your composite SLA above with this Virtual Machines SLA gives you an application SLA of:

$$99.99\\% \\times 99.99\\% \\times 99.99\\% \\times 99.99\\%$$ $$= 99.96\\%$$

This revised SLA of 99.96 percent exceeds your target of 99.9 percent.

To learn more about the SLA for Virtual Machines, visit [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines?azure-portal=true).

### Include redundancy to increase availability

To ensure high availability, you might plan for your application to have duplicate components across several regions, known as *redundancy*. Conversely, to minimize costs during non-critical periods, you might run your application only in a single region. Tailwind Traders might consider this if there's a trend that the special order rates are much higher during certain months or seasons.

To achieve maximum availability in your application, add redundancy to every single part of the application. This redundancy includes the application itself, as well as the underlying services and infrastructure. Be aware, however, that doing so can be difficult and expensive, and often results in solutions that are more complex than they need to be.

Consider how critical high availability is to your requirements before you add redundancy. There may be simpler ways to meet your application SLA.

## Very high performance is difficult to achieve

Performance targets above 99.99 percent are very difficult to achieve. An SLA of 99.99 percent means 1 minute of downtime per week. It's difficult for humans to respond to failures quickly enough to meet SLA performance targets above 99.99 percent. Instead, your application must be able to self-diagnose and self-heal during an outage.
