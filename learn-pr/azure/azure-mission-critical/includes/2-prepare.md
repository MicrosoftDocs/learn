You'll be adding your own enhancements to an existing architecture that meets the organization's high-reliability requirements. Here, we'll discuss the background context you need to be successful with the exercises.

## Problem context

Contoso Shoes needs to be ready for their next high-profile product launch, which is expected to create a significant increase in traffic. In the last two years, there have been several incidents causing the website to be offline for as long as half a day. The system wasn't tested completely in the dev/test environment, and some bugs crept into production. Troubleshooting and remediation took a long time, because the operators weren't able to identify the root causes quickly.

There have been some challenges when certain components aren't available. The scale-out operations on compute were impacted when Azure Key Vault was misconfigured. Also, there aren't any strategies in place for regional outages. In a recent incident, the entire West Europe region went down. Because the workload was only running in that region, the company had to bear financial loss until the region was back up.

## Current architecture

For you to complete this challenge, you need to have a good understanding of Contoso Shoes' current architecture. Let's focus on their API layer.

![Diagram of the basic architecture for a web application.](../media/basic-architecture.png)

### Components

All of this architecture's components are deployed to a single region.

- [Azure App Service plan's](/azure/app-service/overview-hosting-plans) Standard S2 SKU provides the compute platform that hosts the app. Autoscaling is enabled. The development environment uses the Basic B1 SKU.

- [Azure App Service](/azure/app-service/overview) provides the application platform that runs the API code in a container. The App Service Authentication feature is enabled for authorization.

- [Deployment slots](/azure/app-service/deploy-staging-slots) let you stage a deployment and then swap it with the production deployment. They're used in production only.

- [Azure Container Registry](/azure/container-registry/) stores the containerized API code and is pushed through Continuous Integration/Continuous Delivery (CI/CD) pipelines the workload team creates and manages. Both the production and the dev/test environment use the container registry.

- [Azure Cosmos DB](/azure/cosmos-db/) with SQL API stores all state related to the workload. The Cosmos DB database account has a single database that contains a few containers in the Shared throughput model. The Azure Cosmos account uses the Serverless capacity mode. There's one instance for production and one for dev/test.

- [Azure Key Vault](/azure/key-vault/) stores secrets needed for the API to make an HTTP POST call to an external, third-party API as part of one request flow. The application accesses the secrets through a Key Vault reference in the Azure App Service's app configuration. There's one Key Vault for production and one for dev/test.

- [Azure Log Analytics](/azure/azure-monitor/) is used as a unified sink to store logs and metrics for all Azure Diagnostics settings for all components used in the solution. There's one workspace for production and one for dev/test.

- [Azure Application Insights](/azure/azure-monitor/) is used for capturing telemetry and logs from the API. Application Insights uses the self-contained mode, not writing to a dedicated log analytics workspace. Production and dev/test don't share a common instance.

- [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines) is used for CI/CD that builds, tests, and deploys the workload in preproduction and production environments. The workload team manages the pipelines, which also manage all of the infrastructure in their solution. Bicep is the choice of technology for Infrastructure-as-Code (IaC).

### Design choices

In the list of components, the *deployment stamp* consists of services that participate in processing a request. Those services include App Services and the API code and Cosmos DB. The stamp also includes nonfunctional components: Key Vault and Container Registry. The application has a third-party dependency on a performance and resilience framework. System-managed identities are used between components of the stamp.

In the stamp, App Services is configured to automatically scale based on load.

Separate environments are used for production and dev/test. The production environment uses App Service plan's Standard SKU. The company made this choice to be able to prewarm the application to a slot before deploying it to production. The dev/test environment uses the Basic SKU for cost optimization. Both environments have their own instances of services. The environments share only the Container Registry.

The containerized API code is delivered in a single container image that runs in App Service. The API has multiple HTTP endpoints the various frontends use for both reads and writes. The frontends are out of scope for this module, but they're in scope in the big picture for this situation's mission-critical status. The code was instrumented with Application Insights to capture some basic telemetry. The team that developed this code also manages the CI/CD pipeline for the API container image and the CI/CD pipelines.

### Tradeoffs

However, as with everything, there are tradeoffs with the current architecture. Business requirements prioritized cost optimization over reliability and operations. To keep within the cost limits, the architecture hasn't evolved. The components fall short when taking advantage of the reliability capabilities the platform offers. For example, the choice of SKU for compute prevents the workload from using Availability Zones. For telemetry, an older version of Application Insights is used that isn't integrated with Log Analytics.

Also, access to the workload is overly pervasive. For example, without any virtual network integration, all Azure services can be directly reached over the public internet.

When the solution was developed, the app development team used a single Azure Subscription, colocating dev/test and production in the same subscription to make tooling easy for the DevOps teams. However, production resources and dev/test resources aren't completely isolated. Some resources are shared between the two environments, though they did get an isolated subscription from the rest of Contoso Shoes' solutions.

Also, the dev/test environment is a single environment that's shared across all members of the development and QA team. The choice was justified given the size of the teams and coordination between them didn't need a higher degree of isolation. As the team and solution evolved, the single dev/test environment increasingly caused integration complexity as workstream lifecycles collided. The churn and its impact on reliability have been expensive.

## Project specification

The company wants to add capabilities to their solution architecture so that it's able to handle the expected increase in load. Here are the business requirements:

- Build the capability to withstand regional failures by extending the architecture to multiple regions
- Improve customer experience by serving clients faster in a region geographically closer to them
- Align with the Azure roadmap and take advantage of the latest reliability features Azure services offers
- Catch issues early and detect their cascading impact in the system by building an overall health model

Those requirements are only the prioritized list of their improvement plans. The application team is aware that *all* design areas must be considered to bring this solution's reliability up to mission-critical standards. Rest assured, they won't stop improving their solution and operations after you've helped them with the aspects covered in the upcoming exercises. 

Welcome to the team! Contoso Shoes is looking forward to hearing your recommendations.

## Setup

In this **_Challenge Project_**, you'll take on the role of an architect who will help Contoso Shoes achieve their reliability outcomes, starting with the prioritized items in the preceding section.

- We recommend that you use the architecture diagramming tool to visualize the architecture.
- You don't need an Azure subscription for this challenge if you're comfortable with the services and their features.
