The Tailwind Traders team is working on quite a variety of projects! In addition to their main website, they're adding a mapping feature to their Special Orders application so that they can calculate routes between suppliers and retail stores. They're also exploring how severe weather tracking can improve their drone guidance system.

A service-level agreement (SLA) is the formal agreement between a service company and the customer. On Azure, this agreement defines the performance standards that Microsoft commits to for its customers.

As requirements evolve, it's important for the team to understand the how the SLA for each service they choose impacts the overall performance guarantees of their applications.

For example, their main website must be available as close to 100% of the time as possible. To accomplish that, Tailwind Traders might deploy extra instances of the same virtual machine across different Availability Zones in the same Azure region. Doing so helps ensure that if one zone is impacted, virtual machine instances in the other Availability Zone can pick up the load.

The Special Orders application might have more flexible tolerances. As long as retail employees don't lose data and can quickly regain network access, the Special Orders application might have a lower SLA. Here, the team may choose to include less redundancy in their design.

When defining your SLA requirements, be sure to consider both your business needs as well as the time it takes to restore a component after a failure. Also consider how the use of preview services and preview features might impact your systems in production.

## Next steps

Create a sketch or diagram for an application that you plan to migrate to the cloud. Your sketch should include each Azure service you plan to use.

Use the documented [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) to find out the SLA for each Azure service involved. Then compute the composite SLA for your application.

Does the composite SLA meet your requirements? If not, what can you do to improve it?

## Learn more

In this module, you learned about several factors that affect service guarantees on Azure. You also learned how to access preview services and preview features. Here are additional resources to help you go further.

* Review the [resiliency checklist](https://docs.microsoft.com/azure/architecture/checklist/resiliency-per-service?azure-portal=true) to learn how to build resiliency into the Azure services that you use.
* Consider proven recommendations you can use to [design for self healing](https://docs.microsoft.com/azure/architecture/guide/design-principles/self-healing?azure-portal=true) in your applications.
* Learn how [regions and Availability Zones](https://docs.microsoft.com/azure/availability-zones/az-overview?azure-portal=true) protect your applications and data from datacenter failures.
* Review [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms?azure-portal=true).
* Learn about updates and new product features on the [Azure announcements blog](https://azure.microsoft.com/blog/topics/announcements?azure-portal=true).
