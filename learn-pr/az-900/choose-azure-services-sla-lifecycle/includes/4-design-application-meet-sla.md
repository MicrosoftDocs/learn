Tailwind Traders decides that an SLA of 99.9% is acceptable for the Special Orders application. Recall that this gives them an estimated downtime of 10.1 minutes per week.

Now you need to design an efficient and reliable solution for this application on Azure, keeping that application SLA in mind. You'll select the Azure products and services you need and provision your cloud resources according to those requirements.

In reality, failures will happen. Hardware can fail. The network can have intermittent timeout periods. While it's rare for an entire service or region to experience a disruption, you still need to plan for such events.

Let's follow the process Tailwind Traders uses to ensure that their technology choices meet their application SLA.

## Identify your workloads

A *workload* is a distinct capability or task that's logically separated from other tasks, in terms of business logic and data storage requirements. Each workload defines a set of requirements for availability, scalability, data consistency, and disaster recovery.

On Azure, the Special Orders application will require:

* Two virtual machines.
* One instance of Azure SQL Database.
* One instance of Azure Load Balancer.

Here's a diagram that shows the basic architecture:

:::image type="content" source="../media/4-special-orders-architecture.png" alt-text="A diagram showing two virtual machines connected to Azure Load Balancer and Azure SQL Database." border="false":::

## Combine SLAs to compute the composite SLA

After you've identified the SLA for the individual workloads in the Special Orders application, you might notice that those SLAs are not all the same. How does this impact our overall application SLA requirement of 99.9%? To work that out, you'll need to do some math.

The process of combining SLAs helps you compute the *composite SLA* for a set of services. Computing the composite SLA requires you to multiply the SLA of each individual service.

From the [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) page, you discover the SLA for each Azure service that you need. They are:

| Service | SLA |
| --- | --- |
| Virtual Machines | 99.9% |
| Azure SQL Database | 99.99% |
| Azure Load Balancer | 99.99% |

Therefore, for the Special Orders application, the composite SLA would be:

$$99.9\pct \times 99.9\pct \times 99.99\pct \times 99.99\pct$$
$$= 0.999 \times 0.999 \times 0.9999 \times 0.9999$$
$$= 0.9978$$
$$= 99.78\pct$$

Recall that you need two virtual machines. Therefore, you include the Virtual Machines SLA of 99.9% two times in the formula.

What's important to note here is that even though all of the individual services have SLAs equal to or better than our application SLA, the act of combining them results in an overall number that is *lower* than the 99.9% you need. Why? Because using multiple services adds an extra level of complexity and slightly increases the risk of failure.

You see here that the composite SLA of 99.78% doesn't meet the required SLA of 99.9%. You could go back to team and ask whether this is acceptable. Or you could implement some other strategies into your design to improve this SLA.

## What happens when the composite SLA doesn't meet your needs?

For the Special Orders application, the composite SLA of doesn't meet the required SLA of 99.9%. Let's look at a few strategies that Tailwind Traders might consider.

### Choose customization options that fit your required SLA

Each of the workloads defined previously has its own SLA, and the customization choices you make when you provision each workload impacts that SLA. For example:

* **Disks**

    With Azure virtual machines, you can choose from a Standard HDD Managed Disk, a Standard SSD Managed Disk, or a Premium SSD or Ultra Disk. The SLA for a single VM would be either 95%, 99.5% or 99.9%, depending on the disk choice.
* **Tiers**

    Some Azure services are offered as both a free tier product and as a standard paid service. For example, Azure Automation provides 500 minutes of job runtime in an Azure Free account, but is not backed by an SLA. The standard tier SLA for Azure Automation is 99.9%.

Make sure that your purchasing decisions take into account the impact on the SLA for the Azure services that you choose. Doing so ensures that the SLA supports your required application SLA.

Here, Tailwind Traders might choose the Ultra Disk option for their virtual machines to help guarantee greater uptime.

### Build availability requirements into your design

There are application design considerations you can use that relate to the underlying cloud infrastructure.

For example, to improve the availability of the application, you should avoid having any single points of failure. So instead of adding more virtual machines, you can deploy one or more extra instances of the same virtual machine across the different *Availability Zones* in the same Azure region.

An Availability Zone is a unique physical location within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. These zones use different schedules for maintenance, so if one zone is impacted, your virtual machine instance in the other Availability Zone should be unaffected.

Deploying two or more instances of an Azure VM across to or more Availability Zones raises the virtual machine SLA to 99.99%. Recalculating your composite SLA above with this Virtual Machines SLA would give you an application SLA of 99.96%, which exceeds your target.

To learn more about the SLA for virtual machines, visit [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines?azure-portal=true).

### Implement resiliency strategies for when failure happens

*Resiliency* is the ability of a system to recover from failures and continue to function. It's not about avoiding failures, but rather responding to failures in a way that avoids downtime or data loss.

A resilient system returns the application to a fully-functioning state following a failure. High availability and disaster recovery are two crucial components of resiliency.

For their virtual machines, Tailwind Traders might use Azure Backup to back up their data. Azure Backup enables them to more quickly restore data in the case of an outage. We'll provide additional resources around building resilient systems at the end of this module.

### Include redundancy to increase availability

To ensure a high availability, you might plan for your application to have duplicate components across several regions, known as *redundancy*, in case one fails. Conversely, to minimize costs during non-critical periods, you could run your application only in a single region. Tailwind Traders may want to consider this if there is a trend that the special order rates are much higher during certain months or seasons.

To achieve maximum availability in your application, you would need to add redundancy to every single part of the application. This redundancy includes the application itself as well as the underlying services and infrastructure. However, doing so can be difficult and expensive, and often results in solutions that are more complex than they need to be.

Consider how critical high availability is to your requirements before you add redundancy. There may be simpler ways to meet your application SLA.

## Very high performance is difficult to achieve

Performance targets above 99.99% are very difficult to achieve. Recall that an SLA of 99.99% means 1.01 minutes of downtime per week. It's difficult for humans to respond to failures quickly enough to meet SLA performance targets above 99.99%. Instead, your application must be able to self-diagnose and self-heal during an outage.

We'll provide additional resources around designing for self healing systems at the end of this module.