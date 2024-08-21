In this module, you'll build on an existing architecture to support a high-availability scenario for a fictional company. You'll be provided with high-level specifications on application design, infrastructure choices, data model, and overall observability. At the end of exercise, you'll check your work by comparing your design with that of a similar architecture. Be sure to note down the gaps for future enhancements.

## Example scenario

Contoso Shoes migrated their on-premises deployments to the cloud two years ago. While they've seen improvements in operations, it's been challenging to keep their availability and uptime within the service level agreement (SLA). There's also an upcoming product launch that's expected to create a spike in traffic. Previous launches led to outages because the system wasn't able to meet the increase in load, which resulted in significant financial loss.

Based on that experience, the organization is now committed to increase the system's overall reliability and observability. They've *updated the availability targets* for the existing application, making it *mission critical*.

The organization needs an improved design that can *survive a failure of one or more components* in the architecture and even *withstand a complete regional outage* while providing more system-health insights to their operations. They've explored the possibility of adding another region. Contoso would also like to improve the customer experience by *serving clients faster in a region geographically closer to them*.

The team understands the *tradeoffs: added cost and complexity*. However, the cost (actual and reputation) of being down for an extended period is greater than the cost of running in a second region. As the lead cloud architect, you've been asked to evaluate and improve the current architecture with those goals in mind.

The existing application is already designed as per the quality pillars of Azure Well-Architected Framework. As an initial step, you've read through the guidance provided for [Well-Architected mission-critical workloads](/azure/architecture/framework/mission-critical/mission-critical-overview). You've *prioritized enhanced system resiliency and observability* as the key focus areas that will have the highest reliability impact on the system.

## What will you learn?

- Design a health endpoint in the application to check the health at the API level and its dependencies
- Expand the solution into multiple regions to survive a regional outage
- Build a health model and visualize the observability data through operational dashboards

> [!IMPORTANT]
>
> The exercises don't cover all design areas of mission critical workloads. After completing this challenge, you're encouraged to continue exploring mission critical principles given in [Well-Architected mission-critical workloads](/azure/architecture/framework/mission-critical/mission-critical-overview), so that you have a complete perspective for your own designs.

## What is the main goal?

By the end of this module, you'll have demonstrated your ability to apply mission-critical design principles to an example scenario. Based on your learnings, you'll be able to evaluate similar designs and ultimately create your own production-ready mission-critical solution.
