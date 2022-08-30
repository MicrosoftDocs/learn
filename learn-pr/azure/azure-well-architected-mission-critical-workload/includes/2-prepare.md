
You'll be adding your own enhancements to an existing architecture that meets an organization's high reliability requirements. Here, we'll discuss the things you'll need to get started.

## Project specification

Constoso Shoes is a well-known online shoe store. The company wants to add capabilities to their solution architecture to avoid unavaialbility issues that might lead to financial loss. 

You would like to build an overall health model to make sure issues are caught early in the development cycle. Also, build resiliency checks at the API level or one of its dependencies.

## Current architecture

For you to complete this challenge, you need to have a good understanding of the current architecture for this API. 

Note: This is only a placeholder image. Stop fretting.

![Basic web app](../media/basic-web-app.png)

### Components

All components of this architecture are deployed to a single region. 

- **App Service plan** Standard S2 provides the managed virtual machines (VMs) that host your app. Autoscaling is enabled.

- **App Service app** provides the application platform that containerizes the API code. Authentication feature is enabled for authorization. 

- **Deployment slots** let you stage a deployment and then swap it with the production deployment. 

- **Azure Container Registry** stores the containerized API code and is made available through Continuous Integration/Continuous Delivery (CI/CD) pipelines that was created and managed by your team. 

- **Azure Cosmos DB with SQL API** stores all state related to the workload. The Cosmos DB database account has a single database that contains a few containers in the Shared throughput model. The Azure Cosmos account uses the Serverless capacity mode.

- **Azure Key Vault** stores secrets needed for the API to make external HTTP POST calls. The application accesses the secrets through a Key Vault reference in the Azure App Service’s app configuration.

- **Azure Log Analytics** is used as a unified sink to store logs and metrics for all Azure Diagnostics settings for all components used in the solution.

- **Application Insights** is used for capturing telemetry and logs in the API.

### Design choices

System-managed identities are used between the App Service, App Service code and Key Vault, Container Registry, and Cosmos DB.

TODO: need to add details

## Tradeoffs

However, as with everything, there are trade-offs.


## Design improvements

In an ideal architecture, you would build the most higly available and efficient environment possible. 

- Multi region - active-active
- Scale unit architecture
- Health model
- Deployment and testing

## Setup
- Familiarize yourself with Azure Well-Architected Framework guidance for [**mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview).
- We recommend that you use the architecture diagramming tool that you're most comfortable with. The existing architecture diagram is available for download in both Visio and Diagramming.net (drawio) format, but you can import this into any tooling you wish.
- You do not need an Azure subscription for this challenge if you're comfortable with the services and their features.




