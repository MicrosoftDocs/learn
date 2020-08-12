Imagine that you run a clinical system for a healthcare organization. Clinicians and caregivers have little tolerance for downtime. They need to have access to clinical IT systems around the clock to ensure that they're providing the highest-quality care at all times. 

To meet the around-the-clock demands of clinicians, applications must be able to handle failures with minimal impact to their users. How do they keep their applications operational, both for localized incidents and for large-scale disasters?

In this unit, you'll learn how to include elements from the reliability pillar in your architecture design.

## What is reliability?

In a complex application, any number of things can go wrong at any scale. Individual servers and hard drives can fail. A deployment issue might unintentionally drop all tables in a database. Whole datacenters might become unreachable. A ransomware incident might maliciously encrypt all your data. It's critical that your application stays reliable and can handle both localized and broad-impact incidents.

Designing for reliability includes maintaining uptime through small-scale incidents and temporary conditions like partial network outages. You can ensure that your application can handle localized failures by integrating high availability into each component of the application and eliminating single points of failure. Such a design also minimizes the impact of infrastructure maintenance. High-availability designs typically aim to eliminate the impact of incidents quickly and automatically, and to ensure that the system can continue to process requests with little to no impact.

Designing for reliability also focuses on recovery from data loss and from larger-scale disasters. Recovery from these types of incidents often involves active intervention, though automated recovery steps can reduce the time needed to recover. These types of incidents might result in some amount of downtime or permanently lost data. Disaster recovery is as much about careful planning as it is about execution.

Including high availability and recoverability in the design of your architecture protects your business from financial losses that result from downtime and lost data. They ensure that your reputation isn't negatively affected by a loss of trust from your customers.

Architecting for reliability ensures that your application can meet the commitments you make to your customers. This includes ensuring that your systems are *available* to end users and can *recover* from any failures.

### Build a highly available architecture

For availability, identify the service-level agreement (SLA) you're committing to. Examine the potential high-availability capabilities of your application relative to your SLA, and identify where you have proper coverage and where you'll need to make improvements. Your goal is to add redundancy to components of the architecture so that you're less likely to experience an outage. 

Examples of high-availability design components include clustering and load balancing:

- Clustering replaces a single VM with a set of coordinated VMs. When one VM fails or becomes unreachable, services can fail over to another one that can service the requests.

- Load balancing spreads requests across many instances of a service, detecting failed instances and preventing requests from being routed to them.

### Build an architecture that can recover from failure

For recoverability, you should perform an analysis that examines your possible data loss and major downtime scenarios. Your analysis should include an exploration of recovery strategies and the cost/benefit tradeoff for each. This exercise will give you important insight into your organization's priorities, and help clarify the role of your application. The results should include the application's:

- **Recovery point objective (RPO)**: The maximum duration of acceptable data loss. RPO is measured in units of time, not volume. Examples are "30 minutes of data," "four hours of data," and so on. RPO is about limiting and recovering from data *loss*, not data *theft*.

- **Recovery time objective (RTO)**: The maximum duration of acceptable downtime, where "downtime" is defined by your specification. For example, if the acceptable downtime duration is eight hours in the event of a disaster, then your RTO is eight hours.

With RPO and RTO defined, you can design backup, restore, replication, and recovery capabilities into your architecture to meet these objectives.

Every cloud provider offers a suite of services and features that you can use to improve your application's availability and recoverability. When possible, use existing services and best practices, and try to resist creating your own.

Hard drives can fail, datacenters can become unreachable, and hackers can attack. It's important that you maintain a good reputation with your customers by using availability and recoverability. Availability focuses on maintaining uptime through conditions like network outages, and recoverability focuses on retrieving data after a disaster.
