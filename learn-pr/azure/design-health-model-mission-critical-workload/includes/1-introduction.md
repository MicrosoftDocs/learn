It's essential to continuously monitor application components of a mission-critical workload so that you can observe performance degradation early and avoid outages.

A well-designed application **health model** gives you that capability by using metrics and thresholds, which *you* consider important for the workload. Through optimized queries and visualizations, you can quickly identify the cascading impact of degraded system components and troubleshoot problems before an outage can occur.

## Example scenario

Two years ago, Contoso Shoes migrated its deployments from an on-premises environment to the cloud. Although the company saw improvements in operations, keeping its availability and uptime within its service-level agreement continued to be a challenge. Some product launches resulted in outages because the system couldn't meet the demands of increased user load.

To prevent further avoidable outages, Contoso Shoes successfully applied the [design principles of a mission-critical workload](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in its main customer-facing web application, the store website.

As Contoso Shoes prepares for its next high-profile product launch, the company identifies a gap in awareness of the health and availability of its web application. Employees use this application to update the product catalog. Their customers interact with the catalog through the store website. Traffic is expected to increase during the launch and insufficient monitoring and knowledge about application health, is a potential risk.

In this module, you use this web application as the core example. The exercises cover these tasks:

- Design a multi-layered health model structure for the application.
- Build a health model and visualize observability data in an operational dashboard.
- Design queries and a health endpoint in the application to check its health and dependencies at the API level.

> [!IMPORTANT]
>
> The exercises don't cover all aspects of health modeling for mission-critical workloads. After you complete this module, continue to explore health modeling principles in [Health modeling for mission-critical workloads](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling) for a complete perspective for your own health modeling designs.
