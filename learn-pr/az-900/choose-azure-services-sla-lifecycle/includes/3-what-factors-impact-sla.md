<div style="background:yellow;">
TODO: This is REALLY long. A graphic or video could help, or do we split over two units?

(If we decide to keep the sections around availability metrics and recovery metrics, we can split this page at "Design your application to meet your SLA".)
</div>

Now that you know how service-level agreements (SLAs) are structured, how do you know whether the SLA for an Azure service meets your business needs? What other factors do you need to consider?

Tailwind Traders runs an application that they built on Azure called Special Orders that tracks special orders that customers have placed in their retail stores. A special order includes an item and any customizations the customer needs. For example, a folding door might include customizations such as dimension and hinge placement. Because customizations typically aren't held in store inventory, the customized item needs to be ordered from the supplier when a customer needs it.

There are many design decisions you could make to improve the availability of the applications and services you build on Azure. These decisions extend beyond just Microsoft's SLA for a specific service. In this part, you'll explore a few of these considerations.

Let's start by defining what an application SLA is.

## What's an application SLA?

An *application SLA* defines the service-level agreement requirements for a specific application. This term typically refers to an application that _you_ build on Azure.

## Define your application SLA

Let's look at how Tailwind Traders defines the application SLA for the Special Orders application.

### Understand your application requirements

A good place to start is to have a discussion with your team about how important the availability of each application is to your business.

For example, if the Special Orders application goes down, what would the business impact be? In this case, customers won't be able to place new orders through the store and staff won't be able to check the status of existing orders. This can make customers unhappy. They'll either need to try again later or possibly go to a competitor.

That said, the Special Orders application does not affect other operations. So the majority of the Tailwind Traders business would continue to function normally if the Special Orders application went down.

### Plan for usage patterns

*Usage patterns* define when and how users access your application.

One question to consider is whether the availability requirement differs between critical and non-critical time periods. For example, a tax-filing application can't fail during a filing deadline.

In the case of Tailwind Traders, retail stores are not open 24 hours a day, so if the application was down in the middle of the night, the impact would be minimal. However, because Tailwind Traders has retail locations all over the world, they will need to ensure that each location has access to the service during its retail hours.

To ensure a high level of uptime, you should plan for your application to have duplicate components across several regions, known as *redundancy*, in case one fails. Conversely, to minimize costs during non-critical periods, you could run your application only in a single region. Tailwind Traders may want to consider this if there is a trend that the special order rates are much higher during certain months or seasons.

### Establish availability metrics

You may already have uptime goals for workloads you run in the datacenter. Availability metrics such as uptime also apply to running in the cloud. Two common availability metrics to consider are:

* **Mean time to recovery** (MTTR)

    MTTR is the average time it takes to restore a component after a failure. If, for a single component, this timeframe would result in an unacceptable amount of downtime, you would choose to have a duplicate component available to take over or swap out in the event of a failure. This is commonly used for hardware components like hard disks and power supplies.
* **Mean time between failures** (MTBF)

    MTBF defines how long a component can reasonably expect to last between outages. This metric can be improved by using higher quality components or by reducing the complexity of the system.

<div style="background:yellow;">
We define a couple terms here, but what's the guidance?
</div>

### Establish recovery metrics

While availability metrics focus on IT administration, you also need to consider the business impact when an application or service is unavailable.

Here are two recovery metrics to consider:

* **Recovery time objective** (RTO)

    RTO is the maximum acceptable time an application can be unavailable after an incident. Could Tailwind Traders survive if the application was down for one hour or for the entire day? What about the entire month?

* **Recovery point objective** (RPO)

    RPO is the maximum duration of data loss that's acceptable during a disaster. If Tailwind Traders loses special orders that were entered or updated during the last hour, it may be easy to reenter them. It might even possible reenter one day's worth of data. However, losing two weeks of special order data from across all of their stores may create a more significant business impact, including lost sales.

To derive these values, conduct a risk assessment and make sure you understand the cost and risk of downtime or data loss in your organization.

<div style="background:yellow;">
TODO: Any pointers on how to set up a risk assessment? Does Microsoft provide any tools that help with this?
</div>

## Design your application to meet your SLA

Let's say that Tailwind Traders decided that an SLA of 99.9% is acceptable for the Special Orders application. This gives them an estimated downtime of 10.1 minutes per week.

Now you need to design an efficient and reliable solution for this application on Azure, keeping that application SLA in mind. You'll select the Azure products and services you need and provision your cloud resources according to those requirements.

As with any technology, failures will happen. Hardware can fail. The network can have intermittent timeout periods. While it's rare for an entire service or region to experience a disruption, you still need to plan for such events.

Here are a few aspects to consider as you design your application.

### Identify your workloads

A *workload* is a distinct capability or task that's logically separated from other tasks, in terms of business logic and data storage requirements. Each workload defines a set of requirements for availability, scalability, data consistency, and disaster recovery.

On Azure, the Special Orders application will require:

* Two virtual machines.
* One instance of Azure SQL Database.
* One instance of Azure Load Balancer.

Here's a diagram that shows the basic architecture:

:::image type="content" source="../media/3-special-orders-architecture.png" alt-text="A diagram showing two virtual machines connected to Azure Load Balancer and Azure SQL Database." border="false":::

Each of these workloads has its own SLA, and the customization choices you make when you provision each impacts that SLA. For example:

* **Disks**

    With Azure virtual machines, you can choose from a Standard HDD Managed Disk, a Standard SSD Managed Disk, or a Premium SSD or Ultra Disk. The SLA for a single VM would be either 95%, 99.5% or 99.9%, depending on the disk choice.
* **Tiers**

    Some Azure services are offered as both a free tier product and as a standard paid service. For example, Azure Automation provides 500 minutes of job runtime in an Azure Free account, but is not backed by an SLA. The standard tier SLA for Azure Automation is 99.9%.

Make sure that your purchasing decisions take into account the impact on the SLA for the Azure services that you choose. Doing so ensures that the SLA supports your required application SLA.

### Combine SLAs to compute the composite SLA

After you've identified the SLA for the individual workloads in the Special Orders application, you might notice that those SLAs are not all the same. How does this impact our overall application SLA requirement of 99.9%? To work that out, you'll need to do some math.

The process of combining SLAs helps you compute the *composite SLA* for a set of services. Computing the composite SLA requires you to multiply the SLA of each individual service.

From the [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) page, you discover the SLA for each Azure service that you need. They are:

| Service | SLA |
| --- | --- |
| Virtual Machines | 99.9% |
| Azure SQL Database | 99.99% |
| Azure Load Balancer | 99.99% |

Therefore, for the Special Orders application, the composite SLA would be:

$${99.9 \% \times 99.9 \% \times 99.99 \% \times 99.99 \%}$$
$${= 0.999 \times 0.999 \times 0.9999 \times 0.9999}$$
$${= 0.9978}$$
$${= 99.78 \%}$$

Recall that you need two virtual machines. Therefore, you include the Virtual Machines SLA of 99.9% two times in the equation.

What's important to note here is that even though all of the individual services have SLAs equal to or better than our application SLA, the act of combining them results in an overall number that is *lower* than the 99.9% you need. Why? Because using multiple services adds an extra level of complexity and slightly increases the risk of failure.

You could go back to team and ask whether this is acceptable. Or you could implement some other strategies into your design to improve this SLA. Let's examine a few.

### Build availability requirements into your design

There are application design considerations you can use that relate to the underlying cloud infrastructure.

For example, to improve the availability of the application, you should avoid having any single points of failure. So instead of adding more virtual machines, you can deploy one or more extra instances of the same virtual machine across the different *Availability Zones* in the same Azure region.

An Availability Zone is a unique physical location within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. These zones use different schedules for maintenance, so if one zone is impacted, your virtual machine instance in the other Availability Zone should be unaffected.

Deploying two or more instances of an Azure VM across to or more Availability Zones raises the virtual machine SLA to 99.99%. Recalculating your composite SLA above with this Virtual Machines SLA would give you an application SLA of 99.96%, which exceeds your target.

To learn more about the SLA for virtual machines, visit [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines?azure-portal=true).

### Implement resiliency strategies

*Resiliency* is the ability of a system to recover from failures and continue to function. It's not about avoiding failures, but rather responding to failures in a way that avoids downtime or data loss.

A resilient system returns the application to a fully-functioning state following a failure. High availability and disaster recovery are two crucial components of resiliency.

When designing your architecture, consider performing a Failure Mode Analysis (FMA). The goal of an FMA is to identify possible points of failure and to define how the application will respond to those failures.

## Consider cost and complexity versus high availability

To achieve maximum availability in your application, you would need to add redundancy to every single part of the application. This redundancy includes the application itself as well as the underlying services and infrastructure. However, doing so can be difficult and expensive, and often results in solutions that are more complex than they need to be.

<div style="background:yellow;">
TODO: This section is a mouthful. Can we simplify it?
</div>

As your solution grows in complexity, you have an increasing number of services that depend on one other. Therefore, you might overlook possible failure points. The risk of potential downtime is cumulative across SLAs, just as you saw with your composite SLA. Because complex solutions face greater availability challenges, how critical high-availability is to your requirements determines how you handle the addition of complexity and cost, in relation to your application SLA.

## Considerations for high performance targets

Performance targets above 99.99% are very difficult to achieve. Recall that an SLA of 99.99% means 1.01 minutes of downtime per week. It's difficult for humans to respond to failures quickly enough to meet SLA performance targets above 99.99%. Instead, your application must be able to self-diagnose and self-heal during an outage.

Carefully consider the time window against which your application SLA performance targets are measured. The smaller the time window, the smaller the tolerances. If you define your application SLA as hourly or daily uptime, you need to understand that these tolerances might provide achievable performance targets.

<div style="background:yellow;">
TODO: I don't understand the last sentence...
</div>
