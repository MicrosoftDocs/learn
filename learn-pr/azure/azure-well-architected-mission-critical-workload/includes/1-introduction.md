Build on an existing architecture to support a high-availability scenario for a fictional company. You'll be provided with high-level specifications on application design, infrastructure choices, data model, and overall observability. At the end of exercise, check your work by comparing your design with a similar architecture. Be sure to note down the gaps for future enhancements.  

## Example scenario

Contoso Shoes migrated their on-premises deployments to the cloud two years ago. While they've seen improvements in operations, it's been challenging to keep their availability and uptime within the service level agreement (SLA). There's also an upcoming product launch that's expected to create a spike. Previous launches led to outages because the system wasn't able to meet the increase in load. It resulted in significant financial loss. 

Based on that experience, the organization is now committed to increase the overall reliability of the system. They've **updated the availability targets** for the existing application making it _mission critical_. 

The organization needs an improved design that can **survive a failure of one or more components** in the architecture and even **withstand a complete regional outage**. They've explored the possibility of adding another region. Contoso would also like to improve the customer experience by **serving clients faster in a region geographically closer to them**.

The team understands the _tradeoffs: added cost and complexity_. However, the cost (actual and reputation) of being down for an extended period is greater than the cost of running in a second region. As the Lead cloud architect, You have been asked to evaluate and improve the current architecture with those requirements in mind. 

The existing application is already designed as per the quality pillars of Azure Well-Architected Framework. As an initial step, you have read through the guidance provided for [**Well-Architected mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview). You've **prioritized enhanced system observability and resiliency** as the key focus areas that will have the highest reliability impact on the system. 

> [!IMPORTANT]
>
> The exercises in this module won't cover all design areas of a mission critical workload.  After completing this challenge, you're encouraged to evaluate all areas as the design evolves toward the actual target architecture. 

## What will we be doing?

- Design a health endpoint in the application to check the health at the API level and its dependencies
- Expand the solution into multiple regions to survive a regional outage
- Build a health model and visualize the observability data through internal dashboards

## What is the main goal?

By the end of this module, you'll have a design with higher availability. The goal is to gather the experience using the exercises as a way to shape your thinking and apply the learnings to your own mission-critical solution. 


