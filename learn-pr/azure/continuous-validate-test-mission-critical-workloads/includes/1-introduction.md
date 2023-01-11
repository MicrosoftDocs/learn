*Continuous validation* is a concept of the *Azure mission-critical* design methodology. It helps ensure that a mission-critical solution stays operational, even when failures and exceptional situations happen. It involves testing changes and releases regularly in a controlled environment. Such tests can include using a sustained user load and injecting faults to test the workload's resiliency and ability to handle faults.

Continuous validation is implemented as a set of processes and tools. It's embedded into a pipeline or workflow to enable developers and operations teams to run the validation regularly. For example, you can run continuous validation before every release or major code change. Continuous validation helps you ensure a solution's performance and resiliency before it enters production.

In continuous validation, you:

- Run tests under production-like conditions.
- Define tests based on user and system flows, and their expected performance.
- Establish baselines for various scenarios and stages.
- Evaluate and adjust baselines and thresholds regularly.
- Implement Azure services in automated pipelines.

Microsoft Azure provides the following services to implement load testing and chaos engineering:

- [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) is a managed service for generating synthetic, real-world traffic to test the application and underlying infrastructure and services.
- [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that provides chaos engineering capabilities to systematically inject failures into key components of the application.

You can run these two services simultaneously by embedding them in an Azure DevOps continuous integration and continuous delivery (CI/CD) pipeline. Doing so can help you validate the impact of application changes under realistic conditions at any time in the development cycle.

## Example scenario

Contoso Shoes migrated its deployments from an on-premises environment to the cloud two years ago. Although the company saw improvements in operations, keeping its availability and uptime within its service-level agreement continued to be a challenge. Earlier product launches resulted in outages and financial loss because the system couldn't meet the demands of increased user load.

To prevent further avoidable outages, Contoso Shoes successfully applied the [design principles of a mission-critical workload](/azure/architecture/framework/mission-critical/mission-critical-design-principles) in its main customer-facing web application, the store website.

As Contoso Shoes prepares for its next high-profile product launch, the company has decided to implement continuous validation in its pre-production environment. The goal is to identify potential problems as early as possible in the development cycle.

## Application

The application works like other common e-commerce websites, including the main website of the Contoso Shoes store. Employees can browse through a catalog of products, update individual items, and interact with other users through comments.

Contoso Shoes management has decided that it's critical for customers to:

- Interact with the catalog by browsing through a list of items.
- Proceed to the checkout process to purchase items.

## Architecture

The following diagram shows the architecture of the application. Use the diagram to get a good understanding of the individual components and their roles in the system.

:::image type="content" source="../media/contoso-shoes-architecture.png" border="false" alt-text="Diagram that shows the architecture for the Contoso Shoes application.":::

### Components

The application architecture has the following components:

- **Front-end web application**: The user interface of this workload runs on the Web Apps feature of Azure App Service.
  - *Reads*: Catalog API, Azure Blob Storage
  - *Writes*: Requests originating from users, Catalog API

- **Catalog API**: The front-end web application uses this API layer for data operations on catalog items and comments. It doesn't do any database writes itself. Instead, a message is sent to an event hub to be processed asynchronously. This component is hosted on Azure Functions.
  - *Reads*: Azure Cosmos DB
  - *Writes*: Azure Event Hubs

- **Background processor**: This component asynchronously processes database updates. The processor doesn't have a public endpoint. This component is hosted on Azure Functions.
  - *Reads*: Azure Event Hubs
  - *Writes*: Azure Cosmos DB

- **Messaging bus**: The messaging bus uses Azure Event Hubs to pass messages between the Catalog API and the background processor.

- **Database**: Data is persisted in Azure Cosmos DB. The Catalog API reads from the database directly, and the background processor handles writes. Images are stored in Azure Blob Storage.

- **Secrets**: The application components of this workload use secrets to authorize access. Secrets are stored in Azure Key Vault. The Catalog API and background processor use connection strings to access the database and Azure Event Hubs. The front-end web application uses an API key to call the Catalog API.

To prevent performance bottlenecks and to increase confidence in new releases, Contoso Shoes has decided to implement [continuous validation](/azure/architecture/guide/testing/mission-critical-deployment-testing).

## Learning objectives

By the end of this module, you'll be able to:

- Explain the importance of user and system flows as the foundation for defining load tests and chaos experiments for your workload.
- Establish a baseline with expected thresholds for the system.
- Define requirements for load testing and chaos experiments.
