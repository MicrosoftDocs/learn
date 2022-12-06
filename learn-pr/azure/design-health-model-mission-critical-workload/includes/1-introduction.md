For a mission-critical workload, continuous monitoring of application components is essential to ensuring degradations are caught early and outages are prevented. A well-designed health model provides you that ability based on metrics and corresponding thresholds. Through optimized queries and visualizations, you can quickly identify the cascading impact of degraded system components and troubleshoot issues before an outage can occur.

## Example scenario

Contoso Shoes migrated their on-premises deployments to the cloud two years ago. Although they saw improvements in operations, it was challenging to keep their availability and uptime within the service level agreement (SLA). Previous launches led to outages because the system wasn't able to meet the increase in load. It resulted in significant financial loss. Based on that experience, Contoso Shoes has successfully applied the [principles of mission-critical architecture](https://learn.microsoft.com/azure/architecture/framework/mission-critical/mission-critical-design-principles) in their main customer-facing application and it is now *mission critical*.

Going forward, Contoso Shoes needs to be ready for their next high-profile product launch, which is expected to create a significant increase in traffic. The organization has identified a gap in awareness of the health and availability of their internal web application. Contoso Shoes employees use this website to update the item catalog, which is then displayed on the main shop site. This existing application was designed according to the quality pillars of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework). The organization is looking to perform health modeling on this workload and develop queries and dashboards for better observability.

## Learning objectives

By the end of this module, you'll be able to:

- Identify user flows and key application components of a given architecture
- Identify key metrics for the foundation of the health model of a given architecture
- Visualize the health model in a dashboard

## Architecture

The following diagram shows the architecture of the Contoso Shoes application. Make sure you have a good understanding of the individual components and their role within the functionality of the system.

![Diagram showing the architecture for the Contoso Shoes application.](../media/contoso-shoes-architecture.png)

### Components

The components of this architecture are as follows:

- Front-end web application: The user interface of this workload, which runs on Azure Web Apps.
  - Reads: Azure Data Catalog REST API
  - Writes: End user

- Azure Data Catalog REST API: The API layer used by the front-end web application to perform data operations (for example, load catalog, create item, update item, delete item). Hosted on Azure Functions.
  - Reads: Azure Cosmos DB
  - Writes: Azure Event Hubs

- Background processor: A component without any public endpoint, which is used for asynchronous processing of database updates. Hosted on Azure Functions.
  - Reads: Azure Event Hubs
  - Writes: Azure Cosmos DB

- Messaging bus: The messaging bus uses Azure Event Hubs to pass messages between the Data Catalog API and the background processor.

- Database: The data that's persisted in Azure Cosmos DB. The Catalog API reads from the database directly, and writes are handled by the background processor.

- Secrets: Application components of this workload use secrets to authorize access. The Data Catalog API and background processor use connection strings to access the database and Azure Event Hubs, while the front-end application uses an API key to call the Data Catalog API. Secrets are stored in Azure Key Vault.

- Monitoring: Application components send all data measurements to Application Insights, backed with a Log Analytics workspace. The same workspace is used to collect other logs and metrics for this workload.

## What is the main goal?

By the end of this module, you'll have demonstrated your ability to design a health modeling system in a production-ready, mission-critical solution.

## What will you do?

- Design a health endpoint in the application to check the health at the API level and its dependencies.
- Expand the solution into multiple regions to survive a regional outage.
- Build a health model and visualize the observability data through operational dashboards.

> [!IMPORTANT]
>
> The exercises do not cover all aspects of health modeling for mission-critical workloads. After you complete this module, you're encouraged to continue exploring health modeling principles given in [Health modeling for mission-critical workloads](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling), so that you have a complete perspective for your own designs.
