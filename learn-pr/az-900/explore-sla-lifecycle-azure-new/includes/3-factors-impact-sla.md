<div style="background:yellow;">
TODO: This is REALLY long. A graphic or video could help, or do we split over two units?
</div>

Now that you know how Service Level Agreements are structured, how do you know if the SLA for an Azure product or service will meet your business needs? Are there any other factors that you need to consider, too?

There are many design decisions you could make to improve the availability of your applications or your virtual machines. These include things beyond just Microsoft's SLA for an individual product or service. 

## Defining your Application SLA
Tailwind Traders uses an application to track "special orders" that customers have placed in their retail stores. A special order means the item has particular, customizable properties (for example, the dimensions and hinge placement on a folding door), so it is not held in the store as a regular item. Instead, it needs to be ordered in from the supplier when a customer needs it, with the requesting customer's specifications. 

Lets look at how Tailwind Traders would define the Service Level Agreement requirements & design components for the Special Order application, known as an Application SLA. 

### Understand your application requirements
First, you should have a business discussion about how important the availability of this application is. If the Special Orders application couldn't be used, what would the business impact be? In this case, customers could not place new orders through the store and the staff couldn't check the status of existing orders. This scenario is going to make a few customers unhappy, either delaying them or even causing them to go to a competitor. But the majority of the Tailwind Traders business would continue to function, serving all other customers. 

### Plan for usage patterns
The usage patterns also play a role in your requirements. Would the availability requirement differ between critical and non-critical periods? For example, a tax-filing application can't fail during a filing deadline. In this case, Tailwind Traders' retail stores are not open 24 hours a day, so if the application was down in the middle of the night, the impact would be minimal.
 
To ensure a high level of uptime, you should plan for your application to have duplicate components across several regions (known as redundancy), in case one fails. Conversely, to minimize costs during non-critical periods, you could run your application only in a single region. Tailwind Traders may want to consider this if there is a trend that the special order rates are much higher in certain months or seasons, compared to others.

### Establish availability metrics
With the application currently on servers in your own data center, there may be some existing availability metrics that have been defined for those workloads. They're likely to use the following standard industry terms: 
+ Mean time to recovery (MTTR) - the average time it takes to restore a component after a failure. If, for a single component, this timeframe would result in an unacceptable amount of downtime, you would choose to have a duplicate component available to take over or swap out in the event of a failure. This is commmonly used for hardware components like hard disks and power supplies. 
+ Mean time between failures (MTBF) - how long a component can reasonably expect to last between outages. This metric can be improved by using higher quality components, or reducing the complexity of the system.

### Establish recovery metrics
Another important set of metrics is defined in conjunction with the business impact of the application being unavailable.  
+ Recovery time objective (RTO) - the maximum acceptable time an application can be unavailable after an incident. Could Tailwind Traders survive if the application was down for one hour or one day? What about one entire month?
 
+ Recovery point objective (RPO) - the maximum duration of data loss that is acceptable during a disaster. If Tailwind Traders loses special orders that were entered or updated during the last hour, it may be easy to re-enter. They could even possible re-enter one day's worth of data. However, losing two weeks of special order data from across all of their stores may create a more significant business impact, including lost sales.  

To derive these values, conduct a risk assessment and make sure you understand the cost and risk of downtime or data loss in your organization.

## Designing your application to meet your SLA 
Let's say that it's been decided that an SLA of 99.9% (with an estimated downtime of approximately 10.1 minutes per week) is acceptable for the Special Orders application.

Now, you need to design an efficient and reliable solution for this application on Azure, keeping that application SLA in mind. You'll select the Azure products and services you need, provisioning your cloud resources according to those requirements. 

With technology, failures will happen. Hardware can fail. The network can have intermittent  failures. While it's rare for an entire service or region to experience a disruption, this should be planned for. 

### Identify workloads
A workload is a distinct capability or task that is logically separated from other tasks, in terms of business logic and data storage requirements. Each workload has different requirements for availability, scalability, data consistency, and disaster recovery. 

<div style="background:yellow;">
TODO: Get application architecture checked by a dev.
</div>

Once moved to Azure, the special order application will require two virtual machines, an Azure SQL database and a load balancer. Each of these workloads have their own SLA, and the choices you make when you provision them may also impact that SLA. For example:

+ Disks - With Azure Virtual Machines, you can choose from a Standard HDD Managed Disk, a Standard SSD Managed Disk or a Premium SSD or Ultra Disk. The SLA for your single VM would be either 95%, 99.5% or 99.9%, depending on that disk choice.
+ Tiers - Some Azure services are offered as both a free tier product and as a paid service. Azure Automation provides 500 minutes of job runtime in an Azure Free account, but is not backed by an SLA. The standard tier SLA for Azure Automation is 99.9%.

Make sure that your purchasing decisions take into account the impact on the SLA for the Azure product or service, so it is scoped directly to meet your required application SLA. Full details of the SLAs can be found at [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true)  

### Combine SLAs
Once you've identified the SLA for the individual workloads in the special orders application, you'll notice that those SLAs are not all the same. How does this impact our overall application SLA requirement of 99.9%? To work that out, we'll need to do some math.  

The act of combining SLAs (to arrive at a **composite SLA**), requires you to multiply the SLAs together of the individual services. For our special orders application, that would be:

VM1 99.9% x VM2 99.9% x SQL Database 99.99% x Load Balancer 99.99% = 99.78%

What's important to note here is that even though all of the individual services have SLAs equal to or better than our application SLA, the act of combining them results in an overall number that is **lower** than the 99.9% you need. Why? Because using multiple services adds an extra level of complexity and slightly increases the risk of failure.

You could go back to the business and ask if this is acceptable, or you could implement some other strategies into your design to improve this SLA.

### Build availability requirements into your design
There are a number of application design considerations you can implement, related to the underlying Cloud infrastructure. For example, to improve the availability of the application, you should avoid having any single points of failure. Instead of adding more virtual machines, you can deploy one or more extra instances of the same virtual machine across the different Availability Zones in the same Azure region. These zones use different schedules for maintenance, so if one zone is impacted, your virtual machine instance in the other availability zone should be unaffected. 

Deploying two or more instances of an Azure VM across to or more availability zones raises the VM SLA to 99.99%. Recalculating your composite SLA above with this VM SLA would give you an application SLA of 99.96%, which exceeds your target. To learn more about how the configuration of a VM impacts the SLA, visit [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/?azure-portal=true) 
 
### Implement resiliency strategies
Resiliency is the ability of a system to recover from failures and continue to function. It's not about avoiding failures, but responding to failures in a way that avoids downtime or data loss. The goal of resiliency is to return the application to a fully functioning state following a failure. High availability and disaster recovery are two crucial components of resiliency. 

<div style="background:yellow;">
TODO: too much jargon follows.
</div>

When designing your architecture you should perform a Failure Mode Analysis (FMA). The goal of an FMA is to identify possible points of failure and to define how the application will respond to those failures. Look at implementing resiliency design patterns, such as isolating critical resources, using compensating transactions, and performing asynchronous operations whenever possible.

## Cost and complexity vs. high availability
To get the maximum amount of availability for an application would require planning redundancy into every single part of the application - from the application itself to the underlying services and infrastructure. However, adding significant preventative measures can be difficult and expensive, and often results in solutions that are more complex. 

As your solution grows in complexity, you will have more services depending on each other. Therefore, you might overlook possible failure points in your solution if you have several interdependent services. The risk of potential downtime is cumulative across various SLA levels (as seen in our composite SLA), so complex solutions can face greater availability challenges. Therefore, how critical high-availability is to your requirements will determine how you handle the addition of complexity and cost, in relation to your application SLA.

## Considerations for high performance targets
It is difficult for humans to respond to failures quickly enough to meet SLA performance targets above 99.99%. Instead, your application solution must be self-diagnosing and self-healing instead.

Also carefully consider the time window against which your application SLA performance targets are measured. The smaller the time window, the tighter the tolerances. If you define your application SLA as hourly or daily uptime, you need to understand these tighter tolerances might not allow for achievable performance targets.

> [!Tip]
>
> For example: An SLA that defines an uptime of 99.999% only allows for about 5 minutes of total downtime per year.

---
> [!div class="checklist"]
> * Performance targets about 99.99% are going to be very difficult to achieve.

