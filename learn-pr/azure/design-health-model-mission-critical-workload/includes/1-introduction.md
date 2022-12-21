For a mission-critical workload, it's essential to continuously monitor application components. Continuous monitoring helps you observe performance degradation early and avoid outages.

A well-designed application health model uses metrics and thresholds to give you the monitoring you need for a mission-critical application. Through optimized queries and visualizations, you can quickly identify the cascading impact of degraded system components and troubleshoot problems before an outage can occur.

## Example scenario

Contoso Shoes migrated its deployments from an on-premises environment to the cloud two years ago. Although the company saw improvements in operations, keeping its availability and uptime within its service-level agreement continued to be a challenge. Earlier product launches resulted in outages and financial loss because the system couldn't meet the demands of increased user load.

To prevent further avoidable outages, Contoso Shoes successfully applied the [principles of mission-critical architecture](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in its main customer-facing application, the store website.

As Contoso Shoes prepares for its next high-profile product launch, the company has identified a gap in awareness of the health and availability of its internal web application. Contoso Shoes employees use this website to update the product catalog, which customers then interact with on the store website. With increased traffic on the store website during a product launch, insufficient monitoring and knowledge about the health in the internal web application might affect customers.

The internal web application was designed according to the quality pillars of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework). The company is looking to perform health modeling on this workload and develop queries and dashboards to better observe application and component health.

## Learning objectives

By the end of this module, you'll be able to:

- Identify the user flows and key application components in an application architecture.
- Identify key metrics to use as the foundation for an application health model.
- Build a layered health model for an application.
- Visualize the health model in a dashboard.

## What is the main goal?

By the end of this module, you'll have demonstrated your ability to design a health modeling system in a production-ready, mission-critical solution.

## What will you do?

- Design a multi-layered health model structure for an internal web application.
- Build a health model and visualize observability data in an operational dashboard.
- Design queries and a health endpoint in the application to check the application's health and its dependencies at the API level.

> [!IMPORTANT]
>
> The exercises don't cover all aspects of health modeling for mission-critical workloads. After you complete this module, we encourage you to continue exploring health modeling principles in [Health modeling for mission-critical workloads](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling) for a complete perspective for your own health modeling designs.
