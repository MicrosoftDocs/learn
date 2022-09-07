Build on an existing architecture to support a high-availability scenario for a fictional company. You'll be provided with high-level specifications on the application design, infrastructure choices, data model, and monitoring needed to complete this project. 

## Example scenario

Contoso Shoes is a well-known online shoe store. The company is launching a sports line created by a celebrity athlete. Previous launches have resulted in high retail volume similar that caused the application to be unavailable, resulting in financial loss. 

Based on that experience, the organization is now committed to increase the overall reliability of the system. They have updated the availability targets for the existing application making it _mission critical_. 

The organization needs an improved design that can survive a total regional failure of one or more components in the architecture. They've explored the possibility of adding another region. In addition to extended reliability, Contoso would like to improve the customer experience by serving clients faster in a region geographically closer to them.

The team understands the tradeoffs; added cost and complexity. However, the cost (actual and reputation) of being down for extended periods of time is greater than the cost of running in a second region. As the Lead cloud architect, You have been asked to evaluate and improve the current architecture with those requirements in mind. 

The existing application is already designed as per the quality pillars of Azure Well-Architected Framework. As an initial step, you have read through the guidance provided for [**Well-Architected mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview) but now you want to prioritize your efforts. You've identified enhanced system observability and resiliency as the key focus areas that will have the highest reliability impact on the system.

## What will we be doing?

- Design a health endpoint in the application to check the health at the API level and its dependencies.
- Expand the solution into multiple regions to survive a regional outage.
- Build a health model and visualize the oberservability data through internal dashboards.

## What is the main goal?

By the end of this session, you'll have a Well-Architected design for the solution that meets the calculated SLO targets.