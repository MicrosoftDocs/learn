You'll be adding your own enhancements to an existing architecture that meets an organization's high reliability requirements. Here, we'll discuss the things you'll need to get started.

## Problem context

Contoso Shoes wants to be ready for the next launch, which is expected to create an increase in traffic load. In the last six months, there have been several incidents causing the website to be offline for half a day. The system wasn't tested properly in the Dev/Test environment and some bugs crept into production. Troubleshooting took a long time because the operators weren't able to identify the root cause quickly. 

There have some challenges when certain components aren't available. The scale-out operations on compute were impacted when Azure Key Vault wasn't available. Also, there aren't any strategies in place for regional outages. In a recent incident, the entire West Europe region went down. Because the workload was only running in that region, they had to bear financial loss until the region was back up. 

## Current architecture

For you to complete this challenge, you need to have a good understanding of the current architecture. 

![This image shows the basic architecture for a web application](../media/basic-architecture.png)

### Components

All components of this architecture are deployed to a single region. 

- **App Service plan** Standard S2 provides the managed virtual machines (VMs) that host your app. Autoscaling is enabled. In preproduction environment, Basic B1 SKU is used.

- **App Service** provides the application platform that containerizes the API code. Authentication feature is enabled for authorization. 

- **Deployment slots** let you stage a deployment and then swap it with the production deployment. 

- **Azure Container Registry** stores the containerized API code and is made available through Continuous Integration/Continuous Delivery (CI/CD) pipelines created and managed by your team. 

- **Azure Cosmos DB with SQL API** stores all state related to the workload. The Cosmos DB database account has a single database that contains a few containers in the Shared throughput model. The Azure Cosmos account uses the Serverless capacity mode.

- **Azure Key Vault** stores secrets needed for the API to make external HTTP POST calls. The application accesses the secrets through a Key Vault reference in the Azure App Service’s app configuration.

- **Azure Log Analytics** is used as a unified sink to store logs and metrics for all Azure Diagnostics settings for all components used in the solution.

- **Application Insights** is used for capturing telemetry and logs in the API.

- **Azure Pipelines** is used for continuous integration/continuous delivery (CI/CD) that builds, tests, and deploys the workload in preproduction and production environments.

### Design choices

In the list of components, the _deployment stamp_ consists of services that participate in processing of a request. Those services include **App Services and the API code**, **Key Vault**, **Container Registry**, and **Cosmos DB**. The application also has a third-party dependency on a performance and resilience framework. System-managed identities are used between components of stamp. 

In the stamp, App Services is configured to automatically scale based on load. 

Separate environments are used for Production and Dev/Test. The Production environment uses App Service plan Standard SKU. This choice was made to have the capability of prewarming the application to a deployment slot before deploying it to production. In the Dev/Test environment, the SKU is lowered to Basic for cost optimization. Both environments have their own instances of services. Only **Container Registry** is shared between the environments.

TODO: 
- Talk about scaling in the slot. (TBD)

## Tradeoffs

However, as with everything, there are trade-offs with the current architecture. Business requirements prioritized cost optimization over reliability and operations. To keep within the cost limits, the architecture hasn't evolved. The components fall short when taking advantage of the reliability capabilities offered by the platform. For example, the choice of SKU for compute prevents the workload from using Availability Zones. For telemetry, an older version of Application Insights is used that isn't integrated with Log Analytics. 

Also, access to the workload is overly pervasive. For example, without any virtual network integration, all Azure services can be directly reached over the public internet.

## Project specification

The company wants to add capabilities to their solution architecture and make it highly reliable. Here are the business requirements:

- Extend the architecture to multiple regions.
- Improve the customer experience by serving clients faster in a region geographically closer to them. 
- Upgrade the Azure services so that they're aligned with the Azure roadmap. 
- Build an overall health model to make sure issues are caught early in the development cycle.

## Setup
- Familiarize yourself with Azure Well-Architected Framework guidance for [**mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview).
- We recommend that you use the architecture diagramming tool to visualize the architecture. 
- You don't need an Azure subscription for this challenge if you're comfortable with the services and their features. For product documentation for used services, see:
    - [Azure App Service plan](/azure/app-service/overview-hosting-plans) 
    - [Azure App Service](/azure/app-service/overview) 
    - [Deployment slots](/azure/app-service/deploy-staging-slots) 
    - [Azure Container Registry](/azure/container-registry/)
    - [Azure Cosmos DB](/azure/cosmos-db/)
    - [Azure Key Vault](/azure/key-vault/)
    - [Azure Log Analytics](/azure/azure-monitor/)
    - [Azure Application Insights](/azure/azure-monitor/)
    - [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines?view=azure-devops)
