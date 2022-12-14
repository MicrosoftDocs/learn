For a mission-critical workload, continuous monitoring of application components is essential to ensuring degradations are caught early and outages are prevented. A well-designed health model provides you that ability based on metrics and corresponding thresholds. Through optimized queries and visualizations, you can quickly identify the cascading impact of degraded system components and troubleshoot issues before an outage can occur.

## Example scenario

Contoso Shoes migrated its on-premises deployments to the cloud two years ago. Although they saw improvements in operations, it was challenging to keep their availability and uptime within the service level agreement (SLA). Previous launches led to outages because the system wasn't able to meet the increase in load. It resulted in significant financial loss. Based on that experience, Contoso Shoes has successfully applied the [principles of mission-critical architecture](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in their main customer-facing application.

Going forward, Contoso Shoes needs to be ready for their next high-profile product launch, which is expected to create a significant increase in traffic. The organization has identified a gap in awareness of the health and availability of their internal web application. Contoso Shoes employees use this website to update the item catalog, which is then displayed on the main shop site. This existing application was designed according to the quality pillars of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework). The organization is looking to perform health modeling on this workload and develop queries and dashboards for better observability.

## Learning objectives

By the end of this module, you'll be able to:

- Identify user flows and key application components of a given architecture.
- Build a layered health model of a given architecture.
- Identify key metrics and thresholds of the health model of a given architecture.
- Visualize the health model in a dashboard

## What is the main goal?

By the end of this module, you'll have demonstrated your ability to design a health modeling system in a production-ready, mission-critical solution.

## What will you do?

- Design a multi-layered health model structure for an internal employee application.
- Build a health model and visualize the observability data an operational dashboard.
- Design queries and a health endpoint in the application to check the health at the API level and its dependencies.

> [!IMPORTANT]
>
> The exercises do not cover all aspects of health modeling for mission-critical workloads. After you complete this module, you're encouraged to continue exploring health modeling principles given in [Health modeling for mission-critical workloads](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling), so that you have a complete perspective for your own designs.
