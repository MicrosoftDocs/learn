
Build on an existing architecture to support a high-availability scenario for a fictional company. You'll be provided with high-level specifications on the application design, infrastructure choices, data model, and monitoring needed to complete this project. 

## Example scenario

Constoso Shoes is a well-known online shoe store. The company is launching a sports line created by a celebrity athlete. Previous launches have resulted in high retail volume similar that caused the application to be unavailable, resulting in financial loss. 

Based on that experience, the organization is now committed to increase the overall reliability of the system. They have updated the availability targets for the existing application making it _mission critical_. As the Lead cloud architect, You have been asked to evaluate and improve the current architecture for maximum reliability. 

The existing application is already designed as per the quality pillars of Azure Well-Architected Framework. As an initial step, you have read through the guidance provided for [**Well-Architected mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview) but want to prioritize your efforts. You've identified enhanced system observability and resiliency as the key focus areas that will have the highest reliability impact on the system.

## What will we be doing?

- Define a composite Service Level Objective (SLO) to achieve.
- Identify failure points at the API level and its dependencies and visualize availability data in a dashboard.
- Expand the solution into multiple regions to survive a regional outage.
- Build a health model for the global solution and visualize the oberservability data through internal dashboards and for the deployment pipeline’s health-controlled rollouts.

## What is the main goal?

By the end of this session, you'll have a Well-Architected design for the solution that meets the calculated SLO targets.